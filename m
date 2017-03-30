Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: remove unnecessary wakeup
 interrupt number sanity check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490884636-18684-2-git-send-email-huxm@marvell.com>
Date: Thu, 30 Mar 2017 16:44:00 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo <cluo@marvell.com>,
        Guenter Roeck <groeck@chromium.org>
Message-Id: <21885C64-CE14-49C9-AB01-7EA44027B245@holtmann.org>
References: <1490884636-18684-1-git-send-email-huxm@marvell.com>
 <1490884636-18684-2-git-send-email-huxm@marvell.com>
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
> v2: fix apply error in v1
> ---
> drivers/bluetooth/btmrvl_sdio.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

