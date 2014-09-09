Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix mgmt pairing failure when authentication fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410221389-15975-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 8 Sep 2014 18:13:56 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B25E01FD-A6B3-4F25-AE0B-63A6D5214BCA@holtmann.org>
References: <1410221389-15975-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Whether through HCI with BR/EDR or SMP with LE when authentication fails
> we should also notify any pending Pair Device mgmt command. This patch
> updates the mgmt_auth_failed function to take the actual hci_conn object
> and makes sure that any pending pairing command is notified and cleaned
> up appropriately.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  3 +--
> net/bluetooth/hci_event.c        |  6 ++----
> net/bluetooth/mgmt.c             | 19 +++++++++++++------
> net/bluetooth/smp.c              |  3 +--
> 4 files changed, 17 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

