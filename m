Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Remove unnecessary RCU callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415708189-7184-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 11 Nov 2014 22:27:25 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4BB86E93-1B3A-418C-BB96-24F201F9D66C@holtmann.org>
References: <1415708189-7184-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When kfree() is all that's needed to free an object protected by RCU
> there's a kfree_rcu() convenience function that can be used. This patch
> updates the 6lowpan code to use this, thereby eliminating the need for
> the separate peer_free() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/6lowpan.c | 11 ++---------
> 1 file changed, 2 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

