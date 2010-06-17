Return-Path: <cyrus@holtmann.org>
From: Vladimir Davydov <vladimir.davydov@promwad.com>
To: linux-bluetooth@vger.kernel.org
Subject: Timeout in hciattach
Date: Thu, 17 Jun 2010 13:20:30 +0300
Cc: Sergey Kovalev <sergey.kovalev@promwad.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ubfGMGhk093XE2Y"
Message-Id: <201006171320.30987.vladimir.davydov@promwad.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_ubfGMGhk093XE2Y
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, All

I have found that in the latest release of the bluez4 (4.66) timeout in=20
hciattach doesn't work.

Look at this code of hciattach.c:

static void bcsp_tshy_sig_alarm(int sig)
{
	unsigned char bcsp_sync_pkt[10] =3D=20
{0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
	int len, retries =3D 0;

	if (retries < bcsp_max_retries) {
		retries++;
		len =3D write(serial_fd, &bcsp_sync_pkt, 10);
		alarm(1);
		return;
	}

	tcflush(serial_fd, TCIOFLUSH);
	fprintf(stderr, "BCSP initialization timed out\n");
	exit(1);
}

The variable 'retries' will be always 0. Why is it not static? It was stati=
c=20
in oldest releases (3.33 for example).

I have attached simple patch to fix that.

Best regards,
Vladimir

=2D-=20
Vladimir Davydov
Senior Developer
Promwad Innovation Company
Web: www.promwad.com
22, Olshevskogo St.,
220073, Minsk,
BELARUS
Phone/Fax: +375 (17) 312=E2=80=931246
E-mail: vladimir.davydov@promwad.com
Skype: v_davydov

--Boundary-00=_ubfGMGhk093XE2Y
Content-Type: text/x-patch;
  charset="UTF-8";
  name="hciattach-timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hciattach-timeout.patch"

diff -urN bluez-4.42.orig/tools/hciattach.c bluez-4.42/tools/hciattach.c
--- bluez-4.42.orig/tools/hciattach.c	2009-05-19 12:04:10.000000000 +0300
+++ bluez-4.42/tools/hciattach.c	2010-06-16 17:39:01.477248730 +0300
@@ -326,7 +326,8 @@
 static void bcsp_tshy_sig_alarm(int sig)
 {
 	unsigned char bcsp_sync_pkt[10] = {0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
-	int len, retries = 0;
+	int len;
+	static int retries = 0;
 
 	if (retries < bcsp_max_retries) {
 		retries++;

--Boundary-00=_ubfGMGhk093XE2Y--
