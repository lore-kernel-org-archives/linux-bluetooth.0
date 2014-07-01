Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Add flag to track STK encryption
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404231253-21119-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 18:28:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9EAEDC18-C8C3-4A24-881D-D8109A97B552@holtmann.org>
References: <1404231253-21119-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are certain subtle differences in behavior when we're encrypted
> with the STK, such as allowing re-encryption even though the security
> level stays the same. Because of this, add a flag to track whether we're
> encrypted with an STK or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_event.c        | 3 +++
> net/bluetooth/smp.c              | 4 ++++
> 3 files changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

