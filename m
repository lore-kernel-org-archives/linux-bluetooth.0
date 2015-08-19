Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: btmrvl: change device pointer passed to dev_coredumpv
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439979139-15930-1-git-send-email-akarwar@marvell.com>
Date: Wed, 19 Aug 2015 16:07:30 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Shengzhen Li <szli@marvell.com>
Message-Id: <DC28FCCA-AAF2-415E-BAD3-4B956C6C3DD4@holtmann.org>
References: <1439979139-15930-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This change ensures we will get driver name as 'btmrvl_sdio'
> in udev event.
> 
> Signed-off-by: Shengzhen Li <szli@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

