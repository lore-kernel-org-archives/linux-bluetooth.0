Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gene Imes <ebi7@ozob.net>
To: list bluez <bluez-users@lists.sf.net>
Content-Type: text/plain
Message-Id: <1087080981.21738.3.camel@tr1a.ozob.net>
Mime-Version: 1.0
Subject: [Bluez-users] bluepin
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
Date: Sat, 12 Jun 2004 17:56:21 -0500

Sorry about that. I inadvertantly tacked this to another thread. My
apologies.

Anyone know how to fix this:

gene@tr1a:~> bluepin
Xlib: connection to ":0.0" refused by server
Xlib: No protocol specified
 
Traceback (most recent call last):
  File "/usr/bin/bluepin", line 39, in ?
    import gtk
  File "/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py", line
43, in ?    from _gtk import *
RuntimeError: could not open display

Thanks,

Gene





-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
