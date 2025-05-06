from pyswip import Prolog
import tkinter as tk
from tkinter import messagebox
import pygame
import time
from threading import Thread

# Inisialisasi Prolog
prolog = Prolog()
prolog.consult("pakar_tas_gui.pl")

# Ambil pertanyaan dari Prolog
pertanyaan_list = []
jawaban_list = []
index = 0

for result in prolog.query("pertanyaan(_, Teks)"):
    pertanyaan_list.append(result["Teks"])

# Function utama GUI
def buka_aplikasi():
    splash.destroy()  # tutup splash screen

    # Inisialisasi GUI utama
    root = tk.Tk()
    root.title("Sistem Pakar Keaslian Tas")
    root.geometry("700x350")
    root.configure(bg="#1C1C1C")

    # Musik Background
    pygame.mixer.init()
    pygame.mixer.music.load("backsound.mp3")
    pygame.mixer.music.play(-1)

    # Judul
    label_judul = tk.Label(root, text="🔍 Sistem Pakar Autentikasi Tas Branded",
                           font=("Georgia", 20, "bold"), bg="#1C1C1C", fg="white")
    label_judul.pack(pady=15)

    # Pertanyaan
    label_pertanyaan = tk.Label(root, text="", wraplength=650,
                                font=("Georgia", 14), bg="#1C1C1C", fg="white")
    label_pertanyaan.pack(pady=25)

    def tampilkan_pertanyaan():
        if index < len(pertanyaan_list):
            label_pertanyaan.config(text=pertanyaan_list[index])
        else:
            tampilkan_hasil()

    def jawaban(j):
        global index
        jawaban_list.append(j)
        index += 1
        tampilkan_pertanyaan()

    def tampilkan_hasil():
        skor = jawaban_list.count("y")
        if skor >= 11:
            hasil = f"Tas kemungkinan ASLI ✅ (Skor: {skor}/15)"
        elif skor <= 5:
            hasil = f"Tas kemungkinan TIRUAN ❌ (Skor: {skor}/15)"
        else:
            hasil = f"Perlu pengecekan lebih lanjut ℹ️ (Skor: {skor}/15)"
        messagebox.showinfo("Hasil Diagnosa", hasil)
        root.destroy()

    def reset_pertanyaan():
        global index, jawaban_list
        index = 0
        jawaban_list = []
        tampilkan_pertanyaan()

    # Tombol
    frame_tombol = tk.Frame(root, bg="#1C1C1C")
    frame_tombol.pack(pady=10)

    btn_ya = tk.Button(frame_tombol, text="✅ Ya", width=15, bg="#4CAF50", fg="white",
                       font=("Georgia", 12, "bold"), command=lambda: jawaban("y"))
    btn_ya.grid(row=0, column=0, padx=20)

    btn_tidak = tk.Button(frame_tombol, text="❌ Tidak", width=15, bg="#f44336", fg="white",
                          font=("Georgia", 12, "bold"), command=lambda: jawaban("t"))
    btn_tidak.grid(row=0, column=1, padx=20)

    btn_reset = tk.Button(root, text="🔄 Reset Pertanyaan", width=25, bg="#2196F3", fg="white",
                          font=("Georgia", 12, "bold"), command=reset_pertanyaan)
    btn_reset.pack(pady=20)

    tampilkan_pertanyaan()
    root.mainloop()

# Fungsi untuk menjalankan splash screen
def splash_screen():
    global splash
    splash = tk.Tk()
    splash.title("Loading...")
    splash.geometry("450x250")
    splash.configure(bg="#1C1C1C")

    # Label teks
    label_loading = tk.Label(splash, text="🔍 Sistem Pakar Tas Branded", 
                             font=("Georgia", 20, "bold"), bg="#1C1C1C", fg="white")
    label_loading.pack(pady=30)

    label_sub = tk.Label(splash, text="Memuat aplikasi, harap tunggu...", 
                         font=("Georgia", 14), bg="#1C1C1C", fg="white")
    label_sub.pack(pady=10)

    # Animasi titik-titik
    animasi_label = tk.Label(splash, text="", font=("Georgia", 24), bg="#1C1C1C", fg="#00FF7F")
    animasi_label.pack(pady=10)

    def animasi():
        while True:
            for teks in ["⦁", "⦁⦁", "⦁⦁⦁"]:
                animasi_label.config(text=teks)
                time.sleep(0.5)

    # Jalankan animasi di thread terpisah
    Thread(target=animasi, daemon=True).start()

    # Timer splash screen sebelum buka aplikasi utama
    splash.after(4000, buka_aplikasi)
    splash.mainloop()

# Mulai splash screen
splash_screen()
