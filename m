Return-Path: <cyrus@holtmann.org>
Message-ID: <4EFA7696.6060506@gmail.com>
Date: Wed, 28 Dec 2011 02:53:26 +0100
From: Rene Herman <rene.herman@gmail.com>
MIME-Version: 1.0
To: Andre Guedes <andre.guedes@openbossa.org>
CC: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [bluetooth] linux-3.x regression (bisected)
References: <4EF3BACA.1080405@gmail.com> <CACJA=fVezGGcgAtbzG=+ouWq0PiHbgXN1YPwL+VDUphWS7wnrw@mail.gmail.com> <4EFA1EB8.9090005@gmail.com> <20111227203008.GA13870@joana> <4EFA447C.3030906@gmail.com> <20111228012248.GC13870@joana> <20111228012850.GD13870@joana>
In-Reply-To: <20111228012850.GD13870@joana>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 28-12-11 02:28, Gustavo Padovan wrote:

>> For some reason your adapter is returning here the same value of
>> Read Local Features. I would say your device is broken.  The only
>> fix I have in mind now is throw away the device.
>
> Yes, I have one of these ISSC devices, it's completely broken
> device.

It worked well upto and including 2.6.29 though.

This would seem to be the kind of thing other subsystems use quirk 
handling for. The device identifies itself as "1131:1004":

Bus 002 Device 002: ID 1131:1004 Integrated System Solution Corp. 
Bluetooth Device

Do you guys have infra-structure in place for adapter-specific (quitk) 
handling?

Rene.
