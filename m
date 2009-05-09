Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 8 May 2009 17:01:00 -0700
Subject: RE: bluetooth: module_refcount is not decreased when connection
 times out
Message-ID: <477F20668A386D41ADCC57781B1F704301E6295717@SC-VEXCH1.marvell.com>
References: <477F20668A386D41ADCC57781B1F704301E62956E5@SC-VEXCH1.marvell.com>
 <1241825239.4903.71.camel@localhost.localdomain>
In-Reply-To: <1241825239.4903.71.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Bing,
>=20
> > The module refcount is increased by hci_dev_hold() call in hci_conn_add=
() in hci_conn.c, and it is
> decreased by hci_dev_put() call in "del_conn" (hci_sysfs.c).
> >
> > In case connection timeout happens, hci_dev_put() is never called.
>=20
> can you test the attached patch for quickly. It should fix it.
>=20
> Regards
>=20
> Marcel


Hi Marcel,

It seems that hdev is "put" twice with the patch, if the connection fails.

# hciconfig hci0 up
# lsmod | grep btusb				-> "used by" refcount =3D 1

# hcitool cc <non-exisiting bdaddr>		-> will get timeout
# lsmod | grep btusb				-> "used by" refcount =3D 0 (??)

# hcitool cc <non-exisiting bdaddr>		-> time out again
# lsmod | grep btusb				-> "used by" refcount =3D 4294967295 (??)


Thanks,

Bing
