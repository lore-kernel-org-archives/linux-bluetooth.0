Return-Path: <hannes@stressinduktion.org>
Subject: Re: [PATCHv2 bluetooth-next 04/10] ndisc: add addr_len parameter to
 ndisc_opt_addr_space
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
 <1461140382-4784-5-git-send-email-aar@pengutronix.de>
Cc: kernel@pengutronix.de, marcel@holtmann.org,
 jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca,
 werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Patrick McHardy <kaber@trash.net>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <109698cb-18ae-abdb-34a5-1db5a2e8dc6b@stressinduktion.org>
Date: Mon, 2 May 2016 21:37:14 +0200
MIME-Version: 1.0
In-Reply-To: <1461140382-4784-5-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 20.04.2016 10:19, Alexander Aring wrote:
> This patch makes the address length as argument for the
> ndisc_opt_addr_space function. This is necessary to handle addresses
> which don't use dev->addr_len as address length.

Would it make sense for patch 4, 5 and 6 to add the operation to ndisc_ops?

Thanks,
Hannes
