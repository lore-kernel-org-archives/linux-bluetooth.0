Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: btmrvl: release sdio bus after firmware is up
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438857789-3909-1-git-send-email-akarwar@marvell.com>
Date: Thu, 6 Aug 2015 07:22:50 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Nishant Sarmukadam <nishants@marvell.com>,
	Aniket Nagarnaik <aniketn@marvell.com>
Message-Id: <B45EF8EE-27F8-4CAB-BA4F-B04C92AEBEE2@holtmann.org>
References: <1438857789-3909-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> We will not release sdio bus until firmware is completely
> downloaded and becomes ready. Our 8887 A2 chip can have
> separate firmware images for WLAN and bluetooth. This
> patch fixes an issue observed when both drivers
> simultaneously try to download respective firmwares.
> 
> Signed-off-by: Aniket Nagarnaik <aniketn@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

