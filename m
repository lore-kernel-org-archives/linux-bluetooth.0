Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add a delay for module reset
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1484019988-10644-1-git-send-email-jesse.sung@canonical.com>
Date: Thu, 16 Feb 2017 17:33:11 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <40618C53-2550-4E9E-8906-C7C849FA0746@holtmann.org>
References: <1484019988-10644-1-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> Some btbcm devices require more time to complete its reset process.
> They won't reply any hci command until reset is done.
> 
> [ 17.218554] Bluetooth: hci0 command 0x1001 tx timeout
> [ 25.214999] Bluetooth: hci0: BCM: Reading local version info failed (-110)
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btbcm.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

