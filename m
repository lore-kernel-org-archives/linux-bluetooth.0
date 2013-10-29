Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 02/15] Bluetooth: Save connection interval parameters in hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-3-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 29 Oct 2013 23:55:07 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <42E05D26-ED0B-45CD-9443-86E0F315D40F@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-3-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch creates two new fields in struct hci_conn to save the
> minimum and maximum connection interval values used to establish
> the connection this object represents.
> 
> This change is required in order to know what parameters the
> connection is currently using.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 3 +++
> net/bluetooth/hci_conn.c         | 6 ++++--
> 2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 8c0ab3d..037a7b5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -341,6 +341,9 @@ struct hci_conn {
> 
> 	unsigned int	sent;
> 
> +	__u16		conn_interval_min;
> +	__u16		conn_interval_max;
> +

please move these somewhere between setting and flags. I hate the clutter in these structs.

And maybe prefix it with le_ and use le_conn_{min,max}_interval as we do in hdev.

> 	struct sk_buff_head data_q;
> 	struct list_head chan_list;
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ba5366c..9fb7b44 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -558,8 +558,8 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 	bacpy(&cp.peer_addr, &conn->dst);
> 	cp.peer_addr_type = conn->dst_type;
> 	cp.own_address_type = conn->src_type;
> -	cp.conn_interval_min = cpu_to_le16(hdev->le_conn_min_interval);
> -	cp.conn_interval_max = cpu_to_le16(hdev->le_conn_max_interval);
> +	cp.conn_interval_min = cpu_to_le16(conn->conn_interval_min);
> +	cp.conn_interval_max = cpu_to_le16(conn->conn_interval_max);
> 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> @@ -624,6 +624,8 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 	conn->sec_level = BT_SECURITY_LOW;
> 	conn->pending_sec_level = sec_level;
> 	conn->auth_type = auth_type;
> +	conn->conn_interval_min = hdev->le_conn_min_interval;
> +	conn->conn_interval_max = hdev->le_conn_max_interval;
> 

Regards

Marcel

