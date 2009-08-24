Return-Path: <cyrus@holtmann.org>
From: "Weng, Wending" <WWeng@rheinmetall.ca>
To: 'Marcel Holtmann' <marcel@holtmann.org>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Date: Mon, 24 Aug 2009 10:03:28 -0400
Subject: RE: patch for hci_bcsp.c(2.6.31.-rc1)
Message-ID: <54B31811B83D744D90BF0289EB447D460C1A5045@MAIL-MB1.oerlikon.ca>
In-Reply-To: <1250971538.2950.26.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

        If I keep "if (i++ >=3D pkts_to_be_removed)", the loop will end up =
with
        i=3D2 if pkts_to_be_removed=3D=3D1 and the second test skb_queue_wa=
lk_safe is true,

        it will cause error message later on:

        if (i !=3D pkts_to_be_removed) {
                BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_remo=
ved);
        }

        I think we should add another line for i++.

Regards

Wending Weng

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org]On Behalf Of Marcel
Holtmann
Sent: August 22, 2009 4:06 PM
To: Weng, Wending
Cc: 'linux-bluetooth@vger.kernel.org'
Subject: Re: patch for hci_bcsp.c(2.6.31.-rc1)


Hi Wending,

> From 69596948eb2172080bb950d99dc90678ead08305 Mon Sep 17 00:00:00 2001
> From: root <root@SBC_PC_3.localdomain>
> Date: Wed, 19 Aug 2009 08:59:56 -0400
> Subject: [PATCH] The routine bcsp_pkt_cull doesn't ack the packets proper=
ly
> if multiple packets are queued. The counter i must increase before
> doing comparison.
>
> Signed-off-by: Wending Weng <wweng@rheinmetall.ca>
>
> ---
>  drivers/bluetooth/hci_bcsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index 894b2cb..cd30f39 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -373,7 +373,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
>
>         i =3D 0;
>         skb_queue_walk_safe(&bcsp->unack, skb, tmp) {
> -               if (i++ >=3D pkts_to_be_removed)
> +               if (++i >=3D pkts_to_be_removed)
>                         break;

wouldn't be if (i++ > pkts_to_be_removed) the better way to test this?

Regards

Marcel


--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
