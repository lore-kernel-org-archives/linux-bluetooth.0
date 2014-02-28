Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Add timer to force power off
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393572824-663-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 27 Feb 2014 23:41:37 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7A0B1EDB-8C6F-47FE-877D-7319B44158CC@holtmann.org>
References: <1393572824-663-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If some of the cleanup commands caused by mgmt_set_powered(off) never
> complete we should still force the adapter to be powered down. This is
> rather easy to do since hdev->power_off is already a delayed work
> struct. This patch schedules this delayed work if at least one HCI
> command was sent by the cleanup procedure.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/mgmt.c        | 16 +++++++++++++---
> 2 files changed, 14 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

