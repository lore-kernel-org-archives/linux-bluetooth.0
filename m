Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Fix race when waiting for BTUSB_DOWNLOADING
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 30 Jan 2015 02:07:21 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <63584AC4-6865-4C29-BD6A-3296C540637B@holtmann.org>
References: <1422608335-29090-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The test for BTUSB_DOWNLOADING must be after adding to the wait queue
> and setting the TASK_INTERRUPTIBLE state. Otherwise the flag may get
> cleared after we test for it and we end up getting a timeout since
> schedule_timeout() waits for the full duration. This patch uses a
> wait_on_bit_timeout() + wake_up_bit(). To perform the task both
> race-free as well as in a much simpler way.
> 
> Since there's no global wait_on_bit_timeout() helper yet (even though
> all the building blocks for it are in place) this patch creates a
> temporary local btusb copy of it until the global one has made it to
> upstream trees.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btusb.c | 67 ++++++++++++++++++++++++-----------------------
> 1 file changed, 34 insertions(+), 33 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

