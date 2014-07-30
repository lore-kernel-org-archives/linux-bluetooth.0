Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix check for connected state when pairing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406698548-14240-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 29 Jul 2014 22:55:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3B9916DC-CEA5-4EEC-B2B3-060E418C448F@holtmann.org>
References: <1406698548-14240-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Both BT_CONNECTED and BT_CONFIG state mean that we have a baseband link
> available. We should therefore check for either of these when pairing
> and deciding whether to call hci_conn_security() directly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

