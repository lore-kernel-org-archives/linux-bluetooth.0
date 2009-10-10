Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091010133524.GA2852@darkstar.tsinghua.edu.cn>
References: <20090930142636.5366dafe@lxorguk.ukuu.org.uk>
	 <20091002105740.GA2809@darkstar>
	 <1255171224.19127.2.camel@localhost.localdomain>
	 <20091010133524.GA2852@darkstar.tsinghua.edu.cn>
Date: Sat, 10 Oct 2009 21:43:09 +0800
Message-ID: <a8e1da0910100643h5fbd759dkd1e74160cb3eb889@mail.gmail.com>
Subject: Re: Bluetooth is very ill in -next
From: Dave Young <hidave.darkstar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Hartkopp <oliver@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 10, 2009 at 9:35 PM, Dave Young <hidave.darkstar@gmail.com> wro=
te:
> On Sat, Oct 10, 2009 at 12:40:24PM +0200, Marcel Holtmann wrote:
>> Hi Dave,
>>
>> > > Doing "sdptool search DUN" reliably crashes the kernel when using a =
USB
>> > > bluetooth dongle
>> > >
>> > > Language Base Attr List:
>> > > =C2=A0 code_ISO639: 0x656e
>> > > =C2=A0 encoding: =C2=A0 =C2=A00x6a
>> > > =C2=A0 base_offset: 0x100
>> > > Profile Descriptor List:
>> > > =C2=A0 "Dialup Networking" (0x1103)
>> > > =C2=A0 =C2=A0 Version: 0x0100
>> > >
>> > >
>> > > is as far as it gets
>> > >
>> > > It then explodes
>> > >
>> > > _spin_lock_irqsave
>> > > ?skb_dequeue
>> > > skb_dequeue
>> > > skb_queue_purge
>> > > l2cap_recv_frame
>> > > ?__lock_acquire
>> > > ?__usb_hcd_submit_urb
>> > > ?__lock_acquire
>> > > l2cap_recv_acldata
>> > > hci_rx_task
>> > > ?l2cap_recv_acldata
>> > > tasklet_action
>> > >
>> > > reliably.
>> > >
>> >
>> > Marcel, please take a look at following patch, same as previous
>> > dev_set_name problem.
>> >
>> > ---
>> > Due to driver core changes dev_set_drvdata will call kzalloc which sho=
uld be
>> > in might_sleep context, but hci_conn_add will be called in atomic cont=
ext
>> >
>> > Like dev_set_name just put all other device callbacks to work queue fu=
nction.
>> >
>> > oops as following:
>> >
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001341] BUG: sleepin=
g function called from invalid context at mm/slqb.c:1546
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001345] in_atomic():=
 1, irqs_disabled(): 0, pid: 2133, name: sdptool
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001348] 2 locks held=
 by sdptool/2133:
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001350] =C2=A0#0: =
=C2=A0(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.+.}, at: [<faa1d2f5>] lock_s=
ock+0xa/0xc [l2cap]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001360] =C2=A0#1: =
=C2=A0(&hdev->lock){+.-.+.}, at: [<faa20e16>] l2cap_sock_connect+0x103/0x26=
b [l2cap]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001371] Pid: 2133, c=
omm: sdptool Not tainted 2.6.31-mm1 #2
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001373] Call Trace:
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001381] =C2=A0[<c022=
433f>] __might_sleep+0xde/0xe5
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001386] =C2=A0[<c029=
8843>] __kmalloc+0x4a/0x15a
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001392] =C2=A0[<c03f=
0065>] ? kzalloc+0xb/0xd
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001396] =C2=A0[<c03f=
0065>] kzalloc+0xb/0xd
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001400] =C2=A0[<c03f=
04ff>] device_private_init+0x15/0x3d
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001405] =C2=A0[<c03f=
24c5>] dev_set_drvdata+0x18/0x26
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001414] =C2=A0[<fa51=
fff7>] hci_conn_init_sysfs+0x40/0xd9 [bluetooth]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001422] =C2=A0[<fa51=
cdc0>] ? hci_conn_add+0x128/0x186 [bluetooth]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001429] =C2=A0[<fa51=
ce0f>] hci_conn_add+0x177/0x186 [bluetooth]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001437] =C2=A0[<fa51=
cf8a>] hci_connect+0x3c/0xfb [bluetooth]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001442] =C2=A0[<faa2=
0e87>] l2cap_sock_connect+0x174/0x26b [l2cap]
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001448] =C2=A0[<c04c=
8df5>] sys_connect+0x60/0x7a
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001453] =C2=A0[<c024=
b703>] ? lock_release_non_nested+0x84/0x1de
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001458] =C2=A0[<c028=
804b>] ? might_fault+0x47/0x81
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001462] =C2=A0[<c028=
804b>] ? might_fault+0x47/0x81
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001468] =C2=A0[<c033=
361f>] ? __copy_from_user_ll+0x11/0xce
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001472] =C2=A0[<c04c=
9419>] sys_socketcall+0x82/0x17b
>> > Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001477] =C2=A0[<c020=
329d>] syscall_call+0x7/0xb
>> >
>> > Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
>> > ---
>> > net/bluetooth/hci_sysfs.c | =C2=A0 18 ++++++++----------
>> > 1 file changed, 8 insertions(+), 10 deletions(-)
>> >
>> > --- linux-2.6.31.orig/net/bluetooth/hci_sysfs.c =C2=A0 =C2=A0 2009-10-=
02 18:04:14.000000000 +0800
>> > +++ linux-2.6.31/net/bluetooth/hci_sysfs.c =C2=A02009-10-02 18:05:22.0=
00000000 +0800
>> > @@ -90,6 +90,14 @@ static void add_conn(struct work_struct
>> > =C2=A0 =C2=A0 struct hci_conn *conn =3D container_of(work, struct hci_=
conn, work_add);
>> > =C2=A0 =C2=A0 struct hci_dev *hdev =3D conn->hdev;
>> >
>> > + =C2=A0 conn->dev.type =3D &bt_link;
>> > + =C2=A0 conn->dev.class =3D bt_class;
>> > + =C2=A0 conn->dev.parent =3D &hdev->dev;
>> > +
>> > + =C2=A0 dev_set_drvdata(&conn->dev, conn);
>> > +
>> > + =C2=A0 device_initialize(&conn->dev);
>> > +
>> > =C2=A0 =C2=A0 dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->hand=
le);
>> >
>> > =C2=A0 =C2=A0 if (device_add(&conn->dev) < 0) {
>> > @@ -136,18 +144,8 @@ static void del_conn(struct work_struct
>> >
>> > =C2=A0void hci_conn_init_sysfs(struct hci_conn *conn)
>> > =C2=A0{
>> > - =C2=A0 struct hci_dev *hdev =3D conn->hdev;
>> > -
>> > =C2=A0 =C2=A0 BT_DBG("conn %p", conn);
>> >
>> > - =C2=A0 conn->dev.type =3D &bt_link;
>> > - =C2=A0 conn->dev.class =3D bt_class;
>> > - =C2=A0 conn->dev.parent =3D &hdev->dev;
>> > -
>> > - =C2=A0 dev_set_drvdata(&conn->dev, conn);
>> > -
>> > - =C2=A0 device_initialize(&conn->dev);
>> > -
>> > =C2=A0 =C2=A0 INIT_WORK(&conn->work_add, add_conn);
>> > =C2=A0 =C2=A0 INIT_WORK(&conn->work_del, del_conn);
>> > =C2=A0}
>> >
>>
>> I prefer if we only move dev_set_drvdata into the work queue and
>> actually do initialize the struct device here. I have tested this a bit
>> during this week and have not seen any problems. Would this work, too.
>>
>> Regards
>>
>> Marcel
>>
>>
>
> Hi, marcel
>
> Fine, both are ok for me, here is the updated version.
>
> Add oliver to cc-list. Would you mind test one more time?

Sorry, press 'y' in mutt in a hurry without adding.

>
> ---
> Due to driver core changes dev_set_drvdata will call kzalloc which should=
 be
> in might_sleep context, but hci_conn_add will be called in atomic context
>
> Like dev_set_name move dev_set_drvdata to work queue function.
>
> oops as following:
>
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001341] BUG: sleeping f=
unction called from invalid context at mm/slqb.c:1546
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001345] in_atomic(): 1,=
 irqs_disabled(): 0, pid: 2133, name: sdptool
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001348] 2 locks held by=
 sdptool/2133:
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001350] =C2=A0#0: =C2=
=A0(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.+.}, at: [<faa1d2f5>] lock_sock=
+0xa/0xc [l2cap]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001360] =C2=A0#1: =C2=
=A0(&hdev->lock){+.-.+.}, at: [<faa20e16>] l2cap_sock_connect+0x103/0x26b [=
l2cap]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001371] Pid: 2133, comm=
: sdptool Not tainted 2.6.31-mm1 #2
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001373] Call Trace:
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001381] =C2=A0[<c022433=
f>] __might_sleep+0xde/0xe5
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001386] =C2=A0[<c029884=
3>] __kmalloc+0x4a/0x15a
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001392] =C2=A0[<c03f006=
5>] ? kzalloc+0xb/0xd
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001396] =C2=A0[<c03f006=
5>] kzalloc+0xb/0xd
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001400] =C2=A0[<c03f04f=
f>] device_private_init+0x15/0x3d
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001405] =C2=A0[<c03f24c=
5>] dev_set_drvdata+0x18/0x26
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001414] =C2=A0[<fa51fff=
7>] hci_conn_init_sysfs+0x40/0xd9 [bluetooth]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001422] =C2=A0[<fa51cdc=
0>] ? hci_conn_add+0x128/0x186 [bluetooth]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001429] =C2=A0[<fa51ce0=
f>] hci_conn_add+0x177/0x186 [bluetooth]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001437] =C2=A0[<fa51cf8=
a>] hci_connect+0x3c/0xfb [bluetooth]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001442] =C2=A0[<faa20e8=
7>] l2cap_sock_connect+0x174/0x26b [l2cap]
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001448] =C2=A0[<c04c8df=
5>] sys_connect+0x60/0x7a
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001453] =C2=A0[<c024b70=
3>] ? lock_release_non_nested+0x84/0x1de
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001458] =C2=A0[<c028804=
b>] ? might_fault+0x47/0x81
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001462] =C2=A0[<c028804=
b>] ? might_fault+0x47/0x81
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001468] =C2=A0[<c033361=
f>] ? __copy_from_user_ll+0x11/0xce
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001472] =C2=A0[<c04c941=
9>] sys_socketcall+0x82/0x17b
> Oct =C2=A02 17:41:59 darkstar kernel: [ =C2=A0438.001477] =C2=A0[<c020329=
d>] syscall_call+0x7/0xb
>
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
> ---
> net/bluetooth/hci_sysfs.c | =C2=A0 =C2=A04 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-2.6.31.orig/net/bluetooth/hci_sysfs.c 2009-10-09 20:50:43.00000=
0000 +0800
> +++ linux-2.6.31/net/bluetooth/hci_sysfs.c =C2=A0 =C2=A0 =C2=A02009-10-10=
 21:24:56.000000000 +0800
> @@ -92,6 +92,8 @@ static void add_conn(struct work_struct
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_set_name(&conn->dev, "%s:%d", hdev->name, =
conn->handle);
>
> + =C2=A0 =C2=A0 =C2=A0 dev_set_drvdata(&conn->dev, conn);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (device_add(&conn->dev) < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BT_ERR("Failed to =
register connection device");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> @@ -144,8 +146,6 @@ void hci_conn_init_sysfs(struct hci_conn
> =C2=A0 =C2=A0 =C2=A0 =C2=A0conn->dev.class =3D bt_class;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0conn->dev.parent =3D &hdev->dev;
>
> - =C2=A0 =C2=A0 =C2=A0 dev_set_drvdata(&conn->dev, conn);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0device_initialize(&conn->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&conn->work_add, add_conn);
>



--=20
Regards
dave
