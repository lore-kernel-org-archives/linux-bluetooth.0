Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2013 11:19:42 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix handling of unexpected SMP PDUs
Message-ID: <20130129171942.GA26108@x220>
References: <1359417846-5064-1-git-send-email-johan.hedberg@gmail.com>
 <1359442248.16748.40.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359442248.16748.40.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 29, 2013, Marcel Holtmann wrote:
> > The hdev->smp_chan pointer can be NULL if SMP PDUs arrive at unexpected
> > moments. To avoid NULL pointer dereferences the code should be checking
> > for this and simply ignore such PDUs. This patch fixes the issue by
> > adding the checks into each individual PDU handler. It's done there
> > instead of a global place since for some PDUs it *is* ok for smp_chan to
> > be NULL (e.g. pairing request and security request).
> 
> I am not sure we want to ignore such PDUs. Don't we have to respond with
> an error and actually disconnect at this point. Otherwise this might
> open up a denial of service attack.

I couldn't figure out any appropriate response since SMP doesn't really
have clear command-response pairs for everything. I've sent another
patch which still doesn't send a response but instead of just ignoring
the unexpected packet a disconnection is triggered.

Johan
