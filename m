Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: btusb: Remove unneeded btusb_wait_on_bit_timeout()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423899215-31128-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 14 Feb 2015 13:27:01 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9ED216E1-BBB7-4C5E-91B0-7D7E3EE2715D@holtmann.org>
References: <1423899215-31128-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's now a proper wait_on_bit_timeout() API in linux/wait.h so we can
> remove our own copy from btusb.c. Our copy had the task state and
> timeout variables swapped so the patch also changes their order.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btusb.c | 22 ++++++----------------
> 1 file changed, 6 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

