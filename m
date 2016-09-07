Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1473283543.3400.48.camel@gmail.com>
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Date: Wed, 07 Sep 2016 23:25:43 +0200
In-Reply-To: <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
References: 
	<CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
	 <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> So that means udev rules. [...] If you are unlucky you need a DT overlay
> or hardcode it.

So I've followed your suggestion and I've created a udev rule (on a Debian
system). Here is what it looks like for the moment, choosing first the
simpler hardcoding option:

jdb@thinkpad8:~$ cat /etc/udev/rules.d/99-bluetooth-attach-broadcom.rules 
SUBSYSTEM=="tty", KERNEL=="ttyS1", KERNELS=="80860F0A:00",
RUN+="/usr/bin/btattach --bredr /dev/ttyS1 -P bcm"

Rebooting the tablet, good news, the rule seems to properly execute as I can
find btattach in the list of running processes:

jdb@thinkpad8:~$ ps auxw | grep btattach
root      1155  0.0  0.0   6372   728 ?        S    22:04   0:00
/usr/bin/btattach --bredr /dev/ttyS1 -P bcm

and I can see the firmware loading happening quite early in the boot process

jdb@thinkpad8:~$ dmesg | grep "bluetooth.* firmware"
[    5.528293] bluetooth hci0: firmware: direct-loading firmware
brcm/BCM.hcd

However to my surprise Bluetooth is not enabled properly or at all, the
Bluetooth panel in the Gnome settings remains grayed out and bluetoothctl
doesn't detect a Controller. At some later points, I even see the btattach
process disappear by itself.

That's just an uneducated assumption but it seems that somehow I am hitting
a timing condition issue and maybe it ends up trying to attach too early
(compared to what precisely? I have no idea). I'm saying this because if I
launch the btattach command manually at any later timee, it works fine.

Do you have any guess of what could be the issue I'm hitting here? Any
logs/commands in particular that would be useful?


> Until then, you need an userspace part that triggers btattach with the
> right hardware id on the right /dev/ttySx device node as soon as it
> becomes available.

Maybe my mistake is that I've interpreted your sentence: "as soon as *it*
becomes available" to assume that "it" was referring to the /dev/ttyS1
device node. I'll try to see if I can create another udev rule that would
trigger based on the actual BT chipset becoming available, and not based on
/dev/ttyS1 , but I'm still looking for how to do it with udev.

Regards,

Jérôme


P.S. Here is the output of the udevadm command I've used to help me create
the ttyS1-based rule in the first place:

jdb@thinkpad8:~$ udevadm info -a -n /dev/ttyS1

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/platform/80860F0A:00/tty/ttyS1':
    KERNEL=="ttyS1"
    SUBSYSTEM=="tty"
    DRIVER==""

  looking at parent device '/devices/platform/80860F0A:00':
    KERNELS=="80860F0A:00"
    SUBSYSTEMS=="platform"
    DRIVERS=="dw-apb-uart"
    ATTRS{driver_override}=="(null)"

  looking at parent device '/devices/platform':
    KERNELS=="platform"
    SUBSYSTEMS==""
    DRIVERS==""
