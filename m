Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 13:20:51 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] Bluetooth: Fix sending unnecessary HCI_LE_Host_Enable
Message-ID: <20121025152051.GC1764@joana>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
 <1351112996-9597-4-git-send-email-johan.hedberg@gmail.com>
 <20121025150520.GA1764@joana>
 <1351177676.1785.94.camel@aeonflux>
 <20121025151430.GA6105@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121025151430.GA6105@x220>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-25 18:14:30 +0300]:

> Hi,
> 
> On Thu, Oct 25, 2012, Marcel Holtmann wrote:
> > > > From: Johan Hedberg <johan.hedberg@intel.com>
> > > > 
> > > > This patch fixes sending an unnecessary HCI_LE_Host_Enable command if
> > > > the command has already been sent as part of the default HCI init
> > > > sequence.
> > > > 
> > > > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > > > ---
> > > >  net/bluetooth/mgmt.c |   10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > > > index 02dc5f8..03dc176 100644
> > > > --- a/net/bluetooth/mgmt.c
> > > > +++ b/net/bluetooth/mgmt.c
> > > > @@ -2927,8 +2927,14 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
> > > >  			cp.le = 1;
> > > >  			cp.simul = !!lmp_le_br_capable(hdev);
> > > >  
> > > > -			hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
> > > > -				     sizeof(cp), &cp);
> > > > +			/* Check first if we already have the right
> > > > +			 * host state (host features set)
> > > > +			 */
> > > > +			if (cp.le != !!lmp_host_le_capable(hdev) ||
> > > > +			    cp.simul != !!lmp_host_le_br_capable(hdev))
> > > 
> > > Shouldn't the !! be part of the macro itself? Looks we will be using !! always
> > > with these macros.
> > 
> > we could do that actually. However I prefer to do that with a separate
> > patch.
> 
> I was thinking of the same earlier, and yes a separate patch to convert
> all of the feature test macros would be the cleanest.

I didn't say it needed to be in the same patch. Anyway, I applied this patch
now, I'll do the macro's conversion later today.

	Gustavo
