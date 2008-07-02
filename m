Return-Path: <cyrus@holtmann.org>
Date: Wed, 02 Jul 2008 11:59:31 +0100
To: bluez-devel@lists.sourceforge.net
From: Capela <ssc@tziranda.com>
MIME-Version: 1.0
Message-ID: <op.udnvhhfuyxjop7@capela.tziranda.net>
Subject: [Bluez-devel] obexd problems in ftp and opush server
Reply-To: ssc@tziranda.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi everyone,

I'm trying to put a working obex server with both opush and ftp on an arm  =

based board. It is a minimal system without much capacity and as such it  =

does not even has an graphical system. It is based in linux kernel  =

2.6.20-4.

I successfully build dbus-1.2.1, bluez-libs-3.35, bluez-utils-3.35,  =

bluez-hcidump-1.42, openobex-1.3, obexftp-0.22 and now obexd-0.1. The  =

obexftpd server included in obexftp does work but does not support opush  =

so I tried obexd.




To get obexd fully running, and since it is a minimal system, I performed  =

the following steps:

arm-linux-dbus-uuidgen --ensure
ln -s /usr/bin/arm-linux-dbus-launch /usr/bin/dbus-launch

dbus-daemon --system
hcid -x -s -d
dbus-daemon --session --print-address --fork

export DBUS_SESSION_BUS_ADDRESS=3Dunix:path=3D/usr/var/run/dbus/system_bus_=
soc
ket,guid=3D4ac461b547be180a59ec802748690912

obexd -n -d -r /mnt/ -a -o -f




With such settings and trying a obex push from a nokia phone to the board  =

I get the following which results in a failed sending:

/ # ./obexd -n -d --root /mnt/ -a -o -f
obexd[817]: Enabling debug information
obexd[817]: Registered: OBEX OPUSH server, record handle: 0x10004, folder:  =

/mnt/
obexd[817]: Registered: OBEX FTP server, record handle: 0x10005, folder:  =

/mnt/
manager_init: conn 0x1bcb0
obexd[817]: New connection from: 00:1E:A4:A6:0C:30 channel: 9
obexd[817]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
obexd[817]: REQ(0x2), CONNECT(0x0), (null)(0x0)
obexd[817]: Version: 0x10. Flags: 0x00  OBEX packet length: 65535
obexd[817]: Resizing stream chunks to 65335
obexd[817]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
obexd[817]: REQHINT(0x1), PUT(0x2), (null)(0x0)
obexd[817]: REQCHECK(0xb), PUT(0x2), (null)(0x0)
obexd[817]: OBEX_HDR_NAME: (null)
obexd[817]: OBEX_HDR_LENGTH: 7650
obexd[817]: OBEX_HDR_TYPE: image/jpeg
obexd[817]: REQDONE(0x3), PUT(0x2), (null)(0x0)

I noticed that OBEX_HDR_NAME was (null) and as I already had a functioning  =

obexftpd server from the openobex project I copy pasted a few lines of  =

code to the obex.c file, more precisely to the following function:

static gboolean check_put(obex_t *obex, obex_objext_t *obj)

Making a diff between the original and the new for the changes:
463a464,470
>             static char *name =3D NULL;
>            if( (name =3D malloc(hlen / 2)))	{
>                 OBEX_UnicodeToChar((uint8_t *)name, hd.bs, hlen);
>                 fprintf(stderr, "put file name: %s\n", name);
>             }
>
466c473,476
< 			debug("OBEX_HDR_NAME: %s", os->name);
---
>            os->name =3D name;
>            debug("OBEX_HDR_NAME: %s", os->name);

This put the opush functioning in my case but certainly is not a solution  =

and I would like to know why It might be happening and if the problem is  =

on my side. Basically g_convert is not returning anything useful in my  =

case.




If I try to use the ftp service from an htc pda I get the following:

/ # ./obexd -n -d --root /mnt/ -a -o -f
obexd[822]: Enabling debug information
obexd[822]: Registered: OBEX OPUSH server, record handle: 0x10004, folder:  =

/mnt/
obexd[822]: Registered: OBEX FTP server, record handle: 0x10005, folder:  =

/mnt/
manager_init: conn 0x1bcb0
obexd[822]: New connection from: 00:17:83:38:61:E4 channel: 10
obexd[822]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
obexd[822]: REQ(0x2), CONNECT(0x0), (null)(0x0)
obexd[822]: Version: 0x10. Flags: 0x00  OBEX packet length: 4096
obexd[822]: Resizing stream chunks to 3896
obexd[822]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
obexd[822]: REQHINT(0x1), SETPATH(0x5), (null)(0x0)
obexd[822]: REQ(0x2), SETPATH(0x5), (null)(0x0)
obexd[822]: Set to root
obexd[822]: REQDONE(0x3), SETPATH(0x5), (null)(0x0)
obexd[822]: REQHINT(0x1), GET(0x3), (null)(0x0)
obexd[822]: REQ(0x2), GET(0x3), (null)(0x0)
obexd[822]: OBEX_HDR_TYPE: x-obex/folder-listing
obexd[822]: REQDONE(0x3), GET(0x3), (null)(0x0)
obexd[822]: REQHINT(0x1), ABORT(0x7f), (null)(0x0)
obexd[822]: ABORT(0x7), (null)(0x51), (null)(0x7f)
obexd[822]: REQHINT(0x1), SETPATH(0x5), (null)(0x0)
obexd[822]: REQ(0x2), SETPATH(0x5), (null)(0x0)
obexd[822]: Set to root
obexd[822]: REQDONE(0x3), SETPATH(0x5), (null)(0x0)

Once again it does not work. The pda does not show an error but it lists  =

an empty directory and any action to that directory like a paste results  =

in error.


Thanks in advance,
-- =

S=E9rgio Pedro dos Santos Capela

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
