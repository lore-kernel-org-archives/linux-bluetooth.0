Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Apr 2012 10:16:22 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2] Bluetooth: Fix registering hci with duplicate name
Message-ID: <20120418071620.GB19228@aemeltch-MOBL1>
References: <1334670087-2622-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334670087-2622-1-git-send-email-ulisses@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Apr 17, 2012 at 10:41:27AM -0300, Ulisses Furquim wrote:
> When adding HCI devices hci_register_dev assigns the same name
> hci1 for subsequently added AMP devices.
> 
> ...
> [ 6958.381886] sysfs: cannot create duplicate filename
>        '/devices/virtual/bluetooth/hci1
> ...
> 
> We assume id starts with the number we'll try to add the new device
> and keep iterating until we find the proper place. The only difference
> is we start with 0 for BR/EDR device and 1 for AMP devices (thus AMP
> devices will never receive register as index 0). Then every hdev->id in
> the _ordered_ list <= to the id we want we increment id and move the
> variable head. In the end we'll have id as the first available one and
> head is where you need to add hdev after to keep the list ordered.
> 
> Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
> 
> v2 - only increment id when we find it's already there in the list.
> 
> ---
>  net/bluetooth/hci_core.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c4dc263..e2202a1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1754,9 +1754,12 @@ int hci_register_dev(struct hci_dev *hdev)
>  
>  	/* Find first available device id */
>  	list_for_each(p, &hci_dev_list) {
> -		if (list_entry(p, struct hci_dev, list)->id != id)
> +		int nid = list_entry(p, struct hci_dev, list)->id;

this looks bad IMO, better use hdev = list_entry

> +		if (nid > id)
>  			break;
> -		head = p; id++;
> +		if (nid == id)
> +			id++;
> +		head = p;
>  	}

This does not work when creating 3rd AMP device:

[  121.925367] Bluetooth: Chosen id 1
[  121.958056] Created virtual AMP device hci1

[  131.588553] Bluetooth: 	list: hdev->id 1 id 1
[  131.661149] Bluetooth: Chosen id 2

[  131.681159] Created virtual AMP device hci2
[  139.904674] Bluetooth: 	list: hdev->id 2 id 1
[  139.943904] Bluetooth: Chosen id 1
[  139.944780] ------------[ cut here ]------------
[  139.957882] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
...

I suspect that you have to handle 2 cases when you add new device after or
before head otherwise list gets un-ordered.

I put debug prints like below:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aca8398..bbc42bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1801,6 +1801,7 @@ int hci_register_dev(struct hci_dev *hdev)
        /* Find first available device id */
        list_for_each(p, &hci_dev_list) {
                int nid = list_entry(p, struct hci_dev, list)->id;
+               BT_ERR("\tlist: hdev->id %d id %d", nid, id);
                if (nid > id)
                        break;
                if (nid == id)
@@ -1808,6 +1809,8 @@ int hci_register_dev(struct hci_dev *hdev)
                head = p;
        }
 
+       BT_ERR("Chosen id %d", id);
+
        sprintf(hdev->name, "hci%d", id);
        hdev->id = id;


Best regards 
Andrei Emeltchenko 
