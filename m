Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Bag, Amit K" <amit.k.bag@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH] Bluetooth: btusb: Avoid race condition during
 controller recovery
Date: Wed, 6 Jun 2018 06:23:00 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC22400582F3108@PGSMSX105.gar.corp.intel.com>
References: <1528265020-10202-1-git-send-email-amit.k.bag@intel.com>
In-Reply-To: <1528265020-10202-1-git-send-email-amit.k.bag@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> Observed race condition during controller recovery mechanism resulting the controller not responding to the reset command.
>
> To avoid such race condition need a delay of 2ms soon after the USB re-enumeration and before sending the Reset command which shall allow controller to completely recover and process the Reset command.
>
> BUG=b:64035404
> TEST=Magic tethering, P0 and P1 santiy test cases, kernel-boot log
>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
 > drivers/bluetooth/btusb.c | 9 +++++++++
 > 1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index f73a27ea28cc..c7fce9c11889 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1743,6 +1743,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
 >
> +	/* Observed race condition during controller recovery mechanism
> +	 * resulting the controller not responding to the reset command.
> +	 *
> +	 * To avoid such race condition need a delay of 2ms soon after the
> +	 * USB re-enumeration and before sending the Reset command which shall
> +	 * allow controller to completely recover and process the Reset command.
> +	 */
> +	mdelay(2);
> +

I will provide a new patch. Please ignore this patch. 

Thanks & Regards,
Amit Bag
