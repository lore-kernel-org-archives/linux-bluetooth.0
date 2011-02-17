Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 14:48:06 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 1/4] Bluetooth: Implement advertising report meta event
Message-ID: <20110217174806.GK10543@joana>
References: <n>
 <4d5d2585.8f7edc0a.5af6.27d8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d5d2585.8f7edc0a.5af6.27d8@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-02-17 10:39:53 -0300]:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> This patch implements new LE meta event in order to handle advertising
> reports.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |   18 ++++++++++++++++++
>  net/bluetooth/hci_event.c   |   22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 46438f4..5180555 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -980,6 +980,24 @@ struct hci_ev_le_conn_complete {
>  	__u8     clk_accurancy;
>  } __packed;
>  
> +#define ADV_IND		0x00
> +#define ADV_DIRECT_IND	0x01
> +#define ADV_SCAN_IND	0x02
> +#define ADV_NONCONN_IND	0x03
> +#define SCAN_RSP	0x04

ADV_SCAN_RSP, maybe?

> +
> +#define ADDR_DEV_PUBLIC	0x00
> +#define ADDR_DEV_RANDOM	0x01

ADDR_LE_ here.

> +
> +#define HCI_EV_LE_ADVERTISING_REPORT	0x02
> +struct hci_ev_le_advertising_info {
> +	__u8	 evt_type;
> +	__u8	 bdaddr_type;
> +	bdaddr_t bdaddr;
> +	__u8	 length;
> +	__u8	 data[0];
> +} __packed;
> 
>  #define HCI_EV_LE_LTK_REQ		0x05
>  struct hci_ev_le_ltk_req {
>  	__le16	handle;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 99c75f4..1c8d888 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2498,6 +2498,24 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
>  	hci_dev_unlock(hdev);
>  }
>  
> +static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
> +						struct sk_buff *skb)
> +{
> +	struct hci_ev_le_advertising_info *ev;
> +	u8 num_reports, i;
> +
> +	num_reports = skb->data[0];
> +
> +	ev = (void *) &skb->data[1];
> +
> +	BT_DBG("adv from: %s", batostr(&ev->bdaddr));
> +
> +	for (i = 1; i < num_reports; i++) {
> +		ev = (void *) (ev->data + ev->length + 1);

You are not using i anywhere here.

-- 
Gustavo F. Padovan
http://profusion.mobi
