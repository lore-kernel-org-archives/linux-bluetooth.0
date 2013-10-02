Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 13:46:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add a new mgmt_set_bredr command
Message-ID: <20131002104620.GC24910@x220.p-661hnu-f1>
References: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com>
 <1380705040-16300-3-git-send-email-johan.hedberg@gmail.com>
 <7A81AFB1-5441-4548-8A16-AF700AA63371@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7A81AFB1-5441-4548-8A16-AF700AA63371@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> > +static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> > +{
> > +	struct mgmt_mode *cp = data;
> > +	struct pending_cmd *cmd;
> > +	struct hci_request req;
> > +	u8 val, enabled;
> > +	int err;
> > +
> > +	BT_DBG("request for %s", hdev->name);
> > +
> > +	if (!lmp_bredr_capable(hdev) || !lmp_le_capable(hdev))
> > +		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
> > +				  MGMT_STATUS_REJECTED);
> 
> this should MGMT_STATUS_NOT_SUPPORTED to be in sync with how we do it
> for other commands.

Fixed in my latest set.

> > +	if (val == enabled) {
> > +		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
> > +		goto unlock;
> > +	}
> > +
> > +	if (!hdev_is_powered(hdev)) {
> > +		if (!val) {
> > +			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
> > +			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
> > +			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
> > +			clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
> > +			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
> > +			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
> > +		}
> > +
> > +		change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> > +
> > +		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
> > +		if (err < 0)
> > +			goto unlock;
> > +
> > +		err = new_settings(hdev, sk);
> > +		goto unlock;
> > +	}
> > +
> > +	/* Reject disabling when powered on */
> > +	if (!val) {
> > +		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
> > +				 MGMT_STATUS_REJECTED);
> > +		goto unlock;
> > +	}
> 
> I would have done this the other way around with the if clauses.
> 
> 	if (val) {
> 		…
> 	} else {
> 		if (hdev_is_powered())
> 			fail
> 
> 		…
> 	}
> 

I've left this as is since it actually produces simpler code imo. I
believe your suggestion was influenced by the set_hs code, however
that's a bit different since you don't need to send any HCI commands
there.

Johan
