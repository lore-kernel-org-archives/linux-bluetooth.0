Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4fb86bd1-b1ed-72aa-7834-adc84642528e@microchip.com>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
 <4fb86bd1-b1ed-72aa-7834-adc84642528e@microchip.com>
From: Laczen JMS <laczenjms@gmail.com>
Date: Mon, 18 Sep 2017 21:48:06 +0200
Message-ID: <CAFxSrVufJHhz2TqXKwydXqy3UJWJbeaB+Cf0Ke7x6dh=C-h9JA@mail.gmail.com>
Subject: Re: meshctl fails on rpi 3
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I can confirm that recompiling the kernel with the crypto settings
from "test-runner.txt" solves the problem. After recompiling and
installing the kernel with the crypto settings:

CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y

meshctl can load the json files and connect to the bluetooth mesh.

Kind regards,

Jehudi

2017-09-18 12:50 GMT+02:00 Tudor Ambarus <tudor.ambarus@microchip.com>:
> Hi, Jehudi,
>
> On 09/17/2017 06:41 PM, Laczen JMS wrote:
>>
>> After downloading and compiling bluez 5.47 on raspberry pi 3 (raspbian
>> 2017-09-07), it is not possible to run meshctl on the raspberry pi.
>> Meshctl fails at loading the prov_db.
>>
>> After some further testing I have found that the loading fails in the
>> crypto functions at binding the AF_ALG in line 178 of crypto.c. Has
>> this something to do with cryptographic modules being unavailable on
>> the rpi 3?
>>
>> If so, what crypto module is required and what is the best way to add
>> these modules ?
>
>
> I remember that I ran in similar issues when testing SMP. All worked ok
> when I had the af-alg user-space interface builtin in the kernel.
>
> Hope that helps,
> ta
