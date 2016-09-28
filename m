Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: btusb: add entry for Marvell 8997 chipset
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1475059715-6174-1-git-send-email-akarwar@marvell.com>
Date: Wed, 28 Sep 2016 13:03:35 +0200
Cc: linux-bluetooth@vger.kernel.org,
        "Gustavo F. Padovan" <gustavo@padovan.org>, huxm@marvell.com
Message-Id: <A36D8BC6-2C6F-40FC-902F-7703FC74B919@holtmann.org>
References: <1475059715-6174-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> btusb_set_bdaddr_marvell() configures BD address for Marvell chipsets.
> This patch adds new chipset 8997 in the list so that BD address feature
> would be available for it.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

