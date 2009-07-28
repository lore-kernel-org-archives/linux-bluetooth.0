Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A6E5D19.2070408@dtsp.co.nz>
References: <9e4733910907271847w4a10b658x571148965788b5cf@mail.gmail.com>
	 <4A6E5D19.2070408@dtsp.co.nz>
Date: Mon, 27 Jul 2009 23:18:53 -0400
Message-ID: <9e4733910907272018h29171b9atc858b6600f96861c@mail.gmail.com>
Subject: Re: Possible bluez sensor net application
From: Jon Smirl <jonsmirl@gmail.com>
To: David Sainty <david.sainty@dtsp.co.nz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 27, 2009 at 10:06 PM, David Sainty<david.sainty@dtsp.co.nz> wrote:
> Jon Smirl wrote:
>>
>> I need to get data from about 200 sensors in to a central Linux system
>> wirelessly. I'm attracted to using Bluetooth for this since I can buy
>> the radios so cheaply.
>>
>> Power is not a problem in the sensor nodes. The sensors have a basic
>> microcontroller in them. I can add a HCI Bluetooth chip (BC4-ROM).
>> Alternatively I can look at something like a BC4+flash module.
>>
>> Or is Bluetooth totally unsuited to this application
>
> Maybe check out ZigBee?

Implementing Zigbee is more expensive than Bluetooth. ZigBee is also
in a a somewhat chaotic state, the standard is nowhere near as mature
as Bluetooth. ZigBee is also GPL in compatible with it's current
licensing scheme.

That said, ZigBee is my second choice. I'd probably ignore ZigBee and
use 6lowpan instead.

>
>



-- 
Jon Smirl
jonsmirl@gmail.com
