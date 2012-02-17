Return-Path: <cyrus@holtmann.org>
Message-ID: <1329494636.28848.176.camel@aeonflux>
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 17:03:56 +0100
In-Reply-To: <20120217145249.GA9776@x220>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	 <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
	 <20120216221213.GA3889@x220.ger.corp.intel.com>
	 <CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
	 <1329468528.28848.139.camel@aeonflux> <20120217145249.GA9776@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > >> +int mgmt_interleaved_discovery(struct hci_dev *hdev)
> > > >> +{
> > > >> +     int err;
> > > >> +
> > > >> +     BT_DBG("%s", hdev->name);
> > > >> +
> > > >> +     err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
> > > >> +     if (err < 0) {
> > > >> +             hci_dev_lock(hdev);
> > > >> +             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > > >> +             hci_dev_unlock(hdev);
> > > >> +     }
> > > >> +
> > > >> +     return err;
> > > >> +}
> > > >
> > > > The locking doesn't look right to me above. hci_do_inquiry should be
> > > > called with the lock held. I think it might be simpler if you make
> > > > mgmt_interleaved_discovery() require the caller to hold the lock.
> > > 
> > > Yes, you're right. I just realized hci_do_inquiry now calls inquiry_
> > > cache_flush which requires hdev->lock held. I'll fix this too. Thanks.
> > 
> > please keep the lock inside mgmt_interleaved_discovery() for now. We
> > have enough locking crazy. I don't wanna add to it by making the caller
> > deal with it right now.
> 
> The calling code looks like this:
> 
> +
> +               if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
> +                       mgmt_interleaved_discovery(hdev);
> +               } else {
> +                       hci_dev_lock(hdev);
> +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +                       hci_dev_unlock(hdev);
> +               }
> 
> I was thinking that if mgmt_interleaved_discovery required the lock to
> be held this code would become simpler:
> 
> 	hci_dev_lock(hdev);
> 
> 	if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED)
> 		mgmt_interleaved_discovery(hdev);
> 	else
> 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 
>         hci_dev_unlock(hdev);

this is ugly no matter what since we are intermixing things here.

However I think that hci_discovery_set_state() should better take the
look by itself or get a __ prefix for indicating it is unlocked.

Regards

Marcel


