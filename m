Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 17:01:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages
 that need them
Message-ID: <20111108150139.GA13099@fusion.localdomain>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
 <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
 <4EB86A27.1030403@codeaurora.org>
 <20111108085256.GA9733@fusion.localdomain>
 <CAJdJm_NF07-4F+qkdLAbfG-sdXNRmXUY4Bhn9Bk0BrXy9jH3kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_NF07-4F+qkdLAbfG-sdXNRmXUY4Bhn9Bk0BrXy9jH3kw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Nov 08, 2011, Anderson Lizardo wrote:
> > The BREDR_LE option is there for the updated start_discovery command.
> > You'll be able to specify whether you want BR/EDR-only, LE-only or
> > interleaved discovery. I wouldn't add a completely new octet for public
> > vs random information though but reuse the existing one instead. To be
> > able to reuse our address type definitions for all purposes, how about
> > making each value orthogonal to the others, e.g.:
> >
> >        ADDR_BREDR      0x01
> >        ADDR_LE_PUBLIC  0x02
> >        ADDR_LE_RANDOM  0x04
> >
> > For events like connected, found, etc you'd only have one of the bits
> > set whereas for the start_discovery you could have any (but at least
> > one).
> 
> Johan: how would link_to_mgmt() in your code work in this case?

It'd need to get the LE public/random information somehow. E.g. struct
hci_conn will probably need to maintain this information. Another
question this also raises is do we do the conversion to MGMT_ADDR_*
inside or outside of mgmt.c.

> I see this will help simplifying how do we identify LE devices on
> BlueZ (currently it is done by parsing AD flags, but broken devices
> may lack the correct "BR/EDR not supported" flag, and thus we
> incorrectly identify then as BR/EDR). Unfortunately, it will still not
> allow us to correctly connect to LE devices without relying on the
> kernel's advertising cache.

Right. The only way to avoid that would be to add this information to
the L2CAP socket address (a decision which we intentionally pushed
further into the future by initially adopting the kernel-side cache).

Johan
