Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Oct 2014 17:14:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when
 unpairing without disconnecting
Message-ID: <20141009141430.GA31807@t440s.P-661HNU-F1>
References: <1412859828-6224-1-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412859828-6224-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Thu, Oct 09, 2014, Alfonso Acosta wrote:
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -555,6 +555,7 @@ enum {
>  	HCI_CONN_STK_ENCRYPT,
>  	HCI_CONN_AUTH_INITIATOR,
>  	HCI_CONN_DROP,
> +	HCI_CONN_PARAM_REMOVAL_PEND,
>  };
>  
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b9517bd..d106f29 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *work)
>  		conn->state = BT_CLOSED;
>  		break;
>  	}
> +
> +	if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
> +		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>  }
>  
>  /* Enter sniff mode */
> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
>  
>  	hci_conn_del_sysfs(conn);
>  
> +	if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
> +		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);

I suppose the above two test_and_clear_bit() calls should be operating
on HCI_CONN_PARAM_REMOVAL_PEND and not HCI_CONN_MODE_CHANGE_PEND?

Johan


>  	hci_dev_put(hdev);
>  
>  	hci_conn_put(conn);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3fd88b0..0f2c0e9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2700,6 +2700,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>  	struct hci_cp_disconnect dc;
>  	struct pending_cmd *cmd;
>  	struct hci_conn *conn;
> +	struct hci_conn *le_conn = NULL;

I don't think you need to initialize this here since it's
unconditionally set in the first LE addr type branch and only touched
again in the second LE branch. Actually do you even need this second
variable if you simply assign to conn when you look up the LE
connection?

> @@ -2752,8 +2763,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>  			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>  						       &cp->addr.bdaddr);
>  		else
> -			conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> -						       &cp->addr.bdaddr);
> +			conn = le_conn;

Here you could then simply remove the "else" branch with a comment that
the conn is already looked up for LE addresses earlier in the function.
Not sure if that makes the code harder to follow though...

Johan
