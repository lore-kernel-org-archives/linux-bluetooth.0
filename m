Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Queue incoming ACL data until BT_CONNECTED state is reached
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389778231-20307-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 15 Jan 2014 22:17:04 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <BB667CD7-90B1-4D87-8647-F59CB35A258B@holtmann.org>
References: <1389778231-20307-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a queue for incoming L2CAP data that's received before
> l2cap_connect_cfm is called and processes the data once
> l2cap_connect_cfm is called. This way we ensure that we have e.g. all
> remote features before processing L2CAP signaling data (which is very
> important for making the correct security decisions).
> 
> The processing of the pending rx data needs to be done through
> queue_work since unlike l2cap_recv_acldata, l2cap_connect_cfm is called
> with the hci_dev lock held which could cause potential deadlocks.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This patch is e.g. needed for the "L2CAP BR/EDR Server - Security Block"
> l2cap-tester test case to pass reliably.
> 
> include/net/bluetooth/l2cap.h |  3 +++
> net/bluetooth/l2cap_core.c    | 33 +++++++++++++++++++++++++++++++++
> 2 files changed, 36 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index dbc4a89984ca..40e15cd948c1 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -623,6 +623,9 @@ struct l2cap_conn {
> 	__u32			rx_len;
> 	__u8			tx_ident;
> 
> +	struct sk_buff_head	pending_rx;
> +	struct work_struct	pending_rx_work;
> +
> 	__u8			disc_reason;
> 
> 	struct delayed_work	security_timer;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b0ad2c752d73..f2ee479a87a7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -63,6 +63,8 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
> static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> 		     struct sk_buff_head *skbs, u8 event);
> 
> +static void process_pending_rx(struct work_struct *work);
> +

do we really need this forward declaration?

> static inline __u8 bdaddr_type(struct hci_conn *hcon, __u8 type)
> {
> 	if (hcon->type == LE_LINK) {
> @@ -1546,6 +1548,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> 	}
> 
> 	mutex_unlock(&conn->chan_lock);
> +
> +	queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
> }
> 
> /* Notify sockets that we cannot guaranty reliability anymore */
> @@ -1671,6 +1675,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> 
> 	kfree_skb(conn->rx_skb);
> 
> +	skb_queue_purge(&conn->pending_rx);
> +	flush_work(&conn->pending_rx_work);
> +
> 	l2cap_unregister_all_users(conn);
> 
> 	mutex_lock(&conn->chan_lock);
> @@ -1773,6 +1780,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
> 	else
> 		INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
> 
> +	skb_queue_head_init(&conn->pending_rx);
> +	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
> +
> 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
> 
> 	return conn;
> @@ -7084,9 +7094,16 @@ drop:
> static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> {
> 	struct l2cap_hdr *lh = (void *) skb->data;
> +	struct hci_conn *hcon = conn->hcon;
> 	u16 cid, len;
> 	__le16 psm;
> 
> +	if (hcon->state != BT_CONNECTED) {
> +		BT_DBG("queueing pending rx skb");
> +		skb_queue_tail(&conn->pending_rx, skb);
> +		return;
> +	}
> +
> 	skb_pull(skb, L2CAP_HDR_SIZE);
> 	cid = __le16_to_cpu(lh->cid);
> 	len = __le16_to_cpu(lh->len);
> @@ -7132,6 +7149,22 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> 	}
> }
> 
> +static void process_pending_rx(struct work_struct *work)
> +{
> +	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> +					       pending_rx_work);
> +
> +	BT_DBG("");
> +
> +	while (!skb_queue_empty(&conn->pending_rx)) {
> +		struct sk_buff *skb;
> +
> +		skb = skb_dequeue(&conn->pending_rx);
> +
> +		l2cap_recv_frame(conn, skb);
> +	}
> +}
> +

I realize we have done this skb_queue_empty check and then skb_dequeue a bit, but that seems a little bit pointless.

skb_dequeue is taking a spinlock, but even then checking for empty first and then dequeuing it seems more complicated that needed here. We could just dequeue it check if skb == NULL.

	while (1) {
		struct sk_buff *skb;

		skb = sbk_dequeue(&conn->pending_rx);
		if (!skb)
			break;

		l2cap_recv_frame(conn, skb);
	}

And we have similar things in l2cap_streaming_send, l2cap_chan_send and l2cap_le_credits. I get the feeling we should change all of these.

Regards

Marcel

