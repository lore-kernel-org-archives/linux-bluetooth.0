Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jan 2015 11:15:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] Bluetooth: Handle command complete event for HCI
 Read Stored Link Keys
Message-ID: <20150112091553.GB20805@t440s.lan>
References: <1421012665-4842-2-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421012665-4842-2-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jan 11, 2015, Marcel Holtmann wrote:
> +static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
> +					struct sk_buff *skb)
> +{
> +	struct hci_rp_read_stored_link_key *rp = (void *)skb->data;
> +	struct hci_cp_read_stored_link_key *sent;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_STORED_LINK_KEY);
> +	if (!sent)
> +		return;
> +
> +	if (!rp->status && !bacmp(&sent->bdaddr, BDADDR_ANY)) {
> +		hdev->stored_max_keys = rp->max_keys;
> +		hdev->stored_num_keys = rp->num_keys;
> +	}

This probably works fine, but strictly speaking I think you should be
looking at the sent->read_all flag as that's the explicit indication
that the all keys had been requested. In theory the sent->bdaddr value
may be anything for read_all = 0x01 as the spec says that the bdaddr is
simply ignored then.

Johan
