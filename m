Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] multimedia keys MS Bluetooth desktop
References: <BAY10-F503039E475B8677F27C14EB5E80@phx.gbl> <200506220030.39840.cijoml@volny.cz> <1119393804.26772.140.camel@pegasus>
In-Reply-To: <1119393804.26772.140.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200506222008.13899.cijoml@volny.cz>
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
Date: Wed, 22 Jun 2005 20:08:12 +0200

Hi Marcel,

maybe that is problem. It show it only connected

notas:/home/cijoml# hidd --show
00:50:F2:XX:XX:XX Microsoft Bluetooth keyboard [045e:007b] connected
00:50:F2:XX:XX:XX Microsoft Five Button Mouse [045e:007c] connected

Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
usb 3-1: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -=
84
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
usb 3-1: USB disconnect, address 3
usb 3-1: new full speed USB device using uhci_hcd and address 4
mtrr: base(0xe8020000) is not aligned on a size(0x300000) boundary
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb

Michal

Dne st 22. =E8ervna 2005 0:43 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > > I have an old MS keyboard and 2.6.12-mh1 didn't help
> > >
> > > the key may not work, but you will at least see them with hcidump.
> >
> > I tried hcidump as first application...nothing happens after pressing
> > button
>
> that is weird. Does hidd shows this device in boot-protocol mode?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
