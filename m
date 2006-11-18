Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 18 Nov 2006 15:01:36 -0800
From: Andres Vargas - zodman <zod@linuxmerida.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061118150136.727e8084@localhost.localdomain>
In-Reply-To: <001f01c70b4c$c31f0ac0$0200a8c0@BLACKBIRD>
References: <20061118134050.3ea29147@localhost.localdomain>
	<001f01c70b4c$c31f0ac0$0200a8c0@BLACKBIRD>
Mime-Version: 1.0
Subject: Re: [Bluez-users] VB:  Problem with 2nd second dongle
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

yeap search on your hcid.conf file for the pin ..... in debian default is 1=
234

On Sat, 18 Nov 2006 21:04:29 +0100
H=E5kan Lager <hakan@digiloo.net> wrote:

> Also if the pin asking thing is commented in hcid.conf?
> =

> / Hakan
> =

> -----Ursprungligt meddelande-----
> Fr=E5n: bluez-users-bounces@lists.sourceforge.net
> [mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Andres Vargas -
> zodman
> Skickat: den 18 november 2006 22:41
> Till: bluez-users@lists.sourceforge.net
> =C4mne: Re: [Bluez-users] VB: Problem with 2nd second dongle
> =

> yeap because hcid function with dbus
> =

> lagrutadelzod:/home/andy# /etc/init.d/dbus  stop
> Stopping system message bus: dbus.
> lagrutadelzod:/home/andy# pkill hcid
> lagrutadelzod:/home/andy# hcid -n -f /etc/bluetooth/hcid.conf
> hcid[18150]: Bluetooth HCI daemon
> hcid[18150]: Unknown option 'piscan' line 12
> hcid[18150]: Can't open system message bus connection: Failed to
> connect to socket /var/run/dbus/system_bus_socket: No such file or
> directory hcid[18150]: Unable to get on D-Bus
> =

> :'(
> =

> lagrutadelzod:/home/andy# /etc/init.d/dbus  start
> Starting system message bus: dbus.
> lagrutadelzod:/home/andy# hcid -n -f /etc/bluetooth/hcid.conf
> hcid[18161]: Bluetooth HCI daemon
> hcid[18161]: Unknown option 'piscan' line 12
> hcid[18161]: Register path:/org/bluez fallback:1
> hcid[18161]: HCI dev 0 registered
> hcid[18161]: Register path:/org/bluez/hci0 fallback:0
> hcid[18161]: HCI dev 0 already up
> hcid[18161]: Device hci0 has been added
> hcid[18161]: Starting security manager 0
> hcid[18161]: Device hci0 has been activated
> =

> :PPPPPPPPPPPPPPPPPP
> =

> the hcid needs dbus .... =

> =

> On Sat, 18 Nov 2006 18:02:14 +0100
> H=E5kan Lager <hakan@digiloo.net> wrote:
> =

> > Do I need dbus if I only use BT for sending?
> > =

> > / Hakan
> > =

> > =

> > -----Ursprungligt meddelande-----
> > Fr=E5n: bluez-users-bounces@lists.sourceforge.net
> > [mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Andres Vargas -
> > zodman
> > Skickat: den 18 november 2006 19:32
> > Till: bluez-users@lists.sourceforge.net
> > =C4mne: Re: [Bluez-users] VB: Problem with 2nd second dongle
> > =

> > you need start the dbus daemon
> > =

> > /etc/init.d/dbus start
> > =

> > On Sat, 18 Nov 2006 16:08:04 +0100
> > H=E5kan Lager <hakan@digiloo.net> wrote:
> > =

> > > =

> > > Hi,
> > > =

> > > Here is the result:
> > > =

> > > 0)
> > > =

> > > $ ./hcid -n
> > > hcid[205]: Bluetooth HCI daemon
> > > Failed to open connection to system message bus: Failed to connect to
> > socket
> > > /var/run/dbus/system_bus_socket: No such file or directory
> > > =

> > > hcid[205]: Unable to get on D-BUS
> > > =

> > > 1) $ insmod hci_usb.o isoc=3D0
> > > Using /bluetooth/mod/hci_usb.o
> > > insmod: invalid parameter isoc
> > > =

> > > 2) See appended file =

> > >  =

> > > =

> > > -----Ursprungligt meddelande-----
> > > Fr=E5n: bluez-users-bounces@lists.sourceforge.net
> > > [mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Marcel Holtm=
ann
> > > Skickat: den 16 november 2006 11:32
> > > Till: BlueZ users
> > > =C4mne: Re: [Bluez-users] VB: Problem with 2nd second dongle
> > > =

> > > Hi Hakan,
> > > =

> > > > I begin to suspect this is a dbus error. Is there any simple way to
> > check
> > > > this suspicion?
> > > =

> > > it can't be a D-Bus error. Please try to load the hci_usb driver with
> > > isoc=3D0. What does "lsusb" actually tell you?
> > > =

> > > Regards
> > > =

> > > Marcel
> > > =

> > > =

> > > =

> > >
> -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to sha=
re
> > your
> > > opinions on IT & business topics through brief surveys - and earn cash
> > >
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > =

> > =

> =

> =



-- =


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
