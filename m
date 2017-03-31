Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/2] Bluetooth: btmrvl: disable platform wakeup
 interrupt in suspend failure path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1490941952-9048-1-git-send-email-huxm@marvell.com>
Date: Fri, 31 Mar 2017 12:11:11 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Cathy Luo <cluo@marvell.com>
Message-Id: <983D9481-551B-463E-8BCE-9C52017E7CE2@holtmann.org>
References: <1490941952-9048-1-git-send-email-huxm@marvell.com>
To: Xinming Hu <huxm@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Xinming,

> Host sleep handshake with device might been fail, disable platform wakeup
> interrupt in this case.
> 
> Reported-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: same as v1
> v3: use Reported-by (Guenter)
> ---
> drivers/bluetooth/btmrvl_sdio.c | 7 +++++++
> 1 file changed, 7 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

