Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 5 Feb 2011 16:47:41 +0100
Message-ID: <AANLkTin6NsxR9UBDi2fbPOQ8yjL8L1RbQZX+G+VLma82@mail.gmail.com>
Subject: Inconsistent fake-hid-input callback behaviour
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The fake-hid-input API (bluez/input/ plugin) calls the ->connect
callback quite randomly.

The ->connect callback (inside struct fake_hid, NOT struct fake_input)
is called inside input_device_connect() and fake_hid_connadd().
However, input_device_connect() calls it only if the "fake" member is
set, which actually is NEVER set at this point, because the "fake"
member is set on "hsp" connections only and never on "hid"
connections. input_device_connect() works only on "hid" connections
(which is actually written in uppercase "HID" and the device creation
uses lowercase "hid" which should be fixed for consistency (although
it might be case insensitive, I don't know)).
So input_device_connect() never calls this ->connect callback.
fake_hid_connadd() calls the callback only if a second connection is
created on the same device (which never happens because
fake_hid_connadd is only called on PSM 0x11/0x13 HID connections and
there can only be ONE connection on this PSM). So the whole ->connect
callback in struct fake_hid seems useless, same as the code testing
whether fake_hid_connadd() already has an open connection.

All in all it is quite confusing reading input/device.c because the
fake_input structure is used for two purposes, once rfcomm connections
of "hsp" connections and second for HID-fake connections which is
l2cap.

It is not clear to me, why devices registered with fake_input_register
use the same structure (struct fake_input) as fake-HID devices
registered with input_device_register(and then fake_hid_connadd). The
latter one only need the "uinput" member of this structure while all
other members are redundant.

I try to implement a Wii-Remote driver as fake-hid input driver which
actually works and allows the remote to establish connections to my
host and vice-versa, however, trying to understand input/device.c code
is quite impossible and getting this ->connect callback to work is
also not possible. I would be glad to get some help here because my
wiimote-uinput driver needs some initialization before the ->event
callback can be called and doing this inside the uinput_setup callback
seems misplaced as long as there is a ->connect callback.

David
