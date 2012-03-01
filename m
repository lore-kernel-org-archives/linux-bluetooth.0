Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:43:23 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6] core: Make adapter_ops->set_discoverable to
 take discoverable timeout
Message-ID: <20120301014323.GD26492@x220>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 28, 2012, Luiz Augusto von Dentz wrote:
> This enables the driver to implements its own handling of the timeout
> ---
>  src/adapter.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/src/adapter.h b/src/adapter.h
> index 22bb0bb..7acd14d 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -181,7 +181,8 @@ struct btd_adapter_ops {
>  	int (*setup) (void);
>  	void (*cleanup) (void);
>  	int (*set_powered) (int index, gboolean powered);
> -	int (*set_discoverable) (int index, gboolean discoverable);
> +	int (*set_discoverable) (int index, gboolean discoverable,
> +							uint16_t timeout);
>  	int (*set_pairable) (int index, gboolean pairable);
>  	int (*set_limited_discoverable) (int index, gboolean limited);
>  	int (*start_discovery) (int index);

This would seem to introduce compilation breakage. Could you at least
do the necessary changes to hciops and mgmtops that this compiles. If
you prefer to have the moved functionality as a separate patch thats
fine but at least add the necessary new parameters to these function.

Johan
