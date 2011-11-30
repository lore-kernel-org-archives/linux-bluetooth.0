Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1322670976-9517-1-git-send-email-sancane@gmail.com>
References: <1322670976-9517-1-git-send-email-sancane@gmail.com>
Date: Wed, 30 Nov 2011 17:44:21 +0100
Message-ID: <CACLukzJWL5=w59ARvwKvz+_Q81=ZJ+4qj_tU0+AxmT4g6847Sw@mail.gmail.com>
Subject: Re: [PATCH] Fix byte order problems getting PSM through btio API
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

2011/11/30 Santiago Carot-Nemesio <sancane@gmail.com>:
> ---
>  btio/btio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index a129bf9..f8c5cc7 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -882,7 +882,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>                        break;
>                case BT_IO_OPT_PSM:
>                        *(va_arg(args, uint16_t *)) = src.l2_psm ?
> -                                               src.l2_psm : dst.l2_psm;
> +                                       btohs(src.l2_psm) : btohs(dst.l2_psm);
>                        break;
>                case BT_IO_OPT_CID:
>                        *(va_arg(args, uint16_t *)) = src.l2_cid ?
> --
> 1.7.7.4
>

At a first sight, It seems there may be the same problems retrieving
CID, OMTU and IMTU on big endian architectures. I preffer waiting for
a more experienced comments before sending any patch fixing that.

Regards.
