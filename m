Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [2.6.8 ->] Problems, hci_usb dosn't work.
From: Marcel Holtmann <marcel@holtmann.org>
To: Ian Kumlien <pomac@vapor.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095807044.3211.9.camel@big>
References: <1095807044.3211.9.camel@big>
Content-Type: text/plain
Message-Id: <1095842833.5762.27.camel@pegasus>
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
Date: Wed, 22 Sep 2004 10:47:13 +0200

Hi Ian,

> Since some kernel version i can't exactly remember which, i have been
> unable to use usb, i have tested with with 2.6.8 -> 2.6.9-rc2-bk7 and i
> also applied your patches for 2.6.8.
> 
> I have 2 usb dongles, one old that did work once, and one new that seems
> to be working like the older but it doesn't work with linux.
> 
> Both are based on the CSR chipset, here is the new ones entry from the
> hw support list:
> MSI MS-6967 CSR 1.1 hci_usb working Dave Beckett
> 
> Som logs from insertions:
> usb 1-3.4: new full speed USB device using address 12
> ehci_hcd 0000:00:02.2: qh f7e54780 (#0) state 1
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb d968cd74 err -28
> 
> usb 1-4.4: new full speed USB device using address 13
> ehci_hcd 0000:00:02.2: qh f7e54900 (#0) state 1
> hci_usb_intr_rx_submit: hci1 intr rx submit failed urb d315eef4 err -28
> 
> both of these are connected to usb 2.0 hubs (this machine does usb 2.0)

this looks like an USB problem to me. Try to connect it to USB 1.1 ports
and see if this works.

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
