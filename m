Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 4/5] Remove the default security level from btio
Date: Wed, 14 Dec 2011 11:43:47 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B026457760@DNCE02.ent.ti.com>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
 <1323820654-16820-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323820654-16820-4-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vinicius

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> Sent: Wednesday, December 14, 2011 1:58 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Vinicius Costa Gomes
> Subject: [PATCH BlueZ 4/5] Remove the default security level from btio
> 
> The default value of sec_level when setting *any* option
> using bt_io_set() was BT_SECURITY_MEDIUM. This was causing
> the security procedure being started in some situations that
> it should not.
> ---
>  btio/btio.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/btio/btio.c b/btio/btio.c
> index 5641a9c..c26a734 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -698,7 +698,6 @@ static gboolean parse_set_opts(struct set_opts
> *opts, GError **err,
>  	/* Set defaults */
>  	opts->defer = DEFAULT_DEFER_TIMEOUT;
>  	opts->master = -1;
> -	opts->sec_level = BT_IO_SEC_MEDIUM;

So removing this simply sets the default security level to none ?

>  	opts->mode = L2CAP_MODE_BASIC;
>  	opts->flushable = -1;
>  	opts->priority = 0;
> --
> 1.7.8
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks,
Chen Ganir

