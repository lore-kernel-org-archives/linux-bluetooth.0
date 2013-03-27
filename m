Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 11/17] sbc: Add SBC_MSBC flag to enable 15 block encoding
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362565163-3567-12-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 19:23:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7B617435-AB55-4EA9-8FD8-4C6DEF6C3DB1@holtmann.org>
References: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com> <1362565163-3567-12-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch defines the SBC_MSBC flag. The purpose of this flag is to encode 15
> blocks. It is private to the library and can't be set from standard API.
> sbc_init_msbc() function will be defined to set this flag.
> ---
> sbc/sbc.c |   38 ++++++++++++++++++++++++++++++--------
> 1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/sbc/sbc.c b/sbc/sbc.c
> index ffdf05d..631072e 100644
> --- a/sbc/sbc.c
> +++ b/sbc/sbc.c
> @@ -52,6 +52,10 @@
> 
> #define SBC_SYNCWORD	0x9C
> 
> +#define SBC_MSBC	0x01

can we get rid of SBC_MSBC. It is confusing.

> +#define MSBC_SYNCWORD	0xAD
> +#define MSBC_BLOCKS	15
> +
> /* This structure contains an unpacked SBC frame.
>    Yes, there is probably quite some unused space herein */
> struct sbc_frame {
> @@ -903,18 +907,22 @@ static ssize_t sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len
> 	}
> }
> 
> -static void sbc_encoder_init(struct sbc_encoder_state *state,
> -					const struct sbc_frame *frame)
> +static void sbc_encoder_init(unsigned long flags, unsigned long pflags,
> +		struct sbc_encoder_state *state, const struct sbc_frame *frame)
> {
> 	memset(&state->X, 0, sizeof(state->X));
> 	state->position = (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
> -	state->increment = 4;
> +	if (pflags & SBC_MSBC)
> +		state->increment = 1;
> +	else
> +		state->increment = 4;

This pflags thing seems not a good idea. Can we not just hand over the increment value.

Regards

Marcel

