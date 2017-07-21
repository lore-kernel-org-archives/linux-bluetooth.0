Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware
 download
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <aee49b83-5191-23c2-45b3-b695fc6d5a9c@mnementh.co.uk>
Date: Fri, 21 Jul 2017 13:27:49 +0200
Cc: maxin.john@gmail.com,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "Maxin B. John" <maxin.john@intel.com>
Message-Id: <79177492-9A36-4378-A914-A7073C1DD24A@holtmann.org>
References: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
 <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
 <768de172-bf01-e9ea-a4c9-ea8f46cf5f1d@mnementh.co.uk>
 <C7827387-1AD3-41C9-9F1B-FF4A57940AB9@holtmann.org>
 <aee49b83-5191-23c2-45b3-b695fc6d5a9c@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

>>>> However I would prefer if we stop using hciattach and focus on
>>>> hci_bcm.c support with btattach and serdev.
>>> 
>>> I can resubmit my serdev driver if you like? It needs a little
>>> cleanup but its been solid here over the last week or two. Mostly
>>> its missing some runtime PM support (I cant test that as my device
>>> is crippled and has no host-wakeup or device-suspend lines).
>> 
>> I am not going to assign a new N_HCI UART type to the same hardware.
>> It all needs to go through the same type. So I still think for now it
>> should be in the same hci_bcm.c file.
> 
> If I have it share the UART type, that should be no problem. Its highly
> unlikely for anyone to have both drivers coexist on a OF platform.
> 
> I could set it up so that you can select one *or* the other in Kconfig.
> 
>>> I cant see a nice way to integrate it with the existing driver due
>>> to the fact that it differs markedly in the routines that need
>>> pointers to the serio structures.
>> 
>> We want to actually turn all legacy N_HCI drivers into serdev
>> drivers. So that the only think you write are serdev drivers.
> 
> I cannot see a nice way to do this.
> 
>> So that is really the way to go here. Convert everything into serdev
>> drivers. Have a look at his current work.
> 
> It really isnt.
> 
> serdev drivers are for platforms that have the port -> subdevice
> mappings available at probe time.
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=serdev-ldisc
> 
> I hate to sound peevish, but that really does not look like a good idea.
> 
> Part of the point of serdev drivers is to keep the ttydev out of the
> hands of userspace. This code explicitly overrides that.
> 
> This already looks a lot more complex than my serdev driver.
> 
> A far better approach would be to teach ACPI platforms how to chreate
> their own serdev devices.

I agree that ACPI and even pure platform devices should create serdev nodes.

> Platforms with zero hardware info available should NOT be using serdev.

Actually there will be development hardware that comes via USB-TTY converters and we need to make this work somehow. I am not going to write two drivers for each hardware in the future. And we are using development boards often for hardware testing and bringup.

Regards

Marcel

