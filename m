Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluetooth not working anymore due to too agressive PM in hci_bcm
 ? (was: [PATCH v5 5/5] Bluetooth: hci_bcm: Add suspend/resume runtime PM
 functions)
To: =?UTF-8?Q?J=c3=a9r=c3=b4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <1475533357.2947.3.camel@gmail.com>
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <da9a4059-4164-e455-a451-83c97e57ad71@intel.com>
Date: Tue, 4 Oct 2016 09:46:31 +0200
MIME-Version: 1.0
In-Reply-To: <1475533357.2947.3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

>
> since building a kernel with its parent commit [4] works perfectly fine:
>    commit: 7649faff1cfe4f76dabf78cd53d659d39f65b3c1
>    Bluetooth: Remove useless rx_lock spinlock
>
> The code change adding the runtime PM functions introduces an autosleep
> delay but it's unclear from the commit description how the BT chipset is
> supposed to get out of sleep afterwards.

Using out-of-band gpio/irq which are retrieved from the ACPI device.
wakeup can be initiated by host or controller depending which one wants
to transfer hci data.

>
> For 3 different devices at least (Asus T100 Chi, Asus T100TA and Lenovo
> ThinkPad Tablet 8), it seems to lead in practice to a regression since the
> BT chipset doesn't wake up anymore on normal operations (moving the mouse,
> typing a key on the keyboard, etc) breaking Bluetooth from a user PoV. And
> maybe a few more products using hci_bcm are impacted too.

I'm going to retry on my T100 and let you know, but used to work.

>
> If you have a patch suggestion for a potential fix, I would be glad to give
> it a try in the coming days and confirm if it solves the issue or not.

- What is the state of your interrupt counter ("host_wake") in 
/proc/interrupts when you try to generate host wake-up events (using 
mouse...).

- Could you confirm you don't meet the issue if you disable runtime-pm 
via sysfs. You should find the device (BCM43*) as a child node of your 
tty in /sys/class/tty*. (echo on > power/control).

>
> If a proper fix is going to need quite more time otherwise, could you
> consider reverting this specific commit in the meantime? Thanks.

I remember Frederic had some gpio/irq polarity issues:
5cebdfea32b89911d4540440c1c2854a1a3d591e
Bluetooth: hci_bcm: Fix IRQ polarity for T100
Maybe the ACPI table is not correct on some devices.

Regards,
Loic

