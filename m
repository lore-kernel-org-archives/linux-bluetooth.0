Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Don't try to reject failed LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405414288-6903-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 15 Jul 2014 11:02:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <51B06842-76C6-464C-A78D-A88D5C484AB5@holtmann.org>
References: <1405414288-6903-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The check for the blacklist in hci_le_conn_complete_evt() should be when
> we know that we have an actual successful connection (ev->status being
> non-zero). This patch fixes this ordering.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

