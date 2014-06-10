Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 3/3] Bluetooth: Reuse hci_stop_discovery function when cleaning up HCI state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402398359-1602-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 13:59:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C9C36705-6A56-4004-A0A7-AC24B585FA5F@holtmann.org>
References: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com> <1402398359-1602-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When cleaning up the HCI state as part of the power-off procedure we can
> reuse the hci_stop_discovery() function instead of explicitly sending
> HCI command related to discovery. The added benefit of this is that it
> takes care of canceling name resolving and inquiry which were not
> previously covered by the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

