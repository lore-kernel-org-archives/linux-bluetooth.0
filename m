Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix clearing HCI_PSCAN flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406551531-16144-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 28 Jul 2014 07:51:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <84604E68-53D7-4E52-A7DE-BBB98DACFD10@holtmann.org>
References: <1406551531-16144-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes a typo in the hci_cc_write_scan_enable() function where
> we want to clear the HCI_PSCAN flag if the SCAN_PAGE bit of the HCI
> command parameter was not set.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> This one should be applied before the following 5-patch set:
> Subject: [PATCH v2 0/5] Bluetooth: Page scan fixes & improvements
> 
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

