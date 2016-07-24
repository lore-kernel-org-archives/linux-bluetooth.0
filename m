Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 2/2] 6lowpan: ndisc: no overreact if no short address is available
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160724141225.17591-2-aar@pengutronix.de>
Date: Sun, 24 Jul 2016 18:42:33 +0200
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de,
	linux-bluetooth@vger.kernel.org
Message-Id: <B40D8264-956A-43FB-A6A3-670E428486D9@holtmann.org>
References: <20160724141225.17591-1-aar@pengutronix.de> <20160724141225.17591-2-aar@pengutronix.de>
To: Alexander Aring <aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch removes handling to remove short address for a neigbour entry
> if RS/RA/NS/NA doesn't contain a short address. If these messages
> doesn't has any short address option, the existing short address from
> ndisc cache will be used. The current behaviour will set that the
> neigbour doesn't has a short address anymore.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/ndisc.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

