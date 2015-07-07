Return-Path: <cyrus@holtmann.org>
Message-ID: <559B64FA.2070200@ahsoftware.de>
Date: Tue, 07 Jul 2015 07:34:50 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: Re: Why doesn't plugins/sixaxis.c set devices as Trusted?
References: <1436188651.26954.9.camel@hadess.net>	 <559B5633.8000102@ahsoftware.de> <1436245912.26954.15.camel@hadess.net>
In-Reply-To: <1436245912.26954.15.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 07.07.2015 um 07:11 schrieb Bastien Nocera:
> On Tue, 2015-07-07 at 06:31 +0200, Alexander Holler wrote:
>> Am 06.07.2015 um 15:17 schrieb Bastien Nocera:
>>> Hey,
>>>
>>> I don't understand the reason why plugins/sixaxis.c doesn't set the
>>> device as trusted when plugged in.
>>
>> It's because of security. If you trust a bluetooth device on Linux,
>> you're trusting it for all services. In case of the sixaxis it means
>> you're not only trusting it (the BT-MAC) as an input device, but also
>> as
>> a network device.
>>
>> Now if you trust any plugged in device which says it's a sixaxis, I
>> would tell my arduino to say it's an sixaxis with a MAC from one of
>> my
>> BT-dongles to get a magic device which gives me wireless remote
>> access
>> on every linux box with BT when I plug it in once.
>>
>> That means you want user interaction, besides just plugging in a
>> device.
>
> What should the pairing process look like then? Because the current
> workflow is absolutely dreadful.

Pairing is something different than trusting a bluetooth device.

No idea what's your problem. If you remove the necessary user 
interaction to trust a device, you remove the security. Just plugging in 
an (anonymous) usb-device isn't usable as trust.

If Sony decided that's ok for the PS3 (a game console), it's one thing.

But you don't want a wireless remote connected second keyboard or even a 
network device if some just plugged in an anonymous usb-device which 
might even look totally different than as what it presents itself to the 
system.

Alexander Holler
