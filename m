Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <d6db2b820602150328l714b3561qe3b63f8823612143@mail.gmail.com>
From: michael grosman <michaelg100@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8674_10918297.1140002915748"
Subject: [Bluez-users] OUT transaction: 3 bytes (03 10 00) problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 15 Feb 2006 13:28:35 +0200

------=_Part_8674_10918297.1140002915748
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We would like to setup BT communication on embedded MIPS-processor Broadcom
card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).
Kernel contained USB support, HID support and BlueTooth support (on all
layers).
On this card we're using USB-PCI host-controller of Philips (ISP1562ES1).
We are using Bluez-2.24 library and utils. We also use the library for
userspace-kernelspace USB translation (libusb-0.1.so.4.4.3 ).

We are using CSR based BT dongle with the following description:
>T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  5 Spd=3D12  Mx=
Ch=3D 0>
>D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
>P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D11.20
(as we saw in the supported products list, it is supported.)

When we are connecting the BT dongle to Broadcom (2.4) the Broadcom
recognizes it on the USB bus but fails attempting to retrieve from the
dongle BD address.
We tracked all USB urbs in case of Linux 2.6 on desktop vs Linux 2.4 on
Broadcom card.
USB transactions are identical (except for device number setting) up to the
point where an OUT transaction is sent with the following data (recorded
using Ellisys):

SETUP transaction:     8 bytes (00 05 02 00 00 00 00 00)
SETUP transaction:     8 bytes (80 06 00 01 00 00 08 00)
IN transaction:        8 bytes (12 01 10 01 E0 01 01 40)
SETUP transaction:     8 bytes (80 06 00 01 00 00 12 00)
IN transaction:        18 bytes (12 01 10 01 E0 01 01 40 12 0A 01 00 20 11
00 00 00 01)
SETUP transaction:     8 bytes (80 06 00 02 00 00 08 00)
IN transaction:        8 bytes (09 02 B1 00 02 01 00 C0)
SETUP transaction:     8 bytes (80 06 00 02 00 00 B1 00)
IN transaction:        64 bytes (09 02 B1 00 02 01 00 C0 00 09 04 00 00 03
E0 01 01 00 07 05 81 03 10 00 01 07 05 02 02 40  00 01 07 05 ...)
IN transaction:        64 bytes (01 01 02 E0 01 01 00 07 05 03 01 09 00 01
07 05 83 01 09 00 01 09 04 01 02 02 E0 01 01 00 07 05 03 01 ...)
IN transaction:        49 bytes (19 00 01 09 04 01 04 02 E0 01 01 00 07 05
03 01 21 00 01 07 05 83 01 21 00 01 09 04 01 05 02 E0 01 01 ...)
SETUP transaction:     8 bytes (00 09 01 00 00 00 00 00)
SETUP transaction:     8 bytes (01 0B 02 00 01 00 00 00)
IN transaction:        6 bytes (0F 04 00 01 00 00)
SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
OUT transaction:    3 bytes (03 10 00)
----------this was the same as in broadcom+2.4.20

SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
OUT transaction:    3 bytes (05 10 00)
IN transaction:        14 bytes(0E 0C 01 03 10 00 FF FF 0F 00 00 00 00 00)
SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
OUT transaction:    3 bytes (09 10 00)
IN transaction:        13 bytes(0E 0B 01 05 10 00 C0 00 40 08 00 08 00)
IN transaction:        12 bytes(0E 0A 01 09 10 00 FE 70 10 DD 09 00)
SETUP transaction:     8 bytes (20 00 00 00 00 00 03 00)
OUT transaction:    3 bytes (25 0C 00)
SETUP transaction:     8 bytes (20 00 00 00 00 00 05 00)
OUT transaction:    5 bytes (05 0C 02 00 C0)
IN transaction:        8 bytes (0E 06 01 25 0C 00 60 00)
SETUP transaction:     8 bytes (20 00 00 00 00 00 05 00)
OUT transaction:    5 bytes (18 0C 02 00 80)
IN transaction:        6 bytes (0E 04 01 05 0C 12)
...

 How to change the code / use a patch to solve this problem in 2.4(broadcom=
)?
Can someone please explain us why 2.4 does not continuesending SETUP, OUT
etc. following sending OUT transaction (3 bytes): 03 10 00 ?
Where in the code the mechaninsm is defied?
Where in the USB/BT specification we can find the meaning of "OUT
transaction (3 bytes): 03 10 00" and other transactions.
  Thanks,
 Michael

------=_Part_8674_10918297.1140002915748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>We would like to setup BT communication on embedded MIPS-processor Bro=
adcom<br>card with Linux 2.4.20 (patched by patch no.18 of M.Holtman).<br>K=
ernel contained USB support, HID support and BlueTooth support (on all<br>

layers).<br>On this card we're using USB-PCI host-controller of Philips (IS=
P1562ES1).<br>We are using Bluez-2.24 library and utils. We also use the li=
brary for<br>userspace-kernelspace USB translation (libusb-0.1.so.4.4.3

).<br><br>We are using CSR based BT dongle with the following description:<=
br>&gt;T:&nbsp; Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D&nbsp=
; 5 Spd=3D12&nbsp; MxCh=3D 0&gt;<br>&gt;D:&nbsp; Ver=3D 1.10 Cls=3De0(unk. =
) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D&nbsp; 1<br>

&gt;P:&nbsp; Vendor=3D0a12 ProdID=3D0001 Rev=3D11.20<br>(as we saw in the s=
upported products list, it is supported.)<br>&nbsp;</div>

<div>When we are connecting the BT dongle to&nbsp;Broadcom (2.4) the Broadc=
om
recognizes it on the USB bus but fails attempting to retrieve from the
dongle BD address.</div>

<div>We tracked all USB urbs in case of Linux 2.6 on desktop vs Linux 2.4 o=
n Broadcom card.</div>

<div>USB transactions are identical (except for device number setting)
up to the point where an OUT transaction is sent with the following
data (recorded using Ellisys):</div>

<div><br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (00 05 02 00 00 00 00 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (80 06 00 01 00 00 08 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 8 bytes (12 01 10 01 E=
0 01 01 40)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (80 06 00 01 00 00 12 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 18 bytes (12 01 10 01 =
E0 01 01 40 12 0A 01 00 20 11 00 00 00 01)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (80 06 00 02 00 00 08 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 8 bytes (09 02 B1 00 0=
2 01 00 C0)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (80 06 00 02 00 00 B1 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 64 bytes (09 02 B1
00 02 01 00 C0 00 09 04 00 00 03 E0 01 01 00 07 05 81 03 10 00 01 07 05
02 02 40&nbsp; 00 01 07 05 ...)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 64 bytes (01 01 02
E0 01 01 00 07 05 03 01 09 00 01 07 05 83 01 09 00 01 09 04 01 02 02 E0
01 01 00 07 05 03 01 ...)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 49 bytes (19 00 01
09 04 01 04 02 E0 01 01 00 07 05 03 01 21 00 01 07 05 83 01 21 00 01 09
04 01 05 02 E0 01 01 ...)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (00 09 01 00 00 00 00 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (01 0B 02 00 01 00 00 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 6 bytes (0F 04 00 01 0=
0 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 03 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 3 bytes (03 10 00)<br>
----------this was the same as in broadcom+2.4.20<br>
<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 03 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 3 bytes (05 10 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 14 bytes(0E 0C 01 03 1=
0 00 FF FF 0F 00 00 00 00 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 03 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 3 bytes (09 10 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 13 bytes(0E 0B 01 05 1=
0 00 C0 00 40 08 00 08 00)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 12 bytes(0E 0A 01 09 1=
0 00 FE 70 10 DD 09 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 03 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 3 bytes (25 0C 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 05 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 5 bytes (05 0C 02 00 C0)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 8 bytes (0E 06 01 25 0=
C 00 60 00)<br>
SETUP transaction: &nbsp;&nbsp;&nbsp; 8 bytes (20 00 00 00 00 00 05 00)<br>
OUT transaction:&nbsp;&nbsp;&nbsp; 5 bytes (18 0C 02 00 80)<br>
IN transaction:&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 6 bytes (0E 04 01 05 0=
C 12)<br>
...<br>
<br>
</div>

<div>How to change the code / use a patch to solve this problem in 2.4 (bro=
adcom)?</div>

<div>Can&nbsp;someone please explain us why 2.4 does not continuesending
SETUP, OUT etc. following&nbsp;sending OUT transaction (3 bytes): 03 10 00 =
?</div>

<div>Where in the code the mechaninsm is defied?</div>

<div>Where in the USB/BT specification we can find the meaning of &quot;OUT=
 transaction (3 bytes): 03 10 00&quot; and other transactions.</div>

&nbsp;
<div>Thanks,</div>
<span class=3D"sg">
<div>Michael</div></span>

------=_Part_8674_10918297.1140002915748--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
