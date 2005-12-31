Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Andrew N. Balahonov" <sspp@cityline.ru>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
Message-ID: <Pine.LNX.4.63.0512312154150.23868@sundust>
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="717440693-91372076-1136056222=:23868"
Subject: [Bluez-devel] hci.c:885: storage size of `iv' isn't known
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 31 Dec 2005 22:10:22 +0300 (MSK)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--717440693-91372076-1136056222=:23868
Content-Type: TEXT/PLAIN; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello.
Please suggest anything.

~/bluez/bluez-libs-2.24$ make -s
Making all in include
Making all in src
mkdir .libs
  gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
-D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo  -fPIC=20
-DPIC -o .libs/bluetooth.o
  gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
-D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo -o=20
bluetooth.o >/dev/null 2>&1
  gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
-D_FORTIFY_SOURCE=3D2 -c hci.c -Wp,-MD,.deps/hci.TPlo  -fPIC -DPIC -o=20
.libs/hci.o
hci.c: In function `hci_send_cmd':
hci.c:885: storage size of `iv' isn't known
hci.c:903: warning: implicit declaration of function `writev'
hci.c:885: warning: unused variable `iv'
make[2]: *** [hci.lo] =EF=DB=C9=C2=CB=C1 1
make[1]: *** [all-recursive] =EF=DB=C9=C2=CB=C1 1
make: *** [all] =EF=DB=C9=C2=CB=C1 2

(sorry for cyrillic)

from src/hci.c
      881 int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t pl=
en, void *param)
      882 {
      883         uint8_t type =3D HCI_COMMAND_PKT;
      884         hci_command_hdr hc;
      885         struct iovec iv[3];
      886         int ivn;


/usr/src/linux -> linux-2.4.31-ow1
5.7K 2005-08-19 22:31 /usr/src/linux-2.4.31-ow1/include/net/bluetooth/blu=
etooth.h
$Id: bluetooth.h,v 1.9 2002/05/06 21:11:55 maxk Exp $

18K  2004-08-08 03:26 /usr/src/linux-2.4.31-ow1/include/net/bluetooth/hci=
.h
$Id: hci.h,v 1.5 2002/06/27 17:29:30 maxk Exp $

Thank you.

--=20
Yours sincerely, Andrew N. Balahonov
1024D/3C340684 94B4 C3C5 8936 9DF5 A2B8  3E5C DB3A CC66 3C34 0684
--717440693-91372076-1136056222=:23868--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
