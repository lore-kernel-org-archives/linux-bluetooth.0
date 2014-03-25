Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Mar 2014 10:23:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Bluetooth: Merge ADV_IND/ADV_SCAN_IND and
 SCAN_RSP together
Message-ID: <20140325082321.GA5490@t440s.lan>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
 <1395650883-25577-4-git-send-email-johan.hedberg@gmail.com>
 <713211EC-11CA-424C-93FD-AEF338D4FFD9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <713211EC-11CA-424C-93FD-AEF338D4FFD9@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 24, 2014, Marcel Holtmann wrote:
> > @@ -3944,6 +3962,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> > static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> > 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> > {
> > +	struct discovery_state *d = &hdev->discovery;
> > +
> > 	/* Passive scanning shouldn't trigger any device found events */
> > 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> > 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> > @@ -3951,8 +3971,60 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> > 	    return;
> > 	}
> > 
> > -	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
> > -			  data, len, NULL, 0);
> > +	/* If there's nothing cached either cache the data from this
> > +	 * event or send an immediate device found event if the data is
> > +	 * not cachable.
> > +	 */
> 
> I would not use the word cache since it is not really a cache. It is
> just a pending report.
> 
> > +	if (ADV_CACHE_EMPTY(d)) {
> 
> Do we really need to check if the pending report is empty here. It
> will not match the bacmp() change anyway.

I agree with your other suggestions, but here I feel like the logic
stays more understandable with keeping this separate. E.g. one
difference between the two branches is the check for SCAN_RSP. It
prevents the code from trying to merge together two consecutive ADV_IND
from the same device. Furthermore, either way need to compare against
BDADDR_ANY first to know if a mismatch of bdaddrs means we should send
what's pending or not (if there's nothing pending).

I just have a hard time wrapping my head around a simpler solution
that's both understandable and correct. Feel free to suggest your own
solution, but this part of my patch will remain unchanged in the next
revision.

Johan
