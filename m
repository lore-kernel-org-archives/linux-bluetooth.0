Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Fix rfkill functionality during the HCI setup stage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379051898-2630-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Sep 2013 23:23:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EFD984BF-E92F-4959-9EC6-F12DEB974E69@holtmann.org>
References: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com> <1379051898-2630-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to let the setup stage complete cleanly even when the HCI device
> is rfkilled. Otherwise the HCI device will stay in an undefined state
> and never get notified to user space through mgmt (even when it gets
> unblocked through rfkill).
> 
> This patch makes sure that hci_dev_open() can be called in the HCI_SETUP
> stage, that blocking the device doesn't abort the setup stage, and that
> the device gets proper powered down as soon as the setup stage completes
> in case it was blocked meanwhile.
> 
> The bug that this patch fixed can be very easily reproduced using e.g.
> the rfkill command line too. By running "rfkill block all" before
> inserting a Bluetooth dongle the resulting HCI device goes into a state
> where it is never announced over mgmt, not even when "rfkill unblock all"
> is run.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
> v3: Use "else if" instead of separate if-statement
> 
> net/bluetooth/hci_core.c | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

