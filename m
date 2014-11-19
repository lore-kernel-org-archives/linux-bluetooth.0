Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix setting state back to TASK_RUNNING
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416395801-9062-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Nov 2014 23:16:35 +0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <815E1F05-B4D2-44A5-A89C-8093E4479C41@holtmann.org>
References: <1416395801-9062-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In __hci_cmd_sync_ev() and __hci_req_sync() if the hci_req_run() call
> fails and we return from the functions we should ensure that the state
> doesn't remain in TASK_INTERRUPTIBLE that we just set it to. This patch
> fixes missing calls to set_current_state(TASK_RUNNING) in both places.
> 
> Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Tested-by: Kirill A. Shutemov <kirill@shutemov.name>
> ---
> net/bluetooth/hci_core.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

