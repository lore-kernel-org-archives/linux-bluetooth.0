Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] udev rules entry for bluetooth mouse
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1138880751.21953.38.camel@bluez.bueche.ch>
References: <1138872805.21953.20.camel@bluez.bueche.ch>
	 <43E1E11F.8040501@ycom.ch>  <1138880751.21953.38.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=utf-8
Message-Id: <1139303730.7059.2.camel@pc-05.ycom.ch>
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
Date: Tue, 07 Feb 2006 10:15:30 +0100

Le jeudi 02 f=C3=A9vrier 2006 =C3=A0 12:45 +0100, Charles Bueche a =C3=A9=
crit :
> Hi Alexandre,

Charles,=20


> I don't exactly understand who is faulty :
>=20
> - is it hidd which should add the mouse details to a data structure ?
> - or udev which doesn't search for the info ?

I've no ideas who is faulty too.=20
With udev 084, I got :

udevinfo -a -p /sys/class/input/mouse1

--cut--
  looking at device '/class/input/input4/mouse1':
    KERNEL=3D=3D"mouse1"
    SUBSYSTEM=3D=3D"input"
    SYSFS{dev}=3D=3D"13:33"

  looking at device '/class/input/input4':
    ID=3D=3D"input4"
    BUS=3D=3D"input"
    DRIVER=3D=3D""
    SYSFS{uniq}=3D=3D""
    SYSFS{phys}=3D=3D""
    SYSFS{name}=3D=3D"Bluetooth HID Boot Protocol Device"

So very few infos.


> Did you contact the hotplug team about this issue ?

I'm doing this right now, thanks for the tip.

Best regards

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
