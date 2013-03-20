Return-Path: <cyrus@holtmann.org>
Message-ID: <514A108C.9000102@somethingshocking.com>
Date: Wed, 20 Mar 2013 19:39:56 +0000
From: Graham Burnside <graham@somethingshocking.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: ralink rt3290/3298 pcie
References: <514A09AD.20809@somethingshocking.com>
In-Reply-To: <514A09AD.20809@somethingshocking.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 20/03/13 16:58, Gustavo Padovan wrote:
> Hi Graham,
>
> * Graham Burnside <graham@somethingshocking.com> [2013-03-19 22:48:59 +0000]:
>
>> Hi,
>>
>> I was wondering if anyone had had a look into or discussed this wifi /
>> bluetooth combo card with ralink? It came present in my new HP laptop,
>> so I'm guessing its quite common.
>>
>> I have the wifi working perfectly from the rt2x00 backports, but can't
>> find any mention of the bluetooth device. I have also emailed ralink, so
>> will post anything useful back here.
>>
>> Details as follows:
>>
>>            +-1c.0-[01]--+-00.0  Ralink corp. Device 3290
>>            |                        \-00.1  Ralink corp. Device 3298
> You are saying that you don't even see the device with 'hciconfig', right?
>
> So please post the output of /sys/kernel/debug/usb/devices for the bluetooth
> device here so we can more information about this device.
>
> 	Gustavo

Hi,

Thanks for the interest Gustavo. I'm running Debian wheezy, there is no
device found on loading the 3.2, or 3.7 kernel.


On the 3.2 kernel, rfkill gives:

0: hp-wifi: Wireless LAN
    Soft blocked: no
    Hard blocked: no
1: hp-bluetooth: Bluetooth
    Soft blocked: no
    Hard blocked: no
2: phy0: Wireless LAN
    Soft blocked: no
    Hard blocked: no

The hardware switch gives hard-lock on and off for both the hp-wifi
& hp-bluetooth. But neither device work.

Using a backported driver for rt2x00 gets the rt3290 device working fine.

hciconfig gives no ouput.

The directory /sys/kernel/debug/usb/devices does not exist. I'm not sure
what else might be useful?


Here is the relevant output from lspci -v (note there is no kernel
driver being loaded for the bluetooth device).

01:00.0 Network controller: Ralink corp. Device 3290
    Subsystem: Hewlett-Packard Company Device 18ec
    Flags: bus master, fast devsel, latency 0, IRQ 16
    Memory at c2510000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
    Capabilities: [70] Express Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [140] Device Serial Number 00-00-4d-fa-a8-23-94-68
    Kernel driver in use: rt2800pci

01:00.1 Bluetooth: Ralink corp. Device 3298
    Subsystem: Hewlett-Packard Company Device 18ec
    Flags: bus master, fast devsel, latency 0, IRQ 11
    Memory at c2500000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
    Capabilities: [70] Express Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [140] Device Serial Number 00-00-4e-fa-a8-23-94-68


- Graham.

-- 

Get my public signing / encryption OpenPGP key at:
https://www.somethingshocking.com/grahamPublicPGP.key

