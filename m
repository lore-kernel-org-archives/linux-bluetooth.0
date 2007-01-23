Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 10:24:03 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20070123092403.GD11595@suse.de>
References: <45B4D221.4090303@illokken.net> <20070122180351.GA14726@suse.de>
	<45B53179.9030401@illokken.net>
MIME-Version: 1.0
In-Reply-To: <45B53179.9030401@illokken.net>
Subject: Re: [Bluez-users] Bluetooth mouse on openSUSE 10.2 needs
	rootpassword on every reconnect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi H=E5var,

On Mon, Jan 22, 2007 at 10:49:45PM +0100, H=E5var Nielsen wrote:
> Hi Stefan,
> =

> Thanks for the answer. I've tried what you suggested, checked that both
> hidd and dbus are running just after boot-up. They are:
> > ps aux | grep hidd
> 	root      1922  0.0  0.0   1820   456 ?        S<s  21:56   0:00
> /usr/bin/hidd --server
> 	havar     4087  0.0  0.0   2860   716 pts/0    R+   22:07   0:00 grep hi=
dd
> =

> > ps aux | grep dbus
> 	100       2700  0.0  0.0   3628  1060 ?        Ss   21:56   0:00
> /usr/bin/dbus-daemon --system
> 	havar     3821  0.0  0.0   3724   884 ?        Ss   21:59   0:00
> /usr/bin/dbus-daemon --fork --print-pid 4 --print-address 6 --session
> 	havar     4091  0.0  0.0   2856   712 pts/0    R+   22:07   0:00 grep db=
us
> =

> Since you said that dbus needs to start before bluetooth, I opened YaST
> and saw to it that dbus starts at run levels: 1,2,3,5,6,S and bluetooth
> now starts at runlevels 6 and S. What puzzles me is that bluetooth
> actually was disabled (originally set to not start during boot), but it
> started during boot anyways. - I have no idea on which boot-script or
> how it got started.

It gets started by udev when the adapter is plugged in. On a regular boot
this is before DBus is started, though, so it won't work. We fixed this
with an update to the bluez packages.
Just enabling the bluetooth service to always start on every boot is also an
option, you can do this in YaST or simply with "insserv bluetooth".

> Still the mouse won't work properly and I still have to use the sudo
> hidd --search or --connect commands to connect the mouse. Don't have to
> run hidd --server though, cause it is already running.
> =

> And even though the hidd --server is running, the mouse doesn't
> reconnect when I turn it off and on again nor when it comes out of
> power-saving.

This is strange and does not sound like a SUSE-specific bug (to me :-)
It works fine for me with a Logitech MX1000 and a CSR based Epox mouse.
It might still be a service-start-ordering problem.
Try restarting the bluez daemons with "service bluetooth restart" and
check if the mouse will reconnect afterwards. If it does not, i have
no real idea what could be the problem.

> Disabling and re-enabling the internal bluetooth dongle didn't work eithe=
r.
> =

> My hardware is a Dell Latitude X1 laptop and a Logitech V270 mouse.
> > lsusb
> Bus 003 Device 002: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetoo=
th
> > hidd --show
> 00:07:61:4A:1B:EF Bluetooth HID Boot Protocol Device [046d:b002]
> connected [boot-protocol]
> =

> I just got the mouse connected without using sudo =3D)
> > hidd --connect 00:07:61:4a:1b:ef
> HID create error 13 (Permission denied)
> But the mouse started working (had to press the reset button on the
> mouse though). At least some progress.
> =

> Anyhow, I appreciate the answer.
> =

> (A bit tired from reading SuSE boot-scripts for many hours today and
> yesterday).

I can understand that :-)

Good Luck,
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
