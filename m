Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 17 Mar 2016 10:02:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/advertising: Fix byte order for
 MGMT_OP_ADD_ADVERTISING flags
Message-ID: <20160317080201.GA24997@t440s>
References: <55AF7668.7030903@ubnt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AF7668.7030903@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 22, 2015, Andrejs Hanins wrote:
> Fix byte order for MGMT_OP_ADD_ADVERTISING flags
> ---
>  src/advertising.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/advertising.c b/src/advertising.c
> index d56b7a2..8c249d1 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -500,7 +500,7 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
>  		return btd_error_failed(ad->reg, "Failed");
>  	}
>  
> -	cp->flags = flags;
> +	cp->flags = htobl(flags);
>  	cp->instance = ad->instance;
>  	cp->adv_data_len = adv_data_len;
>  	memcpy(cp->data, adv_data, adv_data_len);

I'm surprised you never pinged about this forgotten patch (which I
noticed now when cleaning up my linux-bluetooth folder). Anyway, the
patch has been applied. Thanks.

Johan
