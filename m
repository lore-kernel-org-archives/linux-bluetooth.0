Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Oct 2014 19:30:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alfonso Acosta <fons@spotify.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] core: Add Manufacturer Specific Data EIR field
Message-ID: <20141013163050.GA28130@t440s.P-661HNU-F1>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
 <1413200623-31278-3-git-send-email-fons@spotify.com>
 <20141013161319.GA27533@t440s.P-661HNU-F1>
 <D4814A57-3BAC-43BC-8C39-447FADE29B79@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4814A57-3BAC-43BC-8C39-447FADE29B79@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 13, 2014, Marcel Holtmann wrote:
> Hi Johan,
> 
> >> +		case EIR_MANUFACTURER_DATA:
> >> +			if (data_len < 2 || data_len > 2 + sizeof(eir->msd->data))
> >> +				break;
> >> +			eir->msd = g_malloc(sizeof(*eir->msd));
> >> +			eir->msd->company = get_le16(data);
> >> +			eir->msd->data_len = data_len - 2;
> >> +			memcpy(&eir->msd->data, data + 2, eir->msd->data_len);
> >> +			break;
> > 
> > Wouldn't this lead to a memory leaks if a device (violating the spec. but
> > still) had two or more manufacturer data entries in it's AD/EIR data?
> > Taking example from how remote name entries are handled you should
> > probably g_free(eir->msd) before allocating a new one.
> 
> have multiple manufacturer data entries is not violating the
> specification. That is actually valid.

Right you are. I was somehow assuming this would be similar to e.g. the
UUID fields. Anyway, if we want to represent in the new internal API all
that is allowed in the spec it'd need some redesign. OTOH, I'm not sure
it's worth it until we have an example of an actual product that has
multiple entries).

Johan
