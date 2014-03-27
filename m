Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary NULL check in hci_inquiry_cache_update
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395921084-13605-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 27 Mar 2014 09:03:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B459ACC5-EDFF-4FF6-B8F2-4D7D8CB4437C@holtmann.org>
References: <1395921084-13605-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The ssp parameter is supposed to be a mandatory one and there are no
> callers that would pass NULL to this function. Removing this unnecessary
> NULL check also makes (false positive) static analyzer warnings go away.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

