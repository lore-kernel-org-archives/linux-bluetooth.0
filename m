Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473283543.3400.48.camel@gmail.com>
Date: Wed, 7 Sep 2016 23:59:47 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <57368BCF-67A1-416C-A4DF-19289E7E06A8@holtmann.org>
References: <CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com> <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org> <1473283543.3400.48.camel@gmail.com>
To: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

>> So that means udev rules. [...] If you are unlucky you need a DT overlay
>> or hardcode it.
> 
> So I've followed your suggestion and I've created a udev rule (on a Debian
> system). Here is what it looks like for the moment, choosing first the
> simpler hardcoding option:
> 
> jdb@thinkpad8:~$ cat /etc/udev/rules.d/99-bluetooth-attach-broadcom.rules 
> SUBSYSTEM=="tty", KERNEL=="ttyS1", KERNELS=="80860F0A:00",
> RUN+="/usr/bin/btattach --bredr /dev/ttyS1 -P bcm"
> 
> Rebooting the tablet, good news, the rule seems to properly execute as I can
> find btattach in the list of running processes:
> 
> jdb@thinkpad8:~$ ps auxw | grep btattach
> root      1155  0.0  0.0   6372   728 ?        S    22:04   0:00
> /usr/bin/btattach --bredr /dev/ttyS1 -P bcm
> 
> and I can see the firmware loading happening quite early in the boot process
> 
> jdb@thinkpad8:~$ dmesg | grep "bluetooth.* firmware"
> [    5.528293] bluetooth hci0: firmware: direct-loading firmware
> brcm/BCM.hcd
> 
> However to my surprise Bluetooth is not enabled properly or at all, the
> Bluetooth panel in the Gnome settings remains grayed out and bluetoothctl
> doesn't detect a Controller. At some later points, I even see the btattach
> process disappear by itself.
> 
> That's just an uneducated assumption but it seems that somehow I am hitting
> a timing condition issue and maybe it ends up trying to attach too early
> (compared to what precisely? I have no idea). I'm saying this because if I
> launch the btattach command manually at any later timee, it works fine.
> 
> Do you have any guess of what could be the issue I'm hitting here? Any
> logs/commands in particular that would be useful?
> 
> 
>> Until then, you need an userspace part that triggers btattach with the
>> right hardware id on the right /dev/ttySx device node as soon as it
>> becomes available.
> 
> Maybe my mistake is that I've interpreted your sentence: "as soon as *it*
> becomes available" to assume that "it" was referring to the /dev/ttyS1
> device node. I'll try to see if I can create another udev rule that would
> trigger based on the actual BT chipset becoming available, and not based on
> /dev/ttyS1 , but I'm still looking for how to do it with dev.

maybe the RFKILL switch part gets discovered later than the TTY. I don't have a platform to verify, but just at few printk into the probe routine and see if its finds the according GPIOs for power control.

Regards

Marcel

