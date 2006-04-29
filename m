Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@wanadoo.fr>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604291601.43549.menard.fabrice@wanadoo.fr>
Subject: [Bluez-users] DiNovo and evdev
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 29 Apr 2006 16:01:43 +0200

Hi all,

I'm trying to use my dinovo mouse with the evdev driver from xorg in blueto=
oth=20
mode.

I've got a problem with the way the events are handled:

I've got no entry for the mouse in /proc/bus/input/devices before I "shake"=
=20
the device. So, udevstart can't create a node in the /dev directory and X=20
can't start without a proper event number (Device =3D "/dev/input/event4" i=
n=20
xorg.conf).

So, here is the question:
Is there a way to make appear the mouse in /proc/bus/input/devices without=
=20
having to move the device ?

Thanks.

=2D-=20
=46abrice M=E9nard
menard.fabrice@wanadoo.fr



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
