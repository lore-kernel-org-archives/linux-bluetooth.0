Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix incorrectly disabling page scan when toggling connectable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406570038-18842-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 28 Jul 2014 11:31:13 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <76167C85-3009-4186-8899-11537475928A@holtmann.org>
References: <1406570038-18842-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have entries in the whitelist we shouldn't disable page scanning
> when disabling connectable mode. This patch adds the necessary check to
> the Set Connectable command handler.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

