Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix check for re-enabling advertising
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 15:12:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8163879D-C0B5-47BC-BEAC-F000487ED2D4@holtmann.org>
References: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are many different places that can disable LE scanning but we only
> want to re-enable advertising in hci_cc_le_set_scan_enable() for a very
> specific use case, which is when the active scanning part of Start
> Discovery is complete. Because of this, fix the discovery state check to
> test for the exact state.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

