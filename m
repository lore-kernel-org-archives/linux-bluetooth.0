Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Marcel Holtmann <marcel@holtmann.org>
To: Ian Kumlien <pomac@vapor.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095878969.3211.23.camel@big>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>  <1095878303.6223.93.camel@pegasus>
	 <1095878969.3211.23.camel@big>
Content-Type: text/plain
Message-Id: <1095879167.6223.104.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 20:52:47 +0200

Hi Ian,

> > > ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> > > ohci_hcd 0000:00:02.1: irq 185, pci mem f8818000
> > > ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
> > 
> > your IRQ looks very weird. I have never seen an IO-APIC system assigning
> > IRQ 185 to any device. Does any other USB device works in conjunction
> > with this controller?
> 
> 2 joysticks, one 6in1 card reader and one muvodrive, it all works.
> And, it registers the device correctly it just can't read from it.

are these devices all USB 2.0 capable? If yes, then they are handled by
the ehci_hcd host controller driver.

> And yeah i know, it's part of the nvidia workaround:
> cat /proc/interrupts
>            CPU0
>   0:   91522201          XT-PIC  timer
>   1:      17141    IO-APIC-edge  i8042
>   8:          4    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:     341508    IO-APIC-edge  ide0
>  15:    1917703    IO-APIC-edge  ide1
> 177:          0   IO-APIC-level  ohci_hcd
> 185:          0   IO-APIC-level  ohci_hcd
> 193:     347701   IO-APIC-level  ehci_hcd
> 201:    4266340   IO-APIC-level  EMU10K1
> 209:    3869397   IO-APIC-level  eth0
> 217:   11455874   IO-APIC-level  nvidia
> NMI:       8253
> LOC:   91523920
> ERR:          0
> MIS:          0
> 
> hurrm ohci_hcd should have data... hurrrm, it might be LKML related
> after all.. =P
> (I might have left the experimental 'ohci' support in ehci on in this
> kernel.)

Check that first and then report it to the Linux USB mailing list. It is
more an USB issue then LKML related.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
