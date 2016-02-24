Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: iphc: fix stateful multicast compression
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1456311663-11438-1-git-send-email-aar@pengutronix.de>
Date: Wed, 24 Feb 2016 07:16:40 -0800
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de
Message-Id: <1DF53D6E-353F-4CE2-A47F-7CC626D18733@holtmann.org>
References: <1456311663-11438-1-git-send-email-aar@pengutronix.de>
To: Alexander Aring <aar@pengutronix.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> In case of multicast address we need to set always the LOWPAN_IPHC_M bit
> and if a destination context identifier was found for a multicast
> address then we need to set the LOWPAN_IPHC_DAC as well.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/iphc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

