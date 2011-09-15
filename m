Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Sep 2011 16:34:47 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/5 v3] Bluetooth: prioritizing data over HCI
In-Reply-To: <1315846853-27442-4-git-send-email-luiz.dentz@gmail.com>
Message-ID: <alpine.DEB.2.02.1109151611190.28021@mathewm-linux>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com> <1315846853-27442-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Mon, 12 Sep 2011, Luiz Augusto von Dentz wrote:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This implement priority based scheduler using skbuffer priority set via
> SO_PRIORITY socket option.
>
> It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
> each item in this list refer to a L2CAP connection and it is used to
> queue the data for transmission.
>
> Each connection continue to have a queue but it is only used for time
> critical packets such the L2CAP commands and it is always processed
> before the channels thus it can be considered the highest priority.

For a given L2CAP channel, I think we want commands and data to use 
the same queue.

With AMP channel move signaling, it's important to maintain ordering 
between L2CAP commands and data.  This ensures that data gets flushed 
out of the queues and is not being sent during the channel move 
process and AMP link establishment.  You also want to make sure queued 
data is sent before a disconnect request.


>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |   42 ++++++++++
> include/net/bluetooth/l2cap.h    |    2 +
> net/bluetooth/hci_conn.c         |   59 ++++++++++++++
> net/bluetooth/hci_core.c         |  163 ++++++++++++++++++++++++++++++++------
> net/bluetooth/l2cap_core.c       |   21 ++++-
> 5 files changed, 258 insertions(+), 29 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0742828..e0d29eb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -67,6 +67,12 @@ struct hci_conn_hash {
> 	unsigned int     le_num;
> };
>
> +struct hci_chan_hash {
> +	struct list_head list;
> +	spinlock_t       lock;
> +	unsigned int     num;
> +};
> +
> struct bdaddr_list {
> 	struct list_head list;
> 	bdaddr_t bdaddr;
> @@ -278,6 +284,7 @@ struct hci_conn {
> 	unsigned int	sent;
>
> 	struct sk_buff_head data_q;
> +	struct hci_chan_hash chan_hash;
>
> 	struct timer_list disc_timer;
> 	struct timer_list idle_timer;
> @@ -300,6 +307,14 @@ struct hci_conn {
> 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
> };
>
> +struct hci_chan {
> +	struct list_head list;
> +
> +	struct hci_conn *conn;
> +	struct sk_buff_head data_q;
> +	unsigned int	sent;
> +};
> +
> extern struct hci_proto *hci_proto[];
> extern struct list_head hci_dev_list;
> extern struct list_head hci_cb_list;
> @@ -459,6 +474,28 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
> 	return NULL;
> }
>
> +static inline void hci_chan_hash_init(struct hci_conn *c)
> +{
> +	struct hci_chan_hash *h = &c->chan_hash;
> +	INIT_LIST_HEAD(&h->list);
> +	spin_lock_init(&h->lock);
> +	h->num = 0;
> +}
> +
> +static inline void hci_chan_hash_add(struct hci_conn *c, struct hci_chan *chan)
> +{
> +	struct hci_chan_hash *h = &c->chan_hash;
> +	list_add(&chan->list, &h->list);
> +	h->num++;
> +}
> +
> +static inline void hci_chan_hash_del(struct hci_conn *c, struct hci_chan *chan)
> +{
> +	struct hci_chan_hash *h = &c->chan_hash;
> +	list_del(&chan->list);
> +	h->num--;
> +}
> +
> void hci_acl_connect(struct hci_conn *conn);
> void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
> void hci_add_sco(struct hci_conn *conn, __u16 handle);
> @@ -470,6 +507,10 @@ int hci_conn_del(struct hci_conn *conn);
> void hci_conn_hash_flush(struct hci_dev *hdev);
> void hci_conn_check_pending(struct hci_dev *hdev);
>
> +struct hci_chan *hci_chan_create(struct hci_conn *conn);
> +int hci_chan_del(struct hci_chan *chan);
> +void hci_chan_hash_flush(struct hci_conn *conn);
> +
> struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 						__u8 sec_level, __u8 auth_type);
> int hci_conn_check_link_mode(struct hci_conn *conn);
> @@ -839,6 +880,7 @@ int hci_unregister_notifier(struct notifier_block *nb);
>
> int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
> void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
> +void hci_chan_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
>
> void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index f018e5d..0899f96 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -301,6 +301,7 @@ struct srej_list {
> struct l2cap_chan {
> 	struct sock *sk;
>
> +	struct hci_chan		*hchan;
> 	struct l2cap_conn	*conn;
>
> 	__u8		state;
> @@ -388,6 +389,7 @@ struct l2cap_ops {
>
> struct l2cap_conn {
> 	struct hci_conn	*hcon;
> +	struct hci_chan	*hchan;
>
> 	bdaddr_t	*dst;
> 	bdaddr_t	*src;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 581cc42..1dc8c38 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -374,6 +374,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>
> 	skb_queue_head_init(&conn->data_q);
>
> +	hci_chan_hash_init(conn);
> +
> 	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
> 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
> 	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
> @@ -432,6 +434,8 @@ int hci_conn_del(struct hci_conn *conn)
>
> 	tasklet_disable(&hdev->tx_task);
>
> +	hci_chan_hash_flush(conn);
> +
> 	hci_conn_hash_del(hdev, conn);
> 	if (hdev->notify)
> 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> @@ -950,3 +954,58 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
>
> 	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
> }
> +
> +struct hci_chan *hci_chan_create(struct hci_conn *conn)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +	struct hci_chan *chan;
> +
> +	BT_DBG("%s conn %p", hdev->name, conn);
> +
> +	chan = kzalloc(sizeof(struct hci_chan), GFP_ATOMIC);
> +	if (!chan)
> +		return NULL;
> +
> +	chan->conn = conn;
> +	skb_queue_head_init(&chan->data_q);
> +
> +	tasklet_disable(&hdev->tx_task);
> +	hci_chan_hash_add(conn, chan);
> +	tasklet_enable(&hdev->tx_task);
> +
> +	return chan;
> +}
> +
> +int hci_chan_del(struct hci_chan *chan)
> +{
> +	struct hci_conn *conn = chan->conn;
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	BT_DBG("%s conn %p chan %p", hdev->name, conn, chan);
> +
> +	tasklet_disable(&hdev->tx_task);
> +	hci_chan_hash_del(conn, chan);
> +	tasklet_enable(&hdev->tx_task);
> +
> +	skb_queue_purge(&chan->data_q);
> +	kfree(chan);
> +
> +	return 0;
> +}
> +
> +void hci_chan_hash_flush(struct hci_conn *conn)
> +{
> +	struct hci_chan_hash *h = &conn->chan_hash;
> +	struct list_head *p;
> +
> +	BT_DBG("conn %p", conn);
> +	p = h->list.next;
> +	while (p != &h->list) {
> +		struct hci_chan *chan;
> +
> +		chan = list_entry(p, struct hci_chan, list);
> +		p = p->next;
> +
> +		hci_chan_del(chan);
> +	}
> +}
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 94e916d..821b69b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1958,23 +1958,18 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
> 	hdr->dlen   = cpu_to_le16(len);
> }
>
> -void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
> +static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
> +				struct sk_buff *skb, __u16 flags)
> {
> 	struct hci_dev *hdev = conn->hdev;
> 	struct sk_buff *list;
>
> -	BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
> -
> -	skb->dev = (void *) hdev;
> -	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
> -	hci_add_acl_hdr(skb, conn->handle, flags);
> -
> 	list = skb_shinfo(skb)->frag_list;
> 	if (!list) {
> 		/* Non fragmented */
> 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
>
> -		skb_queue_tail(&conn->data_q, skb);
> +		skb_queue_tail(queue, skb);
> 	} else {
> 		/* Fragmented */
> 		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
> @@ -1982,9 +1977,9 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
> 		skb_shinfo(skb)->frag_list = NULL;
>
> 		/* Queue all fragments atomically */
> -		spin_lock_bh(&conn->data_q.lock);
> +		spin_lock_bh(&queue->lock);
>
> -		__skb_queue_tail(&conn->data_q, skb);
> +		__skb_queue_tail(queue, skb);
>
> 		flags &= ~ACL_START;
> 		flags |= ACL_CONT;
> @@ -1997,16 +1992,46 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>
> 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
>
> -			__skb_queue_tail(&conn->data_q, skb);
> +			__skb_queue_tail(queue, skb);
> 		} while (list);
>
> -		spin_unlock_bh(&conn->data_q.lock);
> +		spin_unlock_bh(&queue->lock);
> 	}
> +}
> +
> +void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
> +
> +	skb->dev = (void *) hdev;
> +	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
> +	hci_add_acl_hdr(skb, conn->handle, flags);
> +
> +	hci_queue_acl(conn, &conn->data_q, skb, flags);
>
> 	tasklet_schedule(&hdev->tx_task);
> }
> EXPORT_SYMBOL(hci_send_acl);
>
> +void hci_chan_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
> +{
> +	struct hci_conn *conn = chan->conn;
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	BT_DBG("%s chan %p flags 0x%x", hdev->name, chan, flags);
> +
> +	skb->dev = (void *) hdev;
> +	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
> +	hci_add_acl_hdr(skb, conn->handle, flags);
> +
> +	hci_queue_acl(conn, &chan->data_q, skb, flags);
> +
> +	tasklet_schedule(&hdev->tx_task);
> +}
> +EXPORT_SYMBOL(hci_chan_send_acl);
> +
> /* Send SCO data */
> void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
> {
> @@ -2104,11 +2129,90 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
> 	}
> }
>
> -static inline void hci_sched_acl(struct hci_dev *hdev)
> +static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
> +						int *quote)
> {
> +	struct hci_conn_hash *h = &hdev->conn_hash;
> +	struct hci_chan *chan = NULL;
> +	int num = 0, min = ~0, cur_prio = 0;
> 	struct hci_conn *conn;
> +	int cnt, q, conn_num = 0;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	list_for_each_entry(conn, &h->list, list) {
> +		struct hci_chan_hash *ch;
> +		struct hci_chan *tmp;
> +
> +		if (conn->type != type)
> +			continue;
> +
> +		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
> +			continue;
> +
> +		conn_num++;
> +
> +		ch = &conn->chan_hash;
> +
> +		list_for_each_entry(tmp, &ch->list, list) {
> +			struct sk_buff *skb;
> +
> +			if (skb_queue_empty(&tmp->data_q))
> +				continue;
> +
> +			skb = skb_peek(&tmp->data_q);
> +			if (skb->priority < cur_prio)
> +				continue;
> +
> +			if (skb->priority > cur_prio) {
> +				num = 0;
> +				min = ~0;
> +				cur_prio = skb->priority;
> +			}
> +
> +			num++;
> +
> +			if (conn->sent < min) {
> +				min  = conn->sent;
> +				chan = tmp;
> +			}
> +		}
> +
> +		if (hci_conn_num(hdev, type) == conn_num)
> +			break;
> +	}


Only the priority of the first skb in each queue is considered.  What 
if there's a higher priority skb deeper in a queue?

Would it work to track priority in hci_chan instead of the skb?  That 
would simplify patch 1 of this series.


> +
> +	if (!chan)
> +		return NULL;
> +
> +	switch (chan->conn->type) {
> +	case ACL_LINK:
> +		cnt = hdev->acl_cnt;
> +		break;
> +	case SCO_LINK:
> +	case ESCO_LINK:
> +		cnt = hdev->sco_cnt;
> +		break;
> +	case LE_LINK:
> +		cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
> +		break;
> +	default:
> +		cnt = 0;
> +		BT_ERR("Unknown link type");
> +	}
> +
> +	q = cnt / num;
> +	*quote = q ? q : 1;
> +	BT_DBG("chan %p quote %d", chan, *quote);
> +	return chan;
> +}
> +
> +static inline void hci_sched_acl(struct hci_dev *hdev)
> +{
> +	struct hci_chan *chan;
> 	struct sk_buff *skb;
> 	int quote;
> +	unsigned int cnt;
>
> 	BT_DBG("%s", hdev->name);
>
> @@ -2122,17 +2226,23 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
> 			hci_link_tx_to(hdev, ACL_LINK);
> 	}
>
> -	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
> -		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> -			BT_DBG("skb %p len %d", skb, skb->len);
> +	cnt = hdev->acl_cnt;
>
> -			hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
> +	while (hdev->acl_cnt &&
> +			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
> +		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
> +			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
> +					skb->len, skb->priority);
> +
> +			hci_conn_enter_active_mode(chan->conn,
> +						bt_cb(skb)->force_active);


Where are conn->data_q skbs dequeued now?


>
> 			hci_send_frame(skb);
> 			hdev->acl_last_tx = jiffies;
>
> 			hdev->acl_cnt--;
> -			conn->sent++;
> +			chan->sent++;
> +			chan->conn->sent++;
> 		}
> 	}
> }
> @@ -2151,7 +2261,7 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
>
> 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
> 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> -			BT_DBG("skb %p len %d", skb, skb->len);
> +			BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
> 			hci_send_frame(skb);
>
> 			conn->sent++;
> @@ -2174,7 +2284,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
>
> 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
> 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> -			BT_DBG("skb %p len %d", skb, skb->len);
> +			BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
> 			hci_send_frame(skb);
>
> 			conn->sent++;
> @@ -2186,7 +2296,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
>
> static inline void hci_sched_le(struct hci_dev *hdev)
> {
> -	struct hci_conn *conn;
> +	struct hci_chan *chan;
> 	struct sk_buff *skb;
> 	int quote, cnt;
>
> @@ -2204,17 +2314,20 @@ static inline void hci_sched_le(struct hci_dev *hdev)
> 	}
>
> 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
> -	while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
> -		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> -			BT_DBG("skb %p len %d", skb, skb->len);
> +	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
> +		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
> +			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
> +					skb->len, skb->priority);
>
> 			hci_send_frame(skb);
> 			hdev->le_last_tx = jiffies;
>
> 			cnt--;
> -			conn->sent++;
> +			chan->sent++;
> +			chan->conn->sent++;
> 		}
> 	}
> +
> 	if (hdev->le_pkts)
> 		hdev->le_cnt = cnt;
> 	else
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index afd5455..28994b7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -313,6 +313,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> 	conn->disc_reason = 0x13;
>
> 	chan->conn = conn;
> +	chan->hchan = hci_chan_create(conn->hcon);
>
> 	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
> 		if (conn->hcon->type == LE_LINK) {
> @@ -357,6 +358,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> 	if (conn) {
> 		/* Delete from channel list */
> 		write_lock_bh(&conn->chan_lock);
> +		hci_chan_del(chan->hchan);
> +		chan->hchan = NULL;
> 		list_del(&chan->list);
> 		write_unlock_bh(&conn->chan_lock);
> 		chan_put(chan);
> @@ -558,7 +561,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
> 	bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
> 	skb->priority = HCI_PRIO_MAX;
>
> -	hci_send_acl(conn->hcon, skb, flags);
> +	hci_chan_send_acl(conn->hchan, skb, flags);
> }
>
> static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
> @@ -984,6 +987,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
> 		chan->ops->close(chan->data);
> 	}
>
> +	hci_chan_del(conn->hchan);
> +
> 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> 		del_timer_sync(&conn->info_timer);
>
> @@ -1004,18 +1009,26 @@ static void security_timeout(unsigned long arg)
> static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
> {
> 	struct l2cap_conn *conn = hcon->l2cap_data;
> +	struct hci_chan *hchan;
>
> 	if (conn || status)
> 		return conn;
>
> +	hchan = hci_chan_create(hcon);
> +	if (!hchan)
> +		return NULL;
> +
> 	conn = kzalloc(sizeof(struct l2cap_conn), GFP_ATOMIC);
> -	if (!conn)
> +	if (!conn) {
> +		hci_chan_del(hchan);
> 		return NULL;
> +	}
>
> 	hcon->l2cap_data = conn;
> 	conn->hcon = hcon;
> +	conn->hchan = hchan;
>
> -	BT_DBG("hcon %p conn %p", hcon, conn);
> +	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
>
> 	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
> 		conn->mtu = hcon->hdev->le_mtu;
> @@ -1255,7 +1268,7 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
> 		flags = ACL_START;
>
> 	bt_cb(skb)->force_active = chan->force_active;
> -	hci_send_acl(hcon, skb, flags);
> +	hci_chan_send_acl(chan->hchan, skb, flags);
> }
>
> void l2cap_streaming_send(struct l2cap_chan *chan)
> -- 
> 1.7.6.1


Thanks for looking at improving the HCI scheduler.  Will you be at the 
Bluetooth summit in Prague?  That might be a good chance to talk about 
overall changes to the HCI layer.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


