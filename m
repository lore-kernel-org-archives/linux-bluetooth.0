Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412991237-20847-1-git-send-email-fons@spotify.com>
Date: Sat, 11 Oct 2014 10:32:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org>
References: <1412991237-20847-1-git-send-email-fons@spotify.com>
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
> index b9517bd..eb9988f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *work)
> 		conn->state = BT_CLOSED;
> 		break;
> 	}
> +
> +	if (test_and_clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
> +		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);

do we really need this one? The hci_conn_timeout should trigger when the connection establishment has a timeout and that is really non of the concerns here. And in case we hit an idle disconnect timeout, we are still ending up in hci_conn_del eventually, right? If not, I am having the slight feeling that you might have uncovered a bug that we should fix.

> }
> 
> /* Enter sniff mode */
> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
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
> index 3fd88b0..0af579d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2699,7 +2699,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct mgmt_rp_unpair_device rp;
> 	struct hci_cp_disconnect dc;
> 	struct pending_cmd *cmd;
> -	struct hci_conn *conn;
> +	struct hci_conn *uninitialized_var(conn);
> 	int err;
> 
> 	memset(&rp, 0, sizeof(rp));
> @@ -2736,7 +2736,17 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 
> 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
> 
> -		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> +					       &cp->addr.bdaddr);
> +
> +		/* If the BLE connection is being used, defer clearing up
> +		 * the connection parameters until closing to give a
> +		 * chance of keeping them if a repairing happens.
> +		 */
> +		if (conn && !cp->disconnect)
> +			set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
> +		else
> +			hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);

Coming to think about this a bit in detail, why are we making a difference on if we disconnect here or not. We could make the code a lot simpler. Just always set the PARAM_REMOVAL flag when unpairing and clear it when pairing. If we disconnect right away or not should not affect the usage of this flag.

As long as the connection is up, we can happily keep the flags around. Only when the connection goes away, we really need to ensure that we know if we want to remove them or not. Honestly, we should have done it that way in the first place and not spread hci_conn_params_del in different places. The central logic to delete or keep connection parameters should be run when hci_conn goes away.

> 
> 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
> 	}
> @@ -2748,12 +2758,12 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 	}
> 
> 	if (cp->disconnect) {
> +		/* Only lookup the connection in the BR/EDR since the
> +		 * LE connection was already looked up earlier.
> +		 */
> 		if (cp->addr.type == BDADDR_BREDR)
> 			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> 						       &cp->addr.bdaddr);
> -		else
> -			conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> -						       &cp->addr.bdaddr);
> 	} else {
> 		conn = NULL;
> 	}

I know that Johan told you to do it this way, but seeing the patch now makes me a bit uneasy. The usage of uninitilized_var in this case can lead to errors in the future. The logic that the compiler is wrong here is not obvious. Which means a week from now all of us have forgotten why we did it.

So here is what I would do to make this easier.

	if (cp->addr.type == BDADDR_BREDR) { 
		if (cp->disconnect) {
                        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
                                                       &cp->addr.bdaddr);
		else
			conn = NULL;

		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
	} else {
		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
                                               &cp->addr.bdaddr);
		if (conn) {
			set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);

			if (!cp->disconnect)
				conn = NULL;
		}

		...

		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);

		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
	}

Add some minor comments on why we set conn = NULL and this should be a simpler block. Mainly because the difference between BR/EDR and LE are contained in a single spot and not spread out over two places.

This already takes into account my comment from above to just set the PARAM_REMOVAL flag no matter if we actually be asked to disconnect or not.

> @@ -3062,6 +3072,11 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
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

Regards

Marcel

