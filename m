Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Jul 2012 20:42:26 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] hci: Fix EIR data parsing
Message-ID: <20120728234226.GA16534@echo>
References: <1343514013-8942-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343514013-8942-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On 00:20 Sun 29 Jul, Andrzej Kaczmarek wrote:
> Data passed to ext_inquiry_data_dump are expected to start with length
> octet which was consumed by get_u8.

Good catch.

> ---
>  parser/hci.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/parser/hci.c b/parser/hci.c
> index 742a1b5..adcdaf7 100644
> --- a/parser/hci.c
> +++ b/parser/hci.c
> @@ -831,16 +831,19 @@ static inline void ext_inquiry_response_dump(int level, struct frame *frm)
>  {
>  	void *ptr = frm->ptr;
>  	uint32_t len = frm->len;
> +	uint8_t *data_ptr;

Just a nitpick, I would only change 'data_ptr' to 'data', to make it more
consistent with the parameters names that ext_inquiry_data_dump() expects.

>  	uint8_t length;
>  
> +	data_ptr = frm->ptr;
>  	length = get_u8(frm);
>  
>  	while (length > 0) {
> -		ext_inquiry_data_dump(level, frm, frm->ptr);
> +		ext_inquiry_data_dump(level, frm, data_ptr);
>  
>  		frm->ptr += length;
>  		frm->len -= length;
>  
> +		data_ptr = frm->ptr;
>  		length = get_u8(frm);
>  	}
>  
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
