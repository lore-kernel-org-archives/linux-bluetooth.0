Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 27 Sep 2010 10:52:28 +0300
Message-ID: <AANLkTikrQ2fAHDZwMncOpNRadjm=tdobvDoas=v5eyxH@mail.gmail.com>
Subject: Spurious authentication request?
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Occasionally when pairing with a headset BlueZ issues what looks
to be an unnecessary "Authentication Requested" after
receiving "Auth Complete" and "Simple Pairing Complete".

2010-09-22 11:23:45.282348 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 2
2010-09-22 11:23:45.282378 < HCI Command: Set Connection Encryption
(0x01|0x0013) plen 3
    handle 2 encrypt 0x01
[..]
2010-09-22 11:23:45.363646 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 2

This request is coming from bonding_connect_cb and occurs if that
callback happens to be executed before the function
hcid_dbus_bonding_process_complete (triggered by the auth complete
event). The order between those functions might have been affected
by this patch

http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=be35d00671519b8d92361c2caad9abeedda151f8

The request for authentication seems to be used for legacy pairing and
should probably not be made for simple pairing. Also, it might be
inconsistent that the kernel issues "Authentication Requested" for
simple pairing, but bluetoothd does it for legacy?

I guess enclosing the call in a check for legacy pairing would
work, if that information is or can be made available to
bluetoothd.

Have I understood the situation correctly and if so, what would
be a good way to fix this issue?

Thanks,
Daniel
