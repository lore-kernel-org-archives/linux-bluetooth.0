Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix checking for master LTKs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403089780-21734-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 18 Jun 2014 15:06:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D0AE5F0A-2869-46AC-89AC-82EA8BE50525@holtmann.org>
References: <1403089780-21734-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When the rename of STK_SLAVE to simply STK happened we missed this place
> in the ltk_type_master function. Now, checking for master is as simple
> as checking whether the type is SMP_LTK. The helper function is kept
> around for better readability in the (right now three) callers and for
> simpler extension with new key types in the future.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

