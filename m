Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334316099-18492-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1334316099-18492-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 13 Apr 2012 13:25:35 -0300
Message-ID: <CAA37ikaFf+=9yR_qa6_QFNjOxAf3DZ5D_R7kZ28ZycjuVaLSsg@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] Bluetooth: Fix registering hci with duplicate name
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Apr 13, 2012 at 8:21 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
>
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> When adding HCI devices hci_register_dev may assigns the same name
> hciX for subsequently added HCI devices. Use bitmask to find free
> device ID the same way as it is done in other subsystems.
>
> ...
> [ 6958.381886] sysfs: cannot create duplicate filename
>        '/devices/virtual/bluetooth/hci1
> ...
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 +++
>  net/bluetooth/hci_core.c    |   28 ++++++++++++++++------------
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 346f087..38b837b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -56,6 +56,9 @@
>  #define HCI_BREDR      0x00
>  #define HCI_AMP                0x01
>
> +/* First BR/EDR Controller shall have ID = 0 */
> +#define HCI_BREDR_ID   0
> +
>  /* HCI device quirks */
>  enum {
>        HCI_QUIRK_NO_RESET,
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 52c7abf..9596a82 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1740,31 +1740,35 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
>  /* Register HCI device */
>  int hci_register_dev(struct hci_dev *hdev)
>  {
> -       struct list_head *head = &hci_dev_list, *p;
> +       struct hci_dev *d;
>        int i, id, error;
> +       unsigned long *inuse;
>
>        BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
>
>        if (!hdev->open || !hdev->close)
>                return -EINVAL;
>
> -       /* Do not allow HCI_AMP devices to register at index 0,
> -        * so the index can be used as the AMP controller ID.
> -        */
> -       id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> +       inuse = (unsigned long *) get_zeroed_page(GFP_KERNEL);
> +       if (!inuse)
> +               return -ENOMEM;
>
>        write_lock(&hci_dev_list_lock);
>
> -       /* Find first available device id */
> -       list_for_each(p, &hci_dev_list) {
> -               if (list_entry(p, struct hci_dev, list)->id != id)
> -                       break;
> -               head = p; id++;
> -       }
> +       /* Index HCI_BREDR_ID reserved for BR/EDR controllers */
> +       if (hdev->dev_type != HCI_BREDR)
> +               set_bit(HCI_BREDR_ID, inuse);
> +
> +       list_for_each_entry(d, &hci_dev_list, list)
> +               set_bit(d->id, inuse);
> +
> +       id = find_first_zero_bit(inuse, PAGE_SIZE * 8);
> +       free_page((unsigned long) inuse);
>
>        sprintf(hdev->name, "hci%d", id);
>        hdev->id = id;
> -       list_add_tail(&hdev->list, head);
> +
> +       list_add_tail(&hdev->list, &hci_dev_list);

Well, I don't like this bitmask approach, really. We used to have this
list ordered and the code was doing that before we added the
restriction of index 0 for AMP devices, I think. Using a bitmask looks
overkill to me when we can probably modify the loop to find the first
available ID. Marcel even suggested an approach with a pseudo code
that seems to be the best way to go. Something along the lines of:

       list_for_each(p, &hci_dev_list) {
               if (list_entry(p, struct hci_dev, list)->id > id)
/* just replacing != with > */
                       break;
               head = p; id++;
       }

We assume id starts with the number we'll try to add the new device
and keep iterating until we find the proper place. The only difference
is we start with 0 for BR/EDR and 1 for AMP devices. Then every
hdev->id in the _ordered_ list <= to the id we want we increment id
and move head. In the end we'll have id as the first available one and
head is where you need to add hdev (before head) to the list to keep
it ordered. Right? Does that work for you? Am I missing anything here?

Best regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
