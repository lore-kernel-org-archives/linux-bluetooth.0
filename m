Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <401A269C.7070104@ei.tum.de>
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: bluez-users <bluez-users@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] cmtp, capidrv and kernel 2.6
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
Date: Fri, 30 Jan 2004 10:40:44 +0100

Hi Marcel et al,

could anyone give a hint what changes are necessary from kernel 2.4.X to 
2.6.X to get an isdn dialup setup via cmtp and capidrv (i4l)?

I have a very well working setup for 2.4.22-mh2, essentially following 
Marcel's (BTW excellent :) instructions from 
http://www.holtmann.org/linux/bluetooth/isdn.html and had a quick try 
using the same setup on an unpatched 2.6.2-rc2 vanilla kernel, getting 
the following symptoms:

- cmtp and kernelcapi are loaded and connecting to an AP-X works
- capiinfo and capiinit complain about not being able to load 
kernelcapi, although it is already loaded
- capidrv isn't loaded automatically any more
- "/etc/init.d/isdnutils start" complains about /dev/isdnctrl (because 
of missing capidrv?)
- when modprobing capidrv the console is flooded with messages

I use debian/unstable with the latest isdn and capi packages (3.3-7).

Do I need any kernel patches (e.g. the i4l patch from 
http://rcum.uni-mb.si/~uvp00845b/)?
Do I have to modify the module loading definitions in /etc/modutils?
Does pppdcapiplugin work without additional kernel patches?

Regards.
Matthias



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
