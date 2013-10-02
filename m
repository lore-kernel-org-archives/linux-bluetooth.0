Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v6 0/4] Bluetooth: btmrvl cal data downloading
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380655155-10007-1-git-send-email-bzhao@marvell.com>
Date: Wed, 2 Oct 2013 09:37:40 +0200
Cc: <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-wireless@vger.kernel.org>,
	Mike Frysinger <vapier@chromium.org>,
	Hyuckjoo Lee <hyuckjoo.lee@samsung.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <1EB87650-8518-47BE-B0D7-4F78E09F8691@holtmann.org>
References: <1380655155-10007-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> This series adds the calibration data downloading support
> along with improvements in sending commands and setup handler.
> 
> Amitkumar Karwar (4):
>  Bluetooth: btmrvl: add btmrvl_send_sync_cmd() function
>  Bluetooth: btmrvl: get rid of struct btmrvl_cmd
>  Bluetooth: btmrvl: add setup handler
>  Bluetooth: btmrvl: add calibration data download support
> 
> drivers/bluetooth/btmrvl_drv.h  |  12 +-
> drivers/bluetooth/btmrvl_main.c | 269 ++++++++++++++++++++++++++--------------
> drivers/bluetooth/btmrvl_sdio.c |  15 +--
> drivers/bluetooth/btmrvl_sdio.h |   2 +
> 4 files changed, 193 insertions(+), 105 deletions(-)

I have decided to apply all 4 patches to bluetooth-next. However please send a follow up patch that changes the code to operate on 16-bit opcodes and not the OGC/OCF and its packing.

Regards

Marcel

