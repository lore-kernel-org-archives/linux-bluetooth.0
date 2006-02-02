Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43E1E11F.8040501@ycom.ch>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1138880751.21953.38.camel@bluez.bueche.ch>
Mime-Version: 1.0
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
Date: Thu, 02 Feb 2006 12:45:51 +0100

Hi Alexandre,

I have found your post on 13.1.2006.

I don't exactly understand who is faulty :

- is it hidd which should add the mouse details to a data structure ?
- or udev which doesn't search for the info ?

Did you contact the hotplug team about this issue ?

Regs,
Charles

On jeu, 2006-02-02 at 11:38 +0100, Alexandre Ghisoli wrote:
> Charles Bueche a =E9crit :
> > Hi,
> >
> > I would like my new Logitech V270 to exists under /dev/input/v270,
> > instead of a changing /dev/input/mouseN.
> >
> >  =20
> Charles,
>=20
> I've posted few weeks ago the same request, without any luck.
>=20
> The trick come with the hid2hci, and the udev struct that is not update=
d.
> With the recent udev-081, struct is somewhat updated, and I'm able to=20
> have a fixed device, but without using event driver (witch I want to=20
> use, but I still cannot write udev rules).
>=20
> By now, with the rule :
> KERNEL=3D=3D"mouse*"        SYSFS{name}=3D=3D"Bluetooth HID Boot Protoc=
ol=20
> Device", NAME=3D=3D"input/bt-mx900", MODE=3D=3D"0664"
>=20
> i'm able to get a FIXED device at /dev/input/bt-mx900 working mouse.
>=20
> Now, next problem is when the bluetooth stack goes standby (for exemple=
,=20
> let my PC running while lunch), when I touch the mouse to reconnect=20
> (hidd setup the link, correct device name is recreated), X lost my=20
> mouse, and I'm forced to close / open session to get it working again.
>=20
>=20
> > % hidd --show
> > 00:07:61:3B:9B:7C Logitech Bluetooth Mouse [046d:b002] connected
> >
> > % cat /proc/bus/input/devices
> > ...snipp...
> > I: Bus=3D0005 Vendor=3D046d Product=3Db002 Version=3D4809
> > N: Name=3D"Logitech Bluetooth Mouse"
> > P: Phys=3D00:10:C6:22:54:AF
> > H: Handlers=3Dmouse4 event4=20
> > B: EV=3Df=20
> > B: KEY=3Dff0000 0 0 0 0 0 0 0 0=20
> > B: REL=3D103=20
> > B: ABS=3D300 0=20
> > ...snipp...
> >
> >  =20
> To show udev properties, use
>=20
> udevinfo -a -p /sys/class/input/event4 (as seen in your dump before)
>=20
> Regards
> --Alexandre
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=103432&bid#0486&dat=12164=
2
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
