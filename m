Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Centralize looking up blocked devices to l2cap_recv_frame
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Jul 2014 09:08:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2A8FF7B1-0390-4A61-9A91-FDC6C73CA414@holtmann.org>
References: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The ATT channel isn't the only one that we should ensure doesn't receive
> data from blocked devices. SMP is another, and in general we don't want
> data packets going to any of the various handlers. Therefore, add a
> single check to the l2cap_recv_frame function.
> 
> The patch fixes at the same time the use of a correct address type. The
> blacklist stores the values with the user space facing triple type
> wheras hci_conn->dst_type uses the HCI address type (0x00 or 0x01).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

