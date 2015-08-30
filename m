Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_intel: Retrieve host-wake IRQ
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440848299-856-1-git-send-email-loic.poulain@intel.com>
Date: Sun, 30 Aug 2015 13:55:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <53A36767-71AC-4A5A-84AC-4636A49D9869@holtmann.org>
References: <1440848299-856-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> An IRQ can be retrieved from the pdev resources. This irq will be used
> in case of LPM suspend mode to wake-up the host and resume the link.
> This resource can be declared as a GPIO-Interrupt which requires to be
> converted into IRQ.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: move irq claim into set_power
> v3: Remove unused variable 'err' in intel_probe
> 
> drivers/bluetooth/hci_intel.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 61 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

