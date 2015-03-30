Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3 1/2] Bluetooth: Refactor L2CAP variables into l2cap_ctrl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427746862-11078-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 30 Mar 2015 14:23:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ECBF21B6-FB5B-44A9-960A-37C7159FE360@holtmann.org>
References: <1427746862-11078-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We're getting very close to the maximum possible size of bt_skb_cb. To
> prepare to shrink the struct with the help of a union this patch moves
> all L2CAP related variables into the l2cap_ctrl struct. To later add
> other 'ctrl' structs the L2CAP one is renamed simple 'l2cap' instead
> of 'control'.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  8 +++----
> net/bluetooth/l2cap_core.c        | 48 +++++++++++++++++++--------------------
> net/bluetooth/l2cap_sock.c        |  6 ++---
> net/bluetooth/smp.c               |  2 +-
> 4 files changed, 32 insertions(+), 32 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

