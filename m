Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <55860F8C.4050205@lwfinger.net>
Date: Sat, 20 Jun 2015 20:12:44 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, Xi Ruoyao <xry111@outlook.com>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device
 table
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl> <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org>
In-Reply-To: <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/20/2015 04:58 PM, Marcel Holtmann wrote:
> Hi Xi,
>
>> In 'commit a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek
>> 8723A/8723B/8761A/8821A support"), support of some Realtek
>> devices was added to the Generic Bluetooth USB driver in kernel.
>> However, these devices are not in the module device table of
>> btusb.ko, so the kernel wouldn't probe them at all.
>>
>> To fix this, add four entries in the device table btusb_table,
>> based on code from <https://github.com/lwfinger/rtl8723au_bt>
>> ('new' branch).
>>
>> This enables bluetooth support in the Lenovo Ideapad Yoga 13
>> which has RTL8723AU USB device, with product ID 0bda:1724.
>>
>> Signed-off-by: Xi Ruoyao <xry111@outlook.com>
>> ---
>> drivers/bluetooth/btusb.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 3c10d4d..dd87623 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -148,6 +148,12 @@ static const struct usb_device_id btusb_table[] = {
>> 	{ USB_DEVICE(0x8087, 0x0a5a),
>> 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
>>
>> +	/* Realtek Bluetooth  */
>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) },
>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bd5, 0xe0, 0x01, 0x01) },
>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xe0, 0x01, 0x01) },
>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xe0, 0x01, 0x01) },
>> +
>
> I highly doubt these are needed. There is a generic entry for an USB transport that is already covering these.

Something changed in recent kernels, and the generic USB transport entries do 
not seem to be recognized in the case where a wifi and BT device share a single 
USB ID. As the OP's tablet has such a case, I suggest that 0bda line be 
accepted, but not the others. If I had a computer with an RTL8723AU, I would 
have a chance at debugging what changed, but sadly, that is not the case.

Larry
