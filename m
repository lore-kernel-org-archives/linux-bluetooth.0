Return-Path: <cyrus@holtmann.org>
Message-ID: <1325887078.6454.105.camel@aeonflux>
Subject: Re: [PATCH 1/9] Bluetooth: Fix persistency of the HCI_MGMT flag
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 06 Jan 2012 13:57:58 -0800
In-Reply-To: <20120106124223.GA12600@x220.Elisa>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-2-git-send-email-johan.hedberg@gmail.com>
	 <1325805036.6454.70.camel@aeonflux> <20120106124223.GA12600@x220.Elisa>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > The HCI_MGMT flag needs to remain set even after closing an HCI device.
> > > 
> > > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > > ---
> > >  net/bluetooth/hci_core.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 6d38d80..52edc11 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -670,8 +670,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> > >  	mgmt_powered(hdev, 0);
> > >  	hci_dev_unlock(hdev);
> > >  
> > > -	/* Clear flags */
> > > -	hdev->flags = 0;
> > > +	/* Clear flags, except persistent ones like HCI_MGMT */
> > > +	hdev->flags &= BIT(HCI_MGMT);
> > >  
> > >  	hci_req_unlock(hdev);
> > >  
> > 
> > can we just move this away from hdev->flags into a hdev->dev_flags.
> 
> Yes, that should be done (and not just for HCI_MGMT but also for other
> related flags) but it should imo be in a separate patch. Simply moving
> to dev_flags won't fix this particular bug since there's a similar
> "hdev->dev_flags = 0;" inside hci_cc_reset() in hci_event.c.

so I rather do the change to dev_flags first.

Regards

Marcel


