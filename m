Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 16:52:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
Message-ID: <20120217145249.GA9776@x220>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
 <1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
 <20120216221213.GA3889@x220.ger.corp.intel.com>
 <CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
 <1329468528.28848.139.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329468528.28848.139.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 17, 2012, Marcel Holtmann wrote:
> > >> +int mgmt_interleaved_discovery(struct hci_dev *hdev)
> > >> +{
> > >> +     int err;
> > >> +
> > >> +     BT_DBG("%s", hdev->name);
> > >> +
> > >> +     err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
> > >> +     if (err < 0) {
> > >> +             hci_dev_lock(hdev);
> > >> +             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > >> +             hci_dev_unlock(hdev);
> > >> +     }
> > >> +
> > >> +     return err;
> > >> +}
> > >
> > > The locking doesn't look right to me above. hci_do_inquiry should be
> > > called with the lock held. I think it might be simpler if you make
> > > mgmt_interleaved_discovery() require the caller to hold the lock.
> > 
> > Yes, you're right. I just realized hci_do_inquiry now calls inquiry_
> > cache_flush which requires hdev->lock held. I'll fix this too. Thanks.
> 
> please keep the lock inside mgmt_interleaved_discovery() for now. We
> have enough locking crazy. I don't wanna add to it by making the caller
> deal with it right now.

The calling code looks like this:

+
+               if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
+                       mgmt_interleaved_discovery(hdev);
+               } else {
+                       hci_dev_lock(hdev);
+                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+                       hci_dev_unlock(hdev);
+               }

I was thinking that if mgmt_interleaved_discovery required the lock to
be held this code would become simpler:

	hci_dev_lock(hdev);

	if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED)
		mgmt_interleaved_discovery(hdev);
	else
		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);

        hci_dev_unlock(hdev);

Johan
