Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jan 2014 10:29:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Bluetooth: Rename L2CAP_CHAN_CONN_FIX_A2MP to
 L2CAP_CHAN_FIXED_CID
Message-ID: <20140124082950.GA8546@x220.p-661hnu-f1>
References: <1390483368-21321-1-git-send-email-johan.hedberg@gmail.com>
 <9D839443-6517-49AA-81E4-F4D744F82635@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9D839443-6517-49AA-81E4-F4D744F82635@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 23, 2014, Marcel Holtmann wrote:
> > There's no reason why A2DP should need or deserve its on channel type.
> 
> I assume you mean A2MP here?
> 
> > Instead we should be able to group all fixed CID users under a single
> > channel type and reuse as much code as possible for them. Where CID
> > specific exceptions are needed the chan-scid value can be used.
> > 
> > This patch renames the current A2DP channel type to a generic one and
> 
> Same here.

Yep. Seems like typing A2DP is somehow hardwired into my brain after so
many years.

> > -#define L2CAP_CHAN_CONN_FIX_A2MP	4
> > +#define L2CAP_CHAN_FIXED_CID		4
> 
> You want to use FIXED_CID instead of just FIXED. I am fine with
> FIXED_CID, just double checking here.

I was thinking of it as "channel with a fixed CID", however now that I
re-read the Core Spec it talks about "Fixed Channels", so I'll change
this simply to CHAN_FIXED.

Johan
