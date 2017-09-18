Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: meshctl fails on rpi 3
To: Laczen JMS <laczenjms@gmail.com>, <linux-bluetooth@vger.kernel.org>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <4fb86bd1-b1ed-72aa-7834-adc84642528e@microchip.com>
Date: Mon, 18 Sep 2017 13:50:04 +0300
MIME-Version: 1.0
In-Reply-To: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Jehudi,

On 09/17/2017 06:41 PM, Laczen JMS wrote:
> After downloading and compiling bluez 5.47 on raspberry pi 3 (raspbian
> 2017-09-07), it is not possible to run meshctl on the raspberry pi.
> Meshctl fails at loading the prov_db.
> 
> After some further testing I have found that the loading fails in the
> crypto functions at binding the AF_ALG in line 178 of crypto.c. Has
> this something to do with cryptographic modules being unavailable on
> the rpi 3?
> 
> If so, what crypto module is required and what is the best way to add
> these modules ?

I remember that I ran in similar issues when testing SMP. All worked ok
when I had the af-alg user-space interface builtin in the kernel.

Hope that helps,
ta
