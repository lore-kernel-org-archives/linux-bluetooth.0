Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware
 download
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <768de172-bf01-e9ea-a4c9-ea8f46cf5f1d@mnementh.co.uk>
Date: Fri, 21 Jul 2017 08:40:00 +0200
Cc: maxin.john@gmail.com,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "Maxin B. John" <maxin.john@intel.com>
Message-Id: <C7827387-1AD3-41C9-9F1B-FF4A57940AB9@holtmann.org>
References: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
 <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
 <768de172-bf01-e9ea-a4c9-ea8f46cf5f1d@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

>> However I would prefer if we stop using hciattach and focus on hci_bcm.c support with btattach and serdev.
> 
> I can resubmit my serdev driver if you like? It needs a little cleanup
> but its been solid here over the last week or two. Mostly its missing
> some runtime PM support (I cant test that as my device is crippled and
> has no host-wakeup or device-suspend lines).

I am not going to assign a new N_HCI UART type to the same hardware. It all needs to go through the same type. So I still think for now it should be in the same hci_bcm.c file.

> I cant see a nice way to integrate it with the existing driver due to
> the fact that it differs markedly in the routines that need pointers to
> the serio structures.
> 
> The non-serio version uses a linked list that it traverses during
> startup to reconcile the port with the tty. Its a much uglier way to do
> it, but kinda by necessity.
> 
> Is there any particular issue with having both drivers in-tree?
> 
> A lot of legacy hardware will *never* use the serio method as it doesn't
> have the information available from firmware as to which serio device it
> should attach to. I guess some of the ACPI versions might be adaptable,
> but that would require some kind of ACPI->serio mapping that I'm not
> sure exists at present? ICBW though?

We want to actually turn all legacy N_HCI drivers into serdev drivers. So that the only think you write are serdev drivers. Rob is trying to work out how that can be done if you do not have DT as backing information. And more importantly do that through N_HCI where the TTY is initially exposed to user space.

So that is really the way to go here. Convert everything into serdev drivers. Have a look at his current work.

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=serdev-ldisc

Regards

Marcel

