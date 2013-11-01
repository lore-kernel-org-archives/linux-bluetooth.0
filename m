Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH v2 1/2] Bluetooth: btmrvl: use cal-data from device-tree instead of conf file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383344905-3525-1-git-send-email-bzhao@marvell.com>
Date: Fri, 1 Nov 2013 23:39:19 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mike Frysinger <vapier@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <1F44CB18-76B3-4A5D-8107-53808A67CC78@holtmann.org>
References: <1383344905-3525-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> Some ARM versions of Chromebook need to download a new calibration
> data from host driver to firmware. They do have EEPROM but still
> need a piece of new calibration data in test mode.
> 
> The cal-data is platform dependent. It's simpler and more feasible
> to use device tree based cal-data instead of configuration file
> based cal-data.
> 
> This patch remove configuration file based cal-data downloading
> and replace it using cal-data from device tree.
> 
> When CONFIG_OF is not selected, or the specific property is not
> present in the device tree, the calibration downloading will not
> happen.
> 
> Cc: Mike Frysinger <vapier@chromium.org>
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Signed-off-by: Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
> ---
> v2: add verbose commit messages (Marcel Holtmann)
> 
> drivers/bluetooth/btmrvl_drv.h  |  4 --
> drivers/bluetooth/btmrvl_main.c | 92 ++++++++---------------------------------
> drivers/bluetooth/btmrvl_sdio.c |  9 +---
> drivers/bluetooth/btmrvl_sdio.h |  2 -
> 4 files changed, 18 insertions(+), 89 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

