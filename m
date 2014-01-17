Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v4 2/2] Bluetooth: Queue incoming ACL data until BT_CONNECTED state is reached
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389984311-10482-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 17 Jan 2014 11:06:17 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8EA18423-4493-4095-A10C-6500E9BAF1CB@holtmann.org>
References: <1389984311-10482-1-git-send-email-johan.hedberg@gmail.com> <1389984311-10482-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a queue for incoming L2CAP data that's received before
> l2cap_connect_cfm is called and processes the data once
> l2cap_connect_cfm is called. This way we ensure that we have e.g. all
> remote features before processing L2CAP signaling data (which is very
> important for making the correct security decisions).
> 
> The processing of the pending rx data needs to be done through
> queue_work since unlike l2cap_recv_acldata, l2cap_connect_cfm is called
> with the hci_dev lock held which could cause potential deadlocks.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/l2cap.h |  3 +++
> net/bluetooth/l2cap_core.c    | 27 +++++++++++++++++++++++++++
> 2 files changed, 30 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

