Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 1/2] core: Add Manufacturer Specific Data EIR field
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141013161319.GA27533@t440s.P-661HNU-F1>
Date: Mon, 13 Oct 2014 18:18:51 +0200
Cc: Alfonso Acosta <fons@spotify.com>, linux-bluetooth@vger.kernel.org
Message-Id: <D4814A57-3BAC-43BC-8C39-447FADE29B79@holtmann.org>
References: <1413200623-31278-1-git-send-email-fons@spotify.com> <1413200623-31278-3-git-send-email-fons@spotify.com> <20141013161319.GA27533@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +		case EIR_MANUFACTURER_DATA:
>> +			if (data_len < 2 || data_len > 2 + sizeof(eir->msd->data))
>> +				break;
>> +			eir->msd = g_malloc(sizeof(*eir->msd));
>> +			eir->msd->company = get_le16(data);
>> +			eir->msd->data_len = data_len - 2;
>> +			memcpy(&eir->msd->data, data + 2, eir->msd->data_len);
>> +			break;
> 
> Wouldn't this lead to a memory leaks if a device (violating the spec. but
> still) had two or more manufacturer data entries in it's AD/EIR data?
> Taking example from how remote name entries are handled you should
> probably g_free(eir->msd) before allocating a new one.

have multiple manufacturer data entries is not violating the specification. That is actually valid.

Regards

Marcel

