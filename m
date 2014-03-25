Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove redundant NULL check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 10:26:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E3718FAD-18B2-4059-A74F-187E9A96E312@holtmann.org>
References: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All callers of hci_inquiry_cache_update() pass a non-NULL ssp pointer to
> it and even the function itself assumes in another place that the
> pointer is non-NULL. Therefore, remove the redundant check.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

