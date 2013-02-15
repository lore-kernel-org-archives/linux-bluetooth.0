Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 02/12] Bluetooth: Add basic start/complete HCI transaction functions
Date: Fri, 15 Feb 2013 09:36:03 +0100
Message-ID: <22685873.dZ0kFmHBbe@uw000953>
In-Reply-To: <20130215082236.GA5232@x220>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com> <CACJA=fWD8mvxvY-WRq-j2c284-SkezbS05KVp_bGwcdKN6yn9g@mail.gmail.com> <20130215082236.GA5232@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Friday 15 of February 2013 10:22:36 Johan Hedberg wrote:
> > > +int hci_start_transaction(struct hci_dev *hdev)
> > > +{
> > > +       struct hci_transaction *transaction;
> > > +       int err;
> > > +
> > > +       hci_transaction_lock(hdev);
> > > +
> > > +       /* We can't start a new transaction if there's another one in
> > > +        * progress of being built.
> > > +        */
> > > +       if (hdev->build_transaction) {
> > > +               err = -EBUSY;
> > > +               goto unlock;
> > > +       }
> > > +
> > > +       transaction = kmalloc(sizeof(*transaction), GFP_ATOMIC);
> > 
> > I've failed to see why we need GFP_ATOMIC here. As this code is not
> > running in any atomic section, we can allocate memory using
> > GFP_KERNEL.
> 
> Since one of the intentions of this API is to create an async version of
> hci_request() I think it's better to keep GFP_ATOMIC here. One situation
> where you couldn't for sure use hci_request() is if you're in an atomic
> section and then a HCI request would be the only other alternative.

You lock mutex in hci_start_transaction so it is non-atomic anyway..

-- 
BR
Szymon Janc

