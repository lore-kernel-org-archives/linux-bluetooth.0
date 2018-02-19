Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix not clearing connectable setting on power off
Date: Mon, 19 Feb 2018 10:21:57 +0100
Message-ID: <2144190.8ubbku3NdT@ix>
In-Reply-To: <20180216191749.GA4619@x1c>
References: <20180208154638.15196-1-szymon.janc@codecoup.pl> <20180216191749.GA4619@x1c>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Friday, 16 February 2018 20:17:49 CET Johan Hedberg wrote:
> Hi Szymon,
> 
> On Thu, Feb 08, 2018, Szymon Janc wrote:
> > +	/* if timeout was set kernel clears discoverable on its own */
> > +	if (!adapter->discoverable_timeout)
> > +		return;
> 
> Isn't this condition inverted? I.e. you want to call Set Connectable if
> the timeout is 0?

No, the check is correct but comment should be better I suppose.

The thing is that with timeout enabled kernel will clear only discoverable 
flag leaving connectabled enabled. If timeout is not set both flags are 
persistent over power toggle (which is OK). So intention of this patch is to 
fix 'dangling' connectable flag in case of powering off discoverable adapter 
with timeout set.

I'll send V2 with udpated comment.

-- 
pozdrawiam
Szymon Janc


