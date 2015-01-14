Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix valid Identity Address check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421261497-11211-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 14 Jan 2015 13:22:26 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5DB20ABA-36C8-4064-9B2D-C60FFC02AD0A@holtmann.org>
References: <1421261497-11211-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> According to the Bluetooth core specification valid identity addresses
> are either Public Device Addresses or Static Random Addresses. IRKs
> received with any other type of address should be discarded since we
> cannot assume to know the permanent identity of the peer device.
> 
> This patch fixes a missing check for the Identity Address when receiving
> the Identity Address Information SMP PDU.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 3.16+
> ---
> net/bluetooth/smp.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

