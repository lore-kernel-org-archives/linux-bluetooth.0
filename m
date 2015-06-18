Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Use zalloc when possible
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434649808-17543-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 18 Jun 2015 19:54:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC774713-9B64-4F79-A0BC-61BD12C473FB@holtmann.org>
References: <1434649808-17543-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Use zallog for adv_instance allocation instead of kmalloc + memset.
> This also fixes the following coccinelle warning:
> 
>>> net/bluetooth/hci_core.c:2693:17-24: WARNING: kzalloc should be
> used for adv_instance, instead of kmalloc/memset
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

