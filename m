Return-Path: <c.torens@web.de>
Date: Thu, 26 Aug 2004 02:36:43 +0200
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-users] l2cap question
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <opsda220m9eocfdv@debian> <1093469385.537.17.camel@pegasus>
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opsdbdbhfdeocfdv@debian>
In-Reply-To: <1093469385.537.17.camel@pegasus>
Sender: c.torens@web.de
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

>> Does a Bluetooth USB-Dongle use isochronus USB transfers?
> It uses it for SCO support.

I read SCO is only (or mainly?) for speech.
I don't use speech, but I guess it is somehow used when
SCO is enabled in the config?
Is it used by "hciconfig hci0 up", too?
(This is making problems with some, but not all dongles)


>> (Because the USB host driver seems to have problems with
>> isoc. transfers and I'm not sure if this actaully is the
>> error I am fighting with)
> Disable SCO support for the USB driver and no ISOC transfers are used.

That is a great idea.
I think this could really help me finding some answers.
Hope to test it tomorrow.

Thank you for this tip, Marcel

-- 
Regards,
Christoph
