Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 May 2012 13:22:09 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Adds definitions for AMP Assoc data
Message-ID: <20120508202209.GA10294@x220.hpllc.com>
References: <1336470247-1646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336470247-1646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, May 08, 2012, Andrei Emeltchenko wrote:
>  #define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
>  #define A2MP_STATUS_SECURITY_VIOLATION			0x06
>  
> +#define MAC_ADDR_TYPE		1
> +#define PREF_CHANLIST_TYPE	2
> +#define CONNECTED_CHAN		3
> +#define PAL_CAP_TYPE		4
> +#define PAL_VER_INFO		5
> +
> +struct tlv {
> +	uint8_t type;
> +	uint16_t len;
> +	uint8_t val[0];
> +} __attribute__ ((packed));
> +
> +struct pal_ver {
> +	uint8_t ver;
> +	uint16_t company_id;
> +	uint16_t sub_ver;
> +} __attribute__ ((packed));
> +
> +struct country_triplet {
> +	union {
> +		struct {
> +			uint8_t first_channel;
> +			uint8_t num_channels;
> +			int8_t max_power;
> +		} __attribute__ ((packed)) chans;
> +		struct {
> +			uint8_t reg_extension_id;
> +			uint8_t reg_class;
> +			uint8_t coverage_class;
> +		} __attribute__ ((packed)) ext;
> +	};
> +} __attribute__ ((packed));
> +
> +struct chan_list {
> +	uint8_t country_code[3];
> +	struct country_triplet triplets[0];
> +} __attribute__ ((packed));

Everything in this file is name-spaced with A2MP_ or a2mp_. Please
follow that convention.

Johan
