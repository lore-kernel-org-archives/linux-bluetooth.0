Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: add sd8997 chipset support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442830002-7626-2-git-send-email-akarwar@marvell.com>
Date: Mon, 21 Sep 2015 21:34:17 +0200
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	Zhaoyang Liu <liuzy@marvell.com>
Message-Id: <DBCB576E-A99F-40C2-A5B5-5C6B4A1DAB3A@holtmann.org>
References: <1442830002-7626-1-git-send-email-akarwar@marvell.com> <1442830002-7626-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch adds support for Marvell's new chipset SD8997.
> Register offsets and supported feature flags are updated.
> 
> Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: Firmware name is corrected.
> sdsd8997_combo.bin -> sd8997_uapsta.bin
> ---
> drivers/bluetooth/Kconfig       |  4 ++--
> drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 38 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

