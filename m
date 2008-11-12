Return-Path: <cyrus@holtmann.org>
Message-ID: <491A9F2A.6030509@SSpaeth.de>
Date: Wed, 12 Nov 2008 10:17:30 +0100
From: Sebastian Spaeth <Sebastian@SSpaeth.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bluez-gnome wizard deficiencies make it mostly useless
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I caused quite a ruckus in this gnome bug yesterday:
http://bugzilla.gnome.org/show_bug.cgi?id=560315

Currently the bluez-gnome connection wizard fails invariably for all BT
devices that don't have a keyboard and are not special cased in source code.

In my case this happens:
I select the "setup new device" from the bluetooth-applet. Select
"eGPS-397" which is my BT GPS device. Next, the "connecting" page comes
up with a brief flash of some "type in random PIN" or something. It
dissappears within a fraction of a second without giving me the chance
to interact at all, leading to the page "pairing failed". This makes the
wizard useless for all BT devices that cannot enter PINs and that are
not special cased.

Bastien Haddess thinks it would be a bad idea to allow users to enter a
fixed pin (as a second choice to a default random PIN) via dialog and
asked to enter a new bug for each device to add it as another special
case. This is the wrong approach IMHO. Tracking all the devices out
there and their PINs will be a losing battle and bloat the code. With a
GPS device product lifecycle of a year, those devices will be outdated
until the code ships in a Linux distribution.

I see 2 solutions and I would like input in what bluez-gnome devs think:
1) Try to pair with random PIN if that fails try "0000", "1234", "1111".
This would at least cover about 90% of all devices and only special case
the rest.

2) Prepopulate a Random PIN in a field but allow the user to override
that PIN. After all he should know best what PIN to use.

Thanks.
spaetz



