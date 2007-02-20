Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4f436aae0702201137g12c4dfd0k96201c2f2f38df26@mail.gmail.com>
Date: Tue, 20 Feb 2007 21:37:08 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4f436aae0702192256p8fb5182web7a3aa633eb1025@mail.gmail.com>
MIME-Version: 1.0
References: <4f436aae0702192256p8fb5182web7a3aa633eb1025@mail.gmail.com>
Subject: [Bluez-users] bluez-utils-3.9 compilation error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hello.

I try to build bluez-utils but I get errors.
I do ./configure with no problems.
but in the make I get these errors:

libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
dbus-common.c:(.text+0x90): undefined reference to
`sdp_device_record_unregister_binary'
libhciserver.a(dbus-common.o): In function `register_sdp_binary':
dbus-common.c:(.text+0x106): undefined reference to
`sdp_device_record_register_binary'
collect2: ld returned 1 exit status

dows anyone have any clue ?

thanks a lot
choi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
