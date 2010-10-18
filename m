Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Oct 2010 17:16:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Get mode option for L2CAP sockets
Message-ID: <20101018141631.GA20917@jh-x301>
References: <1287408102-25344-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287408102-25344-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 18, 2010, Santiago Carot-Nemesio wrote:
> ---
>  btio/btio.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/btio/btio.c b/btio/btio.c
> index 2f719b1..d8439e0 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -839,6 +839,9 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>  			}
>  			memcpy(va_arg(args, uint8_t *), dev_class, 3);
>  			break;
> +		case BT_IO_OPT_MODE:
> +			*(va_arg(args, uint8_t *)) = l2o.mode;
> +			break;
>  		default:
>  			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
>  					"Unknown option %d", opt);

Pushed upstream. Thanks.

Johan
