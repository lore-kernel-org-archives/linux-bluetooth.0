Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix correct nesting for 6lowpan server channel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415864765-7507-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 13 Nov 2014 17:13:31 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E547D9EA-CF45-4E5C-9902-405410175AFF@holtmann.org>
References: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com> <1415864765-7507-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Server channels in BT_LISTEN state should use L2CAP_NESTING_PARENT. This
> patch fixes the nesting value for the 6lowpan channel.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/6lowpan.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

