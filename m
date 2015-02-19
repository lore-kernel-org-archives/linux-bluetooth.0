Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Remove bogus check for pending mgmt Set HS command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 19 Feb 2015 08:08:23 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <127E181B-2E81-497F-93A0-BC425D7A9F95@holtmann.org>
References: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The command handler for Set HS doesn't use mgmt_pending_add() so we can
> never have a pending Set HS command that mgmt_pending_find() would
> return. This patch removes an unnecessary lookup for it in the set_ssp()
> handler function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

