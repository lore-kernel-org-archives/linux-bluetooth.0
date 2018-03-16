Return-Path: <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 robh@kernel.org, Lukas Wunner <lukas@wunner.de>,
 linux-bluetooth@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Subject: Problem with naming of broadcom bt patchram firmware files
Cc: linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>,
 rhowell@uwyo.edu
Message-ID: <359ee843-2c7c-456d-7cb7-fc3496e190c6@redhat.com>
Date: Fri, 16 Mar 2018 11:52:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I've been working recently on adding support for serialport /
serdev attached brcm bt devices on more (x86) boards.

This is going well in general, but I just noticed a problem
with this.

Currently on for example both the Raspberry Pi 3 and the
Chuwi Vi8 Plus, we will load brcm/BCM43430A1.hcd as patchram
file. Ideally this file will be in linux-firmware (*) so things
will just work.

But it turns out there are 2 different builds of the firmware,
one for boards which use a 26MHz crystal and one for boards which
use a 37.4Mhz crystal and guess what the RPi 3 uses 37.4Mhz
and the Chuwi Vi8 Plus 26Mhz.

So this causes 2 problems:

1) We need a -xxmhz postfix to the firmware name I believe,
but this will break existing setups, so I guess we first
try to load with the postfix, and then fallback to the old
name?

2) A bigger problem is how to figure out which frequency we
need. The wifi driver knows this as there is an xtalfreq=26000
or xtalfreq=37400 in the nvram file it loads. We could come
up with a mechanism to use this, but this will not be pretty and
it assumes that the uart attached bcm bt is always combined
with a wifi part which uses nvram from /lib/firmware.

Looking at all the devices I'm aware of atm there is no
real heuristic for this, but if we only look at x86 we can
get away with a per chip default, which we set in the
bcm_uart_subver_table.

So the direction I'm thinking in atm is:

1) Let hci_bcm.c tell btbcm.c which frequency to use, with an
option for it to pass "don't know use default"

2) For ARM allow setting the frequency through a devicetree property
which gets set on the serdev device-node (the node with the
"brcm,bcm43438-bt" compatible), with a fallback to the default
if not set.

3) On x86 rely on the defaults and if ever necessary use DMI
quirks to override

Note for this to work, the default for the BCM43430A1.hcd needs
to be 26 MHz and the RPi needs to have an updated devicetree
setting the freq to 37.4.

So what are your thoughts on this?

Regards,

Hans
