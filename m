Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Boris Passerat de la chapelle <bpasserat@h2ad.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krasi Georgiev <krasi.root@gmail.com>
CC: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: RE: How to use GattProfile1
Date: Wed, 31 May 2017 09:33:47 +0000
Message-ID: <39cb9ea22f14454d83b6e62e59bdc955@sjbsvr074.groupe.local>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com>
 <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com>
 <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com>
 <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
 <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com>
 <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com>
 <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
 <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com>
 <CABBYNZLVjXXmbfTb2Uo9KvE2D83c1PU7f2p=t6JawfeyUfN2+w@mail.gmail.com>
 <3290BB41-234F-4D7B-BF37-0CC2966CB416@gmail.com>
 <CABBYNZKoACnV5rOQ1dJH56Uien-CdMy7CUfgvZEGdJvuLXKBgQ@mail.gmail.com>
 <5D01EC8C-E51B-4F89-8F9B-5D7946674116@gmail.com>
 <CABBYNZ+P8fzQP_v5dtWTHhXthE7JhsJeLBts4+_eweVDBMZpSQ@mail.gmail.com>
 <329D353B-8799-434A-9049-AE8904429A78@gmail.com>
 <CABBYNZJPrNfN-ns60zts863J=0Ec-np5AQb9aguS67fF0ZNbkA@mail.gmail.com>
In-Reply-To: <CABBYNZJPrNfN-ns60zts863J=0Ec-np5AQb9aguS67fF0ZNbkA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SGksDQoNCkkgYW0gd2l0aCB0aGUgc2FtZSBwcm9ibGVtIGFzIEtyYXNpICwgaW1wb3NzaWJsZSB0
byBnZXQgYXV0byBjb25uZWN0aW9uIHdpdGggbXkgZGV2aWNlcy4NCg0KRXZlcnl0aGluZyB3YXMg
d29ya2luZyBmaW5lIHVwIHRvIGJsdWV6IDUuNDEgZnJvbSBibHVleiA1LjQyIEkgaGF2ZSBubyBh
dXRvIGNvbm5lY3Rpb24gd2l0aCB0aGUgZGV2aWNlcy4NCg0KSSByZXZlcnRlZCAgY29tbWl0IDg5
Y2E3MzVlNTc0MTdlYzI5NmE0MWQ4YzMxZDBkMGQ1YzY2Y2UyYTkgYW5kIEkgY2FuIGdldCB0aGUg
YXV0byBjb25uZWN0aW9uIHdvcmtpbmcuDQoNCkJvcmlzDQoNCg0KDQotLS0tLU1lc3NhZ2UgZCdv
cmlnaW5lLS0tLS0NCkRlwqA6IGxpbnV4LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmcg
W21haWx0bzpsaW51eC1ibHVldG9vdGgtb3duZXJAdmdlci5rZXJuZWwub3JnXSBEZSBsYSBwYXJ0
IGRlIEx1aXogQXVndXN0byB2b24gRGVudHoNCkVudm95w6nCoDogamV1ZGkgMjUgbWFpIDIwMTcg
MTU6MDINCsOAwqA6IEtyYXNpIEdlb3JnaWV2IDxrcmFzaS5yb290QGdtYWlsLmNvbT4NCkNjwqA6
IEJhcnJ5IEJ5Zm9yZCA8MzFiYXo2NkBnbWFpbC5jb20+OyBCbHVleiBtYWlsaW5nIGxpc3QgPGxp
bnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+DQpPYmpldMKgOiBSZTogSG93IHRvIHVzZSBH
YXR0UHJvZmlsZTENCg0KSGkgS3Jhc2ksDQoNCk9uIFRodSwgTWF5IDI1LCAyMDE3IGF0IDM6NTYg
UE0sIEtyYXNpIEdlb3JnaWV2IDxrcmFzaS5yb290QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEkgY2Fu
4oCZdCBzZWUgaXQsIHdoZXJlIGRpZCB5b3Ugc2VuZCBpdCAsIG1heWJlIGZvcmdvdCB0byBhdHRh
Y2ggaXQ/DQoNCmh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtYmx1ZXRvb3RoJm09MTQ5NTcwODY0
MDAxNjQwJnc9Mg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KLS0NClRvIHVuc3Vic2Ny
aWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1ibHVl
dG9vdGgiIGluIHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwu
b3JnIE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jk
b21vLWluZm8uaHRtbA0K
