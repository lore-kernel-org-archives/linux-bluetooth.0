Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Restrict blocked device check in l2cap_recv_frame to LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404633816-10624-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 6 Jul 2014 10:18:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C25762F4-28EE-4393-92D9-60ECE397BC7E@holtmann.org>
References: <1404633816-10624-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> BR/EDR has the connection request and connection request rejection, but
> LE doesn't have anything similar. We still request LE connections to
> blocked devices to be disconnected but it's possible that ACL data slips
> through before that. The check in l2cap_recv_frame really only needs to
> be for LE and not BR/EDR because of this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

