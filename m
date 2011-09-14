Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
From: Marcel Holtmann <marcel@holtmann.org>
To: "Keren, Doron" <doronkeren@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Ilia, Kolominsky" <iliak@ti.com>, "Hadar, Amir" <a-hadar@ti.com>
Date: Wed, 14 Sep 2011 16:42:56 +0200
In-Reply-To: <13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
	 <1313617329.3373.188.camel@aeonflux>
	 <13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316011377.1937.43.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Doron,

> > > The patch fixes kernel panic which is due to race condition
> > > between the setup of incomming connection and clean-up of the
> > > dead one. Observed in the following case: attached HID device
> > > disconnects unexpectedly (without performing ACL disconnect ),
> > > the device tries to connect again before the ACL link time-out
> > > fires, this translates to the HCI_DISCONNECT, HCI_CONNECT_REQ
> > > events on the same handle, since HCI_DISCONNECT trigers the clean
> > > up of the HID device and handled in different context, the
> > > linking/unlinking connection object to sysfs, may mess up.
> > >
> > > Signed-off-by: Ilia Kolominsky <iliak@ti.com>
> > > ---
> > >  net/bluetooth/hci_sysfs.c |    4 +++-
> > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> > > index a6c3aa8..5967d63 100644
> > > --- a/net/bluetooth/hci_sysfs.c
> > > +++ b/net/bluetooth/hci_sysfs.c
> > > @@ -9,6 +9,7 @@
> > >  #include <net/bluetooth/bluetooth.h>
> > >  #include <net/bluetooth/hci_core.h>
> > >
> > > +static int acl_conn_index = 0;
> > >  static struct class *bt_class;
> > >
> > >  struct dentry *bt_debugfs;
> > > @@ -91,7 +92,8 @@ static void add_conn(struct work_struct *work)
> > >  	struct hci_conn *conn = container_of(work, struct hci_conn,
> > work_add);
> > >  	struct hci_dev *hdev = conn->hdev;
> > >
> > > -	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
> > > +	acl_conn_index++;
> > > +	dev_set_name(&conn->dev, "%s:%d:%d", hdev->name, conn->handle,
> > acl_conn_index);
> > >
> > >  	dev_set_drvdata(&conn->dev, conn);
> > 
> > can we get a bit more of details on what this is actually trying to
> > solve. I do not like this way of solving it at all. I think it is trying
> > to cover up symptoms and not fixing the real issue.
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> The scenario that causes the kernel panic Happens when HID device disconnect and connect fast. When HID device disconnects the name clean-up appears 100-300msec after the "hci_disconn_complete_evt()", because the two L2CAP channels need to be closed first.
> The problem is that the base-band has already cleaned the handle number when the "hci_disconn_complete_evt()" sent. If another connection is initiating right after, the base-band will send "hci_conn_request_evt()" with the same handle number. During this time we have situation that two HCI connections has the same name, because the handle number from the base-band is the same. There is no reason for the two HCI connections to share the same resource, name. This duplicate name situation will cause Kernel panic.
> 
> The real issue is that the HCI device connection name is saved in the SYSFS 
> In the format: "/devices/virtual/bluetooth/hci0/hci0:1"
> The name in this format depends just on the base-band handle that received in the "hci_conn_complete_evt()". The device name is cleaned just when the
> Variable conn->devref becomes 0.
> In the source code:
>     if (atomic_dec_and_test(&conn->devref))
> 	  	hci_conn_del_sysfs(conn);
> 
> The incremental index in the name format: "/devices/virtual/bluetooth/hci0/hci0:1:<Index>"
> Solves the problem of two HCI connections with the same name.

so I had another look at this and we are still trying to fix the
symptoms and not the real bug.

The real bug here is that we have basically sysfs file creation racing
with the HCI event handling. One done inside a tasklet and the other
done inside a workqueue.

We have this problem since a long time and we really have to move HCI
processing into a workqueue. That is the only way to finally be able to
remove all races that might happen here.

Regards

Marcel


