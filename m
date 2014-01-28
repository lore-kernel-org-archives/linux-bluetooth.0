Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary check for chan->psm
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390951684-3225-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 15:35:10 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <DF71A641-43A9-4415-BF2D-EC59DE21112C@holtmann.org>
References: <1390951684-3225-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that ATT sockets have been converted to use the new L2CAP_CHAN_FIXED
> type there is no need to have an extra check for chan->psm in the
> l2cap_chan_close function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

