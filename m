Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/3] Bluetooth: Add proper defines for HCI connection role
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 11:09:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <33E17A5C-307C-47FF-B8CB-5A401DADC95F@holtmann.org>
References: <1405500148-12370-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All HCI commands and events, including LE ones, use 0x00 for master role
> and 0x01 for slave role. It makes therefore sense to add generic defines
> for these instead of the current LE_CONN_ROLE_MASTER. Having clean
> defines will also make it possible to provide simpler internal APIs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h | 6 +++---
> net/bluetooth/hci_event.c   | 2 +-
> 2 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

