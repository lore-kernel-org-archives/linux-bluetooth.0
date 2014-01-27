Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix respecting le_default_mps value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 00:30:45 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <75D5DDDB-A9BA-4B47-A16D-0BFE24A43E4A@holtmann.org>
References: <1390864295-4259-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's a le_default_mps variable that can be modified through debugfs
> but it was never actually used for determining our MPS value. This patch
> fixes the MPS initialization to use the variable instead of a fixed
> value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

