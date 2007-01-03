Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459BCF21.5020005@xmission.com>
Date: Wed, 03 Jan 2007 08:43:29 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        thomaslloyd82@hotmail.com
References: <003b01c72f45$bd503e30$0300a8c0@2600xp>
In-Reply-To: <003b01c72f45$bd503e30$0300a8c0@2600xp>
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

Tom

> a2dpd_dbus.c:31:28: error: dbus/dbus-glib.h: No such file or directory
> a2dpd_dbus.c:32:37: error: dbus/dbus-glib-lowlevel.h: No such file or
> directory

you will need to install libdbus-1-dev and libdbus-glib-1-dev. I just 
updated the build docs with these.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
