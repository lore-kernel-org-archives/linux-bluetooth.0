Return-Path: <johannes@erdfelt.com>
Date: Fri, 12 Sep 2003 18:32:51 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: jt@hpl.hp.com
Cc: Max Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [BUG] hci_usb + uhci vs. usb-uhci
Message-ID: <20030912183251.G18890@sventech.com>
References: <20030912215154.GB24895@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030912215154.GB24895@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Fri, Sep 12, 2003 at 02:51:54PM -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Sep 12, 2003, Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> 	I just spent some time tracking a problem with hci_usb (BlueZ
> USB driver) and uhci. This happens on 2 different PCs with different
> hardware and 2.4.X kernels, I describe one here.
> 
> UHCI Hardware :
> 	00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
> BlueTooth hardware :
> 	HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
> 	Manufacturer: Cambridge Silicon Radio (10)
> Kernel : 2.4.22 UP
> 
> 	What happens :
> 	Start BNEP session (i.e. TCP/IP over BT). Start intensive TCP
> app (web download, netperf, X-Window). After a few seconds, on the
> transmitter the hardware just stops :
> --------------------------------------------------------
> < ACL data: handle 0x0029 flags 0x01 dlen 192
> < ACL data: handle 0x0029 flags 0x01 dlen 192
> < ACL data: handle 0x0029 flags 0x01 dlen 192
> < ACL data: handle 0x0029 flags 0x01 dlen 192
> < ACL data: handle 0x0029 flags 0x01 dlen 192
> --------------------------------------------------------
> 	The "Number of Completed Packets" event never comes back. I
> have to physically unplug the USB dongle to recover. I could not see
> any error messages in the log, except after a few seconds some BNEP
> and ACL timeouts (which are expected).
> 
> 	I initially though that it was a BlueTooth problem. However,
> I've never seen it happening with my OHCI hardware on SMP (which is
> what I normally use). And, if I replace uhci.o with usb-uhci.o on the
> same hardware, the problem goes away completely.
> 	So, there is definitely something about uhci.o...

Did you enable zero packet when you compiled the BT driver?

JE
