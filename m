Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Fix potential NULL dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422950473-11562-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 3 Feb 2015 00:03:43 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B0C65813-99D4-4972-A6A6-E4065830FF01@holtmann.org>
References: <1422950473-11562-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The bnep_get_device function may be triggered by an ioctl just after a
> connection has gone down. In such a case the respective L2CAP chan->conn
> pointer will get set to NULL (by l2cap_chan_del). This patch adds a
> missing NULL check for this case in the bnep_get_device() function.
> 
> Reported-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/bnep/core.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

