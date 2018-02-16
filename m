Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 16 Feb 2018 21:17:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix not clearing connectable setting on power
 off
Message-ID: <20180216191749.GA4619@x1c>
References: <20180208154638.15196-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208154638.15196-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 08, 2018, Szymon Janc wrote:
> +	/* if timeout was set kernel clears discoverable on its own */
> +	if (!adapter->discoverable_timeout)
> +		return;

Isn't this condition inverted? I.e. you want to call Set Connectable if
the timeout is 0?

Johan
