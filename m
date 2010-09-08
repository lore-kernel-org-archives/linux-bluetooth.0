Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Sep 2010 19:05:04 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Implement LE Set Scan Enable cmd
Message-ID: <20100908220504.GN16973@vigoh>
References: <1282591815-26934-1-git-send-email-anderson.briglia@openbossa.org>
 <1282591815-26934-2-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282591815-26934-2-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Briglia <anderson.briglia@openbossa.org> [2010-08-23 15:30:15 -0400]:

> This patch implements LE Set Scan Enable command for dual
> mode and Low Energy hci controllers. It also adds new HCI flags
> in order to indicate the LE Scanning state for userland applications
> and kernel itself.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    5 +++++
>  net/bluetooth/hci_event.c   |   25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cae1816..268aa94 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -77,6 +77,7 @@ enum {
>  
>  	HCI_RAW,
>  	HCI_LE_ADV,
> +	HCI_LE_SCAN,
>  };
>  
>  /* HCI ioctl defines */
> @@ -599,6 +600,10 @@ struct hci_rp_read_bd_addr {
>  	#define ADVERTISE_ENABLED	0x01
>  	#define ADVERTISE_DISABLED	0x00
>  
> +#define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
> +	#define LESCAN_ENABLED		0x01
> +	#define LESCAN_DISABLED		0x00

Make these LE_SCAN_ENABLED and LE_SCAN_DISABLED.

>  /* ---- HCI Events ---- */
>  #define HCI_EV_INQUIRY_COMPLETE		0x01
>  
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c86c655..f483801 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -845,6 +845,27 @@ static void hci_cc_le_set_advertise(struct hci_dev *hdev, struct sk_buff *skb)
>  	hci_req_complete(hdev, status);
>  }
>  
> +static void hci_cc_le_set_scan(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	__u8 status = *((__u8 *) skb->data);
> +	void *sent;
> +
> +	BT_DBG("%s status 0x%x", hdev->name, status);
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
> +	if (!sent)
> +		return;
> +
> +	clear_bit(HCI_LE_SCAN, &hdev->flags);

Why do you have this clear_bit() outside of the if below? if
status != 0, i.e, the command has failed we can say for sure that
scanning is disabled.

> +	if (!status) {
> +		__u8 param = *((__u8 *) sent);
> +		if (param & LESCAN_ENABLED)
> +			set_bit(HCI_LE_SCAN, &hdev->flags);
> +	}
> +
> +	hci_req_complete(hdev, status);

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
