Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Nov 2011 17:15:10 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: Report LE devices
Message-ID: <20111123201510.GB7179@samus>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
 <1321051824-5216-6-git-send-email-andre.guedes@openbossa.org>
 <1321053293.15441.412.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321053293.15441.412.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08:14 Sat 12 Nov, Marcel Holtmann wrote:
> Hi Andre,
> 
> > Devices found during LE scan should be reported to userspace through
> > mgmt_device_found events.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> >  net/bluetooth/hci_event.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Now that the pair_device mgmt command requires address type information,
we need a way to get the address type information into userspace.

Applying this patch (and 4/6 of this same series) is the easiest way to
have that. We can use hcitool lescan to trigger an LE Scan and the kernel
will send mgmt device found events with address type information.

So, I suggest applying these two patches and solving the rest of the 
issues left in another series.

> 
> However keep in mind that we might have to filter these with the changes
> that Johan is doing with triggering scan for random vs public addresses.
> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
