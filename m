Return-Path: <ian@mnementh.co.uk>
Subject: Re: BCM43430 BT driver almost working...
From: Ian Molton <ian@mnementh.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@intel.com>, linux-bluetooth@vger.kernel.org
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
 <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
 <4078da55-c5d8-7c2d-d954-9da790982b22@mnementh.co.uk>
Message-ID: <5efb7448-9208-f6e3-0c87-6b077a439b5c@mnementh.co.uk>
Date: Fri, 30 Jun 2017 21:53:31 +0100
MIME-Version: 1.0
In-Reply-To: <4078da55-c5d8-7c2d-d954-9da790982b22@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 30/06/17 18:14, Ian Molton wrote:
> On 30/06/17 18:02, Marcel Holtmann wrote:
>> If you have an embedded board with a proper DT definition, and the
>> UART is hard-wired to the Bluetooth chip, then go for serdev. It
>> means no btattach is needed. The kernel will enumerate this properly
>> for you. That is the way forward. Someone needed to adapt the
>> hci_bcm.c driver for this anyway. It just happens that you are the
>> first one.
> 
> Right - I'll follow that route and add serdev support to hci_bcm.c then!

Hmm. ok, this gets to be a bitof a rabbit-hole.

the hci-nokia driver is *extremely* similar in operation to the hci_bcm
driver, other than being serdev based. even the firmware loading is
"broadcom style", so I dont really see why it needs another driver,
other than its been coded to one chip and a few small nokia-specific
bits in it.

It seems there is a fair bit of commonality among the h4 based bluetooth
drivers - probably better to abstract it out and make a h4 core around
which the other serdev and ldisc drivers could sit?

I'll have a look at that on Monday.

-Ian
