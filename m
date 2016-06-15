Return-Path: <hideaki.yoshifuji@miraclelinux.com>
Subject: Re: [PATCHv3 net-next 00/12] 6lowpan: introduce 6lowpan-nd
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org,
 davem@davemloft.net
References: <20160614115239.17788-1-aar@pengutronix.de>
Cc: hideaki.yoshifuji@miraclelinux.com, kernel@pengutronix.de,
 marcel@holtmann.org, jukka.rissanen@linux.intel.com,
 hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca,
 werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <5761361F.5050406@miraclelinux.com>
Date: Wed, 15 Jun 2016 20:03:59 +0900
MIME-Version: 1.0
In-Reply-To: <20160614115239.17788-1-aar@pengutronix.de>
Content-Type: text/plain; charset=iso-2022-jp
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Alexander Aring wrote:
> Alexander Aring (12):
>   6lowpan: add private neighbour data
>   6lowpan: add 802.15.4 short addr slaac
>   6lowpan: remove ipv6 module request
>   ndisc: add __ndisc_opt_addr_space function
>   ndisc: add __ndisc_opt_addr_data function
>   ndisc: add __ndisc_fill_addr_option function
>   addrconf: put prefix address add in an own function
>   ipv6: introduce neighbour discovery ops
>   ipv6: export several functions
>   6lowpan: introduce 6lowpan-nd
>   6lowpan: add support for getting short address
>   6lowpan: add support for 802.15.4 short addr handling
> 
>  include/linux/netdevice.h     |   8 +-
>  include/net/6lowpan.h         |  16 +++
>  include/net/addrconf.h        |  10 ++
>  include/net/ndisc.h           | 248 +++++++++++++++++++++++++++++++++++++++---
>  net/6lowpan/6lowpan_i.h       |   4 +
>  net/6lowpan/Makefile          |   2 +-
>  net/6lowpan/core.c            |  50 ++++++++-
>  net/6lowpan/debugfs.c         |  39 +++++++
>  net/6lowpan/iphc.c            | 167 +++++++++++++++++++++++-----
>  net/6lowpan/ndisc.c           | 234 +++++++++++++++++++++++++++++++++++++++
>  net/ieee802154/6lowpan/core.c |  12 ++
>  net/ieee802154/6lowpan/tx.c   | 113 +++++++++----------
>  net/ipv6/addrconf.c           | 218 +++++++++++++++++++++----------------
>  net/ipv6/ndisc.c              | 123 +++++++++++++--------
>  net/ipv6/route.c              |   8 +-
>  15 files changed, 1004 insertions(+), 248 deletions(-)
>  create mode 100644 net/6lowpan/ndisc.c
> 

Looks good to me.

Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION
