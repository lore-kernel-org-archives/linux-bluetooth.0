Return-Path: <cyrus@holtmann.org>
Message-ID: <1334135883.16897.94.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix registering hci with duplicate name
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Apr 2012 11:18:03 +0200
In-Reply-To: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When adding HCI devices hci_register_dev assigns the same name
> hci1 for subsequently added AMP devices. Find free device id
> the same way as it is done in netdev.
> 
> ...
> [ 6958.381886] sysfs: cannot create duplicate filename
> 	'/devices/virtual/bluetooth/hci1
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   43 ++++++++++++++++++++++++++++---------------
>  1 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 52c7abf..7ea7a02 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1737,10 +1737,35 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  	return 0;
>  }
>  
> +/* Invoked locked */
> +static int __hci_alloc_name(struct hci_dev *hdev)
> +{

I think the name is pretty bad since it does not do any memory
allocation here.

> +	struct hci_dev *d;
> +	unsigned long inuse = 0;
> +	int i, id;
> +
> +	list_for_each_entry(d, &hci_dev_list, list) {
> +		set_bit(d->id, &inuse);
> +	}
> +
> +	i = find_first_zero_bit(&inuse, sizeof(inuse));
> +
> +	/* Do not allow HCI_AMP devices to register at index 0,
> +	 * so the index can be used as the AMP controller ID.
> +	 */
> +	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> +
> +	id = max_t(int, i, id);
> +
> +	sprintf(hdev->name, "hci%d", id);
> +	hdev->id = id;
> +
> +	return id;
> +}
> +
>  /* Register HCI device */
>  int hci_register_dev(struct hci_dev *hdev)
>  {
> -	struct list_head *head = &hci_dev_list, *p;
>  	int i, id, error;
>  
>  	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
> @@ -1748,23 +1773,11 @@ int hci_register_dev(struct hci_dev *hdev)
>  	if (!hdev->open || !hdev->close)
>  		return -EINVAL;
>  
> -	/* Do not allow HCI_AMP devices to register at index 0,
> -	 * so the index can be used as the AMP controller ID.
> -	 */
> -	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> -
>  	write_lock(&hci_dev_list_lock);
>  
> -	/* Find first available device id */
> -	list_for_each(p, &hci_dev_list) {
> -		if (list_entry(p, struct hci_dev, list)->id != id)
> -			break;
> -		head = p; id++;
> -	}
> +	id = __hci_alloc_name(hdev);
>  
> -	sprintf(hdev->name, "hci%d", id);
> -	hdev->id = id;
> -	list_add_tail(&hdev->list, head);
> +	list_add_tail(&hdev->list, &hci_dev_list);

Do we really need a separate function here. Can you just not fix this
inline?

Regards

Marcel


