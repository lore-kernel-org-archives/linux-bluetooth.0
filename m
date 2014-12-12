Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix mgmt response status when removing adapter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418375721-31057-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 12 Dec 2014 13:22:52 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C58C0974-571C-4F87-B0DD-D55DA800FDC0@holtmann.org>
References: <1418375721-31057-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When an adapter is removed (hci_unregister_dev) any pending mgmt
> commands for that adapter should get the appropriate INVALID_INDEX
> response. Since hci_unregister_dev() calls hci_dev_do_close() first
> that'd so far have caused "not powered" responses to be sent.
> 
> Skipping the HCI_UNREGISTER case in mgmt_powered() is also not a
> solution since before reaching the mgmt_index_removed() stage any
> hci_conn callbacks (e.g. used by pairing) will get called, thereby
> causing "disconnected" status responses to be sent.
> 
> The fix that covers all scenarios is to handle both INVALID_INDEX and
> NOT_POWERED responses through the mgmt_powered() function. The
> INVALID_INDEX response sending from mgmt_index_removed() is left
> untouched since there are a couple of places not related to powering off
> or removing an adapter that call it (e.g. configuring a new bdaddr).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

