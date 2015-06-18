Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Fix warning of uninitialized adv_instance variable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434648391-13789-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 18 Jun 2015 19:44:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <053B3B62-5573-46AF-935C-DDDC4AAC1420@holtmann.org>
References: <1434648391-13789-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Some static checkers may cause the following (false positive) warning:
> 
>>> net/bluetooth/mgmt.c:7294:29: warning: 'adv_instance' may be used
> uninitialized in this function [-Wuninitialized]
> 
> Fix it by ensuring adv_instance always gets set to a known value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

