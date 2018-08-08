Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: hci_h5: Add Kconfig dependencies on SERDEV and
 GPIOLIB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180808100703.GA25042@x1c.lan>
Date: Wed, 8 Aug 2018 16:08:50 +0200
Cc: Hans de Goede <hdegoede@redhat.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Message-Id: <5A28D5E1-CCE4-49A0-B58D-C953EE8C120E@holtmann.org>
References: <20180808084825.12120-1-hdegoede@redhat.com>
 <20180808094711.GA23325@x1c.lan> <20180808100703.GA25042@x1c.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index f3c643a0473c..8969d3d5d86c 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -159,6 +159,8 @@ config BT_HCIUART_LL
>>> config BT_HCIUART_3WIRE
>>> 	bool "Three-wire UART (H5) protocol support"
>>> 	depends on BT_HCIUART
>>> +	depends on BT_HCIUART_SERDEV
>>> +	depends on GPIOLIB
>>> 	help
>>> 	  The HCI Three-wire UART Transport Layer makes it possible to
>>> 	  user the Bluetooth HCI over a serial port interface. The HCI
>> 
>> The missing BT_HCIUART_SERDEV is already fixed in bluetooth-next.
>> Please send an updated patch for the GPIOLIB however.
> 
> Actually the GPIOLIB dependency is related to BT_RTL usage, if I
> understand the code right. There's much more to be fixed though:
> currently all "btrtl" code in hci_h5.c is unconditionally compiled in,
> which it shouldn't be (it should depend on BT_RTL). There should
> probably be a similar Kconfig option to select BT_RTL for
> BT_HCIUART_3WIRE like there is for btusb with BT_HCIBTUSB_RTL.
> 
> Would you, or perhaps Jeremy (who introduced this code) be willing to
> submit a patch for it? We need to get this fixed for the last 4.19
> bluetooth-next pull request, which is due this week.

I really wanted that the new bt3wire.c gets fixed up and used for this and I am slightly regretting that I merged the hci_h5.c changes :(

Regards

Marcel

