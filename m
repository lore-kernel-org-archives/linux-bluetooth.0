Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH]     Bluetooth: Add support for Broadcom BCM20702A0 in Fuijitsu Lifebook E751
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <547EF951.8060007@gmx.de>
Date: Wed, 3 Dec 2014 13:57:15 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FF02FEDE-83A1-46E1-A863-65A4EF002073@holtmann.org>
References: <8967C48B-00C1-43E8-A8EC-C41642288122@holtmann.org> <1417546017-25257-1-git-send-email-harv@gmx.de> <EC8200AB-98BA-4C4B-AC07-E6AA51DE284B@holtmann.org> <547EF951.8060007@gmx.de>
To: harv@gmx.de
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

>> Actually there is a generic catch all entry for vendor 0x0489
>> already.
>> 
>> /* Foxconn - Hon Hai */ { USB_VENDOR_AND_INTERFACE_INFO(0x0489,
>> 0xff, 0x01, 0x01) },
>> 
>> So I prefer that we enable BTUSB_BCM_PATCHRAM support in a generic
>> way instead of just for every single product id.
> 
> I have seen the other patch from Wen-chien Jesse Sung that does
> exactly this. But while I would prefer this way too I doubt that all
> firmware files come from the same place as these are vendor specific
> things. Mine i.e. was from a Fuijitsu support URL. So the commit
> message can not provide sources for firmware download in these generic
> way.

yes it can be in the commit message. Just clearly state what you are doing. Allowing for firmware download support does not mean that it is the same firmware. While you are enabling firmware download for the whole vendor class of the devices, the firmware extraction can be just described for a single product id. Just mention it in the commit message.

Regards

Marcel

