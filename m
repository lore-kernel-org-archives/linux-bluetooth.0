Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: RE: [PATCH] bluetooth: opcode field of sent commands is little endian.
Date: Mon, 25 Jun 2012 10:20:25 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F62@saturn3.aculab.com>
In-Reply-To: <1340609570.5461.50.camel@thor.local>
From: "David Laight" <David.Laight@ACULAB.COM>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
	"Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>,
	"Johan Hedberg" <johan.hedberg@intel.com>,
	<linuxppc-dev@ozlabs.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 
> > > Fine with me, though FWIW that not only doesn't use
> > > __constant_cpu_to_le16() but actually swaps the non-constant value.
> > 
> > Don't see what point you are trying to make here. Swapping the value
> > from the actual command structure is always fine with me.
> 
> The point is that the result of swapping a constant value is just
> another constant value, whereas the fix in mainline swaps a value from
> memory. Not a big deal.

Surely, but surely, the definition of cpu_to_le16() uses
gcc 'magic' to determine that the argument is a constant
and then automatically selects the 'constant' form.

	David


