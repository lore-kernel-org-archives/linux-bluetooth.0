Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: Questions on BlueZ 5.13: device creation API + persistent hid/input pipeline
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGXr9JHw-S5XdXEcp3APN9OKadt7LuoPQmJ2RZkAsRZ8dDJB-w@mail.gmail.com>
Date: Thu, 16 Jan 2014 14:30:52 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F4C3DE28-E297-42B1-9FA2-B3335DF0F080@holtmann.org>
References: <CAGXr9JHw-S5XdXEcp3APN9OKadt7LuoPQmJ2RZkAsRZ8dDJB-w@mail.gmail.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> I'm running BlueZ 5.13 userland + backported BlueZ kernel modules on
> an embedded system that I'm working on. The kernel on the system is
> 2.6.37-based. I ported uhid driver manually from 3.12.
> 
> I'm successfully using Bluetooth classic HID remote control and
> Bluetooth LE HoG remote control on this system. However, I have two
> questions:
> 
> 1) The Bluetooth classic remote that I'm using is not discoverable. It
> is only connectable. When the remote is not paired, it sends its
> Bluetooth MAC address to the host via IR, and the host needs to add
> this device to BlueZ's discovered devices database. But, how can I do
> that via D-Bus API? BlueZ 5 porting guide specifically mentions that "
> ... we decided to simply get rid of explicit CreateDevice /
> CreatePairedDevice methods and instead dynamically create device
> objects as they are discovered during device discovery."
> 
> So, is there no API available to add non-discoverable devices in BlueZ 5?
> 
> I have worked around this issue by manually adding this remote to
> <storage path>, so that bluetoothd creates the device on reboot via
> device_create_from_storage(). But, I would prefer not to restart
> bluetoothd every time a non-discoverable device needs to be added.

I have never heard of a remote that uses IR to setup the pairing. A creative way of doing out-of-band pairing.

What I think you are looking for is what the PS3 controllers do when the share their details over USB and then after that connect over Bluetooth HID. Have a look at plugins/sixaxis.c to see how they do it. BlueZ has a plugin API for doing exactly these kind of automated setup/pairing type of cases.

So you want to write a plugin for this remote.

The other plugin you might want to look at is plugins/autopair.c if it actually requires to also create an encrypted link.

> 2) There is a difference in HID vs HoG hid/input pipeline persistence.
> When the Bluetooth classic HID remote disconnects, the corresponding
> hid and input kernel devices are destroyed. And when it reconnects,
> hid and input devices are created again. This adds a lot of
> unnecessary delay at reconnect. And, the first keypress is always lost
> on reconnect.
> 
> In contrast, for the Bluetooth LE HoG remote, the hid/input pipeline
> is persistent. When HoG remote disconnects, hid and input devices
> remain in the system and are reused when the HoG remote reconnects.
> 
> Is there a way to make Bluetooth classic HID behave the same as HoG,
> i.e. retain the hid and input kernel devices on disconnect and reuse
> them on reconnect?

HID and HoG work a little bit different. HID uses a kernel transport driver while HoG uses /dev/uhid to do the work. Porting HID over to use /dev/uhid is certainly a possibility. We have considered that, but nobody has done that work yet.

Please remember that HID (with HIDP) is finding its right place in /sys device tree. While all HoG using /dev/uhid are considered virtual devices. There is a semi proposal that we agreed on New Orleans during the PlumbersConf, but I have no idea if David actually implemented it.

Another option is to make the HIDP transport smarter and persistent by integrating it into BlueZ 5’s kernel mgmt support. That however means you will need a much more recent Bluetooth subsystem. So 2.6.37 is not getting you anywhere near that even if we change HIDP support.

Regards

Marcel

