Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/3] Bluetooth: Rename HCI_PAIRABLE to HCI_BONDABLE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 29 Jul 2014 23:28:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D4177AD8-BF86-4D33-B369-6E91478DD8C7@holtmann.org>
References: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The HCI_PAIRABLE flag isn't actually controlling whether we're pairable
> but whether we're bondable. Therefore, rename it accordingly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h | 2 +-
> net/bluetooth/hci_core.c    | 4 ++--
> net/bluetooth/hci_event.c   | 4 ++--
> net/bluetooth/mgmt.c        | 8 ++++----
> net/bluetooth/smp.c         | 6 +++---
> 5 files changed, 12 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

