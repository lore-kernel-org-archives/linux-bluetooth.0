Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Replace spinlock by mutex
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441102416-29864-1-git-send-email-frederic.danis@linux.intel.com>
Date: Tue, 1 Sep 2015 07:51:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5B1EDE2-47E1-44C3-B0CD-54AB01C3774A@holtmann.org>
References: <1441102416-29864-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Replace spinlock by mutex to be able to use bcm_device_lock in
> sleepable context like devm_request_threaded_irq or upcomming PM support.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 26 +++++++++++++-------------
> 1 file changed, 13 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

