Return-Path: <cyrus@holtmann.org>
Message-ID: <1415270051.2918.49.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: move skb_free from error paths
 in decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	alex.aring@gmail.com, marcel@holtmann.org
Date: Thu, 06 Nov 2014 12:34:11 +0200
In-Reply-To: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
References: <1415136981-13497-1-git-send-email-mtownsend1973@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On ti, 2014-11-04 at 21:36 +0000, Martin Townsend wrote:
> Currently we ensure that the skb is freed on every error path in IPHC
> decompression which makes it easy to introduce skb leaks.  By centralising
> the skb_free into the receive function it makes future decompression routines
> easier to maintain.  It does come at the expense of ensuring that the skb
> passed into the decompression routine must not be copied.

Tested this with real bluetooth hw and no issues were found. Just rebase
the patch with latest upstream (conflict had a very simple fix) so ack
with actions to v2.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka
