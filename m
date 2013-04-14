Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2] Bluetooth: Add support for Intel Bluetooth device [8087:07dc]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BB52B9B497F0EE4EB05C192A0408F6601FBDAD81@ORSMSX105.amr.corp.intel.com>
Date: Sun, 14 Apr 2013 00:22:20 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Hedberg, Johan" <johan.hedberg@intel.com>,
	"Fry, Don" <don.fry@intel.com>
Message-Id: <A132637A-BA02-4D80-9584-2D147A9E1214@holtmann.org>
References: <9783629.ao7UZkXlOD@tedd-ubuntu> <56B55E37-411B-4F5D-AD13-4A2AC83D1244@holtmann.org> <BB52B9B497F0EE4EB05C192A0408F6601FBDAD81@ORSMSX105.amr.corp.intel.com>
To: "An, Tedd" <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

>>> drivers/bluetooth/btusb.c |  333
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 333 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 3d684d2..c8c816b 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -23,6 +23,7 @@
>>> 
>>> #include <linux/module.h>
>>> #include <linux/usb.h>
>>> +#include <linux/firmware.h>
>> 
>> I just remembered that you most likely need also change the Kconfig to
>> depend on the firmware loader support.
>> 
>> Actually you do not. You will get an -EINVAL error. Might want to print an
>> error in that case. As a general principle, it would be a good idea if btusb.ko
>> itself does not depend on the firmware loader.
>> 
> 
> Could you explain more about this?
> Anyway, this header file is needed to read the firmware patch file (request_firmware).

this part is a bit tricky. If you look at the BlueFritz! driver, then you see in Kconfig that it does a select FW_LOADER. So it ensures that the firmware loader support is build. Either as module or built into the kernel.

Of course that driver requires the firmware module since otherwise it won't work. When you look at the generic Bluetooth USB driver, then it can work nicely without the firmware loader. Only the Intel module would need it. And even that would work without, just don't have the right patches or configuration loaded.

Luckily the linux/firmware.h is written in a way that it works with or without the firmware loader being enabled. However in case it is not enabled request_firmware() will return -EINVAL and in that case we should print a proper error message in dmesg that makes it clear why the firmware loading has not been attempted.

Regards

Marcel

