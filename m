Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 21 Sep 2012 22:45:40 +0200
Message-ID: <CAAq6ZEKA8rE7BHQ1rAM3Ax0a4EUGVrHbkEZfXouTpbPbKYVOqw@mail.gmail.com>
Subject: ATH3012 bluetooth not working in kernel-3.2.x
From: Giorgio Cardarelli <giorgio.cardarelli@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=f46d042f9f78b1283604ca3c52b8
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d042f9f78b1283604ca3c52b8
Content-Type: multipart/alternative; boundary=f46d042f9f78b1282f04ca3c52b6

--f46d042f9f78b1282f04ca3c52b6
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I have an Atheros ATH3012 bluetooth chip not working under Ubuntu 12.04
(kernel 3.2.0-30, Ubuntu patched).

This is an excerpt from lsusb -v:

Bus 001 Device 004: ID 0489:e036 Foxconn / Hon Hai
Device Descriptor:
bLength 18
bDescriptorType 1
bcdUSB 1.10
bDeviceClass 224 Wireless
bDeviceSubClass 1 Radio Frequency
bDeviceProtocol 1 Bluetooth
bMaxPacketSize0 64
idVendor 0x0489 Foxconn / Hon Hai
idProduct 0xe036
bcdDevice 0.02
iManufacturer 1 Atheros Communications
iProduct 2 Bluetooth USB Host Controller
iSerial 3 Alaska Day 2006
bNumConfigurations 1

Basicly following what's explained here
http://wireless.kernel.org/en/users/Drivers/ath3k I've produced the patch
attached to this e-mail, which fixes the problem for my chip.

I've checked with vanilla kernel v3.2.30, and the patch applies for that
kernel too. Vanilla v3.5.4 is slightly different, but I think the problem
is still there.

I hope I've followed the right steps for submitting a bugfix.

HTH,
Giorgio

Signed-off-by: Giorgio Cardarelli <giorgio.cardarelli@gmail.com>

--f46d042f9f78b1282f04ca3c52b6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,<br></div><div><br></div><div>I have an Atheros ATH3012 bluetoot=
h chip not working under Ubuntu 12.04 (kernel 3.2.0-30, Ubuntu patched).</d=
iv><div><br></div><div>This is an excerpt from lsusb -v:</div><div><br></di=
v>
<div>Bus 001 Device 004: ID 0489:e036 Foxconn / Hon Hai <br>Device Descript=
or:<br>  bLength                18<br>  bDescriptorType         1<br>  bcdU=
SB               1.10<br>  bDeviceClass          224 Wireless<br>  bDeviceS=
ubClass         1 Radio Frequency<br>
  bDeviceProtocol         1 Bluetooth<br>  bMaxPacketSize0        64<br>  i=
dVendor           0x0489 Foxconn / Hon Hai<br>  idProduct          0xe036 <=
br>  bcdDevice            0.02<br>  iManufacturer           1 Atheros Commu=
nications<br>
  iProduct                2 Bluetooth USB Host Controller<br>  iSerial     =
            3 Alaska Day 2006<br>  bNumConfigurations      1<br></div><div>=
<br></div><div>Basicly following what&#39;s explained here <a href=3D"http:=
//wireless.kernel.org/en/users/Drivers/ath3k">http://wireless.kernel.org/en=
/users/Drivers/ath3k</a> I&#39;ve produced the patch attached to this e-mai=
l, which fixes the problem for my chip.</div>
<div><br></div><div>I&#39;ve checked with vanilla kernel v3.2.30, and the p=
atch applies for that kernel too. Vanilla v3.5.4 is slightly different, but=
 I think the problem is still there.</div><div><br></div><div>I hope I&#39;=
ve followed the right steps for submitting a bugfix.</div>
<div><br></div><div>HTH,</div><div>Giorgio</div><div><br></div><div>Signed-=
off-by: Giorgio Cardarelli &lt;<a href=3D"mailto:giorgio.cardarelli@gmail.c=
om">giorgio.cardarelli@gmail.com</a>&gt;</div><div><br></div><div><br></div=
>

--f46d042f9f78b1282f04ca3c52b6--

--f46d042f9f78b1283604ca3c52b8
Content-Type: application/octet-stream; name="ATH3012.patch"
Content-Disposition: attachment; filename="ATH3012.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7dr3i970

LS0tIGRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMub2xkCTIwMTItMDktMjEgMjE6Mjk6MzIuNDYz
Mzk4NjIzICswMjAwCisrKyBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCTIwMTItMDktMjEgMjE6
MzI6NDQuMjM5MzkwNjA0ICswMjAwCkBAIC0xNDEsNiArMTQxLDcgQEAKIAl7IFVTQl9ERVZJQ0Uo
MHgwNGNhLCAweDMwMDUpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9BVEgzMDEyIH0sCiAJeyBVU0Jf
REVWSUNFKDB4MTNkMywgMHgzMzYyKSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfQVRIMzAxMiB9LAog
CXsgVVNCX0RFVklDRSgweDBjZjMsIDB4ZTAwNCksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX0FUSDMw
MTIgfSwKKwl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweGUwMzYpLCAuZHJpdmVyX2luZm8gPSBCVFVT
Ql9BVEgzMDEyIH0sCiAKIAkvKiBBdGhlcm9zIEFSNUJCVTEyIHdpdGggc2ZsYXNoIGZpcm13YXJl
ICovCiAJeyBVU0JfREVWSUNFKDB4MDQ4OSwgMHhlMDJjKSwgLmRyaXZlcl9pbmZvID0gQlRVU0Jf
SUdOT1JFIH0sCi0tLSBkcml2ZXJzL2JsdWV0b290aC9hdGgzay5jLm9sZAkyMDEyLTA5LTIxIDIx
OjI5OjIxLjY0MzM5OTA3NyArMDIwMAorKysgZHJpdmVycy9ibHVldG9vdGgvYXRoM2suYwkyMDEy
LTA5LTIxIDIxOjMzOjA0LjI5MTM4OTc2NCArMDIwMApAQCAtNzYsNiArNzYsNyBAQAogCXsgVVNC
X0RFVklDRSgweDA0Q0EsIDB4MzAwNSkgfSwKIAl7IFVTQl9ERVZJQ0UoMHgxM2QzLCAweDMzNjIp
IH0sCiAJeyBVU0JfREVWSUNFKDB4MENGMywgMHhFMDA0KSB9LAorCXsgVVNCX0RFVklDRSgweDA0
ODksIDB4RTAzNikgfSwKIAogCS8qIEF0aGVyb3MgQVI1QkJVMTIgd2l0aCBzZmxhc2ggZmlybXdh
cmUgKi8KIAl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweEUwMkMpIH0sCkBAIC0xMDAsNiArMTAxLDcg
QEAKIAl7IFVTQl9ERVZJQ0UoMHgwNGNhLCAweDMwMDUpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9B
VEgzMDEyIH0sCiAJeyBVU0JfREVWSUNFKDB4MTNkMywgMHgzMzYyKSwgLmRyaXZlcl9pbmZvID0g
QlRVU0JfQVRIMzAxMiB9LAogCXsgVVNCX0RFVklDRSgweDBjZjMsIDB4ZTAwNCksIC5kcml2ZXJf
aW5mbyA9IEJUVVNCX0FUSDMwMTIgfSwKKwl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweEUwMzYpLCAu
ZHJpdmVyX2luZm8gPSBCVFVTQl9BVEgzMDEyIH0sCiAKIAkvKiBBdGhlcm9zIEFSNUJCVTIyIHdp
dGggc2ZsYXNoIGZpcm13YXJlICovCiAJeyBVU0JfREVWSUNFKDB4MDQ4OSwgMHhFMDNDKSwgLmRy
aXZlcl9pbmZvID0gQlRVU0JfQVRIMzAxMiB9LAo=
--f46d042f9f78b1283604ca3c52b8--
