Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Nov 2011 20:52:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: IO Capabilities, Secure Simple Pairing, and LE-SMP
Message-ID: <20111110185250.GA14797@fusion.localdomain>
References: <4EBBFE31.1060909@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EBBFE31.1060909@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, Nov 10, 2011, Brian Gix wrote:
> 1. Define separate LE and BR/EDR IO_Capabilities, and store them
> seperately in the hci_dev structure.  This would involve some
> further MGMT mods to specify BR vs LE io_caps, although the
> MGMT_OP_PAIR_DEVICE already includes an io_cap field that the user
> space could set on an explicit "Dedicated Bonding" initiation, it
> would not cover either "General Bonding", or remotely initiated
> bonding of any kind. Bluez would need to specify, and the kernel
> store, separate io_caps for each.
> 
> 2. Internally map the KeyboardDisplay io_cap inside the kernel to
> DisplayYesNo for BR/EDR purposes.  This would allow higher level
> user space (bluez) entities to use a single io_cap
> (KeyboardDisplay), and have it automatically "fallback" to
> DisplayYesNo, which can be looked at as a subset of KeyboardDisplay.
> 
> Again, this is important, because without KeyboardDisplay, we will
> lose the ability to do MITM protection for many LE devices which may
> require it, and I would like to know opinions before I go too far
> down a path which may get shot down here.
> 
> My personal option is #2, because it involves code changes in the
> fewest places.

Option 2 is what I had already assumed that we would do, so let's go
with that.

Johan
