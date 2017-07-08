Return-Path: <ian@mnementh.co.uk>
Subject: Re: PATCH: RFC: Broadcom serdev driver
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Loic Poulain <loic.poulain@gmail.com>, Rob Herring <robh@kernel.org>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <372d1433-376c-8896-60a0-e24bbeede427@mnementh.co.uk>
Date: Sat, 8 Jul 2017 10:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 08:58, Marcel Holtmann wrote:

Hi!

>> -----------------------------------------------------------------------
>>
>> 	This patch adds a driver for broadcom BT devices that are
>> attached as serdev devices.
>>
>> A device tree entry such as the following is used with this driver:
>>
>>        bcm34340a1: bluetooth {
>>                compatible = "brcm,b43430a1";
>>                reset-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
>> 		bluetooth-wakeup-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;
>>
>> 		init-speed = <115200>;
>>                oper-speed = <400000>;
>>        };
> 
> I would prefer a separate patch for this that includes this also as samples in the Documentation/bindings directory.

No problem - this i just an RFC, so I wasnt sure if you'd like the binding.

>> obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
>> +obj-$(CONFIG_BT_HCIUART_BCMBT)	+= hci_bcm_serdev.o
> 
> I was actually not wanting to have a separate driver. Like hci_ll.c this needs to be in hci_bcm.c.

I appreciate that, but there are a couple of reasons why I didn't;

* The original driver operates quite differently with regards to
matching the platform data up with a uart - since it has no knowledge of
the mapping from ttydev to serial device, it maintains a list that it
matches against during upen - its quite a lot more complex as a result.

Being a serdev driver, this one doe not need that code.

* I have no way to test the ACPI or wakeup/irq features of the original
driver, so I could not implement it and be sure it would work.

My hope was that we could include this driver, and move a couple of
common functions it shares with the older driver into btbcm.c

Over time, people could add the functionality and we could remove the
old driver - all without upsetting existing users of the old driver.

> You coding style is messed up here. Please follow the netdev coding style.

Missed that one, as I've not checkpatched it yet, my bad.

Regards,

-Ian
