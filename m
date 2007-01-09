Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Roger Barnes <roger@mindsocket.com.au>
Date: Tue, 9 Jan 2007 09:27:59 +0000 (UTC)
Message-ID: <loom.20070109T102250-819@post.gmane.org>
References: <003b01c72f45$bd503e30$0300a8c0@2600xp>
	<459BCF21.5020005@xmission.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Compilation Problem Plugz
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> > a2dpd_dbus.c:31:28: error: dbus/dbus-glib.h: No such file or directory
> > a2dpd_dbus.c:32:37: error: dbus/dbus-glib-lowlevel.h: No such file or
> > directory
> 
> you will need to install libdbus-1-dev and libdbus-glib-1-dev. I just 
> updated the build docs with these.
> 
> Brad
> 

I'm experiencing the same problem here, and have these packages installed
(Ubuntu edgy).  The problem appears to be blank DBUS_CFLAGS in the compile.  My
Makefile contains:
DBUS_CFLAGS = -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include

But the make output shows blanks:
gcc -DHAVE_CONFIG_H -I. -I. -I../..    -I/usr/include -pthread -Wall -O2 -c
a2dpd_dbus.c
a2dpd_dbus.c:31:28: error: dbus/dbus-glib.h: No such file or directory
a2dpd_dbus.c:32:37: error: dbus/dbus-glib-lowlevel.h: No such file or directory

Manually running gcc with the gap filled in worked and got me past this.

Cheers,
- Roger


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
