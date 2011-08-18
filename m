Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313627862.10336.12.camel@THOR>
References: <1313627862.10336.12.camel@THOR>
Date: Thu, 18 Aug 2011 11:18:32 +0300
Message-ID: <CABBYNZJ4S6Ts7Liu3jZb-tYb3DyRo0_jjDmVMizn6owQy=g6AQ@mail.gmail.com>
Subject: Re: [RFC v2 4/5] Bluetooth: Schedule links by tx buffer use
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 3:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Combine tx link types which use the same tx buffers. So SCO and ESCO
> links are scheduled together and also schedule LE links with ACL
> links *if* the controller uses shared ACL buffers for LE tx.
>
> This also fixes tx timeouts if the controller uses shared ACL buffers
> for LE tx.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/net/bluetooth/hci.h |   10 ++++++
>  net/bluetooth/hci_core.c    |   69 +++++++++++++++++--------------------------
>  2 files changed, 37 insertions(+), 42 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0c20227..c8319e5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -174,6 +174,16 @@ enum {
>  /* Low Energy links do not have defined link type. Use invented one */
>  #define LE_LINK                0x80
>
> +#define LE_MASK                0x80
> +#define SCO_MASK       0x01
> +#define ACL_MASK       0x02
> +#define ESCO_MASK      0x04
> +
> +static inline __u8 link_mask(__u8 type)
> +{
> +       return type < LE_LINK ? 1 << type : LE_MASK;
> +}
> +
>  /* LMP features */
>  #define LMP_3SLOT      0x01
>  #define LMP_5SLOT      0x02
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b2a1b9a..c9b44c5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1798,7 +1798,7 @@ EXPORT_SYMBOL(hci_send_sco);
>  /* ---- HCI TX task (outgoing data) ---- */
>
>  /* HCI Connection scheduler */
> -static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
> +static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 select,
>                                                        int cnt, int *quote)
>  {
>        struct hci_conn_hash *h = &hdev->conn_hash;
> @@ -1812,7 +1812,10 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
>                struct hci_conn *c;
>                c = list_entry(p, struct hci_conn, list);
>
> -               if (c->type != type || skb_queue_empty(&c->data_q))
> +               if (link_mask(c->type) & ~select)
> +                       continue;
> +
> +               if (skb_queue_empty(&c->data_q))
>                        continue;
>
>                if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
> @@ -1833,7 +1836,7 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
>        return conn;
>  }
>
> -static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
> +static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 select)
>  {
>        struct hci_conn_hash *h = &hdev->conn_hash;
>        struct list_head *p;
> @@ -1844,7 +1847,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
>        /* Kill stalled connections */
>        list_for_each(p, &h->list) {
>                c = list_entry(p, struct hci_conn, list);
> -               if (c->type == type && c->sent) {
> +               if (link_mask(c->type) & select && c->sent) {
>                        BT_ERR("%s killing stalled connection %s",
>                                hdev->name, batostr(&c->dst));
>                        hci_acl_disconn(c, 0x13);
> @@ -1858,6 +1861,11 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>        struct sk_buff *skb;
>        int quote = 0;
>        int cnt = hdev->acl_cnt;
> +       __u8 select = ACL_MASK;
> +
> +       /* Also select LE links if ACL buffers are shared */
> +       if (!hdev->le_pkts)
> +               select |= LE_MASK;
>
>        BT_DBG("%s", hdev->name);
>
> @@ -1865,14 +1873,15 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>                /* ACL tx timeout must be longer than maximum
>                 * link supervision timeout (40.9 seconds) */
>                if (!cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
> -                       hci_link_tx_to(hdev, ACL_LINK);
> +                       hci_link_tx_to(hdev, select);
>        }
>
> -       while (cnt && (conn = hci_low_sent(hdev, ACL_LINK, cnt, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, select, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>
> -                       hci_conn_enter_active_mode(conn);
> +                       if (conn->type == ACL_LINK)
> +                               hci_conn_enter_active_mode(conn);
>
>                        hci_send_frame(skb);
>                        hdev->acl_last_tx = jiffies;
> @@ -1891,31 +1900,11 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
>        struct sk_buff *skb;
>        int quote = 0;
>        int cnt = hdev->sco_cnt;
> +       __u8 select = SCO_MASK | ESCO_MASK;
>
>        BT_DBG("%s", hdev->name);
>
> -       while (cnt && (conn = hci_low_sent(hdev, SCO_LINK, cnt, &quote))) {
> -               while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> -                       BT_DBG("skb %p len %d", skb, skb->len);
> -                       hci_send_frame(skb);
> -
> -                       conn->sent++;
> -                       if (conn->sent == ~0)
> -                               conn->sent = 0;
> -               }
> -       }
> -}
> -
> -static inline void hci_sched_esco(struct hci_dev *hdev)
> -{
> -       struct hci_conn *conn;
> -       struct sk_buff *skb;
> -       int quote = 0;
> -       int cnt = hdev->sco_cnt;
> -
> -       BT_DBG("%s", hdev->name);
> -
> -       while (cnt && (conn = hci_low_sent(hdev, ESCO_LINK, cnt, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, select, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>                        hci_send_frame(skb);
> @@ -1932,19 +1921,18 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>        struct hci_conn *conn;
>        struct sk_buff *skb;
>        int quote = 0;
> -       int cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
> +       int cnt = hdev->le_cnt;
>
>        BT_DBG("%s", hdev->name);
>
>        if (!test_bit(HCI_RAW, &hdev->flags)) {
>                /* LE tx timeout must be longer than maximum
>                 * link supervision timeout (40.9 seconds) */
> -               if (!hdev->le_cnt && hdev->le_pkts &&
> -                               time_after(jiffies, hdev->le_last_tx + HZ * 45))
> -                       hci_link_tx_to(hdev, LE_LINK);
> +               if (!cnt && time_after(jiffies, hdev->le_last_tx + HZ * 45))
> +                       hci_link_tx_to(hdev, LE_MASK);
>        }
>
> -       while (cnt && (conn = hci_low_sent(hdev, LE_LINK, cnt, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, LE_MASK, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>
> @@ -1955,10 +1943,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>                        conn->sent++;
>                }
>        }
> -       if (hdev->le_pkts)
> -               hdev->le_cnt = cnt;
> -       else
> -               hdev->acl_cnt = cnt;
> +       hdev->le_cnt = cnt;
>  }
>
>  static void hci_tx_task(unsigned long arg)
> @@ -1973,14 +1958,14 @@ static void hci_tx_task(unsigned long arg)
>
>        /* Schedule queues and send stuff to HCI driver */
>
> +       /* Also schedules LE links if acl buffers are shared */
>        hci_sched_acl(hdev);
>
> +       /* Also schedules esco links */
>        hci_sched_sco(hdev);
>
> -       hci_sched_esco(hdev);
> -
> -       /* Only schedule le links if device is le-capable */
> -       if (lmp_le_capable(hdev))
> +       /* Only schedule LE links here if acl buffers are not shared */
> +       if (hdev->le_pkts)
>                hci_sched_le(hdev);
>
>        /* Send next queued raw (unknown type) packet */
> --
> 1.7.4.1
>
>

I wonder if it wouldn't be simpler to just have another type e.g.
sched_type in hci_conn, so when initializing the connection we already
define which sched_type to use e.g. for LE sched_type = hdev->le_pkts
? LE_LINK : ACL_LINK.

-- 
Luiz Augusto von Dentz
