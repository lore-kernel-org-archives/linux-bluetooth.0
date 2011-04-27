Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 16:46:05 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Add automated SSP user confirmation
 responses
Message-ID: <20110427234605.GA3022@jh-x301>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
 <BANLkTinxDHjLjAPqMLys3nxsjkHNnM=x0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTinxDHjLjAPqMLys3nxsjkHNnM=x0A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Apr 27, 2011, Anderson Lizardo wrote:
> On Wed, Apr 27, 2011 at 7:04 PM,  <johan.hedberg@gmail.com> wrote:
> > @@ -2447,14 +2447,47 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
> >                                                        struct sk_buff *skb)
> >  {
> >        struct hci_ev_user_confirm_req *ev = (void *) skb->data;
> > +       int loc_mitm, rem_mitm;
> > +       struct hci_conn *conn;
> >
> >        BT_DBG("%s", hdev->name);
> >
> >        hci_dev_lock(hdev);
> >
> > -       if (test_bit(HCI_MGMT, &hdev->flags))
> > -               mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey);
> > +       if (!test_bit(HCI_MGMT, &hdev->flags))
> > +               goto unlock;
> 
> You lock hdev for checking hdev->flags, but not for reading hdev->name
> on the BT_DBG() call. Is that ok?

I suppose hdev->name can be considered a read-only value as it never
changes after the HCI dev is created. There's also lots of other places
in hci_event.c that access it without locking, so I think this should be
fine.

Johan
