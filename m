Return-Path: <boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 19:22:50 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
 jason.abele@gmail.com
Subject: Re: [PATCH 0/4] Bluetooth: hci_uart: various fixes
Message-ID: <20160830192250.40eea3cf@bbrezillon>
In-Reply-To: <0649B498-A8BC-42D1-8F70-07B3C8CAB8E2@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
	<0649B498-A8BC-42D1-8F70-07B3C8CAB8E2@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, 30 Aug 2016 09:48:13 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Boris,
> 
> > We recently faced some problems when using an BT uart chip interfaced
> > through the H5 proto (rtk_h5). Here are the logs of the 2 different
> > issues we had when closing the line discipline (actually, restoring
> > the previous one) [1][2]. I know the kernel is Tainted in those logs,
> > but after some investigations I found a few potential issues that might
> > explain what we're seeing.  
> 
> while I can look through these patches, but I wonder when we are finally getting a full and proper RTK support that doesn't use these hackish hciattach code I have seen.
> 
> I mean the only thing userspace should be doing is attaching the line discipline and then everything else should run inside the kernel. Attaching the line discipline is the same as plugging in an USB dongle. Detaching it is the same as unplugging the dongle. That is how we should treat it. So for the lifetime of a system it should never detach. All the power control etc. should be done inside the kernel. Same as how we have done it for Broadcom and Intel devices.

Well, I'm completely new to the bluetooth stack, and while the
'hciattach/in-kernel driver' interaction does seem weird to me, I
definitely can't tell whether it's good or bad.

I just sent those patches because I was facing kernel panics.

Still, I don't get your argument about allowing a user to attach the
line discipline, but preventing him from detaching it. The races exist,
so even if you decide that the line discipline cannot be detached, how
do you plan to handle module unloading (maybe you don't want to allow
that either)?

One last comment. Even after applying those fixes I'm still facing
panics [1], so there are probably other racy portions in the code.

Anyway, tanks for your review.

Boris

[1]http://code.bulix.org/b5td9x-105502
