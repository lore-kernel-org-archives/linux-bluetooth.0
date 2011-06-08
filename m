Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 11:26:10 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next v3 07/16] Bluetooth: Add SMP confirmation checks
 methods
Message-ID: <20110608022610.GA2772@dell.ccr.corp.intel.com>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
 <1307483205-1518-8-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307483205-1518-8-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius/Anderson,

On Tue, Jun 07, 2011, Vinicius Costa Gomes wrote:
> +	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
> +			conn->src, 0, conn->dst, res);

The third last parameter is the remote address type and you're
hard-coding it to 0 (public) here. This means that we cannot pair with a
device with a random address. I suppose you should be passing
conn->hcon->dst_type instead.

> +		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
> +					0, conn->dst, 0, conn->src, res);

Same here.

> +	if (conn->hcon->out)
> +		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
> +				conn->src, 0, conn->dst, res);
> +	else
> +		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
> +				conn->dst, 0, conn->src, res);

And here.

You're also hard-coding the local address type to public, but that's a
less severe issue (for now).

Johan
