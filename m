Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:21:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/9] Bluetooth: Fix persistency of the HCI_MGMT flag
Message-ID: <20120108202144.GA16731@x220.P-661HNU-F1>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
 <1325776582-10314-2-git-send-email-johan.hedberg@gmail.com>
 <1325805036.6454.70.camel@aeonflux>
 <20120106124223.GA12600@x220.Elisa>
 <1325887078.6454.105.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325887078.6454.105.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 06, 2012, Marcel Holtmann wrote:
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index 6d38d80..52edc11 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -670,8 +670,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> > > >  	mgmt_powered(hdev, 0);
> > > >  	hci_dev_unlock(hdev);
> > > >  
> > > > -	/* Clear flags */
> > > > -	hdev->flags = 0;
> > > > +	/* Clear flags, except persistent ones like HCI_MGMT */
> > > > +	hdev->flags &= BIT(HCI_MGMT);
> > > >  
> > > >  	hci_req_unlock(hdev);
> > > >  
> > > 
> > > can we just move this away from hdev->flags into a hdev->dev_flags.
> > 
> > Yes, that should be done (and not just for HCI_MGMT but also for other
> > related flags) but it should imo be in a separate patch. Simply moving
> > to dev_flags won't fix this particular bug since there's a similar
> > "hdev->dev_flags = 0;" inside hci_cc_reset() in hci_event.c.
> 
> so I rather do the change to dev_flags first.

Alright, I'll do it that way around. Meanwhile I've applied the other
acked patches to my bluetooth-next tree.

Johan
