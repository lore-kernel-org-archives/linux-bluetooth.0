Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Feb 2012 19:23:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v2 5/8] client: terminate queued transfers properly
Message-ID: <20120226172353.GC29000@x220.P-661HNU-F1>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329832632-3681-6-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329832632-3681-6-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012, Mikel Astiz wrote:
> +static gint pending_transfer_cmptransfer(gconstpointer a, gconstpointer b)
> +{
> +	const struct pending_request *p = a;
> +	const struct obc_transfer *transfer = b;
> +
> +	return p->transfer < transfer ? -1 : (p->transfer > transfer ? 1 : 0);
> +}

Please rewrite this conditional statement into something more readable.
One has to spend much too much time trying to figure out what it does.
Since you're not using this for sorting but just for finding a specific
transfer you could just make it something like:

	if (p->transfer == transfer)
		return 0;

	return -1;

Johan
