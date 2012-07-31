Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 31 Jul 2012 17:53:30 +0200
Message-ID: <CAJKEbdeVZA+WK8AMNCKCrVgpVchMHQ=XyAnZ7w7H0eX2y48evQ@mail.gmail.com>
Subject: [PATCH] please add VID/PID to ath3k (AR3012)
From: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, shafi.ath9k@gmail.com,
	gustavo@padovan.org
Content-Type: multipart/alternative; boundary=e89a8f6435560ea30c04c6222e70
List-ID: <linux-bluetooth.vger.kernel.org>

--e89a8f6435560ea30c04c6222e70
Content-Type: text/plain; charset=ISO-8859-1

hi,

the VID/PID in the patch belong to a Sony Vaio T-Series.

thx

diff -c2 drivers/bluetooth/ath3k.c drivers/bluetooth-patched/ath3k.c
*** drivers/bluetooth/ath3k.c    2012-07-31 16:09:41.274043862 +0200
--- drivers/bluetooth-patched/ath3k.c    2012-07-31 16:23:59.390051062 +0200
***************
*** 80,83 ****
--- 80,84 ----
      { USB_DEVICE(0x0CF3, 0xE004) },
      { USB_DEVICE(0x0930, 0x0219) },
+     { USB_DEVICE(0x0489, 0xe036) },

      /* Atheros AR5BBU12 with sflash firmware */
***************
*** 109,112 ****
--- 110,115 ----
      { USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },

+     { USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
+
      { }    /* Terminating entry */
  };
diff -c2 drivers/bluetooth/btusb.c drivers/bluetooth-patched/btusb.c
*** drivers/bluetooth/btusb.c    2012-07-31 16:09:41.274043862 +0200
--- drivers/bluetooth-patched/btusb.c    2012-07-31 16:23:59.390051062 +0200
***************
*** 142,145 ****
--- 142,146 ----
      { USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
      { USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+     { USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },

      /* Atheros AR5BBU12 with sflash firmware */

--e89a8f6435560ea30c04c6222e70
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br><br>the VID/PID in the patch belong to a Sony Vaio T-Series.<br><br>=
thx<br><br>diff -c2 drivers/bluetooth/ath3k.c drivers/bluetooth-patched/ath=
3k.c<br>*** drivers/bluetooth/ath3k.c=A0=A0=A0 2012-07-31 16:09:41.27404386=
2 +0200<br>
--- drivers/bluetooth-patched/ath3k.c=A0=A0=A0 2012-07-31 16:23:59.39005106=
2 +0200<br>***************<br>*** 80,83 ****<br>--- 80,84 ----<br>=A0 =A0=
=A0=A0 { USB_DEVICE(0x0CF3, 0xE004) },<br>=A0 =A0=A0=A0 { USB_DEVICE(0x0930=
, 0x0219) },<br>+=A0=A0=A0=A0 { USB_DEVICE(0x0489, 0xe036) },<br>
=A0 <br>=A0 =A0=A0=A0 /* Atheros AR5BBU12 with sflash firmware */<br>******=
*********<br>*** 109,112 ****<br>--- 110,115 ----<br>=A0 =A0=A0=A0 { USB_DE=
VICE(0x0489, 0xE03C), .driver_info =3D BTUSB_ATH3012 },<br>=A0 <br>+=A0=A0=
=A0=A0 { USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },<br>
+ <br>=A0 =A0=A0=A0 { }=A0=A0=A0 /* Terminating entry */<br>=A0 };<br>diff =
-c2 drivers/bluetooth/btusb.c drivers/bluetooth-patched/btusb.c<br>*** driv=
ers/bluetooth/btusb.c=A0=A0=A0 2012-07-31 16:09:41.274043862 +0200<br>--- d=
rivers/bluetooth-patched/btusb.c=A0=A0=A0 2012-07-31 16:23:59.390051062 +02=
00<br>
***************<br>*** 142,145 ****<br>--- 142,146 ----<br>=A0 =A0=A0=A0 { =
USB_DEVICE(0x0cf3, 0xe004), .driver_info =3D BTUSB_ATH3012 },<br>=A0 =A0=A0=
=A0 { USB_DEVICE(0x0930, 0x0219), .driver_info =3D BTUSB_ATH3012 },<br>+=A0=
=A0=A0=A0 { USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },<b=
r>
=A0 <br>=A0 =A0=A0=A0 /* Atheros AR5BBU12 with sflash firmware */<br>

--e89a8f6435560ea30c04c6222e70--
