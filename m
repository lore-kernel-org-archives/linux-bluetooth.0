Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT3030
References: <200405150903.23338.hedin@hiervard.ru> <200405161807.38658.cijoml@volny.cz> <200405171448.23338.hedin@hiervard.ru>
In-Reply-To: <200405171448.23338.hedin@hiervard.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Message-Id: <200405171223.33013.cijoml@volny.cz>
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
Date: Mon, 17 May 2004 12:23:32 +0200

On Monday 17 of May 2004 09:48, =E8=C5=C4=C9=CE wrote:
> Sunday 16 May 2004 23:07, Michal Semler =D0=C9=DB=C5=D4:
> > On Sunday 16 of May 2004 17:53, =E8=C5=C4=C9=CE wrote:
> > > Saturday 15 May 2004 16:01, Marcel Holtmann =D0=C9=DB=C5=D4:
> > > > Hi Hedin,
> > > >
> > > > > Here is my `dmesg` log after I load my modules after connecting t=
he
> > > > > dongle:
> > > > >
> > > > > usb 1-1: new full speed USB device using address 3
> > > > > Bluetooth: Core ver 2.4
> > > > > NET: Registered protocol family 31
> > > > > Bluetooth: HCI device and connection manager initialized
> > > > > Bluetooth: HCI socket layer initialized
> > > > > Bluetooth: L2CAP ver 2.1
> > > > > Bluetooth: L2CAP socket layer initialized
> > > > > Bluetooth: HCI USB driver ver 2.5
> > > > > usbcore: registered new driver hci_usb
> > > > > Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> > > > > bcm203x_probe: Mini driver request failed
> > > > > bcm203x: probe of 1-1:1.0 failed with error -5
> > > > > usbcore: registered new driver bcm203x
> > > >
> > > > this means that the request for the mini driver file BCM2033-MD.hex
> > > > failed. You need /sys mounted, you need /etc/hotplug/firmware.agent
> > > > and you must put the two firmware files from Broadcom in the firmwa=
re
> > > > directory under /usr/lib/hotplug/firmware.
> > >
> > > Sorry for dumb questions. I got these two filfes into
> > > /usr/lib/hotplug/firware (I took them from bluez-blufw package).
> > > The error still remains.
> > >
> > > But how about another one? I can't find it and what is "/sys" ? (I'm
> > > not really experienced with Linux, sorry).
> >
> > write:
> > mkdir /sys
> >
> > edit /etc/fstab and add this line:
> > sysfs           /sys            sysfs   defaults                0      =
 0
> > save it and write:
> > mount -a as root
>
> Yes I did it. But still nothing changed (where do I get firmware.agent?).

It is part of hotplug scripts. You should use latest -mh kernel patches too.

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
