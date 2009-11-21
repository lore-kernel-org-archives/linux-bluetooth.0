Return-Path: <cyrus@holtmann.org>
Subject: Problems with bluetooth mouse pairing
From: Petr =?ISO-8859-1?Q?Kub=E1nek?= <petr@kubanek.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 Nov 2009 15:28:06 +0100
Message-ID: <1258813686.20439.13.camel@epsilon>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have problems with bluetooth mouse pairing - there is debug output
from bluetoothd -d -n:

bluetoothd[25168]: Registered interface org.bluez.Control on
path /org/bluez/25168/hci0/dev_00_21_AB_32_FD_45
bluetoothd[25168]: Found AV Target
bluetoothd[25168]: Adapter /org/bluez/25168/hci0 has been enabled
bluetoothd[25168]: Computer is classified as laptop
bluetoothd[25168]: Setting 0x00010c for major/minor device class
bluetoothd[25168]: Agent registered for hci0
at :1.47:/org/bluez/agent/hci0
bluetoothd[25168]: adapter_get_device(00:07:61:86:FB:A5)
bluetoothd[25168]: adapter_create_device(00:07:61:86:FB:A5)
bluetoothd[25168]: Creating
device /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5
bluetoothd[25168]: btd_device_ref(0x7f12193966e0): ref=1
bluetoothd[25168]: Incoming connection on PSM 17
bluetoothd[25168]: authorize request was sent
for /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5

Then my Ubuntu Gnome ask for confirmation to allow device pairing. If I
allow it, the following follows:

bluetoothd[25168]: Removing temporary
device /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5
bluetoothd[25168]: Removing
device /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5
bluetoothd[25168]: btd_device_unref(0x7f12193966e0): ref=0
bluetoothd[25168]: device_free(0x7f12193966e0)
bluetoothd[25168]: HUP or ERR on socket

If I disallow it, the following is printed:

bluetoothd[25168]: Agent replied with an error:
org.bluez.Error.Rejected, Authorization request rejected
bluetoothd[25168]: Access denied: Authorization request rejected

bluetoothd[25168]: Removing temporary
device /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5
bluetoothd[25168]: Removing
device /org/bluez/25168/hci0/dev_00_07_61_86_FB_A5
bluetoothd[25168]: btd_device_unref(0x7f12193966e0): ref=0
bluetoothd[25168]: device_free(0x7f12193966e0)

What I am missing? What can be wrong? Where I can found details which
socket experienced HUP or ERR? I tried multiple approaches, so far
nothing worked reliably. The mouse worked fine on Ubuntu 9.04, stop
working on 9.10. I tried to install hidd, which was removed, or use
blueman - nothing helps.

Thanks for any aid. Just pointing out what might be wrong will help as
well.

Petr

