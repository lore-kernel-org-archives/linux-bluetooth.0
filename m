Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Sep 2012 11:08:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 02/18] eir: Add support for parsing SSP hash and
 randomizer
Message-ID: <20120924080845.GA19184@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
 <1348230995-8967-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348230995-8967-3-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 21, 2012, Szymon Janc wrote:
> +		case EIR_SSP_HASH:
> +			if (data_len < 16)
> +				break;
> +			eir->hash = g_malloc(16);
> +			memcpy(eir->hash, data, 16);
> +			break;
> +
> +		case EIR_SSP_RANDOMIZER:
> +			if (data_len < 16)
> +				break;
> +			eir->randomizer = g_malloc(16);
> +			memcpy(eir->randomizer, data, 16);
> +			break;

I suppose using g_memdup would be simpler than g_malloc + memcpy.

Johan
