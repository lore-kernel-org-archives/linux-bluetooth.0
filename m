Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NoWi2ujbMW8vXbwfZpS56+HNtEm8s5N__yXTJjADTPhQ@mail.gmail.com>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
 <1380668636-30654-6-git-send-email-andre.guedes@openbossa.org> <CAJdJm_NoWi2ujbMW8vXbwfZpS56+HNtEm8s5N__yXTJjADTPhQ@mail.gmail.com>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Thu, 3 Oct 2013 11:04:56 -0300
Message-ID: <CACJA=fVMZEkLuOjP8dAd6T5d_tSH49V-TqZ=yrLfJW4cc5nG9A@mail.gmail.com>
Subject: Re: [PATCH 5/7] Bluetooth: Refactor hci_connect_le
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 1, 2013 at 9:05 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>
> Hi Guedes,
>
> On Tue, Oct 1, 2013 at 7:03 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> > +       /* If already exists a hci_conn object for the following connection
> > +        * attempt, we simply update pending_sec_level and auth_type fields
> > +        * and return the object found.
> > +        */
>
> Small textual improvement: "If a hci_conn object already exists [...]"

I'll fix it.

>
>
>
> >         le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> > -       if (!le) {
> > -               le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> > -               if (le)
> > -                       return ERR_PTR(-EBUSY);
> > -
> > -               le = hci_conn_add(hdev, LE_LINK, dst);
> > -               if (!le)
> > -                       return ERR_PTR(-ENOMEM);
> > -
> > -               le->dst_type = bdaddr_to_le(dst_type);
> > -               le->state = BT_CONNECT;
> > -               le->out = true;
> > -               le->link_mode |= HCI_LM_MASTER;
> > -               le->sec_level = BT_SECURITY_LOW;
> > -
> > -               err = hci_initiate_le_connection(hdev, &le->dst, le->dst_type);
> > -               if (err) {
> > -                       hci_conn_del(le);
> > -                       return ERR_PTR(err);
> > -               }
> > +       if (le) {
> > +               le->pending_sec_level = sec_level;
> > +               le->auth_type = auth_type;
> > +               goto out;
> >         }
> >
> > -       le->pending_sec_level = sec_level;
> > +       /* Since the controller supports only one LE connection attempt at the
> > +        * time, we return busy if there is any connection attempt running.
> > +        */
>
> s/at the time/at a time/
> s/busy/EBUSY/

I'll fix it.

>
>
>
> > +       le = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> > +       if (le)
> > +               return ERR_PTR(-EBUSY);
> > +
> > +       le = hci_conn_add(hdev, LE_LINK, dst);
> > +       if (!le)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       le->dst_type = bdaddr_to_le(dst_type);
> > +       le->state = BT_CONNECT;
> > +       le->out = true;
> > +       le->link_mode |= HCI_LM_MASTER;
> > +       le->sec_level = BT_SECURITY_LOW;
> > +       le->pending_sec_level = BT_SECURITY_LOW;
>
> I think the previous statement should be:
>
> le->pending_sec_level = sec_level;
>
> Otherwise, we are changing semantics.

Yes, you're right. I'll fix this.

>
>
> >         le->auth_type = auth_type;
> >
> > -       hci_conn_hold(le);
> > +       err = hci_initiate_le_connection(hdev, &le->dst, le->dst_type);
> > +       if (err) {
> > +               hci_conn_del(le);
> > +               return ERR_PTR(err);
> > +       }
> >
> > +out:
> > +       hci_conn_hold(le);
> >         return le;
> >  }

Thanks for reviewing,

Andre
