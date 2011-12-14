Return-Path: <cyrus@holtmann.org>
Message-ID: <1323904340.1965.72.camel@aeonflux>
Subject: Re: [PATCH 5/7] Bluetooth: Add timer for automatically disabling
 the service cache
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Dec 2011 00:12:20 +0100
In-Reply-To: <20111214222537.GA14468@x220.Elisa>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-6-git-send-email-johan.hedberg@gmail.com>
	 <1323900964.1965.66.camel@aeonflux> <20111214222537.GA14468@x220.Elisa>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > -	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> > > +	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags)) {
> > > +		hci_dev_unlock_bh(hdev);
> > > +		cancel_delayed_work_sync(&hdev->service_cache);
> > > +		hci_dev_lock_bh(hdev);
> > >  		update_eir(hdev);
> > > +	}
> > 
> > We have to be a bit careful here since essentially the service cache
> > (actually UUID cache to be precise) is a per mgmt socket feature and not
> > a per hdev feature.
> > 
> > I have nothing against merging this first, but keep in mind that this
> > needs to be updated since we can have two concurrent applications
> > opening a mgmt socket.
> 
> I understand. It does get a bit tricky though since the UUID list is per
> HCI device. I.e. do we keep our own list for each socket and hide it
> from struct hci_dev until the (per-socket) cache gets disabled?

that might be a good idea. Every mgmt socket should keep its list of
added UUIDs and then maybe just call an update function that runs over
all mgmt sockets and picks the union of it. If a socket closes, the list
gets flushed and we update again. That way we do not have to play global
reference counting tricks.

Regards

Marcel


