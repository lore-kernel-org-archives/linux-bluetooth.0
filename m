Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A1F8B46C-982C-4C37-8730-5993D28F324E@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
 <1380668636-30654-2-git-send-email-andre.guedes@openbossa.org> <A1F8B46C-982C-4C37-8730-5993D28F324E@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Thu, 3 Oct 2013 11:03:14 -0300
Message-ID: <CACJA=fVcO=Jy1mxnp1ntHiTjP8H2wsdECASP3MUd-+cR+OU3Og@mail.gmail.com>
Subject: Re: [PATCH 1/7] Bluetooth: Initialize hci_conn fields in hci_connect_le
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 2, 2013 at 1:57 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Andre,
>
> > This patch moves some hci_conn fields initialization from hci_le_
> > create_connection() to hci_connect_le(). It makes more sense to
> > initialize these fields within the function that creates the hci_
> > conn object.
> >
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> > net/bluetooth/hci_conn.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index d2380e0..f473605 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -54,11 +54,6 @@ static void hci_le_create_connection(struct hci_conn *conn)
> >       struct hci_dev *hdev = conn->hdev;
> >       struct hci_cp_le_create_conn cp;
> >
> > -     conn->state = BT_CONNECT;
> > -     conn->out = true;
> > -     conn->link_mode |= HCI_LM_MASTER;
> > -     conn->sec_level = BT_SECURITY_LOW;
> > -
> >       memset(&cp, 0, sizeof(cp));
> >       cp.scan_interval = __constant_cpu_to_le16(0x0060);
> >       cp.scan_window = __constant_cpu_to_le16(0x0030);
> > @@ -565,6 +560,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> >                       return ERR_PTR(-ENOMEM);
> >
> >               le->dst_type = bdaddr_to_le(dst_type);
> > +             le->state = BT_CONNECT;
> > +             le->out = true;
> > +             le->link_mode |= HCI_LM_MASTER;
> > +             le->sec_level = BT_SECURITY_LOW;
> > +
> >               hci_le_create_connection(le);
> >       }
>
> I do not understand on how this is the same. Maybe the confusion is the use of le-> instead of conn-> as variable for hci_conn. Seems that should be fixed first.

Yes, I don't really like le-> either. I'll replace le-> by conn-> in
this function in a first patch.

Andre
