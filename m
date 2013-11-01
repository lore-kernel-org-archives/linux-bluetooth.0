Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: remove cal-data byte swapping and redundant mem copy
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383344905-3525-2-git-send-email-bzhao@marvell.com>
Date: Fri, 1 Nov 2013 23:39:43 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mike Frysinger <vapier@chromium.org>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <F4CC67C2-B44E-4289-BE19-FB8FC406B8B7@holtmann.org>
References: <1383344905-3525-1-git-send-email-bzhao@marvell.com> <1383344905-3525-2-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> The device tree property can define the cal-data in proper order.
> There is no need to swap the bytes in driver.
> Also remove the redundant cal-data memory copy after removing the
> byte swapping.
> 
> Cc: Mike Frysinger <vapier@chromium.org>
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Signed-off-by: Hyuckjoo Lee <hyuckjoo.lee@samsung.com>
> ---
> v2: no change from v1
> 
> drivers/bluetooth/btmrvl_drv.h  |  2 +-
> drivers/bluetooth/btmrvl_main.c | 27 ++++++++++-----------------
> 2 files changed, 11 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

