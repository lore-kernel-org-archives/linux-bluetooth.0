Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 00:25:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] Bluetooth: Add timer for automatically disabling the
 service cache
Message-ID: <20111214222537.GA14468@x220.Elisa>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
 <1323899524-13653-6-git-send-email-johan.hedberg@gmail.com>
 <1323900964.1965.66.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323900964.1965.66.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 14, 2011, Marcel Holtmann wrote:
> > +static void service_cache_off(struct work_struct *work)
> > +{
> > +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> > +							service_cache.work);
> > +
> > +	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> > +		return;
> > +
> > +	hci_dev_lock_bh(hdev);
> > +
> > +	update_eir(hdev);
> > +	update_class(hdev);
> > +
> > +	hci_dev_unlock_bh(hdev);
> > +}
> > +
> > +static void mgmt_init_hdev(struct hci_dev *hdev)
> > +{
> > +	if (!test_and_set_bit(HCI_MGMT, &hdev->flags))
> > +		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
> 
> Why does this depend on MGMT being enabled? Why do we bother here? Why
> not just always initialize it when registering the controller.

Because the timer callback function is static and resides within mgmt.c
(since it needs to call update_class & update_eir which are also static
within mgmt.c).

> > -	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
> > +	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags)) {
> > +		hci_dev_unlock_bh(hdev);
> > +		cancel_delayed_work_sync(&hdev->service_cache);
> > +		hci_dev_lock_bh(hdev);
> >  		update_eir(hdev);
> > +	}
> 
> We have to be a bit careful here since essentially the service cache
> (actually UUID cache to be precise) is a per mgmt socket feature and not
> a per hdev feature.
> 
> I have nothing against merging this first, but keep in mind that this
> needs to be updated since we can have two concurrent applications
> opening a mgmt socket.

I understand. It does get a bit tricky though since the UUID list is per
HCI device. I.e. do we keep our own list for each socket and hide it
from struct hci_dev until the (per-socket) cache gets disabled?

Johan
