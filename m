Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org" <gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth:hci_qca: Changed unsigned long to bool
Date: Mon, 28 Sep 2015 09:15:47 +0200
Message-ID: <8697290.fIAsqDPKZQ@leonov>
In-Reply-To: <20150928062901.GA5935@jci-VirtualBox>
References: <20150928062901.GA5935@jci-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 28 of September 2015 06:29:07 Mutharaju, Prasanna wrote:
> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> 'retransmit' being set in HCI_IBS_TX_WAKING case,
> using bool would be efficient.
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 21f4ea4..3fdb17d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -347,7 +347,7 @@ static void hci_ibs_wake_retrans_timeout(unsigned long
> arg) struct hci_uart *hu = (struct hci_uart *)arg;
>  	struct qca_data *qca = hu->priv;
>  	unsigned long flags, retrans_delay;
> -	unsigned long retransmit = 0;
> +	bool retransmit;
> 
>  	BT_DBG("hu %p wake retransmit timeout in %d state",
>  		hu, qca->tx_ibs_state);
> @@ -358,7 +358,7 @@ static void hci_ibs_wake_retrans_timeout(unsigned long
> arg) switch (qca->tx_ibs_state) {
>  	case HCI_IBS_TX_WAKING:
>  		/* No WAKE_ACK, retransmit WAKE */
> -		retransmit = 1;
> +		retransmit = true;
>  		if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0) {
>  			BT_ERR("Failed to acknowledge device wake up");
>  			break;

Isn't this patch giving you a warning about retransmit being used 
uninitialized? (it is never set to false)

-- 
BR
Szymon Janc
