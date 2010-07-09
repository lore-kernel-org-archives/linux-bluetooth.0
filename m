Return-Path: <cyrus@holtmann.org>
From: "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding support for bluetooth controller shipped with iMac i5
Date: Fri, 9 Jul 2010 08:34:42 +0400
References: <201006161443.50587.clacoux@ifeelgood.org> <201006162028.59280.clacoux@ifeelgood.org> <1278623133.10421.69.camel@localhost.localdomain>
In-Reply-To: <1278623133.10421.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007090834.42674.clacoux@ifeelgood.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Le vendredi 09 juillet 2010 01:05:33, vous avez =C3=A9crit :

Hi,
=20
> please create a proper commit message and include the usb-devices output
> in that message.

I don't understand, patch and usb-devices output were attached to my previo=
us=20
mail. Do you want me to re-send the patch in a separate mail using the git=
=20
output as body ?

> Also the HID part in the source code comment makes no sense. Why are you
> using that one. Copy&paste from the previous one?

Controller has HID capabilities, keyboard and mouse were working (usb-hid) =
in=20
restricted mode until I managed to get the controller working with btusb=20
driver. That's why I copied and paste the previous one.

I filled a bug report[1] on Ubuntu with more explanations. I tried to rever=
t=20
it to hid mode using hid2hci, but no luck.


[1]: https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/575366

Git and kernel development guidelines are really new to me, thank's to take=
=20
the time to fix this.

Regards,
=2D-=20
Cyril Lacoux -- BOFH excuse #181:

Atilla the Hub
