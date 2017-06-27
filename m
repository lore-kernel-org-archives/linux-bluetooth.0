Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix unwanted error reporting if no
 bcm dev
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1498583707-10493-1-git-send-email-loic.poulain@intel.com>
Date: Tue, 27 Jun 2017 19:29:22 +0200
Cc: linux-bluetooth@vger.kernel.org, ian@mnementh.co.uk
Message-Id: <D84E5E57-1A1F-4A60-B500-5B2EA6744369@holtmann.org>
References: <1498583707-10493-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> The hci_bcm proto is able to operate without bcm platform device linked
> to its uart port. In that case, firmware can be applied, but there is
> no power operation (no gpio/irq resources mgmt).
> 
> However, the current implementation breaks this use case because of
> reporting a ENODEV error in the bcm setup procedure if bcm_request_irq
> fails (which is the case if no bcm device linked).
> 
> Fix this by removing bcm_request_irq error forwarding.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> Reported-by: Ian Molton <ian@mnementh.co.uk>
> ---
> drivers/bluetooth/hci_bcm.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

