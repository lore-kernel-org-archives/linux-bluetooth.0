Return-Path: <cyrus@holtmann.org>
Message-ID: <1336020695.5970.33.camel@aeonflux>
Subject: Re: [PATCH 2/2 v2] Bluetooth: btmrvl: add support for SDIO
 suspend/resume callbacks
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Date: Thu, 03 May 2012 06:51:35 +0200
In-Reply-To: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
References: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> Host sleep is activated using already configured host sleep
> parameters in suspend handler and it is cancelled in resume
> handler.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> v2: remove '\n' at end of BT_DBG, BT_ERR. (Marcel Holtmann)
> 
>  drivers/bluetooth/btmrvl_drv.h  |    2 +
>  drivers/bluetooth/btmrvl_main.c |    3 +-
>  drivers/bluetooth/btmrvl_sdio.c |  100 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


