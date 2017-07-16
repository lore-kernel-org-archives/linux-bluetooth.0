Return-Path: <hanipouspilot@gmail.com>
MIME-Version: 1.0
In-Reply-To: <27C5C78B-0335-4E25-82CF-D01233D76A85@holtmann.org>
References: <1499340593-12739-1-git-send-email-hanipouspilot@gmail.com> <27C5C78B-0335-4E25-82CF-D01233D76A85@holtmann.org>
From: Dmitry Tunin <hanipouspilot@gmail.com>
Date: Sun, 16 Jul 2017 10:53:47 +0300
Message-ID: <CANoib0FTjt6B58XA95seTFyjihTFcmEWDhLwYTHKHmBGTeeCoQ@mail.gmail.com>
Subject: Re: [PATCH] Add support of all Foxconn (105b) Broadcom devices
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This one https://github.com/0day-ci/linux/commits/Dmitry-Tunin/Add-support-of-all-Foxconn-105b-Broadcom-devices/20170708-021656
is really garbled. But I wrote to you in a couple of minutes after I
sent it. And then sent the v2.
It looks like you applied a wrong one.

Regards,

Dmitry

2017-07-16 10:15 GMT+03:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Dmitry,
>
>> There is another device
>>
>> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=105b ProdID=e066 Rev=01.12
>> S:  Manufacturer=Broadcom Corp
>> S:  Product=BCM20702A0
>> S:  SerialNumber=342387DAE35E
>> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>>
>> Since we have Cls=ff, we can add all of them.
>>
>> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>> drivers/bluetooth/btusb.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index fa24d69..bf95c13 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -131,7 +131,7 @@ static const struct usb_device_id btusb_table[] = {
>>       { USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
>>
>>       /* Broadcom BCM43142A0 (Foxconn/Lenovo) */
>> -     { USB_DEVICE(0x105b, 0xe065), .driver_info = BTUSB_BCM_PATCHRAM },
>> +     { USB_VENDOR_AND_INTERFACE_INFO(0x105b, 0xff, 0x01, 0x01),
>>
>>       /* Broadcom BCM920703 (HTC Vive) */
>>       { USB_VENDOR_AND_INTERFACE_INFO(0x0bb4, 0xff, 0x01, 0x01),
>
> this patch is garbled up. And please include full /sys/kernel/debug/usb/devices for these ones.
>
> Regards
>
> Marcel
>
