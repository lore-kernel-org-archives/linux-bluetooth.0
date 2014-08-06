Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] Bluetooth: Disable page scan if all whitelisted devices are connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406880812-19731-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 6 Aug 2014 13:00:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F680C20F-F8D1-4D4B-AD98-38FCB7340588@holtmann.org>
References: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com> <1406880812-19731-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're not connectable and all whitelisted (BR/EDR) devices are
> connected it doesn't make sense to keep page scan enabled. This patch
> adds code to check for any disconnected whitelist devices and if there
> are none take the appropriate action in the hci_update_page_scan()
> function to disable page scan.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c  | 20 +++++++++++++++++++-
> net/bluetooth/hci_event.c | 11 ++++++++---
> 2 files changed, 27 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

