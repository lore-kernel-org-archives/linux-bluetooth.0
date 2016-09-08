Return-Path: <jerome.debretagne@gmail.com>
Message-ID: <1473372206.3263.39.camel@gmail.com>
Subject: Re: btattach: auto triggering at boot time by Linux distributions
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Date: Fri, 09 Sep 2016 00:03:26 +0200
In-Reply-To: <57368BCF-67A1-416C-A4DF-19289E7E06A8@holtmann.org>
References: 
	<CA+kEDGFm2jko+bC+DuPK1qQx5OXJZTXUj=aWdk+rm9RC8DDCOA@mail.gmail.com>
	 <72B34103-D15B-463B-B63B-8DD3CE99D712@holtmann.org>
	 <1473283543.3400.48.camel@gmail.com>
	 <57368BCF-67A1-416C-A4DF-19289E7E06A8@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, hi everyone,

> > > Until then, you need an userspace part that triggers btattach with the
> > > right hardware id on the right /dev/ttySx device node as soon as it
> > > becomes available.
> > 
> > Maybe my mistake is that I've interpreted your sentence: "as soon as
> > *it* becomes available" to assume that "it" was referring to the
> > /dev/ttyS1 device node. I'll try to see if I can create another udev
> > rule that would trigger based on the actual BT chipset becoming
> > available, and not based on /dev/ttyS1 , but I'm still looking for how
> > to do it with dev.
> 
> maybe the RFKILL switch part gets discovered later than the TTY. I don't
> have a platform to verify, but just at few printk into the probe routine
> and see if its finds the according GPIOs for power control.

I've continued my investigation first by trying to create another udev rule
detecting the actual BCM4324(1) rev B5 Bluetooth chipset this time.

And I'm happy to share that it works finally!! as I have Bluetooth working
at boot.

This is not over though as I've just discovered this via "man udev" :-(

  Starting daemons or other long-running processes is not appropriate
  for udev; the forked processes, detached or not, will be
  unconditionally *killed* after the event handling has finished.

and indeed btattach gets killed later on. For that part, I will continue my
investigations off the list as I've found blogs / articles explaining
several solutions and how to do it using systemd for instance.

Once I'm done, would you be interested to see such a rule integrated into
the BlueZ project directly? Or do you consider this "last mile" integration
work to be more the responsibility of the various Linux distributions?

Thanks again for all your help and your great work on the Bluetooth stack. 

Regards,
Jérôme


P.S. For a ThinkPad 8 tablet, a hardcoded version of the basic working rule
looks like this, in case that can be useful for someone else:

   $ cat /etc/udev/rules.d/98-bluetooth-attach-broadcom.rule
   KERNEL=="BCM2E55:00", RUN+="/usr/bin/btattach --bredr /dev/ttyS1 -P bcm"
