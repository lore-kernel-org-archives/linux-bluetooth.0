Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Mar 2013 19:09:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 04/16] sbc: add odd member variable to
 sbc_encoder_state
Message-ID: <20130330170906.GA29534@x220.P-661HNU-F1>
References: <1364572700-31701-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1364572700-31701-5-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1364572700-31701-5-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Mar 29, 2013, Frédéric Dalleau wrote:
> --- a/sbc/sbc_primitives.h
> +++ b/sbc/sbc_primitives.h
> @@ -40,6 +40,7 @@ struct sbc_encoder_state {
>  	int position;
>  	/* Number of consecutive blocks handled by the encoder */
>  	uint8_t increment;
> +	bool odd;

Since most of the code related on this variable uses function pointers
would it make sense to simply play with those pointers and have the odd
function set the pointer to the even function and vice versa? If this is
a performance critical part of the code it'd remove one if-statement.

Johan
