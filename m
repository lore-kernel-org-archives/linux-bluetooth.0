Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: Add Kconfig option to enable Realtek protocol
 for serial devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5f6a5437-f20f-199b-8ecd-780245367201@redhat.com>
Date: Wed, 8 Aug 2018 18:24:16 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <D8523376-B4D7-4164-B347-C93BADC20A59@holtmann.org>
References: <20180808145205.26230-1-hdegoede@redhat.com>
 <E5533307-A9A1-452C-B629-B44211F18861@holtmann.org>
 <5f6a5437-f20f-199b-8ecd-780245367201@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

>>> Add a new BT_HCIUART_RTL Kconfig option to enable the Realtek protocol for
>>> Bluetooth HCI over serial port interface, mirroring the existing
>>> BT_HCIUART_BCM Kconfig option.
>>> 
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/bluetooth/Kconfig | 14 ++++++++++++++
>>> 1 file changed, 14 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index 5f953ca8ac5b..1124034d1c7e 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -195,6 +195,20 @@ config BT_HCIUART_BCM
>>> 
>>> 	  Say Y here to compile support for Broadcom protocol.
>>> 
>>> +config BT_HCIUART_RTL
>>> +	bool "Realtek protocol support"
>>> +	depends on BT_HCIUART
>>> +	depends on BT_HCIUART_SERDEV
>>> +	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
>> is this one really needed?
> 
> I mirrored this from the equivalent BCM Kconfig option, this bit comes from:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294625e02902
> 
> Reading the commit message it seems that this indeed is not necessary for the
> RTL_BT case.
> 
>>> +	depends on GPIOLIB
>>> +	select BT_HCIUART_3WIRE
>>> +	select BT_RTL
>>> +	help
>>> +	  The Realtek protocol support enables Bluetooth HCI over serial
>>> +	  port interface for Realtek Bluetooth controllers.
>> I like the text from my patch better since it mentions 3-Wire serial which is what this one is using.
> 
> I've not seen your patch (I'm not subscribed to the list) but if you think
> your version is better feel free to go with it.

you can find it in the archives, but I think my patch is the cleaner one.

Regards

Marcel

