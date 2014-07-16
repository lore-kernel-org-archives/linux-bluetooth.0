Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/3] Bluetooth: Convert HCI_CONN_MASTER flag to a conn->role variable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500148-12370-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 11:09:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FA02B3BB-0C89-4983-8176-1CB80C455026@holtmann.org>
References: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com> <1405500148-12370-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Having a dedicated u8 role variable in the hci_conn struct greatly
> simplifies tracking of the role, since this is the native way that it's
> represented on the HCI level.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_conn.c         | 13 ++++++-------
> net/bluetooth/hci_event.c        | 27 +++++++++------------------
> net/bluetooth/l2cap_core.c       |  4 ++--
> net/bluetooth/smp.c              | 12 ++++++------
> 5 files changed, 24 insertions(+), 34 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

