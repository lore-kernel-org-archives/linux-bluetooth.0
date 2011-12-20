Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Dec 2011 17:05:04 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 5/5] Bluetooth: Correct packet len calculation
Message-ID: <20111220190504.GA24612@joana>
References: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1324305091-19393-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324305091-19393-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-12-19 16:31:31 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove unneeded skb_pull and correct packet length calculation
> removing magic number. Move BT_DBG after len check otherwise
> it could possibly access wrong memory.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 919e3c0..47e1476 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2266,20 +2266,19 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
>  	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
>  	int i;
>  
> -	skb_pull(skb, sizeof(*ev));
> -
> -	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> -
>  	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
>  		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
>  		return;
>  	}
>  
> -	if (skb->len < ev->num_hndl * 4) {
> +	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
> +			ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {

I think you can remove the first part of this check.

	Gustavo
