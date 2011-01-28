Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Jan 2011 18:09:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] HDP: reject MDL reconnection with different MTU
Message-ID: <20110128160954.GA1209@jh-x301>
References: <1295005808-9885-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295005808-9885-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Fri, Jan 14, 2011, Elvis Pf??tzenreuter wrote:
> This patch implements refusal of a MDL reconnection if the new L2CAP
> connection presents a different MTU. Accordingly to HDP spec. item 3.5.
> 
> It aims to pass the TC_SNK_HCT_BV_07_C PTS test. (It does not pass yet
> because PTS itself seems to have issues. See tickets 7212, 7214 and
> 7244 for details.)
> ---
>  health/hdp.c       |   21 +++++++++++++++++++--
>  health/hdp_types.h |    2 ++
>  2 files changed, 21 insertions(+), 2 deletions(-)

Sorry for missing this one earlier, it's now pushed upstream with a
minor rewrite of the following to a proper if-statement to make is more
readable (at least in my mind):

> +	return chan->imtu == imtu && chan->omtu == omtu;

Johan
