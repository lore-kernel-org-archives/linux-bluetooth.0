Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 3/7] Bluetooth: Remove hci_le_create_connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380668636-30654-4-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 2 Oct 2013 07:08:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BC0DAED8-9D11-49E7-86C9-DBD513FB2047@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org> <1380668636-30654-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Since we now use hci_initiate_le_connection() helper for creating new
> LE connections, we can safely remove hci_le_create_connection().
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 19 -------------------
> 1 file changed, 19 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 24d1a0a..b89522f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -49,25 +49,6 @@ static const struct sco_param sco_param_wideband[] = {
> 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
> };
> 
> -static void hci_le_create_connection(struct hci_conn *conn)
> -{
> -	struct hci_dev *hdev = conn->hdev;
> -	struct hci_cp_le_create_conn cp;
> -
> -	memset(&cp, 0, sizeof(cp));
> -	cp.scan_interval = __constant_cpu_to_le16(0x0060);
> -	cp.scan_window = __constant_cpu_to_le16(0x0030);
> -	bacpy(&cp.peer_addr, &conn->dst);
> -	cp.peer_addr_type = conn->dst_type;
> -	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> -	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> -	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> -	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> -	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> -
> -	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> -}
> -
> static void hci_le_create_connection_cancel(struct hci_conn *conn)
> {
> 	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);

I really start to dislike all the super long naming here. Existing one and new that you are defining.

Why not name the new handler hci_le_create_conn() instead of all this initiate_something and remove the existing function at the same time. I mean you can bisect the code, but it will throw a warning of an unused function.

Regards

Marcel

