Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 10:38:31 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix registering HCI devices with duplicate
 name
Message-ID: <20120412073829.GC5341@aemeltch-MOBL1>
References: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 11, 2012 at 05:32:08PM +0200, Marcel Holtmann wrote:
> When adding HCI devices hci_register_dev assigns the same name
> hci1 for subsequently added AMP devices.
> 
> ...
> [ 6958.381886] sysfs: cannot create duplicate filename
>         '/devices/virtual/bluetooth/hci1
> ...
> 
> Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 52c7abf..4becd28 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1741,7 +1741,7 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  int hci_register_dev(struct hci_dev *hdev)
>  {
>  	struct list_head *head = &hci_dev_list, *p;
> -	int i, id, error;
> +	int i, error, min_id, id = 0;
>  
>  	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
>  
> @@ -1751,13 +1751,14 @@ int hci_register_dev(struct hci_dev *hdev)
>  	/* Do not allow HCI_AMP devices to register at index 0,
>  	 * so the index can be used as the AMP controller ID.
>  	 */
> -	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> +	min_id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
>  
>  	write_lock(&hci_dev_list_lock);
>  
>  	/* Find first available device id */
>  	list_for_each(p, &hci_dev_list) {
> -		if (list_entry(p, struct hci_dev, list)->id != id)
> +		if (min_id >= id &&
> +		    list_entry(p, struct hci_dev, list)->id != id)
>  			break;

I have tested a bit and sometimes this does not work, apparently you need
to change

<------8<------------------------------------
|
|@@ -1813,7 +1813,7 @@ int hci_register_dev(struct hci_dev *hdev)
| 
|          sprintf(hdev->name, "hci%d", id);
|          hdev->id = id;
|  -       list_add_tail(&hdev->list, head);
|  +       list_add(&hdev->list, head);
|
|          mutex_init(&hdev->lock);
|
<------8<------------------------------------

Otherwise it does not allow to create second AMP:

[   97.055459] Create virtual AMP device
[   97.083333] Bluetooth: min_id 1 id 1
[  180.063159] Create virtual AMP device
[  180.140567] Bluetooth: min_id 1 id 0
[  180.182268] ------------[ cut here ]------------
[  180.200463] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
[  180.253814] sysfs: cannot create duplicate filename
'/class/bluetooth/hci0'

But even with this I still get sometimes errors below after
adding/removing virtual AMPs.

[  219.358959] Bluetooth: min_id 1 id 4
[  219.367534] ------------[ cut here ]------------
[  219.373130] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
[  219.386933] sysfs: cannot create duplicate filename
'/devices/virtual/bluetooth/hci4'


BTW: Have you checked my patch version 3.

Best regards 
Andrei Emeltchenko 
