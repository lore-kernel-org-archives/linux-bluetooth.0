Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/3] Bluetooth: Simplify logic when checking SMP_FLAG_TK_VALID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Mar 2014 13:59:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B15D0EC6-AF80-4A7D-ADDE-25CFDFAAAB47@holtmann.org>
References: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This is a trivial coding style simplification by instead of having an
> extra early return to instead revert the if condition and do the single
> needed queue_work() call there.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

