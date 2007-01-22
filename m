Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45B53179.9030401@illokken.net>
Date: Mon, 22 Jan 2007 22:49:45 +0100
From: =?ISO-8859-1?Q?H=E5var_Nielsen?= <havar@illokken.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45B4D221.4090303@illokken.net> <20070122180351.GA14726@suse.de>
In-Reply-To: <20070122180351.GA14726@suse.de>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Stefan,

Thanks for the answer. I've tried what you suggested, checked that both
hidd and dbus are running just after boot-up. They are:
> ps aux | grep hidd
	root      1922  0.0  0.0   1820   456 ?        S<s  21:56   0:00
/usr/bin/hidd --server
	havar     4087  0.0  0.0   2860   716 pts/0    R+   22:07   0:00 grep hidd

> ps aux | grep dbus
	100       2700  0.0  0.0   3628  1060 ?        Ss   21:56   0:00
/usr/bin/dbus-daemon --system
	havar     3821  0.0  0.0   3724   884 ?        Ss   21:59   0:00
/usr/bin/dbus-daemon --fork --print-pid 4 --print-address 6 --session
	havar     4091  0.0  0.0   2856   712 pts/0    R+   22:07   0:00 grep dbus

Since you said that dbus needs to start before bluetooth, I opened YaST
and saw to it that dbus starts at run levels: 1,2,3,5,6,S and bluetooth
now starts at runlevels 6 and S. What puzzles me is that bluetooth
actually was disabled (originally set to not start during boot), but it
started during boot anyways. - I have no idea on which boot-script or
how it got started.

Still the mouse won't work properly and I still have to use the sudo
hidd --search or --connect commands to connect the mouse. Don't have to
run hidd --server though, cause it is already running.

And even though the hidd --server is running, the mouse doesn't
reconnect when I turn it off and on again nor when it comes out of
power-saving.

Disabling and re-enabling the internal bluetooth dongle didn't work either.

My hardware is a Dell Latitude X1 laptop and a Logitech V270 mouse.
> lsusb
Bus 003 Device 002: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetooth
> hidd --show
00:07:61:4A:1B:EF Bluetooth HID Boot Protocol Device [046d:b002]
connected [boot-protocol]

I just got the mouse connected without using sudo =3D)
> hidd --connect 00:07:61:4a:1b:ef
HID create error 13 (Permission denied)
But the mouse started working (had to press the reset button on the
mouse though). At least some progress.

Anyhow, I appreciate the answer.

(A bit tired from reading SuSE boot-scripts for many hours today and
yesterday).

With thanks,
H=E5var

Stefan Seyfried wrote:
> Hi H=E5var,
> =

> On Mon, Jan 22, 2007 at 04:02:57PM +0100, H=E5var Nielsen wrote:
> =

>> Dear all,
>>
>> I need some help with my bluetooth mouse.
>>
>> I just went from ubuntu to openSuSE on my laptop. Everything except for
>> the bluetooth mouse is working.
>>
>> I have tried a lot of approaches really, but none seem to work. No
>> matter what I do, I have to use the command sudo hidd --connect ... to
>> make my mouse connect to the computer or vice versa (computer to mouse)
>> every time I want to use the mouse. - That means I also have to type the
>> root password each time I want to use the mouse.
>>
>> On ubuntu this was really as simple as adding a line with 'hidd
>> - --server' in /etc/rc.local. Then after I had connected my mouse with t=
he
>> hidd --connect command once, it always reconnected by itself, even after
>> restarts and such.
>>
>> This approach doesn't seem to work in openSuSE however, even when using
>> the ubuntu (default) /etc/bluetooth/hcid.conf file. Why is that?
> =

> The hcid.conf is mostly obsolete (IMO) in bluez-3.x since all the settings
> are now remembered for every adapter in /var/lib/bluetooth/* and can be
> set via the DBus API..
> =

>> In SuSE, I must go to a terminal, become root and do:
>> hidd --server

> =

> Don't do that. Rather investigate why the bluetooth init script does not
> start hidd for you.
> =

> Check if HID is enabled in /etc/sysconfig/bluetooth:
> root@strolchi:~# grep ^HID_ /etc/sysconfig/bluetooth
> HID_START=3D"yes"
> HID_DAEMON=3D"/usr/bin/hidd"
> HID_DAEMON_ARGS=3D"--server"
> =

> I then just connected my keyboard and mouse once after installation with
> "hidd --search", then pressed the connect button on the keyboard and on t=
he
> mouse ant it is working happily ever after.
> =

> We had a bug which started the bluetooth service too early (before DBus),
> so you needed to unplug and replug your adapter or restart the service
> after booting, but this is fixed since some days with an online update
> =

>> hidd --connect 00:07:61:4a:1b:ef
>> (press reset button on the mouse) -result-> Mouse connects and works.
>> Now, if I turn my mouse off for five seconds and turn it back on again,
>> I have to type another hidd --connect command as root for the mouse to
>> reconnect.
>>
>> I have attached the SuSE bluetooth init script and the bluetooth.conf
>> file used by the bluetooth init script in hopes it can be of use to
>> anyone who might answer this request.
> =

>> ## Path:        Hardware/Bluetooth
>> ## Description: Start responsible demon for HID Daemon
>> ## Type:        yesno
>> ## Default:     no
>> ## ServiceRestart: bluetooth
>> HID_START=3D"yes"
>>
>> ## Path:        Hardware/Bluetooth
>> ## Description: Set responsible demon for HID =

>> ## Type:        list("/usr/bin/hidd","")
>> ## Default:     "/usr/bin/hidd"
>> ## ServiceRestart: bluetooth
>> HID_DAEMON=3D"/usr/bin/hidd"
>>
>> ## Path:        Hardware/Bluetooth
>> ## Description: Arguments for hid-demon start
>> ## Type:        list("--server", "")
>> ## Default:     "--server"
>> ## ServiceRestart: bluetooth
>> HID_DAEMON_ARGS=3D"--server"
> =

> This is strange since it is exactly the same as my config.
> So is the bluetooth service started after bootup?
> Check with "service bluetooth status":
> =

> root@strolchi:~# service bluetooth status
> Checking service bluetooth (enabled) :
>       hcid  (activated)                                               run=
ning
>       hidd  (activated)                                               run=
ning
>    hid2hci                                                            unu=
sed
>       sdpd  (activated)                                               run=
ning
>        opd                                                            unu=
sed
>     rfcomm  (activated)
>       pand                                                            unu=
sed
>       dund                                                            unu=
sed
> =

> The "hcid" and the "hidd" line should show "running".
> =

> Please also check with "ps aux|grep hidd" if there really is no hidd runn=
ing.
> =

> If not, does it help if you unplug and replug the adapter or restart the
> service with "service bluetooth restart"?
> =

> Next try would be to pair the device with "hidd --search", then pressing =
the
> connect button on the mouse (i usually click around on the mouse and move=
 it
> until it is connected, but this might be just voodoo :-):
> =

> root@strolchi:~# hidd --search
> Searching ...
>         Connecting to device 00:07:61:3F:1B:6D
> root@strolchi:~#
> =

>>>From now on, the mouse reconnects automatically to my machine if i activa=
te
> it (depending on the mouse, you might need to press a mouse button or sim=
ply
> move it around).
> =

> This works for me in 10.2, so it looks as if it is not generally broken :=
-)
> =

> HTH,
> =

>    Stefan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFtTF5urImHjOFF6oRAhwSAJ9v1qBB1d7XMbPIus08FlHKY5fmbwCaAiW+
mSwSfsmlYagRAQ6eiV2Tchk=3D
=3DjxNs
-----END PGP SIGNATURE-----


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
