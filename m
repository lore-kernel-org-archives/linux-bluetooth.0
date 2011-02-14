Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4d59a5ff.859ddc0a.46cb.5143@mx.google.com>
References: <4d59a5ff.859ddc0a.46cb.5143@mx.google.com>
Date: Mon, 14 Feb 2011 19:23:47 -0300
Message-ID: <AANLkTikhs5uwFgeF0BT_5R_=8sM5Z+eQ_y2kxZ_oWj1V@mail.gmail.com>
Subject: Re: [RFC 1/5] Bluetooth: Implement advertising report meta event
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Mon, Feb 14, 2011 at 6:59 PM,  <anderson.briglia@openbossa.org> wrote:
> From: Anderson Briglia <anderson.briglia@openbossa.org>
>
> This patch implements new LE meta event in order to handle advertising
> reports.
>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |   18 ++++++++++++++++++
>  net/bluetooth/hci_event.c   |   22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 46438f4..5180555 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -980,6 +980,24 @@ struct hci_ev_le_conn_complete {
>        __u8     clk_accurancy;
>  } __packed;
>
> +#define ADV_IND                0x00
> +#define ADV_DIRECT_IND 0x01
> +#define ADV_SCAN_IND   0x02
> +#define ADV_NONCONN_IND        0x03
> +#define SCAN_RSP       0x04
> +
> +#define ADDR_DEV_PUBLIC        0x00
> +#define ADDR_DEV_RANDOM        0x01
> +
> +#define HCI_EV_LE_ADVERTISING_REPORT   0x02
> +struct hci_ev_le_advertising_info {
> +       __u8     evt_type;
> +       __u8     bdaddr_type;
> +       bdaddr_t bdaddr;
> +       __u8     length;
> +       __u8     data[0];
> +} __packed;
> +
>  #define HCI_EV_LE_LTK_REQ              0x05
>  struct hci_ev_le_ltk_req {
>        __le16  handle;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 99c75f4..987f5de 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2498,6 +2498,25 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
>        hci_dev_unlock(hdev);
>  }
>
> +static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
> +                                               struct sk_buff *skb)
> +{
> +       struct hci_ev_le_advertising_info *ev;
> +       u8 num_reports, i;
> +
> +       num_reports = (u8) skb->data[0];

I think this cast is unnecessary.

> +
> +       ev = (struct hci_ev_le_advertising_info *) (skb->data + 1);

What about a slightly shorter line (well I didn't count the chars):

ev = (struct hci_ev_le_advertising_info *) &skb->data[1];

> +
> +       BT_DBG("adv from: %s", batostr(&ev->bdaddr));
> +
> +       for (i = 1; i < num_reports; i++) {
> +               ev = (struct hci_ev_le_advertising_info *)
> +                                       (ev->data + ev->length + 1);
> +               BT_DBG("adv from: %s", batostr(&ev->bdaddr));
> +       }

What about (not sure if it is shorter, just a suggestion):

ev = (struct hci_ev_le_advertising_info *) &ev->data[ev->length + 1];

> +}
> +
>  static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>        struct hci_ev_le_meta *le_ev = (void *) skb->data;
> @@ -2513,6 +2532,9 @@ static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
>                hci_le_ltk_request_evt(hdev, skb);
>                break;
>
> +       case HCI_EV_LE_ADVERTISING_REPORT:
> +               hci_le_adv_report_evt(hdev, skb);
> +

missing a "break" here.

>        default:
>                break;
>        }
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
