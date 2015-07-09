Return-Path: <cyrus@holtmann.org>
Message-ID: <559ED8FF.2000800@ahsoftware.de>
Date: Thu, 09 Jul 2015 22:26:39 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Harald Schmitt <linux@hschmitt.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Why doesn't plugins/sixaxis.c set devices as Trusted?
References: <1436188651.26954.9.camel@hadess.net> <559B5633.8000102@ahsoftware.de> <559BDF20.9090905@hschmitt.de>
In-Reply-To: <559BDF20.9090905@hschmitt.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 07.07.2015 um 16:16 schrieb Harald Schmitt:
> Am 07.07.2015 um 06:31 schrieb Alexander Holler:
>> Am 06.07.2015 um 15:17 schrieb Bastien Nocera:
>>> Hey,
>>>
>>> I don't understand the reason why plugins/sixaxis.c doesn't set the
>>> device as trusted when plugged in.
>>
>> It's because of security. If you trust a bluetooth device on Linux,
>> you're trusting it for all services.
> Just as a side note: This is not a good security rule. Why should I
> trust a game controller on any other service then controlling my game
> moves?

Also differentiating a network service from an input service wouldn't be 
that hard (at least at OS level), it won't help much in regard to the 
topic because you can't really differentiate a gamepad from a keyboard 
(both are HID input devices).

And you just don't want to automatically enable (trust) a (wireless) 
remote input (especially a keyboard) if someone managed it to plug in 
some USB device into your Linux box without any user interaction.

Regards,

Alexander Holler
