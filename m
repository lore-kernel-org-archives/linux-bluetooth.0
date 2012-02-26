Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Feb 2012 19:26:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 7/8] client: fix canceling queued transfers
Message-ID: <20120226172603.GD29000@x220.P-661HNU-F1>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012, Mikel Astiz wrote:
> -	if (transfer->xfer == 0)
> -		return;
> +	if (transfer->xfer != 0) {
> +		g_obex_cancel_transfer(transfer->xfer);
> +		transfer->xfer = 0;
> +	}

Could you make the tests for a valid source ID > 0 instead of != 0. I
know it doesn't make much difference but it'd be consistent with that
we've tried to use elsewhere in obexd and bluez.

Btw, other than patches 5 and 7 where I had something to point out the
other ones have already been pushed upstream, so no need to resend them.

Johan
