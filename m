Return-Path: <hidave.darkstar@gmail.com>
Message-ID: <a8e1da0710310213r1e4f3d7ckcbdf2e6bf854745e@mail.gmail.com>
Date: Wed, 31 Oct 2007 17:13:59 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH]bluetooth: hci_sysfs connection bus_id add support for diffrent hci device
Cc: "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sourceforge.net
In-Reply-To: <1193817409.32459.10.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
	 <20071031.000141.241824894.davem@davemloft.net>
	 <1193817409.32459.10.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

On 10/31/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Dave,
>
> > > diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
> > > --- linux/net/bluetooth/hci_sysfs.c 2007-10-31 10:21:00.000000000 +0800
> > > +++ linux.new/net/bluetooth/hci_sysfs.c     2007-10-31 10:21:55.000000000 +0800
> > > @@ -302,7 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn
> > >     conn->dev.release = bt_release;
> > >
> > >     snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> > > -                   "%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > +                   "%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > +                   hdev->name,
> > >                     conn->type == ACL_LINK ? "acl" : "sco",
> > >                     ba->b[5], ba->b[4], ba->b[3],
> > >                     ba->b[2], ba->b[1], ba->b[0]);
> >
> > This might not work.
> >
> > Your device's name is already 15 characters long,
> > BUS_ID_SIZE is 20, and it seems hdev->name could
> > easily overflow the 4 or 5 characters of space
> > remaining.
>
> and should also be not needed since their parents are different. However
> we had to add the connections to a bus. Otherwise the userspace will
> never see them. I have to think about the right solution for this
> problem.

Maybe we can use this instead:
 	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
-			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			"%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			hdev->name + 3,
 			conn->type == ACL_LINK ? "acl" : "sco",
 			ba->b[5], ba->b[4], ba->b[3],
 			ba->b[2], ba->b[1], ba->b[0]);
Regards
dave
