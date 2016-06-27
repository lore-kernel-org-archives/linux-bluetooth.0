Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: ndisc: fix double read unlock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160621082719.9903-1-aar@pengutronix.de>
Date: Mon, 27 Jun 2016 08:03:54 +0200
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de, dan.carpenter@oracle.com
Message-Id: <2F025960-E3E9-4C4E-BC34-C34C575E756F@holtmann.org>
References: <20160621082719.9903-1-aar@pengutronix.de>
To: Alexander Aring <aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch removes a double unlock case to accessing neighbour private
> data.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/ndisc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

