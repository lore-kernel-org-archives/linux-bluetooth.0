Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: btusb: Remove redundant call to btusb_free_frags()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422435992-30145-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 28 Jan 2015 12:35:07 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <182618A8-93A3-4E1A-95B9-CD52C7900DC8@holtmann.org>
References: <1422435992-30145-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The btusb_disconnect() callback calls hci_unregister_dev() which in turn
> calls btusb_close() if the HCI device is powered. The btusb_close()
> function in turn will call btusb_free_frags(). It's therefore
> unnecessary to have another call to btusb_free_frags() in the
> btusb_disconnect() function. Besides the redundancy the second call
> seems to also cause some strange stability issues which this patch then
> also fixes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btusb.c | 1 -
> 1 file changed, 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

