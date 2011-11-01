Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 14:42:51 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] Bluetooth: prioritizing data over HCI
Message-ID: <20111101164251.GI2580@joana>
References: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
 <1320137942-25780-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320137942-25780-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-11-01 10:58:59 +0200]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This implement priority based scheduler using skbuffer priority set via
> SO_PRIORITY socket option.
> 
> It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
> each item in this list refer to a L2CAP connection and it is used to
> queue the data for transmission.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   42 ++++++++++
>  include/net/bluetooth/l2cap.h    |    1 +
>  net/bluetooth/hci_conn.c         |   59 ++++++++++++++
>  net/bluetooth/hci_core.c         |  159 ++++++++++++++++++++++++++++++++------
>  net/bluetooth/l2cap_core.c       |   18 ++++-
>  5 files changed, 252 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5d5fba9..1efad6b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -67,6 +67,12 @@ struct hci_conn_hash {
>  	unsigned int     le_num;
>  };
>  
> +struct hci_chan_hash {
> +	struct list_head list;
> +	spinlock_t       lock;
> +	unsigned int     num;
> +};
> +
>  struct bdaddr_list {
>  	struct list_head list;
>  	bdaddr_t bdaddr;
> @@ -287,6 +293,7 @@ struct hci_conn {
>  	unsigned int	sent;
>  
>  	struct sk_buff_head data_q;
> +	struct hci_chan_hash chan_hash;
>  
>  	struct timer_list disc_timer;
>  	struct timer_list idle_timer;
> @@ -309,6 +316,14 @@ struct hci_conn {
>  	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
>  };
>  
> +struct hci_chan {
> +	struct list_head list;
> +
> +	struct hci_conn *conn;
> +	struct sk_buff_head data_q;
> +	unsigned int	sent;
> +};
> +
>  extern struct hci_proto *hci_proto[];
>  extern struct list_head hci_dev_list;
>  extern struct list_head hci_cb_list;
> @@ -469,6 +484,28 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
>  	return NULL;
>  }
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
>  void hci_acl_connect(struct hci_conn *conn);
>  void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
>  void hci_add_sco(struct hci_conn *conn, __u16 handle);
> @@ -480,6 +517,10 @@ int hci_conn_del(struct hci_conn *conn);
>  void hci_conn_hash_flush(struct hci_dev *hdev);
>  void hci_conn_check_pending(struct hci_dev *hdev);
>  
> +struct hci_chan *hci_chan_create(struct hci_conn *conn);
> +int hci_chan_del(struct hci_chan *chan);
> +void hci_chan_hash_flush(struct hci_conn *conn);
> +
>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>  						__u8 sec_level, __u8 auth_type);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
> @@ -850,6 +891,7 @@ int hci_unregister_notifier(struct notifier_block *nb);
>  
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
>  void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
> +void hci_chan_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
>  
>  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index ed38c08..c7aa766 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -450,6 +450,7 @@ struct l2cap_ops {
>  
>  struct l2cap_conn {
>  	struct hci_conn	*hcon;
> +	struct hci_chan	*hchan;
>  
>  	bdaddr_t	*dst;
>  	bdaddr_t	*src;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 6e98ff3..fb66597 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -374,6 +374,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>  
>  	skb_queue_head_init(&conn->data_q);
>  
> +	hci_chan_hash_init(conn);
> +
>  	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
>  	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
>  	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
> @@ -432,6 +434,8 @@ int hci_conn_del(struct hci_conn *conn)
>  
>  	tasklet_disable(&hdev->tx_task);
>  
> +	hci_chan_hash_flush(conn);
> +
>  	hci_conn_hash_del(hdev, conn);
>  	if (hdev->notify)
>  		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> @@ -950,3 +954,58 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
>  
>  	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
>  }
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

Can't this be list_for_each_entry_safe()?

	Gustavo
