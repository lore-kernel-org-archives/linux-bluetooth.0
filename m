Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/3] Bluetooth: Fix notifying discovery state when powering off
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422450799-18548-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 28 Jan 2015 14:04:36 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <97C0B38C-BBA6-4045-9FF5-E671FD98D274@holtmann.org>
References: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com> <1422450799-18548-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The discovery state should be set to stopped when the HCI device is
> powered off. This patch adds the appropriate call to the
> hci_discovery_set_state() function from hci_dev_do_close() which is
> responsible for the power-off procedure.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

