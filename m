Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Feb 2011 15:09:09 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update gatt listen mode.
Message-ID: <20110208230909.GC17287@jh-x301>
References: <1297109496-26609-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1297109496-26609-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Mon, Feb 07, 2011, Andre Dieb Martins wrote:
> Update gatt's listen-mode flag whenever connect_cb() is called again.
> ---
>  attrib/client.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/attrib/client.c b/attrib/client.c
> index 44638d3..ec5fcf2 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -356,6 +356,7 @@ static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
>  
>  	if (gatt->attrib != NULL) {
>  		gatt->attrib = g_attrib_ref(gatt->attrib);
> +		gatt->listen = listen;
>  		return 0;
>  	}

Thanks. The patch has been pushed upstream.

Johan
