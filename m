Return-Path: <hideaki.yoshifuji@miraclelinux.com>
Subject: Re: [RFC 00/12] 6lowpan: introduce 6lowpan-nd
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
Cc: hideaki.yoshifuji@miraclelinux.com, kernel@pengutronix.de,
 marcel@holtmann.org, jukka.rissanen@linux.intel.com,
 hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca,
 werner@almesberger.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Patrick McHardy <kaber@trash.net>
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <57453479.9080603@miraclelinux.com>
Date: Wed, 25 May 2016 14:13:29 +0900
MIME-Version: 1.0
In-Reply-To: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=iso-2022-jp
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

Alexander Aring wrote:
> Hi,
> 
> this patch series introduces the ndisc ops callback structure to add different
> handling for IPv6 neighbour discovery cache functionality. It implements at first
> the two following use-cases:
> 
>  - 6CO handling as userspace option (For all 6LoWPAN layers, BTLE/802.15.4) [0]
>  - short address handling for 802.15.4 6LoWPAN only [1]
> 
> Since my last patch series, I completely changed the whole ndisc_ops callback
> structure to not replace the whole ndisc functionality at recv/send level of
> NS/NA/RS/RA which I send in my previous patch-series "6lowpan: introduce basic
> 6lowpan-nd". I changed it now to add different handling in a very low-level way
> of ndisc functionality.

Thank you for your work!  It looks much better now.
Some comments will follow.

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION
