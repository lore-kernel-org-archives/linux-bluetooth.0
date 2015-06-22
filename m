Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55860F8C.4050205@lwfinger.net>
Date: Mon, 22 Jun 2015 12:33:34 +0200
Cc: Xi Ruoyao <xry111@outlook.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>
Message-Id: <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org>
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl> <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org> <55860F8C.4050205@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

>>> In 'commit a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek
>>> 8723A/8723B/8761A/8821A support"), support of some Realtek
>>> devices was added to the Generic Bluetooth USB driver in kernel.
>>> However, these devices are not in the module device table of
>>> btusb.ko, so the kernel wouldn't probe them at all.
>>> 
>>> To fix this, add four entries in the device table btusb_table,
>>> based on code from <https://github.com/lwfinger/rtl8723au_bt>
>>> ('new' branch).
>>> 
>>> This enables bluetooth support in the Lenovo Ideapad Yoga 13
>>> which has RTL8723AU USB device, with product ID 0bda:1724.
>>> 
>>> Signed-off-by: Xi Ruoyao <xry111@outlook.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 3c10d4d..dd87623 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -148,6 +148,12 @@ static const struct usb_device_id btusb_table[] = {
>>> 	{ USB_DEVICE(0x8087, 0x0a5a),
>>> 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
>>> 
>>> +	/* Realtek Bluetooth  */
>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) },
>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bd5, 0xe0, 0x01, 0x01) },
>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xe0, 0x01, 0x01) },
>>> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xe0, 0x01, 0x01) },
>>> +
>> 
>> I highly doubt these are needed. There is a generic entry for an USB transport that is already covering these.
> 
> Something changed in recent kernels, and the generic USB transport entries do not seem to be recognized in the case where a wifi and BT device share a single USB ID. As the OP's tablet has such a case, I suggest that 0bda line be accepted, but not the others. If I had a computer with an RTL8723AU, I would have a chance at debugging what changed, but sadly, that is not the case.

these Realtek devices are causing the most messy setup in a generic driver. And Bluetooth USB support has been really clean and simple for the last 10 years. I really wonder how many ways this gets done wrong before someone gets a clue and gets this right. At the end of the day this USB transport is 15 years old.

Anyway, for obvious reasons the content of /sys/kernel/debug/usb/devices should be included here so that someone can actually look at how the USB endpoints are configured.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
