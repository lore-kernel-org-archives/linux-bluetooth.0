Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Use list_del when freeing the list entry
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404479843-8770-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 4 Jul 2014 15:56:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B19B4B5-9690-475A-BF78-61798A4DFBC2@holtmann.org>
References: <1404479843-8770-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's wasteful to use list_del_init (which re-initializes the list_head)
> if we're just about to free the element and never use it again.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

