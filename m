Return-Path: <cyrus@holtmann.org>
Message-ID: <555C3814.9070403@rosalab.ru>
Date: Wed, 20 May 2015 10:30:28 +0300
From: Eugene Shatokhin <eugene.shatokhin@rosalab.ru>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
 Andrey Ponomarenko <aponomarenko@rosalab.ru>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add a quirk for BCM43142A0 (105b:e065)
References: <1432056985-30040-1-git-send-email-eugene.shatokhin@rosalab.ru> <4EBEE4B9-BD14-4E3E-A06D-42C97C1730E4@holtmann.org>
In-Reply-To: <4EBEE4B9-BD14-4E3E-A06D-42C97C1730E4@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for a quick reply!

19.05.2015 21:19, Marcel Holtmann пишет:
> Hi Eugene,
>
>> USB Bluetooth module by Foxconn International, Inc. (USB IDs: 105b:e065)
>> is based on BCM43142A0 chip by Broadcom. This module can be found, for
>> example, in Lenovo B590 and a few other laptops.
>>
>> This device requires firmware update to be operational, so this patch
>> adds a quirk for it.
>>
>> With the firmware properly converted and placed:
>> Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=0000 lmp_ver=06
>> lmp_subver=210b
>> Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=00ac lmp_ver=06
>> lmp_subver=210b
>>
>>  From the output of usb-devices:
>> T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=105b ProdID=e065 Rev=01.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM43142A0
>> S:  SerialNumber=F82FA8FAFEBA
>> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>>
>> Tested on Lenovo B590 with kernel 4.0.1 and 4.0.3, x86_64.
>>
>> Signed-off-by: Eugene Shatokhin <eugene.shatokhin@rosalab.ru>
>> ---
>> drivers/bluetooth/btusb.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index d21f3b4..ed3c72a 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -120,6 +120,9 @@ static const struct usb_device_id btusb_table[] = {
>> 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
>> 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
>>
>> +	/* Broadcom BCM43142A0 (Foxconn) */
>> +	{ USB_DEVICE(0x105b, 0xe065), .driver_info = BTUSB_BCM_PATCHRAM },
>> +
>> 	/* Foxconn - Hon Hai */
>> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
>> 	  .driver_info = BTUSB_BCM_PATCHRAM },
>
> I am wondering if want to use USB_VENDOR_AND_INTERFACE_INFO instead. We already have a Foxconn entry. Is Vendor ID 0x105b also for Foxconn. Or is this actually Lenovo?

Looks like there is currently only one device with vendor ID 0x105b, 
this one.

The USB IDs database (http://www.linux-usb.org/usb.ids) contains only 
the following for that vendor ID:

105b  Foxconn International, Inc.
	e065  BCM43142A0 Bluetooth module

On the other hand there is a dozen of entries for Foxconn / Hon Hai 
(vendor ID 0x0489) there. Btusb already handles these, it seems.

Because of the unusual vendor ID, I thought, using USB_DEVICE() would be 
more appropriate, at least for now.

>
> Regards
>
> Marcel
>
>

Regards,

Eugene
