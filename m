Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 02:22:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: Re: [PATCH 2/2 v2] Bluetooth: btmrvl: add support for SDIO
 suspend/resume callbacks
Message-ID: <20120503052248.GF16030@joana>
References: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

* Bing Zhao <bzhao@marvell.com> [2012-04-25 11:43:54 -0700]:

> From: Amitkumar Karwar <akarwar@marvell.com>
> 
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

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
