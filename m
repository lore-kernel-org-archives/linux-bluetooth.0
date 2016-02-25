Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 16:57:44 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Matthias Schmidt <Matthias.Schmidt@netpioneer.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Connection refused - PSM not supported
Message-ID: <20160225155744.GA8073@t440s.nuernbergmesse.de>
References: <3C44B1A8-A9C9-43A9-84C5-C6220705C1B7@netpioneer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3C44B1A8-A9C9-43A9-84C5-C6220705C1B7@netpioneer.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On Thu, Feb 25, 2016, Matthias Schmidt wrote:
> I’m trying with a Nexus 4 ( Android 5.1.1 ) Phone using Bluepixel’s
> BLEScanner to browse the Services/Charateristics provided by Bluez
> 5.37 / ARM and
> our own Python/DBUS Code.
> 
> Alas, i don’t get any information displayed.
> 
> Two things which pop into my eyes while reading throug the dump are:
> 
> a) A connect request using the PSM(1) of SDP get’s turned down:

SDP is a BR/EDR protocol. It doesn't exist for LE (which I assume
you're using since you say you use something called BLEScanner). So
that's why you get PSM not supported.

> b) The Nexus refuses to raise the MTU to 517:
> 
> < ACL data: handle 1 flags 0x00 dlen 7
>     L2CAP(d): cid 0x0042 len 3 [psm 31]
>       ATT: MTU req (0x02)
>         client rx mtu 517
> > ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 31]
>       ATT: Error (0x01)
>         Error: Request not supported (6)
>         MTU req (0x02) on handle 0x0000
> 
> According to my interpretation of the spec this could happen and
> should not cause the connection to fail.

How is it failing? A disconnection isn't necessarily a failure - it
could just be a timeout happening.

Johan
