CREATE DATABASE QuanLyCuaHangSach;
USE QuanLyCuaHangSach;

CREATE TABLE THELOAI
(
	MaTheLoai	Varchar(5) primary key,	
	TenTheLoai	Nvarchar(50)
);

CREATE TABLE TACGIA
(
	MaTacGia	Varchar(5) primary key,
	TenTacGia	Nvarchar(50) not null,
	Website	Varchar(50),
	GhiChu	Varchar(100)
);

CREATE TABLE NHAXUATBAN
(
	MaNXB 	Varchar(5) primary key,
	TenNXB	Nvarchar(50),
	Email	Varchar(30) UNIQUE,
	DiaChi	Nvarchar(50),
	ThongTinNguoiLienHe	Nvarchar(30)
);

CREATE TABLE SACH
(
	MaSach	Varchar(5) primary key,
	MaTacGia	Varchar(5),
	MaTheLoai	Varchar(5),
	MaNXB	Varchar(5),
	TenSach	Nvarchar(30),
	NamXuatBan	Date,
	FOREIGN KEY(MaTacGia) REFERENCES TACGIA(MaTacGia),
	FOREIGN KEY(MaTheLoai) REFERENCES THELOAI(MaTheLoai),
	FOREIGN KEY(MaNXB) REFERENCES NHAXUATBAN(MaNXB)
);

CREATE TABLE NHANVIEN
(
	MaNV	int identity(1,1) primary key,
	TenNV	Nvarchar(50),
	NgaySinh	DateTime,
	SDT	int UNIQUE
);

CREATE TABLE KHACHHANG
(
	MaKH	int primary key,
	TenKH	Nvarchar(50) NOT NULL,
	DiaChi	Nvarchar(50),
	SDT		int
);

CREATE TABLE NHACUNGCAP
(
	MaNCC	Varchar(5) primary key,
	TenNCC	Nvarchar(50),
	DiaChi	Nvarchar(50),
	SDT	int 
);

CREATE TABLE PHIEUNHAP
(
	MaPN	int primary key,
	NgayNhap	Date,
	MaNV	Int,
	MaNCC	Varchar(5),
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

CREATE TABLE PHIEUXUAT
(
	MaPX	int primary key,
	NgayXuat	Date,
	MaNV	Int,
	MaKH	Int,
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

CREATE TABLE CHITIETPHIEUNHAP
(
	MaPN	Int,
	MaSach 	Varchar(5),
	SoLuong	Int,
	DonGia	Decimal(8,2),
	FOREIGN KEY(MaSach) REFERENCES SACH(MaSach),
	FOREIGN KEY(MaPN) REFERENCES PHIEUNHAP(MaPN),
	CONSTRAINT PK_CTPN PRIMARY KEY(MaPN, MaSach)
);

CREATE TABLE CHITIETPHIEUXUAT
(
	MaPX	Int,
	MaSach 	Varchar(5),
	SoLuong	Int,
	DonGia	Decimal(8,2),
	FOREIGN KEY(MaSach) REFERENCES SACH(MaSach),
	FOREIGN KEY(MaPX) REFERENCES PHIEUXUAT(MaPX),
	CONSTRAINT PK_CTPX PRIMARY KEY(MaPX, MaSach)
);

ALTER TABLE NHAXUATBAN
ADD CONSTRAINT ten_nha_xuat_ban
CHECK(TenNXB IN ('NXBVH','NXBTRE','NXBGD'));

ALTER TABLE PHIEUXUAT
ADD CONSTRAINT ngay_xuat
DEFAULT GETDATE() FOR NgayXuat;

ALTER TABLE CHITIETPHIEUNHAP
ADD CONSTRAINT don_gia
DEFAULT 20000 FOR DonGia;

ALTER TABLE CHITIETPHIEUXUAT
ADD CONSTRAINT so_luong
CHECK( SoLuong >= 1);

ALTER TABLE TACGIA
ADD CONSTRAINT Uni_web
UNIQUE(Website);

ALTER TABLE NHANVIEN
ADD CONSTRAINT ngay_sinh
CHECK(NgaySinh < getdate());

INSERT INTO THELOAI VALUES
('L02','Giao khoa'),
('L03','Giai tri'),
('L04','Truyen'),
('L05','Tieu Thuyet'),
('L01','Giao duc')

INSERT INTO TACGIA VALUES
('987','Nam Cao',null,'Nha Van Tieu Bieu'),
('235', 'Tran Van An','VanAn@gmail.com','Da Mat'),
('215','Nguyen Tuan','215Tuan@gmail.com',null),
('345','Ho Huong Thien','345thien@ou.edu.vn',null),
('671','Mac Huong Dong Khua','MHDKhua@gmail.com',null),
('123', 'Nguyen Du','123NDu@gmail.com',null)

INSERT INTO NHAXUATBAN VALUES
('NXB05','NXBTRE','HungHanh@gmail.com','91 Nguyen Kiem','19002323'),
('NXB03','NXBGD','BinhTan@gmail.com','124 Ho Hao Hon','19003131'),
('NXB04','NXBGD','KimDong@gmail.com','83/1 Vo Van Tan','19003121'),
('NXB02','NXBTRE','SieuNhi@gmail.com','751 Le Thanh Ton','19001277'),
('NXB01','NXBVH','HoaBinh@gmail.com','83/1 Le Đuc Tho','19003883')

INSERT INTO SACH VALUES 
('S01','345','L01','NXB01','Co So Du Lieu','2022-06-13'),
('S02','215','L04','NXB05','Chu Nguoi Tu Tu','1939-11-30'),
('S03','671','L05','NXB01','Thien Quan Tu Phuc','2016-02-11'),
('S04','671','L05','NXB02','Ma Dao To Su','2017-01-23'),
('S05','235','L03','NXB01','Truyen Cuoi Viet Nam','2022-12-21'),
('S06','235','L02','NXB03','Sach khoa hoc lop 5','2022-12-12'),
('S07','215','L04','NXB02','Vang Bong Mot Thoi','1940'),
('S08','987','L04','NXB04','Chi Pheo','1941'),
('S10','987','L01','NXB04','Lao Hac','1943'),
('S09','123','L04','NXB05','Truyen Kieu','1814-11-21')

INSERT INTO NHANVIEN VALUES
('Vo Hoang Nhu','2005-02-14',034329653),
('Trinh Thu Nhi','2004-07-26',032134983),
('Nguyen Nhat Thanh','2004-03-21',034738783),
('Tran Kieu Trinh','2002-12-05',034567653),
('Ho Trinh Ha Vy','2004-03-21',034734653),
('Doan Nguyen Bao Tram','2001-02-17',08757653),
('Nguyen Van Toan','2000-11-29',034327653),
('Ho Thien Phuc','2001-10-15',034357653),
('Nguyen Thi My Van','04-12-2003',034757123)

INSERT INTO KHACHHANG VALUES
(143,'Nguyen Hoai Nhan','431 Nguyen Kiem',029675665),
(216,'Nguyen Ngoc Thao Nhi','83/1 Truong Dang Que',037433265),
(253,'Tran Hoai Ngoc','711 Le Thi Sau',056418665),
(1242,'Tran Bao Tuan','89 Vo Van Tan',029709865),
(764,'Ho Trung Truc','111/5 Nguyen Chi Tho',02907665),
(133,'Pham Phu Quy','436/1/33 Binh Tri Dong',09432665),
(111,'Ho Viet Thanh','21 Nguyen Van Cong',029728665)

INSERT INTO NHACUNGCAP VALUES
('N01', 'VBooK', '161B Ly Chinh Thang',039316211),
('N02','VietNoVBook','55 Quang Trung',024398653),
('N03','VanHocVN','65 Nguyen Du', 038222135 ),
('N04','Cong Ty Ly Gia','23 Nguyen Thi Minh Khai',02187491),
('N05','Cong ty Hung Thinh','47 Vo Van Tan',19008267)

INSERT INTO PHIEUNHAP VALUES
(211,'2023-01-02',6,'N03'),
(212,'2022-12-18',8,'N04'),
(213,'2022-10-30',2,'N01'),
(214,'2022-12-05',7,'N05'),
(215,'2022-11-27',2,'N02')

INSERT INTO PHIEUXUAT VALUES
(310,'2023-03-13',7,253),
(311,'2022-12-30',2,111),
(312,'2023-02-03',6,133),
(313,'2023-01-26',8,143),
(314,'2022-12-27',10,253),
(315,'2023-03-13',7,253)

INSERT INTO CHITIETPHIEUNHAP VALUES 
(211,'S03',10000,20),
(212,'S01',30000,45),
(213,'S04',76000,55),
(213,'S08',120000,12),
(215,'S02', 45000,120)

INSERT INTO CHITIETPHIEUXUAT VALUES 
(311,'S09',32,35),
(312,'S07',15,29),
(313,'S05',20,85),
(313,'S08',9,22),
(315,'S10',24,37),
(312,'S03',18,21)


SELECT * FROM NHAXUATBAN;
SELECT * FROM TACGIA;
SELECT * FROM SACH;
SELECT * FROM NHANVIEN;
SELECT * FROM KHACHHANG;
SELECT * FROM NHACUNGCAP;
SELECT * FROM PHIEUNHAP;
SELECT * FROM PHIEUXUAT;
SELECT * FROM CHITIETPHIEUNHAP;
SELECT * FROM CHITIETPHIEUXUAT;

-- Số sách có cùng 1 nhà xuất bản
SELECT MaNXB  , COUNT(TenSach) as 'So Luong Sach'
FROM SACH
GROUP BY MaNXB;


--Nhân viên có năm sinh trước và bằng 2003
SELECT *
FROM NHANVIEN
WHERE (YEAR(NgaySinh) <= 2003);


--Khách hàng mua sách trước ngày 01/02/2023, mã sách và số lượng mua
SELECT A.TenKH, A.DiaChi, B.NgayXuat, C.SoLuong, C.MaSach
FROM KHACHHANG A
INNER JOIN PHIEUXUAT B ON A.MaKH = B.MaKH
INNER JOIN CHITIETPHIEUXUAT C ON B.MaPX = C.MaPX
WHERE B.NgayXuat < '2023-02-01';


--Thông tin về sách , nhà cung cấp được nhập vào năm 2022
SELECT D.MaSach,B.MaNCC, D.TenSach, B.TenNCC, C.SoLuong, A.NgayNhap
FROM PHIEUNHAP A
INNER JOIN NHACUNGCAP B ON A.MaNCC = B.MaNCC
INNER JOIN CHITIETPHIEUNHAP C ON C.MaPN = A.MaPN
INNER JOIN SACH D ON D.MaSach = C.MaSach
WHERE YEAR(A.NgayNhap) = '2022';


--Tên sách , số lượng, đơn giá , ngày nhập sách của nhân viên có mã là 2
SELECT A.TenNV , B.NgayNhap, D.SoLuong, D.DonGia , C.TenSach
FROM NHANVIEN A
INNER JOIN PHIEUNHAP B ON A.MaNV = B.MaNV
INNER JOIN CHITIETPHIEUNHAP D ON D.MaPN = B.MaPN 
INNER JOIN SACH C ON C.MaSach = D.MaSach
WHERE A.MaNV = 2;

