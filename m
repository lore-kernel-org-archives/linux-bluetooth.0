Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Fix canceling RPA expiry timer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393266907-25867-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Feb 2014 11:06:15 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <75757504-51E1-4CB8-9496-B717AE678B0D@holtmann.org>
References: <1393266907-25867-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The RPA expiry timer is only initialized inside mgmt.c when we receive
> the first command from user space. This action also involves setting the
> HCI_MGMT flag for the first time so that flag acts as a good indicator
> of whether the delayed work variable can be touched or not. This patch
> fixes hci_dev_do_close to first check the flag.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

