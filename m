Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 3/6] Bluetooth: Rename HCI_DEBUG_KEYS to HCI_KEEP_DEBUG_KEYS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403604953-19539-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Jun 2014 12:38:49 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <772E2E57-E0E5-4E05-911F-6550680C8651@holtmann.org>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com> <1403604953-19539-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We're planning to add a flag to actively use debug keys in addition to
> simply just accepting them, which makes the current generically named
> DEBUG_KEYS flag a bit confusing. Since the flag in practice affects
> whether the kernel keeps debug keys around or not rename it to
> HCI_KEEP_DEBUG_KEYS.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 +-
> net/bluetooth/hci_event.c   |  2 +-
> net/bluetooth/mgmt.c        | 14 +++++++++-----
> 3 files changed, 11 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

