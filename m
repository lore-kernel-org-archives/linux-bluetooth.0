Return-Path: <cyrus@holtmann.org>
Message-ID: <1348843511.13371.29.camel@aeonflux>
Subject: Re: [PATCH 2/5] Add support for mSBC frame header
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 28 Sep 2012 16:45:11 +0200
In-Reply-To: <1348757068-31048-3-git-send-email-frederic.dalleau@linux.intel.com>
References: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1348757068-31048-3-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> mSBC modifies header so that it contains: OxAD 0x00 0x00.
> The first bytes allows to distinguish mSBC packets from standard SBC
> packets used in A2DP. The two zero bytes are reserved for future definition.
> ---
>  sbc/sbc.c |  104 +++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 63 insertions(+), 41 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index 7e4faa0..131755b 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -407,55 +407,71 @@ static int sbc_unpack_frame(sbc_t *sbc, const uint8_t *data,
>  	if (len < 4)
>  		return -1;
>  
> -	if (data[0] != SBC_SYNCWORD)
> -		return -2;
> -
> -	frame->frequency = (data[1] >> 6) & 0x03;
> +	if (sbc->flags & SBC_MSBC) {
> +		if (data[0] != MSBC_SYNCWORD)
> +			return -2;
> +		if (data[1] != 0)
> +			return -5;
> +		if (data[2] != 0)
> +			return -6;

I am getting the felling that just splitting this into separate
unpack_sbc_frame and unpack_msbc_frame would make this a lot cleaner
instead of keeping to check if mSBC flag or not is set.

We might even include a function callback in sbc_t where we on sbc_init
just select one or the other. No need to keep repeating that check for
every single frame. As far as I can tell, you never can switch from SBC
to mSBC or vice-versa anyway.

With that you also would not need to change the function prototype to
include sbc_t at all.

Regards

Marcel


