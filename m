Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jul 2010 13:39:34 -0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix signal strength for HFP in maemo6 telephony due to
 changed API in libcsnet.
Message-ID: <20100709163934.GA3685@jh-x301>
References: <1278686657-6997-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278686657-6997-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

Congrats on your first patch submission! However, there are a few things
that need fixing:

On Fri, Jul 09, 2010, Dmitriy Paliy wrote:
> Signed-off-by: Dmitriy Paliy <dmitriy.paliy@nokia.com>

We don't use Signed-off-by in user space BlueZ, so please remove it.
Also make sure that your commit message lines don't exceed 74
characters. When you do "git log" on a 80-character wide terminal the
message should be propertly viewable. In this case the summary line
could just be "Fix signal strength for HFP in maemo6 telephony driver"
and then in the body of the commit message (which is encouraged to have
for any non-trivial commits) you can have a proper explanation of how
the csd API has changed. In general, being too verbose in the commit
message is less bad than not being verbose enough.

> -	.signals_bar = 0,
> +	.signal_bars = 0,	/* Init as 0 meaning inactive mode. In modem power off state it can */
> +				/* be -1, but we treat all values as 0s regardless inactive or power off. */

No over 79 character lines in the code please. In this case you can just
put the comment above instead of on the same line.

> -	{ "signal",	"0-5",	0,	TRUE },
> +	{ "signal",	"0-5",	0,	TRUE },			/* signal strength in terms of bars */

Same here.

> +	if (signal_strength_bars < 0) {
> +		DBG("signal strength bars smaller than expected: %d", signal_strength_bars);
> +		signal_strength_bars = 0;
> +	} else if (signal_strength_bars > 5) {
> +		DBG("signal strength bars greater than expected: %d", signal_strength_bars);
> +		signal_strength_bars = 5;

The DBG lines look like they're over 79 too.

Johan
