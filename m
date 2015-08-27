Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/5] Bluetooth: hci_intel: Add intel_device_get function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440689946-13576-2-git-send-email-loic.poulain@intel.com>
Date: Thu, 27 Aug 2015 09:33:47 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <83145518-73A1-46C0-B3B2-C01CBDA3A36C@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Move intel_device searching procedure in a standalone function since it
> will be used from different places in the driver.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 49 +++++++++++++++++++++++++++----------------
> 1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 934b5a7..26a1314 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -93,6 +93,24 @@ static u8 intel_convert_speed(unsigned int speed)
> 	}
> }
> 
> +static struct intel_device *intel_device_get(struct hci_uart *hu)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *idev = list_entry(p, struct intel_device,
> +						       list);
> +
> +		/* tty device and pdev device should share the same parent
> +		 * which is the UART port.
> +		 */
> +		if (hu->tty->dev->parent == idev->pdev->dev.parent)
> +			return idev;
> +	}
> +
> +	return NULL;
> +}
> +

lets see how many times this actually needs to be used. I really want to keep this rather simple.

Regards

Marcel

