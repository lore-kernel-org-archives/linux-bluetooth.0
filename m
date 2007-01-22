Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 22 Jan 2007 19:03:51 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20070122180351.GA14726@suse.de>
References: <45B4D221.4090303@illokken.net>
MIME-Version: 1.0
In-Reply-To: <45B4D221.4090303@illokken.net>
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

On Mon, Jan 22, 2007 at 04:02:57PM +0100, H=E5var Nielsen wrote:

> Dear all,
> =

> I need some help with my bluetooth mouse.
> =

> I just went from ubuntu to openSuSE on my laptop. Everything except for
> the bluetooth mouse is working.
> =

> I have tried a lot of approaches really, but none seem to work. No
> matter what I do, I have to use the command sudo hidd --connect ... to
> make my mouse connect to the computer or vice versa (computer to mouse)
> every time I want to use the mouse. - That means I also have to type the
> root password each time I want to use the mouse.
> =

> On ubuntu this was really as simple as adding a line with 'hidd
> - --server' in /etc/rc.local. Then after I had connected my mouse with the
> hidd --connect command once, it always reconnected by itself, even after
> restarts and such.
> =

> This approach doesn't seem to work in openSuSE however, even when using
> the ubuntu (default) /etc/bluetooth/hcid.conf file. Why is that?

The hcid.conf is mostly obsolete (IMO) in bluez-3.x since all the settings
are now remembered for every adapter in /var/lib/bluetooth/* and can be
set via the DBus API..

> In SuSE, I must go to a terminal, become root and do:
> hidd --server

Don't do that. Rather investigate why the bluetooth init script does not
start hidd for you.

Check if HID is enabled in /etc/sysconfig/bluetooth:
root@strolchi:~# grep ^HID_ /etc/sysconfig/bluetooth
HID_START=3D"yes"
HID_DAEMON=3D"/usr/bin/hidd"
HID_DAEMON_ARGS=3D"--server"

I then just connected my keyboard and mouse once after installation with
"hidd --search", then pressed the connect button on the keyboard and on the
mouse ant it is working happily ever after.

We had a bug which started the bluetooth service too early (before DBus),
so you needed to unplug and replug your adapter or restart the service
after booting, but this is fixed since some days with an online update

> hidd --connect 00:07:61:4a:1b:ef
> (press reset button on the mouse) -result-> Mouse connects and works.
> Now, if I turn my mouse off for five seconds and turn it back on again,
> I have to type another hidd --connect command as root for the mouse to
> reconnect.
> =

> I have attached the SuSE bluetooth init script and the bluetooth.conf
> file used by the bluetooth init script in hopes it can be of use to
> anyone who might answer this request.

> ## Path:        Hardware/Bluetooth
> ## Description: Start responsible demon for HID Daemon
> ## Type:        yesno
> ## Default:     no
> ## ServiceRestart: bluetooth
> HID_START=3D"yes"
> =

> ## Path:        Hardware/Bluetooth
> ## Description: Set responsible demon for HID =

> ## Type:        list("/usr/bin/hidd","")
> ## Default:     "/usr/bin/hidd"
> ## ServiceRestart: bluetooth
> HID_DAEMON=3D"/usr/bin/hidd"
> =

> ## Path:        Hardware/Bluetooth
> ## Description: Arguments for hid-demon start
> ## Type:        list("--server", "")
> ## Default:     "--server"
> ## ServiceRestart: bluetooth
> HID_DAEMON_ARGS=3D"--server"

This is strange since it is exactly the same as my config.
So is the bluetooth service started after bootup?
Check with "service bluetooth status":

root@strolchi:~# service bluetooth status
Checking service bluetooth (enabled) :
      hcid  (activated)                                               runni=
ng
      hidd  (activated)                                               runni=
ng
   hid2hci                                                            unused
      sdpd  (activated)                                               runni=
ng
       opd                                                            unused
    rfcomm  (activated)
      pand                                                            unused
      dund                                                            unused

The "hcid" and the "hidd" line should show "running".

Please also check with "ps aux|grep hidd" if there really is no hidd runnin=
g.

If not, does it help if you unplug and replug the adapter or restart the
service with "service bluetooth restart"?

Next try would be to pair the device with "hidd --search", then pressing the
connect button on the mouse (i usually click around on the mouse and move it
until it is connected, but this might be just voodoo :-):

root@strolchi:~# hidd --search
Searching ...
        Connecting to device 00:07:61:3F:1B:6D
root@strolchi:~#

>>From now on, the mouse reconnects automatically to my machine if i activate
it (depending on the mouse, you might need to press a mouse button or simply
move it around).

This works for me in 10.2, so it looks as if it is not generally broken :-)

HTH,

   Stefan

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
