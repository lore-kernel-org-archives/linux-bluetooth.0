Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <fb2ac3c90708092110y3a4ffff1ka8d5ea1ebdd17e32@mail.gmail.com>
Date: Thu, 9 Aug 2007 22:10:20 -0600
From: "Andrew Jorgensen" <andrew.jorgensen@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth-applet and gnome-vfs-obexftp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Version 0.10 of bluez-gnome added support for "browsing devices" - a
much needed feature by any account.  What I'm not thrilled about is
that it was written to support gnome-vfs-obexftp.

Don't get me wrong - gnome-vfs-obexftp is awesome, but
bluetooth-applet is the wrong entry point for it.  The applet should
allow you to see what devices are around you and allow you to initiate
a bonding with them but the assumption that you want to browse OBEX is
bad.

Another problem with this approach is that it creates a dependency on
gnome-vfs-obexftp and assumes that it's present.  If it's desirable to
have the applet launch other programs it should support more than
obex:// and there should be some generic mechanism for programs to
plug themselves in as handling a given service.  It should be possible
some day to get a bluetooth mouse working from the GUI, or a bluetooth
headset, for example.

Of course there needs to be better integration of gnome-vfs-obexftp,
but that integration should be in nautilus where everything else
vfs-related is found.  A bluetooth link under computer:/// when an
adapter is present would be sufficient (though I wish we'd treat OBEX
more generically as well - it's got 3 or 4 transports besides
bluetooth).

Other thoughts?

Andrew Jorgensen

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
