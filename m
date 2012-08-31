Return-Path: <cyrus@holtmann.org>
Message-ID: <1346429676.23377.22.camel@aeonflux>
Subject: Re: [RFC 03/15] sdp: Use helper functions instead of
 bt_get_unaligned macro
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 31 Aug 2012 09:14:36 -0700
In-Reply-To: <1346402185-9487-4-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
	 <1346402185-9487-4-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This fix number of compilation errors on ARM similar to one below.
> 
> lib/sdp.c: In function 'sdp_uuid_extract':
> lib/sdp.c:1019:27: error: cast increases required alignment
> 	of target type [-Werror=cast-align]
> lib/sdp.c:1019:27: error: cast increases required alignment
> 	of target type [-Werror=cast-align]
> lib/sdp.c:1026:27: error: cast increases required alignment
> 	of target type [-Werror=cast-align]
> lib/sdp.c:1026:27: error: cast increases required alignment
> 	of target type [-Werror=cast-align]
> 
> Change-Id: I587fb99328d7e5b9053af81597bd48b3a4e610ad
> ---
>  lib/sdp.c |   56 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 36b4d08..d40500f 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -376,27 +376,27 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
>  		d->unitSize += sizeof(int8_t);
>  		break;
>  	case SDP_UINT16:
> -		d->val.uint16 = bt_get_unaligned((uint16_t *) value);
> +		d->val.uint16 = bt_get_16(value);
>  		d->unitSize += sizeof(uint16_t);
>  		break;

I do not like this. Either we use be16 here and store it in the native
endian converted from the protocol endian or we leave it as it is.

I want clear get_le16 and get_be16 and not another get_16. That just
makes the code hard to read.

Regards

Marcel


