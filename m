Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: btmrvl: reset is_suspending flag in failure path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1468579852-7118-1-git-send-email-akarwar@marvell.com>
Date: Mon, 18 Jul 2016 10:13:54 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Minghsiu.Tsai@mediatek.com
Message-Id: <EF122B05-3E8E-4B94-B96D-50A0C437732E@holtmann.org>
References: <1468579852-7118-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> is_suspending flag remains on when host sleep fails to enable. Data
> path is unnecessarily blocked after this. This patch ensures to
> reset the flag in failure path.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
