Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix re-setting RPA as expired when deferring update
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410539512-3473-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 12 Sep 2014 09:36:11 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2963E6DE-8EE4-4411-8AEB-F4A9A8EF6108@holtmann.org>
References: <1410539512-3473-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_update_random_address will clear the RPA_EXPIRED flag and
> proceed with setting a new one if the flag was set. However, the
> set_random_addr() function that is called may choose to defer the update
> to a later moment. In such a case the flag would incorrectly remain
> unset unless set_random_addr() re-sets it. This patch fixes the issue.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

