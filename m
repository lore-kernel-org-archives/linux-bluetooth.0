Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF343A1.8010606@atheros.com>
Date: Mon, 29 Nov 2010 11:39:37 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>, Marcel Holtmann
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add new PID for Atheros 3011
References: <1290766393-3801-1-git-send-email-sbalashanmugam@atheros.com> <1290770560.4795.12.camel@aeonflux> <4CEFA3A4.7030806@atheros.com> <4CEFD4D1.1040706@ahsoftware.de> <4CEFD855.6000503@ahsoftware.de>
In-Reply-To: <4CEFD855.6000503@ahsoftware.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Alexander Holler wrote:
> Am 26.11.2010 16:40, schrieb Alexander Holler:
>   
>> Hello,
>>
>> Am 26.11.2010 13:10, schrieb Bala Shanmugam:
>>     
>>> Marcel Holtmann wrote:
>>>       
>>>> Hi Bala,
>>>>
>>>>         
>>>>> Atheros 3011 has small sflash firmware and needs to be
>>>>> blacklisted in transport driver to load actual firmware
>>>>> in DFU driver.
>>>>>           
>>>> please add an empty line here. The signed-off line should always be
>>>> separated from the commit message. The git am takes it literal as it is
>>>> and does not modify it.
>>>>
>>>>         
>>>>> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
>>>>> ---
>>>>> drivers/bluetooth/ath3k.c | 2 ++
>>>>> drivers/bluetooth/btusb.c | 3 +++
>>>>> 2 files changed, 5 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
>>>>> index 128cae4..c70fb0b 100644
>>>>> --- a/drivers/bluetooth/ath3k.c
>>>>> +++ b/drivers/bluetooth/ath3k.c
>>>>> @@ -35,6 +35,8 @@
>>>>> static struct usb_device_id ath3k_table[] = {
>>>>> /* Atheros AR3011 */
>>>>> { USB_DEVICE(0x0CF3, 0x3000) },
>>>>>           
>>>> For the sake of readability add another empty line here as well.
>>>>
>>>>         
>>>>> + /* Atheros AR3011 with sflash firmware*/
>>>>> + { USB_DEVICE(0x0CF3, 0x3002) },
>>>>>           
>> I don't understand this patch and starting bluetooth will fail here,
>> when that patch is applied (to 2.6.36.1):
>>
>> -----------
>> [ 118.395793] usb 1-1.3: new full speed USB device using orion-ehci and
>> address 4
>> [ 118.506262] usb 1-1.3: New USB device found, idVendor=0cf3,
>> idProduct=3000
>> [ 118.506280] usb 1-1.3: New USB device strings: Mfr=0, Product=0,
>> SerialNumber=0
>> [ 118.654973] Bluetooth: Atheros AR30xx firmware driver ver 1.0
>> [ 119.072139] usbcore: registered new interface driver ath3k
>> [ 119.184499] usb 1-1.3: USB disconnect, address 4
>> [ 120.695642] usb 1-1.3: new full speed USB device using orion-ehci and
>> address 5
>> [ 120.806394] usb 1-1.3: New USB device found, idVendor=0cf3,
>> idProduct=3002
>> [ 120.806410] usb 1-1.3: New USB device strings: Mfr=0, Product=0,
>> SerialNumber=0
>> [ 125.815007] ath3k_load_firmware: Can't change to loading configuration
>> err
>> [ 125.815096] ath3k: probe of 1-1.3:1.0 failed with error -5
>> -----------
>>
>> As I've understood it, the pid 0x3002 will only come up, when the
>> firmwire was already uploaded. So adding 0x3002 to ath3k seems to be wrong.
>>     
>
> I assume bluetooth will fail here, because of the second part of that 
> patch which adds BTUSB_IGNORE to btusb.c:
>
> ------------
> +    /* Atheros 3011 with sflash firmware */
> +    { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
> ------------
>
> This means when the firmware was uploaded and the device identifies 
> itself afterwards with the pid 0x3002, btusb will ignore it.
>
> Regards,
>
> Alexander
>   
Alex,

This patch is for Atheros 3011 with sflash firmware.
This device gets identified Generic bluetooth USB device when plugged in.
We are blacklisting 3002 in btusb to load actual firmware in ath3k.
Latest firmware comes up with PID 3005 and not 3002.

Regards,
Bala.
