Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Feb 2014 19:56:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Fix advertising address type when toggling
 connectable
Message-ID: <20140225175643.GA6452@localhost.P-661HNU-F1>
References: <1393349802-5831-1-git-send-email-johan.hedberg@gmail.com>
 <1700F292-DB01-4DA1-AF5D-445535741ACA@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1700F292-DB01-4DA1-AF5D-445535741ACA@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 25, 2014, Marcel Holtmann wrote:
> > -	if (hci_update_random_address(req, require_privacy, &own_addr_type) < 0)
> > +	/* If we're connectable set require_privacy to false as we
> > +	 * shouldn't use NRPAs in that case. If we're non-connectable
> > +	 * however we can allow NRPAs to be used.
> > +	 */
> > +	if (hci_update_random_address(req, !connectable, &own_addr_type) < 0)
> > 		return;
> 
> I really do not want to be pedantic, but this comment is misleading.
> It is a bit hard to understand. Also I am not sure if it NRPA or URPA.

It's "non-resolvable" according to the core specification.

> I think using an acronym here is confusing.
> 
> 	/* Set require_privacy to true only when non-connectable advertising
> 	 * is used. In that case it is fine to use an unresolvable private
> 	 * address.
> 	 */ 

v3 has been sent.

Johan
