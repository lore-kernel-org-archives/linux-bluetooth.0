Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 10:22:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/12] Bluetooth: Add basic start/complete HCI
 transaction functions
Message-ID: <20130215082236.GA5232@x220>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
 <1360767045-26958-3-git-send-email-johan.hedberg@gmail.com>
 <CACJA=fWD8mvxvY-WRq-j2c284-SkezbS05KVp_bGwcdKN6yn9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACJA=fWD8mvxvY-WRq-j2c284-SkezbS05KVp_bGwcdKN6yn9g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Feb 14, 2013, Andre Guedes wrote:
> > +int hci_start_transaction(struct hci_dev *hdev)
> > +{
> > +       struct hci_transaction *transaction;
> > +       int err;
> > +
> > +       hci_transaction_lock(hdev);
> > +
> > +       /* We can't start a new transaction if there's another one in
> > +        * progress of being built.
> > +        */
> > +       if (hdev->build_transaction) {
> > +               err = -EBUSY;
> > +               goto unlock;
> > +       }
> > +
> > +       transaction = kmalloc(sizeof(*transaction), GFP_ATOMIC);
> 
> I've failed to see why we need GFP_ATOMIC here. As this code is not
> running in any atomic section, we can allocate memory using
> GFP_KERNEL.

Since one of the intentions of this API is to create an async version of
hci_request() I think it's better to keep GFP_ATOMIC here. One situation
where you couldn't for sure use hci_request() is if you're in an atomic
section and then a HCI request would be the only other alternative.

> > +       if (!transaction) {
> > +               err = -ENOMEM;
> > +               goto unlock;
> > +       }
> > +
> > +       memset(transaction, 0, sizeof(*transaction));
> 
> We can also use kzalloc instead of kmalloc, making this memset unnecessary.

Good point. Fixed in v2.

Johan
