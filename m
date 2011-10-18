Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH obexd] gobex: add missing checks for config.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 18 Oct 2011 08:51:06 -0700
In-Reply-To: <1318925545-4128-1-git-send-email-luiz.dentz@gmail.com>
References: <1318925545-4128-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318953068.15441.124.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>  gobex/gobex-defs.c   |    4 ++++
>  gobex/gobex-header.c |    4 ++++
>  gobex/gobex-packet.c |    4 ++++
>  3 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/gobex/gobex-defs.c b/gobex/gobex-defs.c
> index f1f3b38..beb773d 100644
> --- a/gobex/gobex-defs.c
> +++ b/gobex/gobex-defs.c
> @@ -19,6 +19,10 @@
>   *
>   */
>  
> +#ifdef HAVE_CONFIG_H
> +# include "config.h"

what is this space between # and include doing here. Please remove that.

And it is <config.h> and not "config.h".

Regards

Marcel


