Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] adapter: Add ConnectDevice method
Date: Mon, 19 Feb 2018 13:04:23 +0100
Message-ID: <1676489.ptRUvfTOY1@ix>
In-Reply-To: <20180216180211.GA29745@x1c>
References: <20180212215946.30909-1-szymon.janc@codecoup.pl> <20180216180211.GA29745@x1c>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Friday, 16 February 2018 19:02:11 CET Johan Hedberg wrote:
> Hi Szymon,
> 
> On Mon, Feb 12, 2018, Szymon Janc wrote:
> > +	} else {
> > +		dev->pending = create_pending_list(dev, NULL);
> > 
> > -		dev->pending = g_slist_append(dev->pending, service);
> > +		DBG("BLAH %d", g_slist_length(dev->pending));
> 
> Seems like something you forgot to remove? :)

:-)  yeah, I'll fix that :D

-- 
pozdrawiam
Szymon Janc


