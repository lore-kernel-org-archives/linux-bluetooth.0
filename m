Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix address in unmergeable device found events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1396075193-29925-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 29 Mar 2014 00:50:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <03ACC1BE-DB00-4657-9B60-7FE060228286@holtmann.org>
References: <1396075193-29925-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When sending out a device found event caused by an advertising report in
> the situation where we couldn't store the report as a pending one, the
> code was incorrectly trying to use the address and address type from the
> pending data. Since the pending data is cleared in the previous line
> this causes a potentially incorrect address type and an address of
> BDADDR_ANY. This patch fixes the call to use the address information
> correctly from the received advertising report.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

