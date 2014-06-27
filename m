Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 0/6] Bluetooth: Various SMP cleanups & fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 27 Jun 2014 13:40:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <010EDA1D-030B-4F77-86AC-B910975F0198@holtmann.org>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a set of cleanups and fixes for SMP. I'd consider all of them as
> bluetooth-next material, but it could be debated whether the first patch
> should go to bluetooth.git first (I don't have any obvious way of
> exploiting it so I don't consider it very critical).
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (6):
>      Bluetooth: Fix missing hdev locking in smp_cmd_ident_addr_info
>      Bluetooth: Add dedicated AES instance for each SMP context
>      Bluetooth: Update SMP crypto functions to take the SMP context
>      Bluetooth: Remove unnecessary hci_dev_unlock for smp_user_confirm_reply
>      Bluetooth: Fix missing check for SMP session in smp_user_confirm_reply
>      Bluetooth: Remove unnecessary hcon->smp_conn variable
> 
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/mgmt.c             |  7 ----
> net/bluetooth/smp.c              | 73 ++++++++++++++++++++------------------
> 3 files changed, 38 insertions(+), 43 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

And even patch 1/6 is not something I would consider for 3.16-rcX unless we see real bugs about it. If anyone stumbles over it, we promote it to -stable once 3.16 has been released.

Regards

Marcel

