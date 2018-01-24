Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [v2 1/5] Bluetooth: hci_intel: Update firmware filename for Intel
 9x60 and later
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516814361-16945-1-git-send-email-tedd.an@linux.intel.com>
Date: Wed, 24 Jan 2018 19:32:43 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Amit K Bag <amit.k.bag@intel.com>, tedd.an@intel.com
Message-Id: <BD5BD52E-EDCB-481A-92A0-11E4A41292B0@holtmann.org>
References: <1516814361-16945-1-git-send-email-tedd.an@linux.intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> The format of Intel Bluetooth firmware for bootloader product is
> ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.
> 
> But for the 9x60 SKU, there are three variants of FW, which cannot be
> differenticate just with hw_variant and device_revision_id.
> So, to pick the appropriate FW file for 9x60 SKU, three fields,
> hw_variant, hw_revision, and fw_revision, needs to be used rather than
> hw_variant and device_revision_id.
> 
> Format will be like this:
> ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi and .ddc
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 56 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 49 insertions(+), 7 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

