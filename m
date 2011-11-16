Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv4 2/5] Bluetooth: Allow to set AMP type for virtual HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 16 Nov 2011 14:48:24 +0900
In-Reply-To: <1321366547-29462-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321366547-29462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321366547-29462-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321422506.15441.511.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Type can be changed during re-opening device /dev/vhci.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/hci_vhci.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 2e302a1..ac08adc 100644
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
> @@ -239,6 +241,11 @@ static int vhci_open(struct inode *inode, struct file *file)
>  	hdev->bus = HCI_VIRTUAL;
>  	hdev->driver_data = data;
>  
> +	if (amp) {
> +		hdev->dev_type = HCI_AMP;
> +		hdev->amp_status = AMP_CTRL_BLUETOOTH_ONLY;
> +	}
> +

I do not like doing this. You are not squeezing two patches into one.
Please keep them separate. I already acked the previous one.

Regards

Marcel


