Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110824200446.GD2662@joana>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
	<1313587384-2653-5-git-send-email-luiz.dentz@gmail.com>
	<20110824200446.GD2662@joana>
Date: Thu, 25 Aug 2011 00:53:04 +0300
Message-ID: <CABBYNZJB8sOawyqJM-p3yyhRKQBq46Q2qm3V0Jio4FwFm-OWVA@mail.gmail.com>
Subject: Re: [RFC 4/5 v2] Bluetooth: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 24, 2011 at 11:04 PM, Gustavo Padovan
<padovan@profusion.mobi> wrote:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-17 16:23:03 +0300]:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This implement priority based scheduler using skbuffer priority set via
>> SO_PRIORITY socket option.
>>
>> It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
>> each item in this list refer to a L2CAP connection and it is used to
>> queue the data for transmission.
>>
>> Each connection continue to have a queue but it is only used for time
>> critical packets such the L2CAP commands and it is always processed
>> before the channels thus it can be considered the highest priority.
>
> I think we can drop the connection and queue create a channel by default for
> the special L2CAP channels, BR/EDR and LE signalling, SMP and AMP Manager.
> Those will have high priority of course. Standardize this in just one way to
> send packets would be better. It simplifies the sending logic and reduces the
> code.

Sure, but then we need something to identify this special hci_chan and
it needs to be added to the list to be processed together, not sure if
it will simplify that much in the end.

>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>>  include/net/bluetooth/hci_core.h |   42 +++++++++
>>  include/net/bluetooth/l2cap.h    |    1 +
>>  net/bluetooth/hci_conn.c         |   59 ++++++++++++
>>  net/bluetooth/hci_core.c         |  180 ++++++++++++++++++++++++++++++++++----
>>  net/bluetooth/l2cap_core.c       |    5 +-
>>  5 files changed, 269 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 0742828..e0d29eb 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -67,6 +67,12 @@ struct hci_conn_hash {
>>       unsigned int     le_num;
>>  };
>>
>> +struct hci_chan_hash {
>> +     struct list_head list;
>> +     spinlock_t       lock;
>> +     unsigned int     num;
>> +};
>> +
>>  struct bdaddr_list {
>>       struct list_head list;
>>       bdaddr_t bdaddr;
>> @@ -278,6 +284,7 @@ struct hci_conn {
>>       unsigned int    sent;
>>
>>       struct sk_buff_head data_q;
>> +     struct hci_chan_hash chan_hash;
>>
>>       struct timer_list disc_timer;
>>       struct timer_list idle_timer;
>> @@ -300,6 +307,14 @@ struct hci_conn {
>>       void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
>>  };
>>
>> +struct hci_chan {
>> +     struct list_head list;
>> +
>> +     struct hci_conn *conn;
>> +     struct sk_buff_head data_q;
>> +     unsigned int    sent;
>> +};
>> +
>>  extern struct hci_proto *hci_proto[];
>>  extern struct list_head hci_dev_list;
>>  extern struct list_head hci_cb_list;
>> @@ -459,6 +474,28 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
>>       return NULL;
>>  }
>>
>> +static inline void hci_chan_hash_init(struct hci_conn *c)
>> +{
>> +     struct hci_chan_hash *h = &c->chan_hash;
>> +     INIT_LIST_HEAD(&h->list);
>> +     spin_lock_init(&h->lock);
>> +     h->num = 0;
>> +}
>> +
>> +static inline void hci_chan_hash_add(struct hci_conn *c, struct hci_chan *chan)
>> +{
>> +     struct hci_chan_hash *h = &c->chan_hash;
>> +     list_add(&chan->list, &h->list);
>> +     h->num++;
>> +}
>> +
>> +static inline void hci_chan_hash_del(struct hci_conn *c, struct hci_chan *chan)
>> +{
>> +     struct hci_chan_hash *h = &c->chan_hash;
>> +     list_del(&chan->list);
>> +     h->num--;
>> +}
>> +
>>  void hci_acl_connect(struct hci_conn *conn);
>>  void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
>>  void hci_add_sco(struct hci_conn *conn, __u16 handle);
>> @@ -470,6 +507,10 @@ int hci_conn_del(struct hci_conn *conn);
>>  void hci_conn_hash_flush(struct hci_dev *hdev);
>>  void hci_conn_check_pending(struct hci_dev *hdev);
>>
>> +struct hci_chan *hci_chan_create(struct hci_conn *conn);
>> +int hci_chan_del(struct hci_chan *chan);
>> +void hci_chan_hash_flush(struct hci_conn *conn);
>> +
>>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>>                                               __u8 sec_level, __u8 auth_type);
>>  int hci_conn_check_link_mode(struct hci_conn *conn);
>> @@ -839,6 +880,7 @@ int hci_unregister_notifier(struct notifier_block *nb);
>>
>>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
>>  void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
>> +void hci_chan_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
>
> So we should have only one function to send data to HCI here, I propose keep
> the hci_send_acl() name and just change its parameter to hci_chan.
>
>>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
>>
>>  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index f018e5d..1e4dd6b 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -301,6 +301,7 @@ struct srej_list {
>>  struct l2cap_chan {
>>       struct sock *sk;
>>
>> +     struct hci_chan         *hchan;
>>       struct l2cap_conn       *conn;
>>
>>       __u8            state;
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index ea7f031..19ae6b4 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -374,6 +374,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>>
>>       skb_queue_head_init(&conn->data_q);
>>
>> +     hci_chan_hash_init(conn);
>> +
>>       setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
>>       setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
>>       setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
>> @@ -432,6 +434,8 @@ int hci_conn_del(struct hci_conn *conn)
>>
>>       tasklet_disable(&hdev->tx_task);
>>
>> +     hci_chan_hash_flush(conn);
>> +
>>       hci_conn_hash_del(hdev, conn);
>>       if (hdev->notify)
>>               hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
>> @@ -956,3 +960,58 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
>>
>>       return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
>>  }
>> +
>> +struct hci_chan *hci_chan_create(struct hci_conn *conn)
>> +{
>> +     struct hci_dev *hdev = conn->hdev;
>> +     struct hci_chan *chan;
>> +
>> +     BT_DBG("%s conn %p", hdev->name, conn);
>> +
>> +     chan = kzalloc(sizeof(struct hci_chan), GFP_ATOMIC);
>> +     if (!chan)
>> +             return NULL;
>> +
>> +     chan->conn = conn;
>> +     skb_queue_head_init(&chan->data_q);
>> +
>> +     tasklet_disable(&hdev->tx_task);
>> +     hci_chan_hash_add(conn, chan);
>> +     tasklet_enable(&hdev->tx_task);
>> +
>> +     return chan;
>> +}
>> +
>> +int hci_chan_del(struct hci_chan *chan)
>> +{
>> +     struct hci_conn *conn = chan->conn;
>> +     struct hci_dev *hdev = conn->hdev;
>> +
>> +     BT_DBG("%s conn %p chan %p", hdev->name, conn, chan);
>> +
>> +     tasklet_disable(&hdev->tx_task);
>> +     hci_chan_hash_del(conn, chan);
>> +     tasklet_enable(&hdev->tx_task);
>> +
>> +     skb_queue_purge(&chan->data_q);
>> +     kfree(chan);
>> +
>> +     return 0;
>> +}
>> +
>> +void hci_chan_hash_flush(struct hci_conn *conn)
>> +{
>> +     struct hci_chan_hash *h = &conn->chan_hash;
>> +     struct list_head *p;
>> +
>> +     BT_DBG("conn %p", conn);
>> +     p = h->list.next;
>> +     while (p != &h->list) {
>> +             struct hci_chan *chan;
>> +
>> +             chan = list_entry(p, struct hci_chan, list);
>
> Use list_for_each_entry() here, instead while + list_entry

Sure.

>> +             p = p->next;
>> +
>> +             hci_chan_del(chan);
>> +     }
>> +}
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 9574752..3a4c3a2 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1975,23 +1975,18 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
>>       hdr->dlen   = cpu_to_le16(len);
>>  }
>>
>> -void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>> +static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
>> +                             struct sk_buff *skb, __u16 flags)
>>  {
>>       struct hci_dev *hdev = conn->hdev;
>>       struct sk_buff *list;
>>
>> -     BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
>> -
>> -     skb->dev = (void *) hdev;
>> -     bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
>> -     hci_add_acl_hdr(skb, conn->handle, flags);
>> -
>>       list = skb_shinfo(skb)->frag_list;
>>       if (!list) {
>>               /* Non fragmented */
>>               BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
>>
>> -             skb_queue_tail(&conn->data_q, skb);
>> +             skb_queue_tail(queue, skb);
>>       } else {
>>               /* Fragmented */
>>               BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
>> @@ -1999,9 +1994,9 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>>               skb_shinfo(skb)->frag_list = NULL;
>>
>>               /* Queue all fragments atomically */
>> -             spin_lock_bh(&conn->data_q.lock);
>> +             spin_lock_bh(&queue->lock);
>>
>> -             __skb_queue_tail(&conn->data_q, skb);
>> +             __skb_queue_tail(queue, skb);
>>
>>               flags &= ~ACL_START;
>>               flags |= ACL_CONT;
>> @@ -2014,16 +2009,46 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>>
>>                       BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
>>
>> -                     __skb_queue_tail(&conn->data_q, skb);
>> +                     __skb_queue_tail(queue, skb);
>>               } while (list);
>>
>> -             spin_unlock_bh(&conn->data_q.lock);
>> +             spin_unlock_bh(&queue->lock);
>>       }
>> +}
>> +
>> +void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>> +{
>> +     struct hci_dev *hdev = conn->hdev;
>> +
>> +     BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
>> +
>> +     skb->dev = (void *) hdev;
>> +     bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
>> +     hci_add_acl_hdr(skb, conn->handle, flags);
>> +
>> +     hci_queue_acl(conn, &conn->data_q, skb, flags);
>>
>>       tasklet_schedule(&hdev->tx_task);
>>  }
>>  EXPORT_SYMBOL(hci_send_acl);
>>
>> +void hci_chan_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
>> +{
>> +     struct hci_conn *conn = chan->conn;
>> +     struct hci_dev *hdev = conn->hdev;
>> +
>> +     BT_DBG("%s chan %p flags 0x%x", hdev->name, chan, flags);
>> +
>> +     skb->dev = (void *) hdev;
>> +     bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
>> +     hci_add_acl_hdr(skb, conn->handle, flags);
>> +
>> +     hci_queue_acl(conn, &chan->data_q, skb, flags);
>> +
>> +     tasklet_schedule(&hdev->tx_task);
>> +}
>> +EXPORT_SYMBOL(hci_chan_send_acl);
>> +
>>  /* Send SCO data */
>>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
>>  {
>> @@ -2127,11 +2152,95 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
>>       }
>>  }
>>
>> +static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
>> +                                             int *quote)
>> +{
>> +     struct hci_conn_hash *h = &hdev->conn_hash;
>> +     struct hci_chan *chan = NULL;
>> +     int num = 0, min = ~0, cur_prio = 0;
>> +     struct list_head *p, *c;
>> +     int cnt, q, conn_num = 0;
>> +
>> +     BT_DBG("%s", hdev->name);
>> +
>> +     list_for_each(p, &h->list) {
>> +             struct hci_conn *conn;
>> +             struct hci_chan_hash *ch;
>> +
>> +             conn = list_entry(p, struct hci_conn, list);
>> +             ch = &conn->chan_hash;
>> +
>> +             if (conn->type != type)
>> +                     continue;
>> +
>> +             if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
>> +                     continue;
>> +
>> +             conn_num++;
>> +
>> +             list_for_each(c, &ch->list) {
>> +                     struct hci_chan *tmp;
>> +                     struct sk_buff *skb;
>> +
>> +                     tmp = list_entry(c, struct hci_chan, list);
>> +
>> +                     if (skb_queue_empty(&tmp->data_q))
>> +                             continue;
>> +
>> +                     skb = skb_peek(&tmp->data_q);
>> +                     if (skb->priority < cur_prio)
>> +                             continue;
>> +
>> +                     if (skb->priority > cur_prio) {
>> +                             num = 0;
>> +                             min = ~0;
>> +                             cur_prio = skb->priority;
>> +                     }
>> +
>> +                     num++;
>> +
>> +                     if (conn->sent < min) {
>> +                             min  = conn->sent;
>> +                             chan = tmp;
>> +                     }
>> +             }
>> +
>> +             if (hci_conn_num(hdev, type) == conn_num)
>> +                     break;
>> +     }
>> +
>> +     if (!chan)
>> +             return NULL;
>> +
>> +     switch (chan->conn->type) {
>> +     case ACL_LINK:
>> +             cnt = hdev->acl_cnt;
>> +             break;
>> +     case SCO_LINK:
>> +     case ESCO_LINK:
>> +             cnt = hdev->sco_cnt;
>> +             break;
>> +     case LE_LINK:
>> +             cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
>> +             break;
>> +     default:
>> +             cnt = 0;
>> +             BT_ERR("Unknown link type");
>> +     }
>> +
>> +     q = cnt / num;
>> +     *quote = q ? q : 1;
>> +     BT_DBG("chan %p quote %d", chan, *quote);
>> +     return chan;
>> +}
>> +
>>  static inline void hci_sched_acl(struct hci_dev *hdev)
>>  {
>>       struct hci_conn *conn;
>> +     struct hci_chan *chan;
>>       struct sk_buff *skb;
>>       int quote;
>> +     unsigned int cnt;
>>
>>       BT_DBG("%s", hdev->name);
>>
>> @@ -2145,9 +2254,10 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>>                       hci_link_tx_to(hdev, ACL_LINK);
>>       }
>>
>> -     while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
>> +     while (hdev->acl_cnt &&
>> +                     (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
>>               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>> -                     BT_DBG("skb %p len %d", skb, skb->len);
>> +                     BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
>>
>>                       hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
>>
>> @@ -2158,6 +2268,26 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>>                       conn->sent++;
>>               }
>>       }
>> +
>> +     cnt = hdev->acl_cnt;
>> +
>> +     while (hdev->acl_cnt &&
>> +                     (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
>> +             while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
>> +                     BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
>> +                                     skb->len, skb->priority);
>> +
>> +                     hci_conn_enter_active_mode(chan->conn,
>> +                                             bt_cb(skb)->force_active);
>> +
>> +                     hci_send_frame(skb);
>> +                     hdev->acl_last_tx = jiffies;
>> +
>> +                     hdev->acl_cnt--;
>> +                     chan->sent++;
>> +                     chan->conn->sent++;
>> +             }
>> +     }
>>  }
>>
>>  /* Schedule SCO */
>> @@ -2174,7 +2304,7 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
>>
>>       while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
>>               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>> -                     BT_DBG("skb %p len %d", skb, skb->len);
>> +                     BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
>>                       hci_send_frame(skb);
>>
>>                       conn->sent++;
>> @@ -2197,7 +2327,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
>>
>>       while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
>>               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>> -                     BT_DBG("skb %p len %d", skb, skb->len);
>> +                     BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
>>                       hci_send_frame(skb);
>>
>>                       conn->sent++;
>> @@ -2210,6 +2340,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
>>  static inline void hci_sched_le(struct hci_dev *hdev)
>>  {
>>       struct hci_conn *conn;
>> +     struct hci_chan *chan;
>>       struct sk_buff *skb;
>>       int quote, cnt;
>>
>> @@ -2229,7 +2360,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>>       cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
>>       while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
>>               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>> -                     BT_DBG("skb %p len %d", skb, skb->len);
>> +                     BT_DBG("conn %p skb %p len %d", conn, skb, skb->len);
>>
>>                       hci_send_frame(skb);
>>                       hdev->le_last_tx = jiffies;
>> @@ -2238,6 +2369,21 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>>                       conn->sent++;
>>               }
>>       }
>> +
>> +     while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
>> +             while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
>> +                     BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
>> +                                     skb->len, skb->priority);
>> +
>> +                     hci_send_frame(skb);
>> +                     hdev->le_last_tx = jiffies;
>> +
>> +                     cnt--;
>> +                     chan->sent++;
>> +                     chan->conn->sent++;
>> +             }
>> +     }
>> +
>
> IMHO when le_pkts equals zero(i.e., ACL and LE use the same buffer) we should
> handle LE sending together with the ACL sending. This way we are prioritizing
> ACL data over LE if we call hci_sched_acl before hci_sched_le.

iirc Peter has some patch that merges them, the problem is that
conn->type cannot be set to ACL since it is used for other purposes,
but perhaps we gonna have a different type to identify the buffer type
the connection is using.


-- 
Luiz Augusto von Dentz
