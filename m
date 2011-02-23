Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 11:51:12 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix typo on DBG() string format
Message-ID: <20110223145112.GC26355@jh-x301>
References: <1298464037-10700-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298464037-10700-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 23, 2011, Anderson Lizardo wrote:
> ---
>  attrib/client.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/attrib/client.c b/attrib/client.c
> index 0f9ba3e..4635c75 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -299,7 +299,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
>  						NULL, NULL, NULL);
>  	case ATT_OP_HANDLE_NOTIFY:
>  		if (characteristic_set_value(chr, &pdu[3], len - 3) < 0)
> -			DBG("Can't change Characteristic %0x02x", handle);
> +			DBG("Can't change Characteristic 0x%02x", handle);
>  
>  		g_slist_foreach(prim->watchers, update_watchers, chr);
>  		break;

Good catch. The patch has been pushed upstream.

Johan
