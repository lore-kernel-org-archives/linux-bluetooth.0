Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "martin.pitt@ubuntu.com" <martin.pitt@ubuntu.com>
Date: Fri, 3 Jun 2011 17:18:44 -0400
Subject: Bluez needs configuration mechanism for not running hid2hci
Message-ID: <1307135924.2622.109.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Related to my earlier patch for the udev rules here
<http://marc.info/?l=linux-bluetooth&m=130713440317947&w=2>,

Bluez needs a configurable way of *NOT* running hid2hci.

Currently, if a device *is capable* of switching to HCI mode, it _is_
switched to HCI mode. There are several problems with this approach:

1. Multi-boot systems. Since each host OS currently has different link
keys (or if the host names are different), *on each cross-boot*
bluetooth devices must be re-paired.
2. Input devices. Currently, after hid2hci switches modes, there is no
reliable way to pair input devices *without non-bluetooth input
devices*. This means that users with access to bluetooth keyboard and
mouse *only* should leave those devices in HID mode.

Pre-udev, /etc/bluetooth/main.conf had HID2HCI_ENABLE= to enable/disable
this behavior.

Now, there's nothing - and this is the source of *a lot* of distro bug
reports. Here's a spattering from Ubuntu only:
https://bugs.launchpad.net/ubuntu/lucid/+source/udev/+bug/444420
https://bugs.launchpad.net/ubuntu/lucid/+source/udev/+bug/550288
https://bugs.launchpad.net/ubuntu/+source/udev/+bug/658471

The solutions people come up with is to, in-essence, blacklist HCI mode
for other users!

Ideas?

Regards,
Peter Hurley
