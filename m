Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 10:26:04 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Bluetooth: Add option for SCO socket mode
Message-ID: <20130201162604.GA24448@x220>
References: <1359561800-12870-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1359561800-12870-2-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1359561800-12870-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Jan 30, 2013, Frédéric Dalleau wrote:
> +#define SCO_MODE_CVSD		0x00
> +#define SCO_MODE_TRANSPARENT	0x01
> +#define SCO_MODE_MAX            0x02

If you're going to have a MAX define better make it the real maximum
instead of max + 1.

> +		if (opts.mode >= SCO_MODE_MAX) {
> +			err = -EINVAL;
> +			break;
> +		}

It makes this check also look a bit nicer since you use > instead of >=

Johan
