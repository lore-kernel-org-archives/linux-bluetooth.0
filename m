Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Nov 2011 11:29:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Bluetooth: Add User Passkey entry to HCI Events
Message-ID: <20111112092926.GA6151@fusion.localdomain>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
 <1321057441-7921-4-git-send-email-bgix@codeaurora.org>
 <1321081199.15441.430.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321081199.15441.430.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Nov 12, 2011, Marcel Holtmann wrote:
> > +static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
> > +							struct sk_buff *skb)
> > +{
> > +	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
> > +
> > +	BT_DBG("%s", hdev->name);
> > +
> > +	hci_dev_lock(hdev);
> > +
> > +	/* Passkey Request is a degenerate case of User Confirm */
> > +	if (test_bit(HCI_MGMT, &hdev->flags))
> > +		mgmt_user_confirm_request(hdev, &ev->bdaddr, 0, 0);
> > +	else
> > +		hci_send_cmd(hdev, HCI_OP_USER_PASSKEY_NEG_REPLY,
> > +					sizeof(ev->bdaddr), &ev->bdaddr);
> 
> We might want a comment here that this needs fixing ;)

If HCI_MGMT isn't set this code should do nothing. In such a case it's
likely that hciops is running in user-space and will take care of this
request.

Johan
