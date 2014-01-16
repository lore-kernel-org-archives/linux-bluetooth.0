Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2014 14:17:05 -0800
Message-ID: <CAGXr9JHw-S5XdXEcp3APN9OKadt7LuoPQmJ2RZkAsRZ8dDJB-w@mail.gmail.com>
Subject: Questions on BlueZ 5.13: device creation API + persistent hid/input pipeline
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

linux-bluetooth:

I'm running BlueZ 5.13 userland + backported BlueZ kernel modules on
an embedded system that I'm working on. The kernel on the system is
2.6.37-based. I ported uhid driver manually from 3.12.

I'm successfully using Bluetooth classic HID remote control and
Bluetooth LE HoG remote control on this system. However, I have two
questions:

1) The Bluetooth classic remote that I'm using is not discoverable. It
is only connectable. When the remote is not paired, it sends its
Bluetooth MAC address to the host via IR, and the host needs to add
this device to BlueZ's discovered devices database. But, how can I do
that via D-Bus API? BlueZ 5 porting guide specifically mentions that "
... we decided to simply get rid of explicit CreateDevice /
CreatePairedDevice methods and instead dynamically create device
objects as they are discovered during device discovery."

So, is there no API available to add non-discoverable devices in BlueZ 5?

I have worked around this issue by manually adding this remote to
<storage path>, so that bluetoothd creates the device on reboot via
device_create_from_storage(). But, I would prefer not to restart
bluetoothd every time a non-discoverable device needs to be added.


2) There is a difference in HID vs HoG hid/input pipeline persistence.
When the Bluetooth classic HID remote disconnects, the corresponding
hid and input kernel devices are destroyed. And when it reconnects,
hid and input devices are created again. This adds a lot of
unnecessary delay at reconnect. And, the first keypress is always lost
on reconnect.

In contrast, for the Bluetooth LE HoG remote, the hid/input pipeline
is persistent. When HoG remote disconnects, hid and input devices
remain in the system and are reused when the HoG remote reconnects.

Is there a way to make Bluetooth classic HID behave the same as HoG,
i.e. retain the hid and input kernel devices on disconnect and reuse
them on reconnect?
