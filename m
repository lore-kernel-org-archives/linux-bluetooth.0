Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix sending Device Removed when clearing all parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404641211-17487-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 6 Jul 2014 12:32:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <43B035DE-32EB-46F4-9D5C-C66BE53E4DE5@holtmann.org>
References: <1404641211-17487-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When calling Device Remove with BDADDR_ANY we should in a similar way
> emit Device Removed events as we do when removing a single device. Since
> we have to iterate the list and call device_removed() the dedicated
> hci_conn_params_clear_enabled() is not really useful anymore. This patch
> removes the helper function and does the event emission and list item
> removal in a single loop.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_core.c         | 18 ------------------
> net/bluetooth/mgmt.c             | 15 ++++++++++++++-
> 3 files changed, 14 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

