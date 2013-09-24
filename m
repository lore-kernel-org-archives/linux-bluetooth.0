Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/8] Bluetooth: Add clarifying comment to bt_sock_wait_state()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:11:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <83341B7D-7E7E-402F-A00F-2BBC59400E31@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The bt_sock_wait_state requires the sk lock to be held (through
> lock_sock) so document it clearly in the code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/af_bluetooth.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

