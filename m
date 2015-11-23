Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Fix returning proper HCI status from __hci_req_sync
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448282447-27618-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 23 Nov 2015 13:50:48 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <40DEB8D8-105B-46CC-9B14-F5E918973DA9@holtmann.org>
References: <1448282447-27618-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There were a couple of code paths missed by the previous patch that
> added a HCI status return parameter to __hci_req_sync. This patch adds
> the missing assignments for them.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

