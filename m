Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Nov 2014 11:04:31 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] shared/gatt: Fix dereference before NULL check
 warnings
Message-ID: <20141127090425.GB29443@aemeltch-MOBL1>
References: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416489195-26477-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Thu, Nov 20, 2014 at 03:13:14PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add NULL check otherwise constructions like below give warnings:
> ...
> 	uint8_t pdu[4 + get_uuid_len(uuid)];
> 
> 	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
> ...
> ---
>  src/shared/gatt-helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index d0bee3f..dc4a8e8 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -588,6 +588,9 @@ static void put_uuid_le(const bt_uuid_t *src, void *dst)
>  
>  static inline int get_uuid_len(const bt_uuid_t *uuid)
>  {
> +	if (!uuid)
> +		return 0;
> +
>  	return (uuid->type == BT_UUID16) ? 2 : 16;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
