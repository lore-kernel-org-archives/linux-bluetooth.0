Return-Path: <cyrus@holtmann.org>
Message-ID: <1425202764.15960.3.camel@gentoo.org>
Subject: Re: hid2hci.rules uses old udevadm location
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 01 Mar 2015 10:39:24 +0100
In-Reply-To: <1424549892.30961.2.camel@gentoo.org>
References: <1423821397.31528.59.camel@gentoo.org>
	 <1424549892.30961.2.camel@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El sáb, 21-02-2015 a las 21:18 +0100, Pacho Ramos escribió:
> El vie, 13-02-2015 a las 10:56 +0100, Pacho Ramos escribió:
> > Hello
> > 
> > It seems that hid2hci.rules uses old udevadm location
> >   ENV{REMOVE_CMD}="/sbin/udevadm trigger --action=change
> > --subsystem-match=usb --property-match=HID2HCI_SWITCH=1"
> > 
> > 
> > Wouldn't be better to make it use the current location used in
> > udev/systemd? (/usr/bin/udevadm) (or to not hardcode the location)
> > 
> > Thanks a lot
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Or are we supposed to create the compat symlinks at /sbin?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Probably you could supply something like the following rule to try to
cover both cases, changing:

ATTR{bDeviceClass}=="e0", ATTR{bDeviceSubClass}=="01",
ATTR{bDeviceProtocol}=="01", ATTR{idVendor}=="413c", \
  ENV{REMOVE_CMD}="/sbin/udevadm trigger --action=change
--subsystem-match=usb --property-match=HID2HCI_SWITCH=1"

to:

ATTR{bDeviceClass}=="e0", ATTR{bDeviceSubClass}=="01",
ATTR{bDeviceProtocol}=="01", ATTR{idVendor}=="413c", \
  ENV{REMOVE_CMD}="/usr/bin/udevadm trigger --action=change
--subsystem-match=usb --property-match=HID2HCI_SWITCH=1" \
  ENV{REMOVE_CMD}="/sbin/udevadm trigger --action=change
--subsystem-match=usb --property-match=HID2HCI_SWITCH=1"

What do you think?

