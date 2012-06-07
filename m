Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 10:07:22 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Add support for encryption key refresh
Message-ID: <20120607070720.GC32366@aemeltch-MOBL1>
References: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
 <1339052318-11423-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339052318-11423-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jun 07, 2012 at 02:58:38PM +0800, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> With LE/SMP the completion of a security level elavation from medium to
> high is indicated by a HCI Encryption Key Refresh complete event. The
> necessary behavior upon receiving this event is a mix of what's done for
> auth_complete and encryption_change, which is also where most of the
> event handling code has been copied from.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

...

> +static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
> +					 struct sk_buff *skb)
> +{
> +	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
> +	struct hci_conn *conn;
> +
> +	BT_DBG("%s status %u handle %u", hdev->name, ev->status,
> +	       __le16_to_cpu(ev->handle));
> +
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
> +	if (!conn)
> +		goto unlock;
> +
> +	if (!ev->status)
> +		conn->sec_level = conn->pending_sec_level;
> +
> +	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
> +
> +	if (ev->status && conn->state == BT_CONNECTED) {
> +		hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
> +		hci_conn_put(conn);
> +		goto unlock;
> +	}
> +
> +	if (conn->state == BT_CONFIG) {
> +		if (!ev->status)
> +			conn->state = BT_CONNECTED;
> +
> +		hci_proto_connect_cfm(conn, ev->status);
> +		hci_conn_put(conn);
> +	} else {
> +		hci_auth_cfm(conn, ev->status);
> +
> +		hci_conn_hold(conn);

If you want to keep extra hold(conn) you may just not put. Is this typo?

> +		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> +		hci_conn_put(conn);
> +	}

Best regards 
Andrei Emeltchenko 

