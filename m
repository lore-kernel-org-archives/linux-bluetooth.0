Return-Path: <hidave.darkstar@gmail.com>
Message-ID: <a8e1da0710310206j1b3571f9rf4074f55f9024b94@mail.gmail.com>
Date: Wed, 31 Oct 2007 17:06:27 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH]bluetooth: hci_sysfs connection bus_id add support for diffrent hci device
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sourceforge.net
In-Reply-To: <20071031.000141.241824894.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
	 <20071031.000141.241824894.davem@davemloft.net>
List-ID: <bluez-devel.lists.sourceforge.net>

On 10/31/07, David Miller <davem@davemloft.net> wrote:
> From: Dave Young <hidave.darkstar@gmail.com>
> Date: Wed, 31 Oct 2007 10:30:17 +0800
>
> > diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
> > --- linux/net/bluetooth/hci_sysfs.c   2007-10-31 10:21:00.000000000 +0800
> > +++ linux.new/net/bluetooth/hci_sysfs.c       2007-10-31 10:21:55.000000000 +0800
> > @@ -302,7 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn
> >       conn->dev.release = bt_release;
> >
> >       snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> > -                     "%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > +                     "%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > +                     hdev->name,
> >                       conn->type == ACL_LINK ? "acl" : "sco",
> >                       ba->b[5], ba->b[4], ba->b[3],
> >                       ba->b[2], ba->b[1], ba->b[0]);
>
> This might not work.
>
> Your device's name is already 15 characters long,
> BUS_ID_SIZE is 20, and it seems hdev->name could
> easily overflow the 4 or 5 characters of space
> remaining.
>
Yes, this is possible due to hdev->name length is 8.

The space for it ist 5 characters. IMHO,in normal usage 'hciX' is
unlikely over this limit.

Any better ideas?
