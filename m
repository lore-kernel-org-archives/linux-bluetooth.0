Return-Path: <linux-wpan-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: use put and get unaligned functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457082621-20194-1-git-send-email-aar@pengutronix.de>
Date: Fri, 4 Mar 2016 09:10:54 -0800
Cc: linux-wpan@vger.kernel.org,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	kernel@pengutronix.de
Message-Id: <697D41BC-EF57-44A6-ACAB-18332BE3C9EB@holtmann.org>
References: <1457082621-20194-1-git-send-email-aar@pengutronix.de>
To: Alexander Aring <aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch removes the swap pointer and memmove functionality. Instead
> we use the well known put/get unaligned access with specific byte order
> handling.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> include/net/mac802154.h | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

