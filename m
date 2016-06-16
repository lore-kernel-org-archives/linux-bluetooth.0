Return-Path: <hannes@stressinduktion.org>
Subject: Re: [PATCHv4 net-next 07/12] addrconf: put prefix address add in an
 own function
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <20160615192027.4064-1-aar@pengutronix.de>
 <20160615192027.4064-8-aar@pengutronix.de>
Cc: kernel@pengutronix.de, marcel@holtmann.org,
 jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca,
 werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Patrick McHardy <kaber@trash.net>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <0909dcd8-cf31-4a68-6e84-8a8fcf1906c1@stressinduktion.org>
Date: Thu, 16 Jun 2016 12:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160615192027.4064-8-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 15.06.2016 21:20, Alexander Aring wrote:
> This patch moves the functionality to add a RA PIO prefix generated
> address in an own function. This move prepares to add a hook for
> adding a second address for a second link-layer address. E.g. short
> address for 802.15.4 6LoWPAN.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: James Morris <jmorris@namei.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: Patrick McHardy <kaber@trash.net>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>

Ah, I noticed I am too late for the Acks but go through the rest of the
series anyway. :)
