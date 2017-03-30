Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: disable platform wakeup interrupt
 in suspend failure path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490878364-2735-1-git-send-email-huxm@marvell.com>
Date: Thu, 30 Mar 2017 16:21:19 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo <cluo@marvell.com>,
        Guenter Roeck <groeck@chromium.org>
Message-Id: <28D1B808-CD0F-4CDD-8C3A-8341F9A65F83@holtmann.org>
References: <1490878364-2735-1-git-send-email-huxm@marvell.com>
To: Xinming Hu <huxm@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Xinming,

> Host sleep handshake with device might been fail, disable platform wakeup
> interrupt in this case.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

