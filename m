Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix validating IO capability values in mgmt commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403007288-7152-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 17 Jun 2014 14:51:40 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D9B810C2-4EDA-479C-8667-7CDEE4BA3871@holtmann.org>
References: <1403007288-7152-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The valid range of IO capabilities for the Set IO Capability and Pair
> Device mgmt commands is 0-4 (4 being the KeyboarDisplay capability for
> SMP). We should return an invalid parameters error if user space gives
> us a value outside of this range.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 9 +++++++++
> 1 file changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

