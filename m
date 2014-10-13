Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Oct 2014 19:13:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] core: Add Manufacturer Specific Data EIR field
Message-ID: <20141013161319.GA27533@t440s.P-661HNU-F1>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
 <1413200623-31278-3-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413200623-31278-3-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Oct 13, 2014, Alfonso Acosta wrote:
> +		case EIR_MANUFACTURER_DATA:
> +			if (data_len < 2 || data_len > 2 + sizeof(eir->msd->data))
> +				break;
> +			eir->msd = g_malloc(sizeof(*eir->msd));
> +			eir->msd->company = get_le16(data);
> +			eir->msd->data_len = data_len - 2;
> +			memcpy(&eir->msd->data, data + 2, eir->msd->data_len);
> +			break;

Wouldn't this lead to a memory leaks if a device (violating the spec. but
still) had two or more manufacturer data entries in it's AD/EIR data?
Taking example from how remote name entries are handled you should
probably g_free(eir->msd) before allocating a new one.

Johan
