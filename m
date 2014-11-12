Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Remove unnecessary hci_dev_lock/unlock in smp.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415776628-32562-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 12 Nov 2014 18:07:44 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8171380F-DC95-4D07-99BA-F56DFD6C8028@holtmann.org>
References: <1415776628-32562-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The mgmt_user_passkey_request and related functions do not do anything
> else except read access to hdev->id. This member never changes after the
> hdev creation so there is no need to acquire a lock to read it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/smp.c | 4 ----
> 1 file changed, 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

