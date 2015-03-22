Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Fix memory leak in le_scan_disable_work_complete()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426917743-10597-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 22 Mar 2015 00:09:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CC713F7E-147B-4C84-A553-11673AB692F1@holtmann.org>
References: <1426917743-10597-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> The hci_request in le_scan_disable_work_complete() was being initialized
> in a general context but only used in a specific branch in the function
> (when simultaneous discovery is not supported). This patch moves the
> usage to be limited to the branch where hci_req_run() is actually
> called.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

