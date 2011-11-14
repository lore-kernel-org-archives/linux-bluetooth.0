Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 1/3] Bluetooth: Allow to set AMP type for virtual HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Nov 2011 18:47:59 +0900
In-Reply-To: <1321263947-14724-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321263947-14724-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321263947-14724-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321264082.15441.466.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Type can be changed during re-opening device /dev/vhci.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 2e302a1..13e734f 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -41,6 +41,8 @@
>  
>  #define VERSION "1.3"
>  
> +static bool amp;
> +
>  struct vhci_data {
>  	struct hci_dev *hdev;
>  
> @@ -239,6 +241,9 @@ static int vhci_open(struct inode *inode, struct file *file)
>  	hdev->bus = HCI_VIRTUAL;
>  	hdev->driver_data = data;
>  
> +	if (amp)
> +		hdev->dev_type = HCI_AMP;
> +
>  	hdev->open     = vhci_open_dev;
>  	hdev->close    = vhci_close_dev;
>  	hdev->flush    = vhci_flush;
> @@ -303,6 +308,9 @@ static void __exit vhci_exit(void)
>  module_init(vhci_init);
>  module_exit(vhci_exit);
>  
> +module_param(amp, bool, 0644);
> +MODULE_PARM_DESC(amp, "AMP HCI device type");
> +

actually "Create AMP controller device" would be a better description.

Regards

Marcel


