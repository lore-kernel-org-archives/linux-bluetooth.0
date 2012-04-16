Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 12:19:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Bluetooth: mgmt: Add helper function for Address
 Type
Message-ID: <20120416091944.GA25476@x220.P-661HNU-F1>
References: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334567093-15058-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Apr 16, 2012, Hemant Gupta wrote:
> +static u8 mgmt_to_link(u8 link_type, u8 addr_type)
> +{
> +	switch (link_type) {
> +	case LE_LINK:
> +		switch (addr_type) {
> +		case MGMT_ADDR_LE_PUBLIC:
> +			return ADDR_LE_DEV_PUBLIC;
> +
> +		default:
> +			/* Fallback to LE Random address type */
> +			return ADDR_LE_DEV_RANDOM;
> +		}
> +
> +	default:
> +		/* Fallback to BR/EDR type */
> +		return ACL_LINK;
> +	}
> +}

This isn't right. The mgmt address type includes all possible address
types in it, i.e. the input to this function should be a single value
and the output should be two separate values (just like link_to_mgmt has
two inputs and one output).

However, I'm not sure you even need this generic helper here since you
only have a single user for it and it's restricted to LE only. If we get
more users then we can consider it, but for now either do the conversion
inline or do an LE specific helper:

static u8 mgmt_to_le(u8 mgmt_type)
{
	switch (mgmt_type) {
	case MGMT_ADDR_LE_PUBLIC:
		return ADDR_LE_DEV_PUBLIC;
	case MGMT_ADDR_LE_RANDOM:
	default:
		return ADDR_LE_DEV_RANDOM;
}

Johan
