Return-Path: <cyrus@holtmann.org>
Message-ID: <51F7722E.9050708@digi.com>
Date: Tue, 30 Jul 2013 09:58:38 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"gustavo@padovan.org" <gustavo@padovan.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <lrodriguez@atheros.com>, "suraj@atheros.com"
	<suraj@atheros.com>
Subject: Re: [PATCH] bluetooth: remove wrong dependency for BT_ATH3K
References: <1375114325-25498-1-git-send-email-hector.palacios@digi.com> <5438CD3C-E28C-485C-94B8-F743E8B13D4A@holtmann.org>
In-Reply-To: <5438CD3C-E28C-485C-94B8-F743E8B13D4A@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 07/29/2013 06:43 PM, Marcel Holtmann wrote:
> Hi Hector,
>
>> The Atheros firmware download driver is not dependent on HCI
>> USB driver. This driver is needed to complement any Atheros
>> driver like BT_HCIUART_ATH3K.
>>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>> CC: Suraj Sumangala <suraj@atheros.com>
>> CC: Vikram Kandukuri <vikram.kandukuri@atheros.com>
>> ---
>> drivers/bluetooth/Kconfig | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 11a6104..a1d482b 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -222,7 +222,6 @@ config BT_MRVL_SDIO
>>
>> config BT_ATH3K
>> 	tristate "Atheros firmware download driver"
>> -	depends on BT_HCIBTUSB
>> 	select FW_LOADER
>> 	help
>> 	  Bluetooth firmware download driver.
>>
>
> I am confused now. How can an USB driver work with an UART driver? If you do not want to depend on BT_HCIBTUSB then that is fine, but at least you need to depend on USB.

The thing is I have an Atheros AR6233 chipset which has wireless and Bluetooth. 
Bluetooth part in this chip operates as a UART. The driver for this is hci_ath.c but I 
also need to download the firmware to the chip, and for this I need to compile 
ath3k.c. However I don't need BT_HCIBTUSB.
But you are right, looking at the source code of ath3k.c it is calling usb commands, 
so it needs to depend on USB at least.

This brings an interesting question: shouldn't the firmware download part be isolated 
from the USB driver? After all, I want to communicate with a UART bluetooth chip.

Best regards,
--
Hector Palacios
