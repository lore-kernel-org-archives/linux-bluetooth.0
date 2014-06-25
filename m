Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Use macro instead of hard-coded value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403725485-29556-1-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 25 Jun 2014 22:07:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <68B06E89-A98B-4EE0-BA12-5750702F77D7@holtmann.org>
References: <1403725485-29556-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch replaces the hard-coded value in hci_bdaddr_is_rpa() helper
> by the corresponding macro ADDR_LE_DEV_RANDOM.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

