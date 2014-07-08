Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix clearing HCI_LE_ADV for LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404829311-6903-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 16:54:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D3A7737D-AD13-4A12-A2E2-D400381091C8@holtmann.org>
References: <1404829311-6903-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All LE controllers always implicitly stop advertising when establishing
> connections. Therefore, be sure to clear the flag in the event handler
> for new LE connections.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

