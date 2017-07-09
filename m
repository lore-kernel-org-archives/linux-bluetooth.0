Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: PATCH: RFC: Broadcom serdev driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170708214623.fhzrzhcedo2hhov4@earth>
Date: Sun, 9 Jul 2017 10:07:17 +0200
Cc: Ian Molton <ian@mnementh.co.uk>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Rob Herring <robh@kernel.org>
Message-Id: <12AF72B3-C621-4E01-AB9B-10BF5E5913FE@holtmann.org>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
 <372d1433-376c-8896-60a0-e24bbeede427@mnementh.co.uk>
 <20170708214623.fhzrzhcedo2hhov4@earth>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

>>>> -----------------------------------------------------------------------
>>>> 
>>>> 	This patch adds a driver for broadcom BT devices that are
>>>> attached as serdev devices.
>>>> 
>>>> A device tree entry such as the following is used with this driver:
>>>> 
>>>>       bcm34340a1: bluetooth {
>>>>               compatible = "brcm,b43430a1";
>>>>               reset-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
>>>> 		bluetooth-wakeup-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;
>>>> 
>>>> 		init-speed = <115200>;
>>>>               oper-speed = <400000>;
>>>>       };
>>> 
>>> I would prefer a separate patch for this that includes this also as samples in the Documentation/bindings directory.
>> 
>> No problem - this i just an RFC, so I wasnt sure if you'd like the binding.
>> 
>>>> obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
>>>> +obj-$(CONFIG_BT_HCIUART_BCMBT)	+= hci_bcm_serdev.o
>>> 
>>> I was actually not wanting to have a separate driver. Like hci_ll.c this needs to be in hci_bcm.c.
>> 
>> I appreciate that, but there are a couple of reasons why I didn't;
>> 
>> * The original driver operates quite differently with regards to
>> matching the platform data up with a uart - since it has no knowledge of
>> the mapping from ttydev to serial device, it maintains a list that it
>> matches against during upen - its quite a lot more complex as a result.
>> 
>> Being a serdev driver, this one doe not need that code.
>> 
>> * I have no way to test the ACPI or wakeup/irq features of the original
>> driver, so I could not implement it and be sure it would work.
>> 
>> My hope was that we could include this driver, and move a couple of
>> common functions it shares with the older driver into btbcm.c
>> 
>> Over time, people could add the functionality and we could remove the
>> old driver - all without upsetting existing users of the old driver.
> 
> The broadcom driver should probably become serdev only at some
> point, since it always requires platform support due to the GPIOs
> The current solution is a big hack. But tackling that requires ACPI
> support for serdev, so I guess that it must be done by somebody
> else.

actually I think that all of them need to be serdev only drivers. We just need to figure out on how to create the serdev devices for the ones that are not backed by DT.

Regards

Marcel

