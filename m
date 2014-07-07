Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Update discovery state earlier in hci_discovery_set_state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 12:37:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FF3613BE-479B-4155-9665-05C1F1B127F6@holtmann.org>
References: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In a subsequent patch the hci_update_background_scan() function will
> depend on being able to know the current discovery state. For this to be
> possible we need to set the new state early in the function. Since we
> also need to check what the old state was this patch introduces an extra
> variable for tracking it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

