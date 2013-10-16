Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] Bluetooth: Ignore SMP data on non-LE links
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381912621-10238-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 10:42:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <08718B49-E464-4704-8CC8-E45B101A298B@holtmann.org>
References: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com> <1381912621-10238-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The SMP CID is only defined for LE transports. Instead of returning an
> error from smp_sig_channel() in this case (which would cause a
> disconnection) just return 0 to ignore the data, which is consistent
> with the behavior for other unknown CIDs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

