Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Geert Geurts <geert@ebm.nl>
To: bluez-users@lists.sourceforge.net
Message-Id: <1079973771.5419.24.camel@geert.ebm.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] sendmsg: No buffer space available
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 22 Mar 2004 17:42:51 +0100

Hello, I've got a problem with my usb-dongle...
as soon as I put request too much traffic over ppp (a webpage is too
much, ping is no problem) the connection is broken...
when I try to ping over the ppp after I got the timeout on my palm, I
get sendmsg: No buffer space available 
when I do the same when I didn't get the timeout message yet I get a
normal reply...

I found out that I have the same problem when I try connecting via
normal cradle/cable...
no matter witch speed I set! well tried 19200 without success...

I'm using gentoo linux
devfs and usbfs
2.4.23-ck3-mh2 kernel
bluez-kernel-2.3
bluez-libs-2.4
bluez-pan-1.1
bluez-sdp-1.5
bluez-utils-2.3-r1



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
