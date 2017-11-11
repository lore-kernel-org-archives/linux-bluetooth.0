Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] bluetooth: btusb: Add device ID for RTL8822BE
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org, Hon Weng Chong <honwchong@gmail.com>
References: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
 <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a2c8efa7-6acb-fc97-8401-87bbc9e3d618@lwfinger.net>
Date: Sat, 11 Nov 2017 13:10:08 -0600
MIME-Version: 1.0
In-Reply-To: <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/11/2017 12:51 PM, Marcel Holtmann wrote:
> Hi Larry,
> 
>> The Asus Z370-I contains a Realtek RTL8822BE device with an associated
>> BT chip using a USB ID of 0b05:185c. This device is added to the driver.
>>
>> Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> ---
>> drivers/bluetooth/btusb.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 7a5c06aaa181..c265ef63cab7 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -373,6 +373,9 @@ static const struct usb_device_id blacklist_table[] = {
>> 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
>> 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
>>
>> +	/* Additional Realtek 8822BE Bluetooth devices */
>> +	{ USB_DEVICE(0x0b05, 0x1185c), .driver_info = BTUSB_REALTEK },
>> +
> 
> I prefer to have /sys/kernel/debug/usb/devices for the device included in the commit message.
> 
> Regards
> 
> Marcel
> 
> 
Hon,

Please provide the data.

Larry
