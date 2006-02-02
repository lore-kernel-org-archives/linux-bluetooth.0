Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43E1E11F.8040501@ycom.ch>
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
References: <1138872805.21953.20.camel@bluez.bueche.ch>
In-Reply-To: <1138872805.21953.20.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 02 Feb 2006 11:38:23 +0100

Charles Bueche a =E9crit :
> Hi,
>
> I would like my new Logitech V270 to exists under /dev/input/v270,
> instead of a changing /dev/input/mouseN.
>
>  =20
Charles,

I've posted few weeks ago the same request, without any luck.

The trick come with the hid2hci, and the udev struct that is not updated.
With the recent udev-081, struct is somewhat updated, and I'm able to=20
have a fixed device, but without using event driver (witch I want to=20
use, but I still cannot write udev rules).

By now, with the rule :
KERNEL=3D=3D"mouse*"        SYSFS{name}=3D=3D"Bluetooth HID Boot Protocol=
=20
Device", NAME=3D=3D"input/bt-mx900", MODE=3D=3D"0664"

i'm able to get a FIXED device at /dev/input/bt-mx900 working mouse.

Now, next problem is when the bluetooth stack goes standby (for exemple,=20
let my PC running while lunch), when I touch the mouse to reconnect=20
(hidd setup the link, correct device name is recreated), X lost my=20
mouse, and I'm forced to close / open session to get it working again.


> % hidd --show
> 00:07:61:3B:9B:7C Logitech Bluetooth Mouse [046d:b002] connected
>
> % cat /proc/bus/input/devices
> ...snipp...
> I: Bus=3D0005 Vendor=3D046d Product=3Db002 Version=3D4809
> N: Name=3D"Logitech Bluetooth Mouse"
> P: Phys=3D00:10:C6:22:54:AF
> H: Handlers=3Dmouse4 event4=20
> B: EV=3Df=20
> B: KEY=3Dff0000 0 0 0 0 0 0 0 0=20
> B: REL=3D103=20
> B: ABS=3D300 0=20
> ...snipp...
>
>  =20
To show udev properties, use

udevinfo -a -p /sys/class/input/event4 (as seen in your dump before)

Regards
--Alexandre




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
