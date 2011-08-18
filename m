Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
	<1313617329.3373.188.camel@aeonflux>
	<13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
Date: Thu, 18 Aug 2011 13:44:21 +0200
Message-ID: <CANq1E4TKSJZF+HoV+XuopnupRmSvDiEOu72b+7YX4O2wR6Hd9g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
From: David Herrmann <dh.herrmann@googlemail.com>
To: "Keren, Doron" <doronkeren@ti.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Ilia, Kolominsky" <iliak@ti.com>,
	"Hadar, Amir" <a-hadar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 18, 2011 at 1:21 PM, Keren, Doron <doronkeren@ti.com> wrote:
> Hi Marcel
>
>> -----Original Message-----
>> From: Marcel Holtmann [mailto:marcel@holtmann.org]
>> Sent: Thursday, August 18, 2011 12:42 AM
>> To: doron.keren.bluez@gmail.com
>> Cc: linux-bluetooth@vger.kernel.org; Keren, Doron; Ilia, Kolominsky
>> Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs H=
CI
>> connection name.
>>
>> Hi Doron,
>>
>> > The patch fixes kernel panic which is due to race condition
>> > between the setup of incomming connection and clean-up of the
>> > dead one. Observed in the following case: attached HID device
>> > disconnects unexpectedly (without performing ACL disconnect ),
>> > the device tries to connect again before the ACL link time-out
>> > fires, this translates to the HCI_DISCONNECT, HCI_CONNECT_REQ
>> > events on the same handle, since HCI_DISCONNECT trigers the clean
>> > up of the HID device and handled in different context, the
>> > linking/unlinking connection object to sysfs, may mess up.
>> >
>> > Signed-off-by: Ilia Kolominsky <iliak@ti.com>
>> > ---
>> > =A0net/bluetooth/hci_sysfs.c | =A0 =A04 +++-
>> > =A01 files changed, 3 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>> > index a6c3aa8..5967d63 100644
>> > --- a/net/bluetooth/hci_sysfs.c
>> > +++ b/net/bluetooth/hci_sysfs.c
>> > @@ -9,6 +9,7 @@
>> > =A0#include <net/bluetooth/bluetooth.h>
>> > =A0#include <net/bluetooth/hci_core.h>
>> >
>> > +static int acl_conn_index =3D 0;
>> > =A0static struct class *bt_class;
>> >
>> > =A0struct dentry *bt_debugfs;
>> > @@ -91,7 +92,8 @@ static void add_conn(struct work_struct *work)
>> > =A0 =A0 struct hci_conn *conn =3D container_of(work, struct hci_conn,
>> work_add);
>> > =A0 =A0 struct hci_dev *hdev =3D conn->hdev;
>> >
>> > - =A0 dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
>> > + =A0 acl_conn_index++;
>> > + =A0 dev_set_name(&conn->dev, "%s:%d:%d", hdev->name, conn->handle,
>> acl_conn_index);
>> >
>> > =A0 =A0 dev_set_drvdata(&conn->dev, conn);
>>
>> can we get a bit more of details on what this is actually trying to
>> solve. I do not like this way of solving it at all. I think it is trying
>> to cover up symptoms and not fixing the real issue.
>>
>> Regards
>>
>> Marcel
>>
>
> The scenario that causes the kernel panic Happens when HID device disconn=
ect and connect fast. When HID device disconnects the name clean-up appears=
 100-300msec after the "hci_disconn_complete_evt()", because the two L2CAP =
channels need to be closed first.
> The problem is that the base-band has already cleaned the handle number w=
hen the "hci_disconn_complete_evt()" sent. If another connection is initiat=
ing right after, the base-band will send "hci_conn_request_evt()" with the =
same handle number. During this time we have situation that two HCI connect=
ions has the same name, because the handle number from the base-band is the=
 same. There is no reason for the two HCI connections to share the same res=
ource, name. This duplicate name situation will cause Kernel panic.
>
> The real issue is that the HCI device connection name is saved in the SYS=
FS
> In the format: "/devices/virtual/bluetooth/hci0/hci0:1"
> The name in this format depends just on the base-band handle that receive=
d in the "hci_conn_complete_evt()". The device name is cleaned just when th=
e
> Variable conn->devref becomes 0.
> In the source code:
> =A0 =A0if (atomic_dec_and_test(&conn->devref))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_conn_del_sysfs(conn);
>
> The incremental index in the name format: "/devices/virtual/bluetooth/hci=
0/hci0:1:<Index>"
> Solves the problem of two HCI connections with the same name.
>
> Regards,
> Doron
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I can confirm that there is a reconnection issue and I get the same
oops (device "hci0:1" is tried to be added twice) on fast
reconnections.

However, I tested this fix and Marcel seems right. I no longer get the
sysfs-oops, but I now get another oops in hidp_add_connection() so
this doesn't fix the problem.
After restarting the machine after this oops, my log contains only
half of the oops-message so I can't post this here. I will try to get
a full log and report it then.

Regards
David
