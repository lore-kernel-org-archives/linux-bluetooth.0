Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v4] Bluetooth: Defer connection-parameter removal when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413026054-5913-1-git-send-email-fons@spotify.com>
Date: Sat, 11 Oct 2014 13:53:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0025B704-1B18-4B1E-B27D-DF84AA2F9201@holtmann.org>
References: <1413026054-5913-1-git-send-email-fons@spotify.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> Systematically removing the LE connection parameters and autoconnect
> action is inconvenient for rebonding without disconnecting from
> userland (i.e. unpairing followed by repairing without
> disconnecting). The parameters will be lost after unparing and
> userland needs to take care of book-keeping them and re-adding them.
> 
> This patch allows userland to forget about parameter management when
> rebonding without disconnecting. It defers clearing the connection
> parameters when unparing without disconnecting, giving a chance of
> keeping the parameters if a repairing happens before the connection is
> closed.
> 
> Signed-off-by: Alfonso Acosta <fons@spotify.com>
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 07ddeed62..b8685a7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -555,6 +555,7 @@ enum {
> 	HCI_CONN_STK_ENCRYPT,
> 	HCI_CONN_AUTH_INITIATOR,
> 	HCI_CONN_DROP,
> +	HCI_CONN_PARAM_REMOVAL_PEND,
> };
> 
> static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b9517bd..11aac06 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -544,6 +544,9 @@ int hci_conn_del(struct hci_conn *conn)
> 
> 	hci_conn_del_sysfs(conn);
> 
> +	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
> +		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
> +
> 	hci_dev_put(hdev);
> 
> 	hci_conn_put(conn);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3fd88b0..2911a5e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2725,10 +2725,29 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 	}
> 
> 	if (cp->addr.type == BDADDR_BREDR) {
> +		if (cp->disconnect)
> +			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> +						       &cp->addr.bdaddr);
> +		else
> +			conn = NULL; /* Avoid disconnecting later on*/
> +

I do not think this is a comment style that is valid in the network subsystem coding style and even if it is valid, it would be pretty unusual.

Generally I would do comment on the whole code. So something like this:

	/* When disconnect of the the connection is requested,
	 * then look up the connection. If the remote device is
	 * connected, it will be later used to terminate the
	 * link.
	 * 
	 * Setting it to NULL explicitly will cause no
	 * termination of the link.
	 */
	if (cp->disconnect)
		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
					       &cp->addr.bdaddr);
	else
		conn = NULL;

> 		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
> 	} else {
> 		u8 addr_type;
> 
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> +					       &cp->addr.bdaddr);
> +		if (conn) {
> +			/* Defer clearing up the connection parameters
> +			 * until closing to give a chance of keeping
> +			 * them if a repairing happens.
> +			 */
> +			set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
> +
> +			if (!cp->disconnect)
> +				conn = NULL; /* Avoid disconnecting later on*/

And here I would do this:

		/* If disconnection is not requested, then clear the
		 * connection variable so that that the link is not
		 * terminated.
		 */
		if (!cp->disconnect)
			conn = NULL;


> +		}
> +
> 		if (cp->addr.type == BDADDR_LE_PUBLIC)
> 			addr_type = ADDR_LE_DEV_PUBLIC;
> 		else
> @@ -2736,8 +2755,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 
> 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
> 
> -		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
> -
> 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
> 	}
> 
> @@ -2747,17 +2764,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 		goto unlock;
> 	}
> 
> -	if (cp->disconnect) {
> -		if (cp->addr.type == BDADDR_BREDR)
> -			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> -						       &cp->addr.bdaddr);
> -		else
> -			conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> -						       &cp->addr.bdaddr);
> -	} else {
> -		conn = NULL;
> -	}
> -

And here I would just add a minor comment to remind us why this is correct:

	/* If the connection variable is set, then termination of the
	 * link is requested.
	 */

> 	if (!conn) {
> 		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
> 				   &rp, sizeof(rp));
> @@ -3062,6 +3068,11 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
> 	hci_conn_put(conn);
> 
> 	mgmt_pending_remove(cmd);
> +
> +	/* The device is paired so there is no need to remove
> +	 * its connection parameters anymore.
> +	 */
> +	clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
> }
> 
> void mgmt_smp_complete(struct hci_conn *conn, bool complete)

>From a logic point of view the patch looks good to me. This is just style changes to make it easier to remember why things are done. Johan might should have a second look at it before applying.

Regards

Marcel

