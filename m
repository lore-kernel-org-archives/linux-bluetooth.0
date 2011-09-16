Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1109151611190.28021@mathewm-linux>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	<1315846853-27442-4-git-send-email-luiz.dentz@gmail.com>
	<alpine.DEB.2.02.1109151611190.28021@mathewm-linux>
Date: Fri, 16 Sep 2011 10:35:59 +0300
Message-ID: <CABBYNZJqu-in9NX8Wat0-Y6C3cRdSepwB4XpwWqYTo+uwStqMA@mail.gmail.com>
Subject: Re: [RFC 4/5 v3] Bluetooth: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, Sep 16, 2011 at 2:34 AM, Mat Martineau <mathewm@codeaurora.org> wrote:
>
>
> On Mon, 12 Sep 2011, Luiz Augusto von Dentz wrote:
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
> For a given L2CAP channel, I think we want commands and data to use the same
> queue.

Yep, I forgot to remove the old hci_chan from l2cap_chan, but the idea
is to use only one queue per channel to maintain ordering.

> With AMP channel move signaling, it's important to maintain ordering between
> L2CAP commands and data.  This ensures that data gets flushed out of the
> queues and is not being sent during the channel move process and AMP link
> establishment.  You also want to make sure queued data is sent before a
> disconnect request.

Yep.

>
>>
>> -static inline void hci_sched_acl(struct hci_dev *hdev)
>> +static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8
>> type,
>> +                                               int *quote)
>> {
>> +       struct hci_conn_hash *h = &hdev->conn_hash;
>> +       struct hci_chan *chan = NULL;
>> +       int num = 0, min = ~0, cur_prio = 0;
>>        struct hci_conn *conn;
>> +       int cnt, q, conn_num = 0;
>> +
>> +       BT_DBG("%s", hdev->name);
>> +
>> +       list_for_each_entry(conn, &h->list, list) {
>> +               struct hci_chan_hash *ch;
>> +               struct hci_chan *tmp;
>> +
>> +               if (conn->type != type)
>> +                       continue;
>> +
>> +               if (conn->state != BT_CONNECTED && conn->state !=
>> BT_CONFIG)
>> +                       continue;
>> +
>> +               conn_num++;
>> +
>> +               ch = &conn->chan_hash;
>> +
>> +               list_for_each_entry(tmp, &ch->list, list) {
>> +                       struct sk_buff *skb;
>> +
>> +                       if (skb_queue_empty(&tmp->data_q))
>> +                               continue;
>> +
>> +                       skb = skb_peek(&tmp->data_q);
>> +                       if (skb->priority < cur_prio)
>> +                               continue;
>> +
>> +                       if (skb->priority > cur_prio) {
>> +                               num = 0;
>> +                               min = ~0;
>> +                               cur_prio = skb->priority;
>> +                       }
>> +
>> +                       num++;
>> +
>> +                       if (conn->sent < min) {
>> +                               min  = conn->sent;
>> +                               chan = tmp;
>> +                       }
>> +               }
>> +
>> +               if (hci_conn_num(hdev, type) == conn_num)
>> +                       break;
>> +       }
>
>
> Only the priority of the first skb in each queue is considered.  What if
> there's a higher priority skb deeper in a queue?

Can be done at cost of redoing the quote calculation every time
skb>priority < quote priority, but I considered that too expensive for
the little impact it cause as priority inversion, also note that it
will not handle the case you have presented that a higher priority is
deeper in the queue because it is not really a problem since we have
to maintain the ordering we cannot sent it before the low priority skb
so it has to wait until those are sent.

> Would it work to track priority in hci_chan instead of the skb?  That would
> simplify patch 1 of this series.

Nope, because RFCOMM connections share the same L2CAP channel, so
currently Im afraid it has to be per skb.

>
>> +
>> +       if (!chan)
>> +               return NULL;
>> +
>> +       switch (chan->conn->type) {
>> +       case ACL_LINK:
>> +               cnt = hdev->acl_cnt;
>> +               break;
>> +       case SCO_LINK:
>> +       case ESCO_LINK:
>> +               cnt = hdev->sco_cnt;
>> +               break;
>> +       case LE_LINK:
>> +               cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
>> +               break;
>> +       default:
>> +               cnt = 0;
>> +               BT_ERR("Unknown link type");
>> +       }
>> +
>> +       q = cnt / num;
>> +       *quote = q ? q : 1;
>> +       BT_DBG("chan %p quote %d", chan, *quote);
>> +       return chan;
>> +}
>> +
>> +static inline void hci_sched_acl(struct hci_dev *hdev)
>> +{
>> +       struct hci_chan *chan;
>>        struct sk_buff *skb;
>>        int quote;
>> +       unsigned int cnt;
>>
>>        BT_DBG("%s", hdev->name);
>>
>> @@ -2122,17 +2226,23 @@ static inline void hci_sched_acl(struct hci_dev
>> *hdev)
>>                        hci_link_tx_to(hdev, ACL_LINK);
>>        }
>>
>> -       while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK,
>> &quote))) {
>> -               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>> -                       BT_DBG("skb %p len %d", skb, skb->len);
>> +       cnt = hdev->acl_cnt;
>>
>> -                       hci_conn_enter_active_mode(conn,
>> bt_cb(skb)->force_active);
>> +       while (hdev->acl_cnt &&
>> +                       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
>> +               while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
>> +                       BT_DBG("chan %p skb %p len %d priority %u", chan,
>> skb,
>> +                                       skb->len, skb->priority);
>> +
>> +                       hci_conn_enter_active_mode(chan->conn,
>> +                                               bt_cb(skb)->force_active);
>
>
> Where are conn->data_q skbs dequeued now?

Ive removed as suggested by Gustavo to unify the algorithm used for
ACL, SCO/ESCO still use it, gonna update the commit message to reflect
it.


-- 
Luiz Augusto von Dentz
