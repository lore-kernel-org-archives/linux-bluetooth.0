Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Neumeier <dennismail@gmx.net>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1075019314.2741.5.camel@matos.local>
Mime-Version: 1.0
Subject: [Bluez-users] Cannot start bluepin
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
Date: Sun, 25 Jan 2004 09:28:34 +0100

When I try to start bluepin (only for testing purposes, no device
connected) I get follwoing message:

  File "/bin/bluepin", line 34, in ?
    from gtk import *
  File "/usr/lib/python2.3/site-packages/gtk-2.0/gtk/__init__.py", line
43, in ?
    from _gtk import *
RuntimeError: could not open display

I tried to update the python.packages, but this didn´t solve the
problem. 
Any ideas?




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
