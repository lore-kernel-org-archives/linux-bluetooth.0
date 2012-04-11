Return-Path: <cyrus@holtmann.org>
Message-ID: <1334137926.16897.104.camel@aeonflux>
Subject: Re: [PATCHv2] Bluetooth: Fix registering hci with duplicate name
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Apr 2012 11:52:06 +0200
In-Reply-To: <1334137632-30696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334132612-29610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1334137632-30696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
>  net/bluetooth/hci_core.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 52c7abf..eaa6876 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1740,8 +1740,9 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  /* Register HCI device */
>  int hci_register_dev(struct hci_dev *hdev)
>  {
> -	struct list_head *head = &hci_dev_list, *p;
> +	struct hci_dev *d;
>  	int i, id, error;
> +	unsigned long inuse = 0;
>  
>  	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
>  
> @@ -1755,16 +1756,17 @@ int hci_register_dev(struct hci_dev *hdev)
>  
>  	write_lock(&hci_dev_list_lock);
>  
> -	/* Find first available device id */
> -	list_for_each(p, &hci_dev_list) {
> -		if (list_entry(p, struct hci_dev, list)->id != id)
> -			break;
> -		head = p; id++;
> -	}
> +	list_for_each_entry(d, &hci_dev_list, list)
> +		set_bit(d->id, &inuse);
> +
> +	i = find_first_zero_bit(&inuse, sizeof(inuse));
> +
> +	id = max_t(int, i, id);

I am not 100% convinced that this is the best way to fix this. Not that
anybody will attach hundreds of controllers, but it is in theory
possible.

>  
>  	sprintf(hdev->name, "hci%d", id);
>  	hdev->id = id;
> -	list_add_tail(&hdev->list, head);
> +
> +	list_add_tail(&hdev->list, &hci_dev_list);

I am now a little bit confused. Is it not enough to just replace head
with &hci_dev_list to get this fixed? Or why is this failing in the
first place actually.

Also this change will of course break the fix that we added to ensure
that the HCI list comes sorted when calling hciconfig.

Regards

Marcel


