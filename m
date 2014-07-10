Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 4/4] Bluetooth: Remove unneeded mgmt_write_scan_failed function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404983349-6105-4-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 11:17:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7927125B-4504-4EF0-A50D-9D6424EEDD32@holtmann.org>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com> <1404983349-6105-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Set Connectable/Discoverable mgmt handlers use a hci_request with a
> proper callback to handle the HCI command sending. It makes therefore
> little sense to have this extra function to be called from hci_event.c
> for command failures.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_event.c        |  1 -
> net/bluetooth/mgmt.c             | 13 -------------
> 3 files changed, 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

