Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <98e24d190506231022112e7e15@mail.gmail.com>
From: Joel - JFX <jfxbrazil@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to scan for other bluetooth device
In-Reply-To: <42BACBEB.5080805@e28.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <42BA9D29.2070303@e28.com.hk>
	 <98e24d1905062307421443b245@mail.gmail.com>
	 <42BACBEB.5080805@e28.com.hk>
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
Date: Thu, 23 Jun 2005 14:22:52 -0300

could you paste here your hcid.conf and rfcomm.conf ???

2005/6/23, Jacky Cheung <jackycheung@e28.com.hk>:
> my mobile device is on.. and had tried hcitool scan., but no device found
>=20
> Joel - JFX wrote:
>=20
> >the bluetooth option like "visible" on your mobile are ON??
> >
> >you can scan using "hcitool scan"
> >
> >2005/6/23, Jacky Cheung <jackycheung@e28.com.hk>:
> >
> >
> >>Hi all,
> >>
> >>I am new to linux Bluetooth. I've got a question in paging other
> >>bluetooth device, says Bluetooth support phone.
> >>
> >>My PC is running in Redhat9.0, and I got a USB Bluetooth device. When I
> >>plugin the Bluetooth device, I've got the following message from
> >>/var/log/message
> >>
> >>Jun 23 18:03:48 localhost kernel: hub.c: new USB device 00:1d.2-1,
> >>assigned address 5
> >>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 registered
> >>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 registered
> >>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 up
> >>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 up
> >>Jun 23 18:03:49 localhost hcid[2579]: Starting security manager 0
> >>Jun 23 18:03:49 localhost hcid[2611]: Starting security manager 0
> >>Jun 23 18:03:49 localhost /sbin/hotplug: no runnable
> >>/etc/hotplug/bluetooth.agent is installed
> >>Jun 23 18:03:52 localhost /etc/hotplug/usb.agent: Setup hci_usb for USB
> >>product a12/1/1120
> >>
> >>Actually, I can see the Bluetooth device from hciconfig, and the phone
> >>can scan the USB BT. However, I fail to scan the phone device in PC. Is
> >>that I have missed some settings?
> >>
> >>Thanks
> >>
> >>Regards,
> >>Jacky Cheung
> >>
> >>-------------------------------------------------------
> >>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> >>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>informative Webcasts and more! Get everything you need to get up to
> >>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> >>_______________________________________________
> >>Bluez-users mailing list
> >>Bluez-users@lists.sourceforge.net
> >>https://lists.sourceforge.net/lists/listinfo/bluez-users
> >>
> >>
> >>
> >
> >
> >-------------------------------------------------------
> >SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> >from IBM. Find simple to follow Roadmaps, straightforward articles,
> >informative Webcasts and more! Get everything you need to get up to
> >speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
