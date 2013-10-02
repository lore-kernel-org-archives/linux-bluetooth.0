Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 4/7] Bluetooth: Remove hci_cs_le_create_conn event handler
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380668636-30654-5-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 2 Oct 2013 07:11:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3E999DA3-EE5E-41B3-8903-16C4A29FEB95@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org> <1380668636-30654-5-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch removes the hci_cs_le_create_conn event handler since this
> handling is now done in create_le_connection_complete() callback in
> hci_conn.c.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_event.c | 31 -------------------------------
> 1 file changed, 31 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d171c04b..1d1ffa6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1465,33 +1465,6 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
> 	hci_dev_unlock(hdev);
> }
> 
> -static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
> -{
> -	struct hci_conn *conn;
> -
> -	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> -
> -	if (status) {
> -		hci_dev_lock(hdev);
> -
> -		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> -		if (!conn) {
> -			hci_dev_unlock(hdev);
> -			return;
> -		}
> -
> -		BT_DBG("%s bdaddr %pMR conn %p", hdev->name, &conn->dst, conn);
> -
> -		conn->state = BT_CLOSED;
> -		mgmt_connect_failed(hdev, &conn->dst, conn->type,
> -				    conn->dst_type, status);
> -		hci_proto_connect_cfm(conn, status);
> -		hci_conn_del(conn);
> -
> -		hci_dev_unlock(hdev);
> -	}
> -}

this is dangerous since it actually breaks bisection. The code is never complete. So while this might turn into a larger patch, you might need to do it all 3 patches at once. With a length commit message explaining exactly what happens and why this is correct.

Regards

Marcel

