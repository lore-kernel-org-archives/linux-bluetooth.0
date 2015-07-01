Return-Path: <cyrus@holtmann.org>
Message-ID: <5593ED9E.4040907@gmail.com>
Date: Wed, 01 Jul 2015 15:39:42 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Szymon Janc <Szymon.Janc@tieto.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Peripheral role support for android
References: <558DE8B3.3060102@gmail.com> <650B748F-76F8-4031-9397-E65D18AD01A4@holtmann.org>
In-Reply-To: <650B748F-76F8-4031-9397-E65D18AD01A4@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

>> AFAICS there is (at least) one catch: the kernel does not support setting custom values for min/max adv interval, channel map, tx power, etc. while the HAL API seems to expect per-instance setup of these values. How should we deal with this? Should we ignore these values? Or should we error out with a NOT_SUPPORTED error if they are different from the kernel defaults?
>
> We never exposed the channel map since that is pretty much stupid. I would just ignore that parameter. Just accept whatever it asks of and see okay, I will do it, even if you don't in the end.
>
> The TX power you could set whatever you want, but I would advise against it. Just accept the TX power you get from the HAL and then set Include TX Power flag. I mean the best you can do is check if TX Power is included or not. And allow the advertising data to reflect this.
>
> And min/max advertising interval is also something you should ignore. Actually that is something an application should never be in control of anyway. Choosing bad parameters might cause the controller to make a choice between BR/EDR and LE in its schedule. And for obvious reasons, the application has not knowledge of the BR/EDR state. So just accept them and go on with it.
>
>> Please let me know whether you agree to that roadmap and what you think about the unsupported features. Is it ok if I try to tackle these todos? Or is someone working on this already?
>
> Go ahead.
>
> Regards
>
> Marcel

Thanks Marcel! All questions answered. :-)

Florian
