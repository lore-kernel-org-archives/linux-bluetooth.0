Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 May 2011 14:15:37 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove btio.c compilation warning
Message-ID: <20110502211537.GA17551@jh-x301>
References: <y>
 <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

On Mon, May 02, 2011, anderson.briglia@openbossa.org wrote:
> This patch fixes a compilation warning regarding btio/btio.c
> compilation.
> ---
>  btio/btio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/btio/btio.c b/btio/btio.c
> index 6d71b90..8f166cc 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -800,7 +800,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>  	uint8_t dev_class[3];
>  	uint16_t handle;
>  	socklen_t len;
> -	gboolean flushable;
> +	gboolean flushable = TRUE;
>  
>  	len = sizeof(l2o);
>  	memset(&l2o, 0, len);

I don't get the warning with my compiler, so in addition to the already
requested compiler logs please also mention the compiler version. Also,
the value should default to FALSE and not TRUE.

Johan
