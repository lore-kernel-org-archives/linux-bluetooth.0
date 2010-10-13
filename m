Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 17:24:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adjust mce_bt_set flag to gboolean type values
Message-ID: <20101013142403.GC4828@jh-x301>
References: <1286975300-2832-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286975300-2832-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Oct 13, 2010, Rafal Michalski wrote:
> -		mce_bt_set = !!(sigvalue & MCE_RADIO_STATE_BLUETOOTH);
> +		mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH ?
> +								TRUE : FALSE;

Ok, that's basically a coding style fix.

> -	mce_bt_set = radio_states & MCE_RADIO_STATE_BLUETOOTH;
> +	mce_bt_set = radio_states & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;

And that's a clear bug fix (since there's no guarantee that the binary
and results in the value 1 or TRUE).

In principle I'd prefer having coding style patches separate from real
bug fixes (even for trivial changes), but since these are related I've
let it go for now and pushed the patch upstream.

Johan
