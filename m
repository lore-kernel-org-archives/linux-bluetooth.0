Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Add clarifying comment why schedule_work is used
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1446809733-31134-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 6 Nov 2015 20:38:40 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98DFBF22-BEE6-4DCD-AC17-206FC32FEB68@holtmann.org>
References: <1446809733-31134-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's not obvious why schedule_work is used instead of queue_work. Add
> a comment explaining why.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

