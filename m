Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: Questions on BlueZ 5.13: device creation API + persistent hid/input pipeline
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGXr9JHi5UuDd01POdua1UZ2kY+n=0wGcxaWx4Ta=55fHvZxyw@mail.gmail.com>
Date: Thu, 16 Jan 2014 15:42:52 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <3D384890-B1E7-41D0-A859-CB7537DD74D3@holtmann.org>
References: <CAGXr9JHw-S5XdXEcp3APN9OKadt7LuoPQmJ2RZkAsRZ8dDJB-w@mail.gmail.com> <F4C3DE28-E297-42B1-9FA2-B3335DF0F080@holtmann.org> <CAGXr9JHi5UuDd01POdua1UZ2kY+n=0wGcxaWx4Ta=55fHvZxyw@mail.gmail.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

>>> 2) There is a difference in HID vs HoG hid/input pipeline persistence.
>>> When the Bluetooth classic HID remote disconnects, the corresponding
>>> hid and input kernel devices are destroyed. And when it reconnects,
>>> hid and input devices are created again. This adds a lot of
>>> unnecessary delay at reconnect. And, the first keypress is always lost
>>> on reconnect.
>>> 
>>> In contrast, for the Bluetooth LE HoG remote, the hid/input pipeline
>>> is persistent. When HoG remote disconnects, hid and input devices
>>> remain in the system and are reused when the HoG remote reconnects.
>>> 
>>> Is there a way to make Bluetooth classic HID behave the same as HoG,
>>> i.e. retain the hid and input kernel devices on disconnect and reuse
>>> them on reconnect?
>> 
>> HID and HoG work a little bit different. HID uses a kernel transport driver while HoG uses /dev/uhid to do the work. Porting HID over to use /dev/uhid is certainly a possibility. We have considered that, but nobody has done that work yet.
>> 
>> Please remember that HID (with HIDP) is finding its right place in /sys device tree. While all HoG using /dev/uhid are considered virtual devices. There is a semi proposal that we agreed on New Orleans during the PlumbersConf, but I have no idea if David actually implemented it.
>> 
>> Another option is to make the HIDP transport smarter and persistent by integrating it into BlueZ 5’s kernel mgmt support. That however means you will need a much more recent Bluetooth subsystem. So 2.6.37 is not getting you anywhere near that even if we change HIDP support.
> 
> I'm using BlueZ kernel modules (bluetooth, hidp) from Linux
> backports-3.13-rc2-1, so that is pretty recent code. Works fine on top
> of 2.6.37. However, my HID and input drivers come from 2.6.37, as they
> are not available in backports-3.13-rc2-1.
> 
> I understand the difference between HID and HoG. Both hidp and uhid
> are hid_ll_drivers. HID input reports stay entirely in kernel, whereas
> HoG is handled in bluetoothd and input reports are passed back to
> kernel via /dev/uhid.
> 
> Assuming the latest HIDP code, what kind of effort would it be to make
> the hid/input pipeline persistent when HID remote disconnects and
> reconnects?

for the HIDP code itself there is actually a lot of work. It does not have the model of persistent connections. It is designed to disconnect and reconnect. Since normally when you disconnect your device it is off. Otherwise you just sniff the connection. It is also a bit legacy reason from where L2CAP only had a concept of sockets and not l2cap_chan that only recently got introduced.

Why you are loosing your first input, that sounds like a bug we should look into. That should actually not happen.

To be honest, the easiest for you might be to run HID over /dev/uhid as well. So HoG and HID are both using /dev/uhid. A port of the input plugin to use /dev/uhid for HID should be straight forward. All the building blocks should be already there.

Regards

Marcel

