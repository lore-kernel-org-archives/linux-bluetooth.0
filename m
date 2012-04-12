Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 13:03:30 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix registering HCI devices with duplicate
 name
Message-ID: <20120412100328.GF5341@aemeltch-MOBL1>
References: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
 <20120412073829.GC5341@aemeltch-MOBL1>
 <1334224208.16897.138.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334224208.16897.138.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On Thu, Apr 12, 2012 at 11:50:08AM +0200, Marcel Holtmann wrote:
> > > @@ -1751,13 +1751,14 @@ int hci_register_dev(struct hci_dev *hdev)
> > >  	/* Do not allow HCI_AMP devices to register at index 0,
> > >  	 * so the index can be used as the AMP controller ID.
> > >  	 */
> > > -	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> > > +	min_id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
> > >  
> > >  	write_lock(&hci_dev_list_lock);
> > >  
> > >  	/* Find first available device id */
> > >  	list_for_each(p, &hci_dev_list) {
> > > -		if (list_entry(p, struct hci_dev, list)->id != id)
> > > +		if (min_id >= id &&
> > > +		    list_entry(p, struct hci_dev, list)->id != id)
> > >  			break;
> > 
> > I have tested a bit and sometimes this does not work, apparently you need
> > to change
> > 
> > <------8<------------------------------------
> > |
> > |@@ -1813,7 +1813,7 @@ int hci_register_dev(struct hci_dev *hdev)
> > | 
> > |          sprintf(hdev->name, "hci%d", id);
> > |          hdev->id = id;
> > |  -       list_add_tail(&hdev->list, head);
> > |  +       list_add(&hdev->list, head);
> > |
> > |          mutex_init(&hdev->lock);
> > |
> > <------8<------------------------------------
> >
> > Otherwise it does not allow to create second AMP:
> > 
> > [   97.055459] Create virtual AMP device
> > [   97.083333] Bluetooth: min_id 1 id 1
> > [  180.063159] Create virtual AMP device
> > [  180.140567] Bluetooth: min_id 1 id 0
> > [  180.182268] ------------[ cut here ]------------
> > [  180.200463] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
> > [  180.253814] sysfs: cannot create duplicate filename
> > '/class/bluetooth/hci0'
> 
> that makes sense. Since if the list is not ordered, we are obviously
> failing here to pick the right id. So it is important that we keep our
> list ordered.
> 
> > But even with this I still get sometimes errors below after
> > adding/removing virtual AMPs.
> > 
> > [  219.358959] Bluetooth: min_id 1 id 4
> > [  219.367534] ------------[ cut here ]------------
> > [  219.373130] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
> > [  219.386933] sysfs: cannot create duplicate filename
> > '/devices/virtual/bluetooth/hci4'
> 
> Can you print out the order of the list when this happens. Something is
> fishy here. And I bet it is broken for a while now. Just that nobody has
> really noticed yet.

I had hci0...hci4 then removed hci3 and created again and it chooses hci4.
This is because logic is not smart and just checks hdev->id != id

[  162.994073] Create virtual AMP device
[  163.018114] Bluetooth: min_id 1 id 3
[  166.452585] Create virtual AMP device
[  166.508589] Bluetooth: min_id 1 id 4
[  197.062710] Clean up virtual AMP device => hci3
[  202.391750] Create virtual AMP device
[  202.425382] Bluetooth: min_id 1 id 4
[  202.428386] ------------[ cut here ]------------
[  202.431338] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9b/0xd0()
[  202.541644] sysfs: cannot create duplicate filename
'/devices/virtual/bluetooth/hci4'

> > BTW: Have you checked my patch version 3.
> 
> If we have to run through that list twice, then we are doing something
> wrong. Also having to run through the whole list seems pointless. We
> just need to make sure that the list stays ordered.

We are not running through the whole list, just until found free id.

Best regards 
Andrei Emeltchenko 
