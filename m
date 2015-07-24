Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>,
	"linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] core/advertising: Fix byte order for MGMT_OP_ADD_ADVERTISING flags
In-Reply-To: <55AF7668.7030903@ubnt.com>
References: <55AF7668.7030903@ubnt.com>
Date: Fri, 24 Jul 2015 14:55:46 -0300
Message-ID: <87pp3h4ezh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Andrejs Hanins <andrejs.hanins@ubnt.com> writes:

> Fix byte order for MGMT_OP_ADD_ADVERTISING flags
> ---
>  src/advertising.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks good.

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
> --
> 1.9.1


Cheers,
--
Vinicius
