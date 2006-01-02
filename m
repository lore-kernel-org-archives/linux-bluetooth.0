Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci.c:885: storage size of `iv' isn't known
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.63.0512312154150.23868@sundust>
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
	 <Pine.LNX.4.63.0512312154150.23868@sundust>
Content-Type: text/plain; charset=utf-8
Message-Id: <1136201460.22810.10.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 02 Jan 2006 12:31:00 +0100

Hi Andrew,

> Please suggest anything.
>=20
> ~/bluez/bluez-libs-2.24$ make -s
> Making all in include
> Making all in src
> mkdir .libs
>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
> -D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo  -fPI=
C=20
> -DPIC -o .libs/bluetooth.o
>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
> -D_FORTIFY_SOURCE=3D2 -c bluetooth.c -Wp,-MD,.deps/bluetooth.TPlo -o=20
> bluetooth.o >/dev/null 2>&1
>   gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../include -Wall -O2=20
> -D_FORTIFY_SOURCE=3D2 -c hci.c -Wp,-MD,.deps/hci.TPlo  -fPIC -DPIC -o=20
> .libs/hci.o
> hci.c: In function `hci_send_cmd':
> hci.c:885: storage size of `iv' isn't known
> hci.c:903: warning: implicit declaration of function `writev'
> hci.c:885: warning: unused variable `iv'
> make[2]: *** [hci.lo] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 1
> make[1]: *** [all-recursive] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 1
> make: *** [all] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 2

this is strange. What kind of system is this? What kind of compiler do
you use?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
