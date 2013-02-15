Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 11:06:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 02/12] Bluetooth: Add basic start/complete HCI
 transaction functions
Message-ID: <20130215090604.GB10022@x220>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
 <CACJA=fWD8mvxvY-WRq-j2c284-SkezbS05KVp_bGwcdKN6yn9g@mail.gmail.com>
 <20130215082236.GA5232@x220>
 <22685873.dZ0kFmHBbe@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22685873.dZ0kFmHBbe@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 15, 2013, Szymon Janc wrote:
> On Friday 15 of February 2013 10:22:36 Johan Hedberg wrote:
> > > > +int hci_start_transaction(struct hci_dev *hdev)
> > > > +{
> > > > +       struct hci_transaction *transaction;
> > > > +       int err;
> > > > +
> > > > +       hci_transaction_lock(hdev);
> > > > +
> > > > +       /* We can't start a new transaction if there's another one in
> > > > +        * progress of being built.
> > > > +        */
> > > > +       if (hdev->build_transaction) {
> > > > +               err = -EBUSY;
> > > > +               goto unlock;
> > > > +       }
> > > > +
> > > > +       transaction = kmalloc(sizeof(*transaction), GFP_ATOMIC);
> > > 
> > > I've failed to see why we need GFP_ATOMIC here. As this code is not
> > > running in any atomic section, we can allocate memory using
> > > GFP_KERNEL.
> > 
> > Since one of the intentions of this API is to create an async version of
> > hci_request() I think it's better to keep GFP_ATOMIC here. One situation
> > where you couldn't for sure use hci_request() is if you're in an atomic
> > section and then a HCI request would be the only other alternative.
> 
> You lock mutex in hci_start_transaction so it is non-atomic anyway..

This has me a bit confused since hci_dev_lock() also uses the same. Does
this mean that there's no code at all in the Bluetooth subsystem anymore
that can run in atomic context? (since most things require locking at
least the hdev struct). I remember seeing some time back (after the
whole workqueue conversion) bugs arising from incorrect GFP_ATOMIC ->
GFP_KERNEL conversions (none of which luckily made it to Linus' tree), so at
least some parts seemed to still be atomic. Do a grep for GFP_ATOMIC in
net/bluetooth/ and you'll find plenty of them.

Johan
