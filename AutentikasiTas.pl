% =============================
% SISTEM PAKAR AUTENTIKASI TAS
% =============================

% Deklarasi database dinamis
:- dynamic(jawaban/2).

% Pertanyaan-pertanyaan
tanya(jahitan_rapi) :-
    write('1. Apakah jahitan tas terlihat rapi, lurus, dan tidak ada benang terputus? (y/t)'), nl,
    read(J),
    asserta(jawaban(jahitan_rapi, J)).

tanya(benang_sesuai) :-
    write('2. Apakah jenis benang sesuai dengan kualitas bahan tas? (y/t)'), nl,
    read(J),
    asserta(jawaban(benang_sesuai, J)).

tanya(bahan_kokoh) :-
    write('3. Apakah bahan tas terasa kokoh, halus, dan tidak mudah kusut? (y/t)'), nl,
    read(J),
    asserta(jawaban(bahan_kokoh, J)).

tanya(material_berkualitas) :-
    write('4. Apakah tekstur, warna, dan kualitas material sesuai standar brand? (y/t)'), nl,
    read(J),
    asserta(jawaban(material_berkualitas, J)).

tanya(logo_jelas) :-
    write('5. Apakah logo dan font brand tercetak jelas dan presisi? (y/t)'), nl,
    read(J),
    asserta(jawaban(logo_jelas, J)).

tanya(logo_tidak_salah) :-
    write('6. Apakah tidak ada kesalahan pada bentuk atau posisi logo? (y/t)'), nl,
    read(J),
    asserta(jawaban(logo_tidak_salah, J)).

tanya(nomor_seri_ada) :-
    write('7. Apakah tas memiliki nomor seri unik di dalamnya? (y/t)'), nl,
    read(J),
    asserta(jawaban(nomor_seri_ada, J)).

tanya(serifikasi_nomor_seri) :-
    write('8. Apakah nomor seri bisa diverifikasi di website resmi atau aplikasi autentikasi? (y/t)'), nl,
    read(J),
    asserta(jawaban(serifikasi_nomor_seri, J)).

tanya(packaging_berkualitas) :-
    write('9. Apakah tas disertai dust bag dan packaging berkualitas sesuai standar brand? (y/t)'), nl,
    read(J),
    asserta(jawaban(packaging_berkualitas, J)).

tanya(pernah_cek_counter) :-
    write('10. Apakah tas pernah dicek keasliannya di counter resmi brand? (y/t)'), nl,
    read(J),
    asserta(jawaban(pernah_cek_counter, J)).

tanya(pernah_cek_aplikasi) :-
    write('11. Apakah tas pernah dicek menggunakan aplikasi autentikasi seperti Entrupy? (y/t)'), nl,
    read(J),
    asserta(jawaban(pernah_cek_aplikasi, J)).

tanya(resleting_ori) :-
    write('12. Apakah resleting menggunakan brand original seperti YKK/Lampo, dan berfungsi halus? (y/t)'), nl,
    read(J),
    asserta(jawaban(resleting_ori, J)).

tanya(resleting_detail) :-
    write('13. Apakah logo dan detail di resleting sesuai standar brand? (y/t)'), nl,
    read(J),
    asserta(jawaban(resleting_detail, J)).

tanya(bentuk_tas) :-
    write('14. Apakah bentuk tas kokoh, tidak mudah berubah, dan proporsional? (y/t)'), nl,
    read(J),
    asserta(jawaban(bentuk_tas, J)).

tanya(aroma_kulit) :-
    write('15. Apakah aroma tas khas kulit asli dan tidak menyengat atau bau plastik? (y/t)'), nl,
    read(J),
    asserta(jawaban(aroma_kulit, J)).

% Aturan diagnosis
tas_asli :-
    hitung_skor(Skor),
    Skor >= 11,
    write('^^ Tas kemungkinan ASLI. Skor: '), write(Skor), nl.

tas_tiruan :-
    hitung_skor(Skor),
    Skor =< 5,
    write('X Tas kemungkinan TIRUAN. Skor: '), write(Skor), nl.

tas_perlu_cek :-
    hitung_skor(Skor),
    Skor > 5,
    Skor < 11,
    write('!Tas perlu pengecekan lebih lanjut. Skor: '), write(Skor), nl.

% Hitung jumlah jawaban 'y'
hitung_skor(Skor) :-
    findall(1, (jawaban(_, y)), L),
    length(L, Skor).

% Membersihkan database
reset :-
    retractall(jawaban(_, _)).

% Main program
diagnosa :-
    reset,
    tanya(jahitan_rapi),
    tanya(benang_sesuai),
    tanya(bahan_kokoh),
    tanya(material_berkualitas),
    tanya(logo_jelas),
    tanya(logo_tidak_salah),
    tanya(nomor_seri_ada),
    tanya(serifikasi_nomor_seri),
    tanya(packaging_berkualitas),
    tanya(pernah_cek_counter),
    tanya(pernah_cek_aplikasi),
    tanya(resleting_ori),
    tanya(resleting_detail),
    tanya(bentuk_tas),
    tanya(aroma_kulit),
    tas_asli;
    tas_tiruan;
    tas_perlu_cek.
