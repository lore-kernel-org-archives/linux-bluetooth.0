Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Marcel Holtmann <marcel@holtmann.org>
To: Ian Kumlien <pomac@vapor.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095877955.3211.18.camel@big>
References: <1095807044.3211.9.camel@big> <1095842833.5762.27.camel@pegasus>
	 <1095877600.3211.15.camel@big>  <1095877744.6223.88.camel@pegasus>
	 <1095877955.3211.18.camel@big>
Content-Type: text/plain
Message-Id: <1095878303.6223.93.camel@pegasus>
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
Date: Wed, 22 Sep 2004 20:38:24 +0200

Hi Ian,

> > this problem was reported two or three times, but I am unable to
> > reproduce it with my USB 2.0 host controllers.
> 
> ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> ohci_hcd 0000:00:02.1: irq 185, pci mem f8818000
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3

your IRQ looks very weird. I have never seen an IO-APIC system assigning
IRQ 185 to any device. Does any other USB device works in conjunction
with this controller?

> What controller do you use? and what usb1.1 driver?

I use a NEC controller with an OHCI for USB 1.1 stuff.

0000:02:0c.0 USB Controller: NEC Corporation USB (rev 43)
0000:02:0c.1 USB Controller: NEC Corporation USB (rev 43)
0000:02:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:02:0c.0: OHCI Host Controller
ohci_hcd 0000:02:0c.0: irq 20, pci mem e1352000
ohci_hcd 0000:02:0c.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:02:0c.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:02:0c.1: OHCI Host Controller
ohci_hcd 0000:02:0c.1: irq 21, pci mem e137a000
ohci_hcd 0000:02:0c.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:02:0c.2[C] -> GSI 22 (level, low) -> IRQ 22
ehci_hcd 0000:02:0c.2: EHCI Host Controller
ehci_hcd 0000:02:0c.2: irq 22, pci mem e137c000
ehci_hcd 0000:02:0c.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:02:0c.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected

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
