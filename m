Return-Path: <cyrus@holtmann.org>
Date: Sun, 23 Mar 2014 17:04:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Merge adv_ind/adv_direct_ind ans scan_rsp
 together
Message-ID: <20140323150405.GA20404@t440s.P-661HNU-F1>
References: <1395506915-23058-1-git-send-email-johan.hedberg@gmail.com>
 <1395506915-23058-3-git-send-email-johan.hedberg@gmail.com>
 <AFA78EB0-FC63-422A-9A62-69B2473DF163@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AFA78EB0-FC63-422A-9A62-69B2473DF163@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 22, 2014, Marcel Holtmann wrote:
> > 	case LE_SCAN_DISABLE:
> > +		if (hdev->pending_adv) {
> > +			struct hci_adv_ind *p = hdev->pending_adv;
> > +
> > +			if (!ADV_CACHE_EMPTY(p))
> > +				mgmt_device_found(hdev, &p->bdaddr, LE_LINK,
> > +						  p->bdaddr_type, NULL,
> > +						  p->rssi, 0, 1, p->data,
> > +						  p->len);
> > +
> > +			hdev->pending_adv = NULL;
> > +			kfree(p);
> > +		}
> > +
> 
> I wonder if this should not all be centralized in the discovery set_state function.

I'm fine with all your other suggestions (and have mostly completed
implementing them), but since DISCOVERY_STOPPED is set only at the end
of inquiry in the case of dual-mode discovery I think it's better to do
the sending of the pending device found event here when LE scanning stops.


Johan
