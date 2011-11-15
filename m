Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Nov 2011 14:09:26 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/3] Bluetooth: Allow to set AMP type for virtual HCI
Message-ID: <20111115120918.GA27081@aemeltch-MOBL1>
References: <1321267370-15727-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1321267370-15727-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321267370-15727-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 14, 2011 at 12:42:48PM +0200, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Type can be changed during re-opening device /dev/vhci.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 2e302a1..2ed6ab1 100644
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

I am thinking about changing lines above to:

-       if (amp)
+       if (amp) {
                hdev->dev_type = HCI_AMP;
+               hdev->amp_type = AMP_CTRL_BLUETOOTH_ONLY;
+       }

to indicate that that "the AMP Controller is only used by the Bluetooth
technology and will not be shared with other non-Bluetooth technologies".

Best regards 
Andrei Emeltchenko 

>  	hdev->open     = vhci_open_dev;
>  	hdev->close    = vhci_close_dev;
>  	hdev->flush    = vhci_flush;
> @@ -303,6 +308,9 @@ static void __exit vhci_exit(void)
>  module_init(vhci_init);
>  module_exit(vhci_exit);
>  
> +module_param(amp, bool, 0644);
> +MODULE_PARM_DESC(amp, "Create AMP controller device");
> +
>  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>  MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
>  MODULE_VERSION(VERSION);
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
