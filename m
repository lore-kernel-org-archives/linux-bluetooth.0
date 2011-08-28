Return-Path: <cyrus@holtmann.org>
From: "Keren, Doron" <doronkeren@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "Ilia, Kolominsky" <iliak@ti.com>,
        "Hadar, Amir" <a-hadar@ti.com>
Date: Sun, 28 Aug 2011 17:16:36 +0200
Subject: FW: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
Message-ID: <13872098A06B02418CF379A158C0F1460162EB4DEB@dnce02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

Please read further explanation in the lines below...

Thanks,
Doron

> >> -----Original Message-----
> >> From: David Herrmann [mailto:dh.herrmann@googlemail.com]
> >> Sent: Thursday, August 18, 2011 3:38 PM
> >> To: Keren, Doron
> >> Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs
> HCI
> >> connection name.
> >>
> >> Hi Doron
> >>
> >> On Thu, Aug 18, 2011 at 2:25 PM, Keren, Doron <doronkeren@ti.com>
> wrote:
> >> > Hi David,
> >> >
> >> > Please write how did you reproduce the scenario?
> >> > I'm repeating the scenario by connecting to HID keyboard (Logitech).
> >> > After the connection I'm pulling out the HID device batteries and
> >> > Return the batteries fast before any Bluetooth timeout. Even with
> this
> >>
> >> I use a bluetooth HID device, shut it down and reconnect. The bug
> >> triggers quite randomly so I can't tell when it happens. It doesn't
> >> matter what device I use.
> >>
> >> > Action it takes several times (~up to 10) to cause the kernel panic.
> >> > My fix solves this kernel panic.
> >>
> >> I still get kernel panics. I don't get the sysfs-oops anymore, but
> >> hidp_add_connection() still fails. As it happens quite randomly, I
> >> can't reproduce it.
> >>
> >> > Regards,
> >> > Doron
> >>
> >> Cheers
> >> David
> >
> > I got the kernel panic before the fix, when the
> "hci_conn_complete_evt()"
> > comes and call "hci_conn_add_sysfs()", before the "hidp_session()"
> finished
> > and call "hci_conn_del_sysfs()".
> > The HID device reconnects when the HID session waits for the 2 L2CAP
> > channels delete event.
> > The base-band is getting the reconnect attempt and because it is the
> same
> > device that is still connected, it sends immediately DISCONNECT and the=
n
> > > CONNECT events with the same handle number.
>=20
> > Why didn't you write that in your first email? ;) I now understand the
> > issue. New connections are added in atomic-context, but the removal of
> > old connections may sleep, so new connections may be initiated even
> > though the removal of the old is still in progress. Locking doesn't
> > apply here so a counter is the only way.
>=20
> > My bug may be related to something else. I will try to investigate
> > further but currently don't have time.
>=20
> > BR,
> > Doron
> >
>=20
> > I recommend writing your explanation to the list again and CC Marcel.
>=20
> > Thanks
> > David
