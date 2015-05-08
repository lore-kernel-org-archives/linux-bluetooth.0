Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 8 May 2015 06:57:01 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: add manufacturing mode support
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF5951B17110716@SC-VEXCH1.marvell.com>
References: <1431012963-2754-1-git-send-email-akarwar@marvell.com>
 <473D0724-1A5E-4F6C-9A88-0EA53BF64116@holtmann.org>
In-Reply-To: <473D0724-1A5E-4F6C-9A88-0EA53BF64116@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>=20
> Hi Amitkumar,
>=20
> > Default firmware is chosen when driver is loaded. This patch adds
> > provision to download manufacturing firmware which is used for RF
> > tests in the factory through sysfs configuration.
> >
> > Procedure
> > 1) Switch from normal mode to manufacturing mode.
> >    echo 1 > /sys/class/bluetooth/hci0/mfg_mode.
> >    echo "mrvl/sdio8897_mfg.bin" >
> /sys/class/bluetooth/hci0/mfg_firmware
> >    Trigger chip reset from wlan driver.
> >
> > 2) Switch from manufacturing mode to normal mode.
> >   echo 0 > /sys/class/bluetooth/hci0/mfg_mode
> >   Trigger chip reset from wlan driver.
>=20
> I am really not happy with this being sysfs. It would mean this is an
> API now and clearly it is Marvell specific. So I would propose that you
> do this via debugfs and clearly prefix it with mrvl_ to indicate that
> this is Marvell specific.
>=20
> Also I do not see the need for providing the firmware name. We could
> just have that hardcoded in the driver. Since the name is so generic
> depending on the model you have, it will not change. Also if devices do
> not support manufacturing firmware, then do not expose the debugfs file.
> That way this becomes easy testable.
>=20

Thanks for your comments. We will work on them.
Basically we intend to change firmware runtime while switching between norm=
al and manufacturing mode. This is possible by power cycling the chip using=
 our wlan driver's API.
When device is reenumerated, we are checking global mfg_mode variable(confi=
gured via sysfs/debugfs earlier) and accordingly choosing firmware for down=
load. We will check if we can avoid global variable usage.

Regards,
Amit
