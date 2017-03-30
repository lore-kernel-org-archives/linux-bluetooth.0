Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: remove unnecessary wakeup
 interrupt number sanity check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490878364-2735-2-git-send-email-huxm@marvell.com>
Date: Thu, 30 Mar 2017 16:20:59 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo <cluo@marvell.com>,
        Guenter Roeck <groeck@chromium.org>
Message-Id: <19C158FE-9A3F-4B4C-9173-ECAC99304B4A@holtmann.org>
References: <1490878364-2735-1-git-send-email-huxm@marvell.com>
 <1490878364-2735-2-git-send-email-huxm@marvell.com>
To: Xinming Hu <huxm@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Xinming,

> Sanity check of interrupt number in interrupt handler is unnecessary and
> confusion, remove it.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)

patch does not apply to bluetooth-next tree.

error: drivers/bluetooth/btmrvl_sdio.c: patch does not apply
Patch failed at 0002 Bluetooth: btmrvl: remove unnecessary wakeup interrupt number sanity check

Regards

Marcel

