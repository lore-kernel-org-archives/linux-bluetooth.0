Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Apr 2011 15:38:48 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, Kevin Gan <ganhy@marvell.com>,
	Tristan Xu <xurf@marvell.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Stefan A. Popa" <stefan.a.popa@intel.com>
Subject: Re: [PATCH] Bluetooth: btmrvl: support Marvell Bluetooth device
 SD8787
Message-ID: <20110411183848.GD2195@joana>
References: <1302311973-10715-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302311973-10715-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

* Bing Zhao <bzhao@marvell.com> [2011-04-08 18:19:33 -0700]:

> From: Kevin Gan <ganhy@marvell.com>
> 
> The SD8787 firmware image is shared with mwifiex driver.
> Whoever gets loaded first will be responsible for firmware
> downloading.
> 
> Signed-off-by: Kevin Gan <ganhy@marvell.com>
> Signed-off-by: Tristan Xu <xurf@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/Kconfig       |    4 +-
>  drivers/bluetooth/btmrvl_sdio.c |  124 +++++++++++++++++++++++++++++---------
>  drivers/bluetooth/btmrvl_sdio.h |   68 +++++++++++----------
>  3 files changed, 132 insertions(+), 64 deletions(-)

Patch is now applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
