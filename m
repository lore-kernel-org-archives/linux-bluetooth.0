Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Disable HCI_CONNECTABLE based passive scanning for now
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405865445-4441-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 20 Jul 2014 16:17:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A019E03A-E59E-4B4F-84AD-6CBB041C3945@holtmann.org>
References: <1405865445-4441-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When HCI_CONNECTABLE is set the code has been enabling passive scanning
> in order to be consistent with BR/EDR and accept connections from any
> device doing directed advertising to us. However, some hardware
> (particularly CSR) can get very noisy even when doing duplicates
> filtering, making this feature waste resources.
> 
> Considering that the feature is for fairly corner-case use (devices
> who'd use directed advertising would likely be in the whitelist anyway)
> it's better to disable it for now. It may still be brought back later,
> possibly with a better implementation (e.g. through improved scan
> parameters).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

