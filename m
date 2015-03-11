Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Fix missing rcu_read_unlock() in hci_bdaddr_is_paired()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426056951-3412-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Mar 2015 00:53:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7C7B01F8-E273-4462-AC68-56417D59A1C5@holtmann.org>
References: <1426056951-3412-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When finding a matching LTK the rcu_read_unlock() function was failing
> to release the RCU read lock. This patch adds the missing call to
> rcu_reaD_unlock().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

