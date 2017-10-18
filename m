Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508291477.5910.75.camel@hadess.net>
Subject: Re: [PATCH 3/9] sixaxis: Ask user whether cable configuration
 should be allowed
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Oct 2017 03:51:17 +0200
In-Reply-To: <1757680.YUP8J5zydk@ix>
References: <20170904181212.5639-1-hadess@hadess.net>
         <20170904181212.5639-3-hadess@hadess.net> <1757680.YUP8J5zydk@ix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-27 at 11:12 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On Monday, 4 September 2017 20:12:06 CEST Bastien Nocera wrote:
> > <snip>
> > +	char device_addr[18];
> 
> If this is needed only for debug then just convert address to string
> in place 
> where it is printed.

The string was in string format already when we get it from the device,
but I've switched that to pass around a bdaddr_t instead.
<snip>

> > +	closure = g_try_new0(struct authentication_closure, 1);
> 
> Just use new0() instead.

Fixed.

I've also added a btd_device_set_trusted() as well, which was bizarrely
missing from this patch. I guess it got lost when I started splitting
up the original patches.
