Return-Path: <cyrus@holtmann.org>
Message-ID: <1438174313.2896.211.camel@linux.intel.com>
Subject: Re: btle 6lowpan races
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Date: Wed, 29 Jul 2015 15:51:53 +0300
In-Reply-To: <20150729123802.GA31129@omega>
References: <20150729123802.GA31129@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On ke, 2015-07-29 at 14:38 +0200, Alexander Aring wrote:
> Hi Jukka,
> 
> I think it's bad for filling data for btle lowpan private data at point [0].
> This is called after register_netdev and the rtnl_lock isn't hold after
> calling "register_netdev" anymore which ends in a possible interface up
> between register and filling lowpan_dev information. The result would be
> that lowpan_dev is readed somewhere where it isn't filled.
> 
> The solution would be simple move the filling between alloc and register of
> netdev.

Yes, that makes sense.

> 
> If you like I can prepare patches for that.

Sure, patches are welcome.

> 
> Any thoughts on this?
> 
> - Alex
> 
> [0] http://lxr.free-electrons.com/source/net/bluetooth/6lowpan.c#L874


Cheers,
Jukka


