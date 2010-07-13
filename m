Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Jul 2010 16:53:36 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Makes FindAdapter() accept lower-case hex addresses
Message-ID: <20100713195336.GA24716@jh-x301>
References: <1279046782-16444-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1279046782-16444-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Jul 13, 2010, Elvis Pfützenreuter wrote:
> ---
>  src/manager.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/manager.c b/src/manager.c
> index cbbca1e..9b90cab 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -337,7 +337,7 @@ static gint adapter_address_cmp(gconstpointer a, gconstpointer b)
>  	adapter_get_address(adapter, &bdaddr);
>  	ba2str(&bdaddr, addr);
>  
> -	return strcmp(addr, address);
> +	return strcasecmp(addr, address);

The patch is now upstream. Thanks.

Johan
