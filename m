Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 16 Feb 2018 20:02:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] adapter: Add ConnectDevice method
Message-ID: <20180216180211.GA29745@x1c>
References: <20180212215946.30909-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212215946.30909-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Feb 12, 2018, Szymon Janc wrote:
> +	} else {
> +		dev->pending = create_pending_list(dev, NULL);
>  
> -		dev->pending = g_slist_append(dev->pending, service);
> +		DBG("BLAH %d", g_slist_length(dev->pending));

Seems like something you forgot to remove? :)

Otherwise the patch seems fine to me.

Johan
