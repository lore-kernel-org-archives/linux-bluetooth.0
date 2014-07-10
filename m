Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/4] Bluetooth: Remove unneeded mgmt_connectable function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 11:16:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0BF3817A-FB01-4CC5-8AC8-5DA94EABFFD5@holtmann.org>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The mgmt_connectable function has been used to ensure that the right
> actions to HCI_CONNECTABLE are taken when the HCI_Write_Scan_Enable
> command is triggered by something else than mgmt. The only other user
> that we really care about is the HCISETSCAN ioctl code, so we can
> actually more simply perform the needed changes there instead.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_core.c         |  6 +++---
> net/bluetooth/hci_event.c        |  6 +-----
> net/bluetooth/mgmt.c             | 32 --------------------------------
> 4 files changed, 4 insertions(+), 41 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

