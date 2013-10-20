Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v3] Bluetooth: Update Set Discoverable to support LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382284807-26311-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 20 Oct 2013 18:07:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0EFBEBC3-653A-449B-9691-A50B4F47570A@holtmann.org>
References: <1382259320-20009-1-git-send-email-johan.hedberg@gmail.com> <1382284807-26311-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates the Set Discoverable management command to also be
> applicable for LE. In particular this affects the advertising flags
> where we can say "general discoverable" or "limited discoverable".
> 
> Since the device flags may not be up-to-date when the advertising data
> is written this patch introduces a get_adv_discov_flags() helper
> function which also looks at any pending mgmt commands (a pending
> set_discoverable would be the exception when the flags are not yet
> correct).
> 
> The patch also adds HCI_DISCOVERABLE flag clearing to the
> mgmt_discoverable_timeout function, since the code was previously
> relying on the mgmt_discoverable callback to handle this, which is only
> called for the BR/EDR-only HCI_Write_Scan_Enable command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v3:
> * Fix updating advertising flags when switching connectable off while
>   limited discoverable is enabled.
> v2:
> * Fix advertising flags update when disabling connectable while
>  discoverable is enabled.
> * Fix redundant check for HCI_LE_ENABLED
> 
> net/bluetooth/mgmt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 69 insertions(+), 11 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

