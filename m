Return-Path: <cyrus@holtmann.org>
From: "Keren, Doron" <doronkeren@ti.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Ilia, Kolominsky" <iliak@ti.com>, "Hadar, Amir" <a-hadar@ti.com>
Date: Thu, 18 Aug 2011 13:21:39 +0200
Subject: RE: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
Message-ID: <13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
 <1313617329.3373.188.camel@aeonflux>
In-Reply-To: <1313617329.3373.188.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, August 18, 2011 12:42 AM
> To: doron.keren.bluez@gmail.com
> Cc: linux-bluetooth@vger.kernel.org; Keren, Doron; Ilia, Kolominsky
> Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HC=
I
> connection name.
>=20
> Hi Doron,
>=20
> > The patch fixes kernel panic which is due to race condition
> > between the setup of incomming connection and clean-up of the
> > dead one. Observed in the following case: attached HID device
> > disconnects unexpectedly (without performing ACL disconnect ),
> > the device tries to connect again before the ACL link time-out
> > fires, this translates to the HCI_DISCONNECT, HCI_CONNECT_REQ
> > events on the same handle, since HCI_DISCONNECT trigers the clean
> > up of the HID device and handled in different context, the
> > linking/unlinking connection object to sysfs, may mess up.
> >
> > Signed-off-by: Ilia Kolominsky <iliak@ti.com>
> > ---
> >  net/bluetooth/hci_sysfs.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > index a6c3aa8..5967d63 100644
> > --- a/net/bluetooth/hci_sysfs.c
> > +++ b/net/bluetooth/hci_sysfs.c
> > @@ -9,6 +9,7 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> >
> > +static int acl_conn_index =3D 0;
> >  static struct class *bt_class;
> >
> >  struct dentry *bt_debugfs;
> > @@ -91,7 +92,8 @@ static void add_conn(struct work_struct *work)
> >  	struct hci_conn *conn =3D container_of(work, struct hci_conn,
> work_add);
> >  	struct hci_dev *hdev =3D conn->hdev;
> >
> > -	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
> > +	acl_conn_index++;
> > +	dev_set_name(&conn->dev, "%s:%d:%d", hdev->name, conn->handle,
> acl_conn_index);
> >
> >  	dev_set_drvdata(&conn->dev, conn);
>=20
> can we get a bit more of details on what this is actually trying to
> solve. I do not like this way of solving it at all. I think it is trying
> to cover up symptoms and not fixing the real issue.
>=20
> Regards
>=20
> Marcel
>=20

The scenario that causes the kernel panic Happens when HID device disconnec=
t and connect fast. When HID device disconnects the name clean-up appears 1=
00-300msec after the "hci_disconn_complete_evt()", because the two L2CAP ch=
annels need to be closed first.
The problem is that the base-band has already cleaned the handle number whe=
n the "hci_disconn_complete_evt()" sent. If another connection is initiatin=
g right after, the base-band will send "hci_conn_request_evt()" with the sa=
me handle number. During this time we have situation that two HCI connectio=
ns has the same name, because the handle number from the base-band is the s=
ame. There is no reason for the two HCI connections to share the same resou=
rce, name. This duplicate name situation will cause Kernel panic.

The real issue is that the HCI device connection name is saved in the SYSFS=
=20
In the format: "/devices/virtual/bluetooth/hci0/hci0:1"
The name in this format depends just on the base-band handle that received =
in the "hci_conn_complete_evt()". The device name is cleaned just when the
Variable conn->devref becomes 0.
In the source code:
    if (atomic_dec_and_test(&conn->devref))
	  	hci_conn_del_sysfs(conn);

The incremental index in the name format: "/devices/virtual/bluetooth/hci0/=
hci0:1:<Index>"
Solves the problem of two HCI connections with the same name.

Regards,
Doron
