Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 0/5] Bluetooth: Further refactoring of mgmt API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 17 Mar 2015 10:05:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9462060B-BD01-4373-9F4F-57E9AFF3195A@holtmann.org>
References: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch set refactors mgmt command handling further into a new
> mgmt_util.c file containing helper functions. After this set the old
> mgmt.c file should only contain purely HCI_CHANNEL_CONTROL related
> information and we could start introducing new HCI channels using mgmt
> semantics.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Add helper to get HCI channel of a socket
>      Bluetooth: Add channel parameter to mgmt_pending_find() API
>      Bluetooth: Add generic mgmt helper API
>      Bluetooth: Add hdev_init callback for HCI channels
>      Bluetooth: Move generic mgmt command dispatcher to hci_sock.c
> 
> include/net/bluetooth/bluetooth.h |   1 +
> include/net/bluetooth/hci_core.h  |   4 +-
> net/bluetooth/Makefile            |   2 +-
> net/bluetooth/hci_sock.c          | 121 +++++++++++-
> net/bluetooth/mgmt.c              | 393 +++++--------------------------------
> net/bluetooth/mgmt_util.c         | 210 ++++++++++++++++++++
> net/bluetooth/mgmt_util.h         |  53 +++++
> 7 files changed, 438 insertions(+), 346 deletions(-)
> create mode 100644 net/bluetooth/mgmt_util.c
> create mode 100644 net/bluetooth/mgmt_util.h

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

