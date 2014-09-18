Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix setting correct security level when initiating SMP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411028792-1049-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 18 Sep 2014 08:47:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <99480573-77F9-42E3-9F8A-583AC2537140@holtmann.org>
References: <1411028792-1049-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We can only determine the final security level when both pairing request
> and response have been exchanged. When initiating pairing the starting
> target security level is set to MEDIUM unless explicitly specified to be
> HIGH, so that we can still perform pairing even if the remote doesn't
> have MITM capabilities. However, once we've received the pairing
> response we should re-consult the remote and local IO capabilities and
> upgrade the target security level if necessary.
> 
> Without this patch the resulting Long Term Key will occasionally be
> reported to be unauthenticated when it in reality is an authenticated
> one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

