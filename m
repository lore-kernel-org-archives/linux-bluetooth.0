Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: btusb: Use GFP_KERNEL in btusb_send_frame()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410673774-10957-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 13 Sep 2014 23:59:41 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1780E4DC-57E7-4DB3-BC26-06312436A3B1@holtmann.org>
References: <1410673774-10957-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All hdev->send() calls are these days done through a work queue. For the
> btusb driver this means the btusb_send_frame() function. Because of this
> we can safely use GFP_KERNEL for all memory allocations in this code
> path.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btusb.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

