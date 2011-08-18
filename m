Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313627857.10336.11.camel@THOR>
References: <1313627857.10336.11.camel@THOR>
Date: Thu, 18 Aug 2011 10:57:52 +0300
Message-ID: <CABBYNZ+XX-kwFPWZL_xbyHLWbaEMBPXzj3N5gomUX=UxoStOYA@mail.gmail.com>
Subject: Re: [RFC v2 3/5] Bluetooth: Add buffer count to tx scheduler parameters
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 3:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Utilize already known tx buffer count values as parameters to
> the tx scheduler, rather than determining the values on each
> iteration of the tx scheduler.
>
> This is preparatory for merging transmission types (such as SCO
> and ESCO) and also for handling tx buffer counters atomically.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/hci_core.c |   51 ++++++++++++++++-----------------------------
>  1 files changed, 18 insertions(+), 33 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0defa83..b2a1b9a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1798,7 +1798,8 @@ EXPORT_SYMBOL(hci_send_sco);
>  /* ---- HCI TX task (outgoing data) ---- */
>
>  /* HCI Connection scheduler */
> -static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
> +static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
> +                                                       int cnt, int *quote)
>  {
>        struct hci_conn_hash *h = &hdev->conn_hash;
>        struct hci_conn *conn = NULL;
> @@ -1825,28 +1826,8 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
>                }
>        }
>
> -       if (conn) {
> -               int cnt;
> -
> -               switch (conn->type) {
> -               case ACL_LINK:
> -                       cnt = hdev->acl_cnt;
> -                       break;
> -               case SCO_LINK:
> -               case ESCO_LINK:
> -                       cnt = hdev->sco_cnt;
> -                       break;
> -               case LE_LINK:
> -                       cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
> -                       break;
> -               default:
> -                       cnt = 0;
> -                       BT_ERR("Unknown link type");
> -               }
> -
> +       if (conn)
>                *quote = (cnt + (num - 1)) / num;
> -       } else
> -               *quote = 0;
>
>        BT_DBG("conn %p quote %d", conn, *quote);
>        return conn;
> @@ -1875,18 +1856,19 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>  {
>        struct hci_conn *conn;
>        struct sk_buff *skb;
> -       int quote;
> +       int quote = 0;
> +       int cnt = hdev->acl_cnt;
>
>        BT_DBG("%s", hdev->name);
>
>        if (!test_bit(HCI_RAW, &hdev->flags)) {
>                /* ACL tx timeout must be longer than maximum
>                 * link supervision timeout (40.9 seconds) */
> -               if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
> +               if (!cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
>                        hci_link_tx_to(hdev, ACL_LINK);
>        }
>
> -       while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, ACL_LINK, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>
> @@ -1895,10 +1877,11 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>                        hci_send_frame(skb);
>                        hdev->acl_last_tx = jiffies;
>
> -                       hdev->acl_cnt--;
> +                       cnt--;
>                        conn->sent++;
>                }
>        }
> +       hdev->acl_cnt = cnt;
>  }
>
>  /* Schedule SCO */
> @@ -1906,11 +1889,12 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
>  {
>        struct hci_conn *conn;
>        struct sk_buff *skb;
> -       int quote;
> +       int quote = 0;
> +       int cnt = hdev->sco_cnt;
>
>        BT_DBG("%s", hdev->name);
>
> -       while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, SCO_LINK, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>                        hci_send_frame(skb);
> @@ -1926,11 +1910,12 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
>  {
>        struct hci_conn *conn;
>        struct sk_buff *skb;
> -       int quote;
> +       int quote = 0;
> +       int cnt = hdev->sco_cnt;
>
>        BT_DBG("%s", hdev->name);
>
> -       while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, ESCO_LINK, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>                        hci_send_frame(skb);
> @@ -1946,7 +1931,8 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>  {
>        struct hci_conn *conn;
>        struct sk_buff *skb;
> -       int quote, cnt;
> +       int quote = 0;
> +       int cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
>
>        BT_DBG("%s", hdev->name);
>
> @@ -1958,8 +1944,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
>                        hci_link_tx_to(hdev, LE_LINK);
>        }
>
> -       cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
> -       while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
> +       while (cnt && (conn = hci_low_sent(hdev, LE_LINK, cnt, &quote))) {
>                while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
>                        BT_DBG("skb %p len %d", skb, skb->len);
>
> --
> 1.7.4.1
>
>

Nice work, it probably conflict with one of my patches to check if
there is any connection, but I guess it is easy to rebase, btw it is
probably a good idea to no initialize the variables in the declaration
since with hci_conn_num check we may bail out without using them.


-- 
Luiz Augusto von Dentz
