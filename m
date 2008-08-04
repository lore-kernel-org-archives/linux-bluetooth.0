Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <9925799E-5F50-4C03-9C0C-A28A9A657B1A@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200808041901.36706.oliver@neukum.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 19:25:17 +0200
References: <200807311452.24166.oliver@neukum.org> <200808041823.28309.oliver@neukum.org> <7D2DA686-9741-4369-9E47-E4AD140D067E@holtmann.org> <200808041901.36706.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

>>> Then why do you implement this option for hci_usb?
>>> And why can the other IGNORE options be overridden?
>>
>> if I wanna use the generic Bluetooth descriptor for matching, I  
>> need a
>> way to mark broken devices as to be ignored. Otherwise I would have a
>> really long list of matching vendor and product ids.
>
> True, but if btusb is to replace hci_usb, the module options should  
> match.
> So will you remove that option in hci_usb?

the override_ignore is your invention. So what do you mean?

Regards

Marcel

