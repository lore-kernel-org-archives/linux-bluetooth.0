Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Add Kconfig dependencies on SERDEV and
 GPIOLIB
To: Marcel Holtmann <marcel@holtmann.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20180808084825.12120-1-hdegoede@redhat.com>
 <20180808094711.GA23325@x1c.lan> <20180808100703.GA25042@x1c.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <21ddfb69-860a-49b4-4a55-792a631089f8@redhat.com>
Date: Wed, 8 Aug 2018 16:41:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180808100703.GA25042@x1c.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/08/2018 12:07 PM, Johan Hedberg wrote:
> Hi Hans,
> 
> On Wed, Aug 08, 2018, Johan Hedberg wrote:
>> On Wed, Aug 08, 2018, Hans de Goede wrote:
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index f3c643a0473c..8969d3d5d86c 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -159,6 +159,8 @@ config BT_HCIUART_LL
>>>   config BT_HCIUART_3WIRE
>>>   	bool "Three-wire UART (H5) protocol support"
>>>   	depends on BT_HCIUART
>>> +	depends on BT_HCIUART_SERDEV
>>> +	depends on GPIOLIB
>>>   	help
>>>   	  The HCI Three-wire UART Transport Layer makes it possible to
>>>   	  user the Bluetooth HCI over a serial port interface. The HCI
>>
>> The missing BT_HCIUART_SERDEV is already fixed in bluetooth-next.
>> Please send an updated patch for the GPIOLIB however.
> 
> Actually the GPIOLIB dependency is related to BT_RTL usage, if I
> understand the code right. There's much more to be fixed though:
> currently all "btrtl" code in hci_h5.c is unconditionally compiled in,
> which it shouldn't be (it should depend on BT_RTL).

This is handled the same way as with BT_BCM already, bt_bcm.h
has

#if IS_ENABLED(CONFIG_BT_BCM)
...
#else
...
#endif

With the #else block defining empty stubs which always return
an error. btrtl.h does exactly the same thing.


> There should
> probably be a similar Kconfig option to select BT_RTL for
> BT_HCIUART_3WIRE like there is for btusb with BT_HCIBTUSB_RTL.

Yes I will submit a patch adding a new BT_HCIUART_RTL
mirroring the existing BT_HCIUART_BCM for this.

Regards,

Hans
