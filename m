Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Refactor HCI request variables into own struct
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427746862-11078-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 30 Mar 2015 14:23:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <17581CDC-E55C-46B3-B73E-0C88FC691CFE@holtmann.org>
References: <1427746862-11078-1-git-send-email-johan.hedberg@gmail.com> <1427746862-11078-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In order to shrink the size of bt_skb_cb, this patch moves the HCI
> request related variables into their own req_ctrl struct. Additionall
> the L2CAP and HCI request structs are placed inside the same union since
> they will never be used at the same time for the same skb.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 14 ++++++++++----
> net/bluetooth/hci_core.c          | 12 ++++++------
> net/bluetooth/hci_event.c         |  4 ++--
> net/bluetooth/hci_request.c       |  6 +++---
> net/bluetooth/hci_sock.c          |  2 +-
> 5 files changed, 22 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

