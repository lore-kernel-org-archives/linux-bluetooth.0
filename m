Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:52:55 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Frank Huang <frankh@marvell.com>
Subject: Re: [PATCH] Bluetooth: btmrvl: support Marvell Bluetooth device
 SD8797
Message-ID: <20111121155255.GD2552@joana>
References: <1321504842-11199-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321504842-11199-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

* Bing Zhao <bzhao@marvell.com> [2011-11-16 20:40:42 -0800]:

> The SD8797 firmware image is shared with mwifiex driver.
> Whoever gets loaded first will be responsible for firmware
> downloading.
> 
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Signed-off-by: Frank Huang <frankh@marvell.com>
> ---
>  drivers/bluetooth/Kconfig       |    6 +++---
>  drivers/bluetooth/btmrvl_sdio.c |   15 +++++++++++++--
>  2 files changed, 16 insertions(+), 5 deletions(-)

Applied, thanks.

	Gustavo
