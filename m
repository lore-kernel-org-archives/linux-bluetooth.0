Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Nov 2011 00:26:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add missing hci_dev locking when calling
 mgmt functions
Message-ID: <20111108222610.GA17415@fusion.localdomain>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
 <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
 <CAMXE1-qLHUj_QzkuyT9NQmj+DBVvWLD_djoXG4x_FyVast=_SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMXE1-qLHUj_QzkuyT9NQmj+DBVvWLD_djoXG4x_FyVast=_SQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 08, 2011, Andrei Emeltchenko wrote:
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -549,8 +549,11 @@ int hci_dev_open(__u16 dev)
> >                hci_dev_hold(hdev);
> >                set_bit(HCI_UP, &hdev->flags);
> >                hci_notify(hdev, HCI_DEV_UP);
> > -               if (!test_bit(HCI_SETUP, &hdev->flags))
> > +               if (!test_bit(HCI_SETUP, &hdev->flags)) {
> > +                       hci_dev_lock_bh(hdev);
> >                        mgmt_powered(hdev, 1);
> > +                       hci_dev_unlock_bh(hdev);
> 
> Shall we acquire lock before test_bit here and below?

Once the HCI_SETUP flag has been cleared it never gets set again for a
hci_dev, so in the above case it doesn't really make a difference
whether we lock before or after the test.

> > @@ -1561,8 +1566,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >                kfree_skb(hdev->reassembly[i]);
> >
> >        if (!test_bit(HCI_INIT, &hdev->flags) &&
> > -                                       !test_bit(HCI_SETUP, &hdev->flags))
> > +                                       !test_bit(HCI_SETUP, &hdev->flags)) {
> > +               hci_dev_lock_bh(hdev);
> >                mgmt_index_removed(hdev);
> > +               hci_dev_unlock_bh(hdev);
> > +       }

The same applies for the above. The only question there is about
HCI_INIT. Since we're inside hci_unregister_dev and have already called
hci_dev_do_close I don't think there's any problem here. Furthermore,
the whole test for HCI_INIT looks unnecessary to me since testing for
HCI_SETUP should be enough. I might send a separate patch for that later
(it's anyway unrelated to this locking patch).

Johan
