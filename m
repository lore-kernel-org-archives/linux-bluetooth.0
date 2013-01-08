Return-Path: <cyrus@holtmann.org>
Message-ID: <1357672384.1806.34.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/2] lib: Fix SDP_TEXT_STR16/SDP_URL_STR16 parsing
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 11:13:04 -0800
In-Reply-To: <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> sdp_extract_attr() uses the "size" parameter to return the number of
> bytes consumed when parsing SDP Data Elements. This size is used to
> advance a buffer pointer to parse next element.
> 
> This size was being incorrectly calculated for
> SDP_TEXT_STR16/SDP_URL_STR16, where the string length was added twice.
> 
> A unit test added on the previous commit should now pass with this fix.
> ---
>  lib/sdp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index ca474cd..b87f392 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -1176,7 +1176,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
>  		}
>  		n = bt_get_be16(p);
>  		p += sizeof(uint16_t);
> -		*len += sizeof(uint16_t) + n;
> +		*len += sizeof(uint16_t);

I do not get this fix. Isn't this str8 and url8 part wrong?

Regards

Marcel




