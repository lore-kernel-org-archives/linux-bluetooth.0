Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 24 Aug 2006 23:31:30 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060824203130.GA7420@localhost.localdomain>
References: <8712867d0608231353l6aa027bbha331a44392231f92@mail.gmail.com>
	<8712867d0608231418ld76b304oc8ae4ba1d8269d56@mail.gmail.com>
	<1156410090.4133.68.camel@aeonflux.holtmann.net>
	<8712867d0608240646n3ae773d6h271ba57ef06771cf@mail.gmail.com>
	<20060824141134.GA3181@localhost.localdomain>
	<8712867d0608240751g5efef440q4474334bc7d0a7fc@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <8712867d0608240751g5efef440q4474334bc7d0a7fc@mail.gmail.com>
Subject: Re: [Bluez-users] Fwd: bluez-utils: The inquiry scan (ISCAN) gets
	turned off
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

On Thu, Aug 24, 2006, Jaime Alberto Silva wrote:
> Can you, please, point me to some documentation about dbus usage and
> how to discover the methods registered by bluez?.

You can find a description of the bluez D-Bus API in the 
hcid/dbus-api.txt file that comes along with bluez-utils (you'll have to 
use version 3.3 since it wasn't included before that).

About D-Bus usage, well, by googling you should be able to find several 
places with some documentation, though I have to admit that some of the 
higher level bindings lack good documentation. E.g. the lowlevel API 
description can be found here:
http://dbus.freedesktop.org/doc/api/html/group__DBus.html

If you want to specifically use the bluez D-Bus API you could e.g. take 
a look at the source code of the new bluez-gnome package (which uses the 
GLib bindings of D-Bus) or the hcid/dbus-test script which is part of 
the bluez-utils package (it uses the python bindings and contains 
examples of pretty much every feature of the bluez D-Bus API).

> Another example will be nice, something like... How to set the 
> discover timeout with dbus

Set the discoverable timeout:
dbus-send --system --dest=org.bluez /org/bluez/hci0 \
	org.bluez.Adapter.SetDiscoverableTimeout uint32:100

Get the discoverable timeout:
dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0 \
	org.bluez.Adapter.GetDiscoverableTimeout

> Thanks for your help!

No problem :)

Johan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
