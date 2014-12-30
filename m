Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/5] Bluetooth: Fix const declarations for smp_f5 and smp_f6
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419847454-574-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 29 Dec 2014 22:30:54 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <514A65C3-2E59-49EA-908D-5CF25AA52175@holtmann.org>
References: <1419847454-574-1-git-send-email-johan.hedberg@gmail.com> <1419847454-574-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> These SMP crypto functions should have all their input parameters
> declared as const. This patch fixes the parameters that were missing the
> const declaration.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

this patch out of this series has been applied to bluetooth-next tree.

Regards

Marcel

