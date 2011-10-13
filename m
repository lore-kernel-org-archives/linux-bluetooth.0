Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 13 Oct 2011 17:51:13 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix hci core device initialization
Message-ID: <20111013205113.GJ20892@joana>
References: <1318078729-4158-1-git-send-email-dh.herrmann@googlemail.com>
 <20111010184442.GA6936@joana>
 <CANq1E4S2gngG9CfFSxHUsefA2HTij0-ToGDGjDx1eyOOzLYxRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4S2gngG9CfFSxHUsefA2HTij0-ToGDGjDx1eyOOzLYxRw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-11 14:35:01 +0200]:

> Hi Gustavo
>=20
> On Mon, Oct 10, 2011 at 8:44 PM, Gustavo Padovan <padovan@profusion.mobi>=
 wrote:
> > Hi David,
> >
> > * David Herrmann <dh.herrmann@googlemail.com> [2011-10-08 14:58:47 +020=
0]:
> >
> >> We must not call device_del() if we didn't use device_add(). See modul=
e.c for
> >> comments on that. Therefore, we need to call device_initialize() when =
allocating
> >> the hci device and later device_add() instead of device_register().
> >>
> >> This also fixes a bug when hci_register_dev() failed and we call hci_f=
ree_dev()
> >> without a valid core device. hci_free_dev() segfaults while calling pu=
t_device()
> >> on invalid memory.
> >
> > Please let me know if the following diff also fixes this problem.
> > It seems to fixes other issues like failing in usb_driver_claim_interfa=
ce().
>=20
> Could you elaborate more? I what way does may patch not fix this issue?
>=20
> > =A0 =A0 =A0 =A0Gustavo
> >
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b84458d..ac446a7 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -922,9 +922,6 @@ EXPORT_SYMBOL(hci_alloc_dev);
> > =A0void hci_free_dev(struct hci_dev *hdev)
> > =A0{
> > =A0 =A0 =A0 =A0skb_queue_purge(&hdev->driver_init);
> > -
> > - =A0 =A0 =A0 /* will free via device release */
> > - =A0 =A0 =A0 put_device(&hdev->dev);
>=20
> This does not work. We need to drop a reference here, otherwise this
> function is totally useless except cleaning up the skb queue. In fact,
> this function will be called on an HCI device without having a
> reference.

Yes, I forgot about this put_device magic.

I reconsidered your patches and applied them all. Thanks.

	Gustavo
