Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC v2 4/4] Bluetooth: Add support Intel Bluetooth bootloader device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D0ACDE57.44B1%tedd.an@intel.com>
Date: Wed, 10 Dec 2014 12:31:56 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <B196DBB9-21EF-41B9-8079-968BED72C356@holtmann.org>
References: <20141208152500.6fef57ae@tedd-test> <91440EF0-0729-4962-AFC6-56E322B48183@holtmann.org> <D0ACDE57.44B1%tedd.an@intel.com>
To: "An, Tedd" <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

>>> +/*
>>> + * Send Intel Reset command to the device to enable the operational
>>> firmware.
>>> + * Because the device will not send CC event for Intel Reset command,
>>> + * the command is sent with btusb_send_frame() instead of
>>> __hci_cmd_sync() so
>>> + * the host won't wait for event.
>>> + */
>> 
>> Why :(
>> 
>> These are the things that does frustrate me sometimes. Is it too much to
>> ask from the bootloader to acknowledge that it received the command and
>> only then go and reset everything in the device.
>> 
>> I mean you start using a well defined transport protocol and then you
>> start violating it whenever you please because it is some tiny shortcut.
>> It means that the host stack now has to do extra work and we can never
>> tell when the device actually does a reset or if something fails. I mean
>> how would we know if some of the firmware verification fails?
> 
> I knew that you won¹t like it. :)
> This is currently on discussion and this implementation is based on the
> current spec and firmware design.
> I will update you in a few days.

if you go through the Bluetooth specification, then every HCI command sends a HCI command status event (or command complete) before doing its execution. Even commands like HCI Reset do this.

If you have to deal with UART chips that change the baudrate even the vendor specific commands are pretty clear that the HCI command status event comes via the old baudrate and only after that the new baudrate can be assumed.

I think it is just good practice to send the HCI command status event here and only after sending it out to do the reset and have the new firmware run. And I realize that internally there is some fun with the USB endpoints and making sure the host got this event. However that is better than the host guessing since if anything goes wrong, the host can not recover from this.

Regards

Marcel

