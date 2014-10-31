Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2014 12:34:56 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] gatt: Fix wrong function exit
Message-ID: <20141031103454.GA13697@aemeltch-mobl1.fi.intel.com>
References: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414509602-2534-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Tue, Oct 28, 2014 at 05:20:01PM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  src/shared/gatt-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index d751d5a..4f53de3 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -1029,7 +1029,7 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
>  		data = new_read_included(cur_result);
>  		if (!data) {
>  			success = false;
> -			goto done;
> +			goto failed;
>  		}
>  
>  		read_included(data);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
