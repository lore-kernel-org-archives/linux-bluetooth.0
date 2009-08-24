Return-Path: <cyrus@holtmann.org>
Subject: RE: patch for hci_bcsp.c(2.6.31.-rc1)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Weng, Wending" <WWeng@rheinmetall.ca>
Cc: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <54B31811B83D744D90BF0289EB447D460C1A5046@MAIL-MB1.oerlikon.ca>
References: <54B31811B83D744D90BF0289EB447D460C1A5046@MAIL-MB1.oerlikon.ca>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 11:37:47 -0700
Message-Id: <1251139067.2950.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wending,

>         replace >= with > will not work. Below is the new patch.
> 
> From: root <root@SBC_PC_3.localdomain>
> Date: Mon, 24 Aug 2009 14:06:18 -0400
> Subject: [PATCH] The routine bcsp_pkt_cull displays the false error message
> "Removed only %u out of %u pkts" when multiple to be acked packets are queued.
> As if (i++ >= pkts_to_be_removed)
>         break;
>    will breaks the loop and increase the counter i when i==pkts_to_be_removed,
>    the loop ends up with i=pkts_to_be_removed+1. The following line:
>    if (i != pkts_to_be_removed) {
>         BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
>    }
>    will display the false message.
> The counter i must not increase on the same line.
> ---
>  drivers/bluetooth/hci_bcsp.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 894b2cb..40aec0f 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -373,8 +373,9 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
> 
>         i = 0;
>         skb_queue_walk_safe(&bcsp->unack, skb, tmp) {
> -               if (i++ >= pkts_to_be_removed)
> +               if (i >= pkts_to_be_removed)
>                         break;
> +               i++;
> 
>                 __skb_unlink(skb, &bcsp->unack);
>                 kfree_skb(skb);

looks good, but I need a patch that applies with bluetooth-testing.git
tree. And please create it with git format-patch.

Regards

Marcel


