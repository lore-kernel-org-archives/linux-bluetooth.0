Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary params variable from process_adv_report()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405400879-28788-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 15 Jul 2014 11:01:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <591D708E-B78A-4C66-AEE1-8450ABBCEC18@holtmann.org>
References: <1405400879-28788-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The params variable was just used for storing the return value from the
> hci_pend_le_action_lookup() function and then checking whether it's NULL
> or not. We can simplify the code by checking the return value directly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

