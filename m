Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473372206.3263.39.camel@gmail.com>
Date: Mon, 12 Sep 2016 09:29:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1C6C9A5E-3E82-4BC0-8FE1-CA72722B5EE1@holtmann.org>
References: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com> <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org> <1473283543.3400.48.camel@gmail.com> <57368BCF-67A1-416C-A4DF-19289E7E06A8@holtmann.org> <1473372206.3263.39.camel@gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

>>>> Until then, you need an userspace part that triggers btattach with the
>>>> right hardware id on the right /dev/ttySx device node as soon as it
>>>> becomes available.
>>> 
>>> Maybe my mistake is that I've interpreted your sentence: "as soon as
>>> *it* becomes available" to assume that "it" was referring to the
>>> /dev/ttyS1 device node. I'll try to see if I can create another udev
>>> rule that would trigger based on the actual BT chipset becoming
>>> available, and not based on /dev/ttyS1 , but I'm still looking for how
>>> to do it with dev.
>> 
>> maybe the RFKILL switch part gets discovered later than the TTY. I don't
>> have a platform to verify, but just at few printk into the probe routine
>> and see if its finds the according GPIOs for power control.
> 
> I've continued my investigation first by trying to create another udev rule
> detecting the actual BCM4324(1) rev B5 Bluetooth chipset this time.
> 
> And I'm happy to share that it works finally!! as I have Bluetooth working
> at boot.
> 
> This is not over though as I've just discovered this via "man udev" :-(
> 
>   Starting daemons or other long-running processes is not appropriate
>   for udev; the forked processes, detached or not, will be
>   unconditionally *killed* after the event handling has finished.
> 
> and indeed btattach gets killed later on. For that part, I will continue my
> investigations off the list as I've found blogs / articles explaining
> several solutions and how to do it using systemd for instance.
> 
> Once I'm done, would you be interested to see such a rule integrated into
> the BlueZ project directly? Or do you consider this "last mile" integration
> work to be more the responsibility of the various Linux distributions?

we could add a --daemon mode into btattach that can be just started at boot and then monitors udev to auto-attach devices.

Regards

Marcel

