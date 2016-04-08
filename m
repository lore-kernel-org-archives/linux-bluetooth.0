Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: iphc: fix handling of link-local compression
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1458132761-24055-1-git-send-email-aar@pengutronix.de>
Date: Fri, 8 Apr 2016 10:32:17 -0700
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de, jukka.rissanen@linux.intel.com
Message-Id: <38422A6C-F5B1-4AC7-B793-2CCB5569EC83@holtmann.org>
References: <1458132761-24055-1-git-send-email-aar@pengutronix.de>
To: Alexander Aring <aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch fixes handling in case of link-local address compression. A
> IPv6 link-local address is defined as fe80::/10 prefix which is also
> what ipv6_addr_type checks for link-local addresses.
> 
> But IPHC compression for link-local addresses are for fe80::/64 types
> only. This patch adds additional checks for zero padded bits in case of
> link-local address compression to match on a fe80::/64 address only.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/iphc.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

