Return-Path: <cyrus@holtmann.org>
Message-ID: <1334865892.16897.299.camel@aeonflux>
Subject: Re: [PATCH v3] Bluetooth: Fix registering hci with duplicate name
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 19 Apr 2012 22:04:52 +0200
In-Reply-To: <CAA37ikYC+4s69RPksnUH6N4jDe=4bgSAvhX-vqK6kDr4G3x4Sg@mail.gmail.com>
References: <1334761984-5400-1-git-send-email-ulisses@profusion.mobi>
	 <20120419070846.GC16002@aemeltch-MOBL1>
	 <CAA37ikYC+4s69RPksnUH6N4jDe=4bgSAvhX-vqK6kDr4G3x4Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> > On Wed, Apr 18, 2012 at 12:13:04PM -0300, Ulisses Furquim wrote:
> >> When adding HCI devices hci_register_dev assigns the same name
> >> hci1 for subsequently added AMP devices.
> >>
> >> ...
> >> [ 6958.381886] sysfs: cannot create duplicate filename
> >>        '/devices/virtual/bluetooth/hci1
> >> ...
> >>
> >> We assume id starts with the number we'll try to add the new device
> >> and keep iterating until we find the proper place. The only difference
> >> is we start with 0 for BR/EDR device and 1 for AMP devices (thus AMP
> >> devices will never receive register as index 0). Then every hdev->id in
> >> the _ordered_ list <= to the id we want we increment id and move the
> >> variable head. In the end we'll have id as the first available one and
> >> head is where you need to add hdev after to keep the list ordered.
> >>
> >> Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> >> ---
> >>
> >> v3 - really add new hdev after head to keep the list ordered.
> >> v2 - only increment id when we find it's already there in the list.
> >>
> >> ---
> >>  net/bluetooth/hci_core.c |   16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index c4dc263..2b98c33 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -1739,24 +1739,28 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> >>  /* Register HCI device */
> >>  int hci_register_dev(struct hci_dev *hdev)
> >>  {
> >> -     struct list_head *head = &hci_dev_list, *p;
> >> +     struct list_head *head, *p;
> >>       int i, id, error;
> >>
> >>       if (!hdev->open || !hdev->close)
> >>               return -EINVAL;
> >>
> >> +     write_lock(&hci_dev_list_lock);
> >> +
> >>       /* Do not allow HCI_AMP devices to register at index 0,
> >>        * so the index can be used as the AMP controller ID.
> >>        */
> >>       id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> >> -
> >> -     write_lock(&hci_dev_list_lock);
> >> +     head = &hci_dev_list;
> >>
> >>       /* Find first available device id */
> >>       list_for_each(p, &hci_dev_list) {
> >> -             if (list_entry(p, struct hci_dev, list)->id != id)
> >> +             int nid = list_entry(p, struct hci_dev, list)->id;
> >> +             if (nid > id)
> >>                       break;
> >> -             head = p; id++;
> >> +             if (nid == id)
> >> +                     id++;
> >> +             head = p;
> >>       }
> >
> > This looks to be working but I still prefer bitmask approach as it results
> > in simpler code like shown below:
> >
> > <------8<------------------------------------------
> > |  list_for_each_entry(d, &hci_dev_list, list)
> > |          set_bit(d->id, inuse);
> > |
> > |  id = find_first_zero_bit(inuse, PAGE_SIZE * 8);
> > |
> > <------8<------------------------------------------
> >
> > Anyway I leave it to maintainers to decide.
> >
> > Tested-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Well, it's certainly up to them. Thanks for checking anyway. :-) I
> just don't think allocating a page, marking the bits and finding the
> first available is better than the other solution (which was already
> there too). However, we need any fix merged soon as 3.3 seems to be
> affected by this bug. Just plugging two USB dongles on my machine
> gives me the duplicate name error from sysfs. :-/

I am with you here. Allocating the page is a bit too much in my book.
Especially since we already maintainer a sorted list in the first place.

Patch has been applied to bluetooth-next tree.

Regards

Marcel


