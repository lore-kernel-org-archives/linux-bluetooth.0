Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH] Bluetooth: Fix removing connection parameters when unpairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445241107-5303-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 20 Oct 2015 09:55:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A4EF964A-3CD0-4762-B1FA-2F7D325CF610@holtmann.org>
References: <1445241107-5303-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The commit 89cbb0638e9b7 introduced support for deferred connection
> parameter removal when unpairing by removing them only once an
> existing connection gets disconnected. However, it failed to address
> the scenario when we're *not* connected and do an unpair operation.
> 
> What makes things worse is that most user space BlueZ versions will
> first issue a disconnect request and only then unpair, meaning the
> buggy code will be triggered every time. This effectively causes the
> kernel to resume scanning and reconnect to a device for which we've
> removed all keys and GATT database information.
> 
> This patch fixes the issue by adding the missing call to the
> hci_conn_params_del() function to a branch which handles the case of
> no existing connection.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 3.19+
> ---
> net/bluetooth/mgmt.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

