Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Simplify request cleanup code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447334100-10167-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Nov 2015 23:46:55 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <62E21329-5E49-4C01-83DA-61A9F1840D5E@holtmann.org>
References: <1447334100-10167-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_req_sync_cancel() is just as much related to the request
> cleanup as hci_request_cancel_all() is. Just move the former into the
> latter and do the cleanup from a single place in hci_dev_do_close().
> The important thing is to avoid deadlocks by holding the req_sync
> lock: previously hci_request_cancel_all was done right after releasing
> the lock and with this patch it's right before taking it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 4 +---
> net/bluetooth/hci_request.c | 2 ++
> 2 files changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

