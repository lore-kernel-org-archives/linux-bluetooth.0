Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btmrvl: cleanup code in return from
 btmrvl_sdio_suspend()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <SG2PR0302MB257551E9937B577EF80ACA15CA320@SG2PR0302MB2575.apcprd03.prod.outlook.com>
Date: Wed, 29 Mar 2017 08:58:14 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Prasanna Karthik <pkarthik@outlook.com>
Message-Id: <ABC86811-0916-4FFB-A2DC-559307E38A6F@holtmann.org>
References: <SG2PR0302MB257551E9937B577EF80ACA15CA320@SG2PR0302MB2575.apcprd03.prod.outlook.com>
To: prasanna karthik <prasannakarthik@outlook.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Else is not generally useful after a break or return
> 
> Signed-off-by: Prasanna Karthik <pkarthik@outlook.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

