Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix locking of hdev when calling into SMP code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402644148-24141-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Jun 2014 13:18:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E2B81A7D-2344-4FBA-A240-7404BD15A386@holtmann.org>
References: <1402644148-24141-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The SMP code expects hdev to be unlocked since e.g. crypto functions
> will try to (re)lock it. Therefore, we need to release the lock before
> calling into smp.c from mgmt.c. Without this we risk a deadlock whenever
> the smp_user_confirm_reply() function is called.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

patch has been applied to bluetooth tree.

Regards

Marcel

