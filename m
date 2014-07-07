Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Don't try background scanning if LE is not enabled
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404735590-4378-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 15:20:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1A4B955B-FDE7-4B30-BA76-0B8C577054FF@holtmann.org>
References: <1404735590-4378-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For adapters that do not support LE and ones where LE hasn't been
> enabled we shouldn't be trying to initiate background scanning. This
> patch adds an extra check to the hci_update_background_scan() to ensure
> that we bail out if HCI_LE_ENABLED is not set.
> 
> Since we do allow user space to feed the kernel with LE connection
> parameters even when LE is not enabled we now need to also call
> hci_update_background_scan() as soon as LE gets enabled so that scanning
> gets started if necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 ++++
> net/bluetooth/mgmt.c     | 2 ++
> 2 files changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

