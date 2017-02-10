Return-Path: <haagch@frickel.club>
Subject: Re: [PATCH] Bluetooth: btusb: add support for 0bb4:0306
To: Marcel Holtmann <marcel@holtmann.org>
References: <20170210003142.3871-1-haagch@frickel.club>
 <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, "Gustavo F. Padovan"
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
From: Christoph Haag <haagch@frickel.club>
Message-ID: <0dd3dccb-e0b2-fcd1-5271-5388ab847bd3@frickel.club>
Date: Fri, 10 Feb 2017 13:09:18 +0100
MIME-Version: 1.0
In-Reply-To: <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel.

I've sent a new version but it seems my message was not included, so here it is.

Thanks for the comment.
It did not work right with the first patch anyway, was probably missing some stuff.

With this new patch I can actually pair and use gatttool.
lsusb says BCM920703 now.

dmesg says

Bluetooth: hci0: BCM: chip id 102
Bluetooth: hci0: c-l
Bluetooth: hci0: BCM (001.001.005) build 0000
Bluetooth: hci0: BCM (001.001.005) build 0481
Bluetooth: hci0: BCM20703A1 Generic USB 20Mhz fcbga_BU

Would this be useful for the commit message?

Christoph

On 10.02.2017 12:23, Marcel Holtmann wrote:
> Hi Christoph,
>
>> It's a custom USB ID for the broadcom bt adapter in the HTC Vive.
>>
>> T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0bb4 ProdID=0306 Rev=01.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM2045A0
>> S:  SerialNumber=AC3743E110CE
>> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>>
>> Signed-off-by: Christoph Haag <haagch@frickel.club>
>> ---
>> drivers/bluetooth/btusb.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 2f633df9f4e6..afb48aebe9c5 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -124,6 +124,9 @@ static const struct usb_device_id btusb_table[] = {
>> 	/* Broadcom BCM20702A0 */
>> 	{ USB_DEVICE(0x413c, 0x8197) },
>>
>> +	/* Broadcom BCM2045A0 found in the HTC Vive */
>> +	{ USB_DEVICE(0x0bb4, 0x0306) },
>> +
> actually you want to use USB_VENDOR_AND_INTERFACE_INFO like we do for all the other Broadcom based devices. So that all HTC devices that have the Broadcom ff:01:01 interface description are covered.
>
> And if you can add /sys/kernel/debug/usb/devices to have to the full descriptors, that would be great. If this works with the BTUSB_BCM_PATCHRAM quirk, then there is also some extra debug info in dmesg that you might want to include.
>
> Regards
>
> Marcel
>
