Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2009 12:40:46 -0500
Message-ID: <21b895620909101040m5b2a2ae1tf407bba7bc4ff4cd@mail.gmail.com>
Subject: [PATCH 0/3] bluetooth: Wiimote via HIDP+HIDRAW
From: SephirXV <sephirxv@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christopher Olson <sephirxv@gmail.com>

Updates to the Bluetooth/HIDP and Hidraw subsystems to allow easy
access to wiimotes via hidraw files.

Abbreviations: I will use 'hidrawN' to represent a hidraw device file,
present in /dev (and subdirectories
 would be based on udev rules and is really irrelevant to my purpose.

I see no reason why these need to be applied in any special combination.

These patches are made against 2.6.28 (net/bluetooth/hidp/core.c),
they should work with .30/.31
1/3 - hidraw disconnect - non-compliant HIDP devices
2/3 - hidraw write support - non-compliantd HIDP devices

Patch made against 2.6.28 (drivers/hid/hidraw.c), be better served by
some other facility, but I needed a way
 to map which wiimote was addressed by which hidrawN.
3/3 - hidraw ioctl to identify hidrawN 'bindings'. See below for more info.

1) Hidraw disconnect - Somewhere between .26 and .28, hidraw began
connecting to HIDP devices which don't
 strictly define their behavior in the HID usage table, and without
any patching on my part. These non-compliant
 devices wouldn't automatically disconnect, leaving hidraw files which
did nothing.

2) Hidraw write support - As above, somewhere before .28,
non-compliant HIDP devices would connect, and could
 be read from, but writing to the device had no effect.

3) Hidraw ioctl uniq - I needed a way to find out whether a given
hidrawN was a HIDP device, and if so what it's
 uniq (bdaddr) was. I tried other ways, but the only way I could find
was udev-monitor, but there were no
 guarentees that the messages were in order; two connecting devices
could interleave their messages in the
 monitor output. If someone has an idea of a reliable method I might
try, let me know. I would much prefer it if
 the /sys interface would export the uniq variable, but I have no idea
where to find that sort of thing.
