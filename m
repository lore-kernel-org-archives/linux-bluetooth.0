Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1263321945.12466.30.camel@localhost.localdomain>
References: <6aeb672b1001120157x18b2fee0n2e47078214e0f239@mail.gmail.com>
	 <1263295337.12466.22.camel@localhost.localdomain>
	 <6aeb672b1001120539u1285b7ccr2558d804e965782b@mail.gmail.com>
	 <1263321945.12466.30.camel@localhost.localdomain>
Date: Fri, 15 Jan 2010 14:31:43 +0800
Message-ID: <6aeb672b1001142231g6b63b203t47be84d542c2d76b@mail.gmail.com>
Subject: Re: can we disable/enable eSCO by using setsockopt of sco socket?
From: Liang Bao <tim.bao@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel,

I've merged the 2.6.33-rc3 into our code base and made extensive tests
in the past 2 days. The problem is still there if I tried long enough.
But it could be my own problem because the merge is manually
conducted. Our code is 2.6.29 and has a couple of changes so I have to
add the commit 9eba32b86d17ef87131fa0bce43c614904ab5781 with some
minor tailoring.

However, I doubt the duplicate sysfs entry doesn't lead to our kernel
panic. I revert the code back to official 2.6.30 where retry logic was
first introduced and simply add the error code 0x10(Connection Accept
Timeout Exceeded) for retry(see modified code snippet at the end) on
the code snippet for retrying SCO right now. By using hcitool to
monitor the connections, I found the code will eventually result in 3
connection handles while the eSCO one seems to be invalid.

# /data/local/hcitool con
Connections:
< eSCO 00:50:CD:20:BA:E6 handle 0 state 5 lm SLAVE  (note the handle
and the state)
< SCO 00:50:CD:20:BA:E6 handle 513 state 1 lm SLAVE
> ACL 00:50:CD:20:BA:E6 handle 1 state 1 lm MASTER AUTH ENCRYPT

While the phenomenon appears due to error 0x10 and with our code, I am
wondering the same will happen if the hci_sync_conn_complete_evt() is
called with error 0x1c and 0x1f in the official code. As you can see,
the snippet just skips hci_conn_del(conn) and goto unlock:. With the
invalid eSCO handle, when I power off bluetooth, sometimes a kernel
panic will happen(the panic backtrace appended at the end of the
message,too). Now my question is that shall we call hci_conn_del(conn)
for the failed eSCO attempt before  retry SCO?

Regarding extend the SCO socket parameters to allow specifying a
eSCO/SCO packet mask, do you want us to provide a patch as well?

Regards,
Liang Bao

<<the backtrace of the kernel panic>>

<4>[ 7691.791656] Backtrace:

<4>[ 7691.794799] [<c03663f8>] (hci_send_to_sock+0x0/0x17c) from
[<c0362078>] (hci_si_event+0xd0/0xe0)

<4>[ 7691.805480] [<c0361fa8>] (hci_si_event+0x0/0xe0) from
[<c03657e8>] (hci_sock_dev_event+0x38/0x148)

<4>[ 7691.816040] [<c03657b0>] (hci_sock_dev_event+0x0/0x148) from
[<c007caec>] (notifier_call_chain+0x34/0x78)

<4>[ 7691.827545] [<c007cab8>] (notifier_call_chain+0x0/0x78) from
[<c007d104>] (__atomic_notifier_call_chain+0x34/0x60)

<4>[ 7691.839843] [<c007d0d0>] (__atomic_notifier_call_chain+0x0/0x60)
from [<c007d150>] (atomic_notifier_call_chain+0x20/0x28)

<4>[ 7691.852783]  r5:c96e1218 r4:c96e1000

<4>[ 7691.857666] [<c007d130>] (atomic_notifier_call_chain+0x0/0x28)
from [<c035e9a8>] (hci_notify+0x18/0x20)

<4>[ 7691.868713] [<c035e990>] (hci_notify+0x0/0x20) from [<c035ec24>]
(hci_dev_do_close+0xcc/0x1f0)

<4>[ 7691.879180] [<c035eb58>] (hci_dev_do_close+0x0/0x1f0) from
[<c035f4d4>] (hci_dev_close+0x20/0x60)

<4>[ 7691.889953]  r7:400448ca r6:00000000 r5:c62c4c00 r4:c96e1000

<4>[ 7691.897369] [<c035f4b4>] (hci_dev_close+0x0/0x60) from
[<c03660cc>] (hci_sock_ioctl+0x100/0x284)

<4>[ 7691.908050]  r5:c62c4c00 r4:400448ca

<4>[ 7691.912658] [<c0365fcc>] (hci_sock_ioctl+0x0/0x284) from
[<c02ac90c>] (sock_ioctl+0x1f0/0x240)

<4>[ 7691.922882]  r7:400448ca r6:00000000 r5:00000000 r4:400448ca

<4>[ 7691.930541] [<c02ac71c>] (sock_ioctl+0x0/0x240) from
[<c00ccdbc>] (vfs_ioctl+0x34/0x94)

<4>[ 7691.940124]  r7:400448ca r6:00000000 r5:c02ac71c r4:c97d04c0

<4>[ 7691.947784] [<c00ccd88>] (vfs_ioctl+0x0/0x94) from [<c00cd41c>]
(do_vfs_ioctl+0x508/0x56c)

<4>[ 7691.957916]  r7:0000006b r6:400448ca r5:c97d04c0 r4:00000000

<4>[ 7691.965332] [<c00ccf14>] (do_vfs_ioctl+0x0/0x56c) from
[<c00cd4c0>] (sys_ioctl+0x40/0x64)

<4>[ 7691.975372]  r9:c9da2000 r8:c0037004 r7:0000006b r6:400448ca r5:00000=
000

<4>[ 7691.983947] r4:c97d04c0

<4>[ 7691.987548] [<c00cd480>] (sys_ioctl+0x0/0x64) from [<c0036e80>]
(ret_fast_syscall+0x0/0x2c)

<4>[ 7691.997497]  r7:00000036 r6:0000006b r5:aea00d30 r4:aea010c8

<4>[ 7692.005157] Code: e5955000 e3550000 0a000006 e1a04005 (e4143008)

<0>[ 7692.014282] Kernel panic - not syncing: Fatal exception


<< the code I am currently using, one line insertion on official 2.6.30 >>

1670static inline void hci_sync_conn_complete_evt(struct hci_dev
*hdev, struct sk_buff *skb)
1671{
1672 =A0 =A0 =A0 =A0struct hci_ev_sync_conn_complete *ev =3D (void *) skb->=
data;
1673 =A0 =A0 =A0 =A0struct hci_conn *conn;
1674
1675 =A0 =A0 =A0 =A0BT_DBG("%s status %d", hdev->name, ev->status);
1676
1677 =A0 =A0 =A0 =A0hci_dev_lock(hdev);
1678
1679 =A0 =A0 =A0 =A0conn =3D hci_conn_hash_lookup_ba(hdev, ev->link_type, &=
ev->bdaddr);
1680 =A0 =A0 =A0 =A0if (!conn) {
1681 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ev->link_type =3D=3D ESCO_LINK)
1682 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
1683
1684 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn =3D hci_conn_hash_lookup_ba(hdev, =
ESCO_LINK,
&ev->bdaddr);
1685 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!conn)
1686 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
1687
1688 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->type =3D SCO_LINK;
1689 =A0 =A0 =A0 =A0}
1690
1691 =A0 =A0 =A0 =A0switch (ev->status) {
1692 =A0 =A0 =A0 =A0case 0x00:
1693 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->handle =3D __le16_to_cpu(ev->hand=
le);
1694 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->state =A0=3D BT_CONNECTED;
1695
1696 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_conn_add_sysfs(conn);
1697 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
1698
++++=A0 =A0 =A0 =A0 case 0x10: =A0 =A0 =A0/* Connection accept timeout exce=
eded */
1699 =A0 =A0 =A0 =A0case 0x1c: =A0 =A0 =A0/* SCO interval rejected */
1700 =A0 =A0 =A0 =A0case 0x1f: =A0 =A0 =A0/* Unspecified error */
1701 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (conn->out && conn->attempt < 2) {
1702 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->pkt_type =3D (hde=
v->esco_type & SCO_ESCO_MASK) |
1703 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(hdev->esco_type & EDR_ESCO_MASK);
1704 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_setup_sync(conn, co=
nn->link->handle);
1705 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
1706 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
1707 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
1708
1709 =A0 =A0 =A0 =A0default:
1710 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conn->state =3D BT_CLOSED;
1711 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
1712 =A0 =A0 =A0 =A0}
1713
1714 =A0 =A0 =A0 =A0hci_proto_connect_cfm(conn, ev->status);
1715 =A0 =A0 =A0 =A0if (ev->status)
1716 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_conn_del(conn);
1717
1718unlock:
1719 =A0 =A0 =A0 =A0hci_dev_unlock(hdev);
1720}


2010/1/13 Marcel Holtmann <marcel@holtmann.org>:
> Hi Liang,
>
>> >> We resumed the work of troubleshooting some problematic carkits
>> >> recently. While we agree with that eSCO/SCO is handled by the stuff
>> >> below HCI and bluez is absoultely right handling this, we still need
>> >> to face the fact that there're bunch of carkits and headsets with
>> >> hidden issues which only get exposed in certain combination like the
>> >> HF850 and our phones. Bluez can still be even better.
>> >>
>> >> In our case, the HF850 claims eSCO but when you're trying to connect
>> >> with it, it will timeout. So to have the stack works with those
>> >> on-market products, it's better if the developers sitting above the
>> >> HCI layer have some tweaking method on bluez behavior in ununsal
>> >> cases.
>> >>
>> >> Regarding the particular eSCO timeout failure, we add the following
>> >> delta into the net/bluetooth/hci_event.c
>> >>
>> >> =A0 =A0 =A0 =A0 hci_proto_connect_cfm(conn, ev->status);
>> >> +
>> >> + =A0 =A0if (conn->out && (ev->status =3D=3D 0x1a || ev->status =3D=
=3D 0x1c ||
>> >> + =A0 =A0 =A0 =A0 =A0 =A0ev->status =3D=3D 0x1f || ev->status =3D=3D =
0x10) &&
>> >> + =A0 =A0 =A0 =A0 =A0 =A0conn->attempt < 2) {
>> >> + =A0 =A0 =A0 =A0conn->pkt_type =3D (hdev->esco_type & SCO_ESCO_MASK)=
 |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(hdev->esco_type & EDR_ESCO_=
MASK);
>> >> + =A0 =A0 =A0 =A0hci_setup_sync(conn, conn->link->handle);
>> >> + =A0 =A0 =A0 =A0goto unlock;
>> >> + =A0 =A0}
>> >> +
>> >> =A0 =A0 =A0 if (ev->status)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_del(conn);
>> >>
>> >> With this code change, we can successfully retry a SCO link after eSC=
O
>> >> attempt timeout. Still, a setsockopt interface will be better for
>> >> tweaking. Or is there any better idea on how to allow bluez work with
>> >> those on-market problematic devices?
>> >
>> > no you can NOT. It is race condition hazard. You can not call
>> > hci_proto_connect_cfm() and then just hci_setup_sync(). That confuses
>> > upper layers and just works by pure luck.
>> >
>> > The upstream code actually handles already the 0x1c and 0x1f error cod=
es
>> > and retries the setup without eSCO packets types. So you snippet is
>> > against an old kernel (older than 2.6.30 at least).
>> >
>> Yeah, you're right, we're using version 2.6.29. I put the retry code bet=
ween
>>
>> =A0 =A0 hci_proto_connect_cfm(conn, ev->status)
>>
>> and
>>
>> =A0 =A0 if (ev->status)
>> =A0 =A0 =A0 =A0 =A0hci_conn_del(conn);
>>
>> because the kernel log is showing a warning complaining duplicate
>> device files is being added( log put at the end to make reading easy).
>> It seems the device file is created twice. I noticed a call to
>> hci_conn_hold_device(conn) is added to kernel 2.6.30 and onwards. I'll
>> try the new way tomorrow.
>
> that should be fixed. Please re-test with bluetooth-testing tree based
> on 2.6.33-rc3.
>
>> >> The hcidump log is copied again here for your convenience:
>> >> > 2009-09-03 17:26:29.093601 < HCI Command: Setup Synchronous Connect=
ion (0x01|0x0
>> >> > 028) plen 17
>> >> > =A0 =A0handle 1 voice setting 0x0060
>> >> > 2009-09-03 17:26:29.094608 > HCI Event: Command Status (0x0f) plen =
4
>> >> > =A0 =A0Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd =
1
>> >> > 2009-09-03 17:26:34.190952 > HCI Event: Synchronous Connect Complet=
e (0x2c) plen
>> >> > =A017
>> >> > =A0 =A0status 0x10 handle 257 bdaddr 00:50:CD:20:BA:E6 type eSCO
>> >> > =A0 =A0Error: Connection Accept Timeout Exceeded
>> >
>> > The accept timeout has a pretty clear definition and while we could
>> > retry, I am having some concerns here. This also does not explain why
>> > 0x1a is in your code snippet.
>> We conduct a retry for the code 0x1a because there's also some devices
>> claim eSCO capability but respond with "Unsupported Remote Feature /
>> Unsupported LMP Feature (0X1A)".
>
> So adding 0x1a to the exception list and falling back to SCO is fine
> with me. Send a proper patch against the bluetooth-testing tree with a
> detailed commit message and the extract of hcidump -X -V for this one.
> You will find an example on how such a commit message should look like
> when looking through the history.
>
>> We can understand your concern for 0x10 as it's a timeout by
>> definition, therefore, if a retry will be done, probably the same set
>> of parameters shall be used. However, the reality is that devices came
>> to market around eSCO was introduced could be troubles - eSCO was
>> added but not fully tested or failed to pass test and finally device
>> manufacturer had to turn off them but inconsistency was kept - like
>> what the Motorola HF850 does. Anyway, it's your call to determine the
>> behavior for the 0x10(Connection Accept Timeout Exceeded) and
>> personally I'll respect that.
>
> If we really wanna work around this problem, then it might be better to
> extend the SCO socket parameters to allow specifying a eSCO/SCO packet
> mask. So it is up to the userspace to select any quirks.
>
> Regards
>
> Marcel
>
>
>
