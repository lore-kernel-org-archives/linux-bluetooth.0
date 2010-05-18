Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100517190607.GA19907@vigoh>
References: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
	 <20100516083122.GA21819@vigoh>
	 <AANLkTimyNqIdMoZ6J6InYRzD1JNl1Fsv-CdVpd84pjot@mail.gmail.com>
	 <20100517190607.GA19907@vigoh>
Date: Tue, 18 May 2010 10:15:56 +0300
Message-ID: <AANLkTilyAbXWIHHB1Ae7GP6xlH7zdzd1QZQzYP-NiMjV@mail.gmail.com>
Subject: Re: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, May 17, 2010 at 10:06 PM, Gustavo F. Padovan
<gustavo@padovan.org> wrote:
>> >> We have a bug with race condition between l2cap tasklet and krfcomm p=
rocess.
>> >>
>> >> When sending following sequence:
>> >>
>> >> ...
>> >> No. =A0 =A0 Time =A0 =A0 =A0 =A0Source =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0Destination =A0 =A0 =A0 =A0 =A0 Protocol Info
>> >> =A0 =A0 =A089 1.951202 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DL=
CI=3D20
>> >> =A0 =A0 =A090 1.951324 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Sent UA DLCI=
=3D20
>> >> =A0 =A0 =A091 1.959381 =A0 =A0 =A0 =A0 =A0 =A0HCI_EVT =A0 Number of C=
ompleted Packets
>> >> =A0 =A0 =A092 1.966461 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DL=
CI=3D0
>> >> =A0 =A0 =A093 1.966492 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Rcvd Disco=
nnect Request
>> >> =A0 =A0 =A094 1.972595 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Sent Disco=
nnect Response
>> >>
>> >> ...
>> >>
>> >> krfcommd kernel thread is preempted with l2cap tasklet which remove l=
2cap_conn
>> >> (L2CAP connection handler structure). Then rfcomm thread tries to sen=
d RFCOMM
>> >> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn c=
rash
>> >> happens.
>> >>
>> >> ...
>> >> [ =A0694.175933] Unable to handle kernel NULL pointer dereference at
>> >> virtual address 00000000
>> >> [ =A0694.184936] pgd =3D c0004000
>> >> [ =A0694.187683] [00000000] *pgd=3D00000000
>> >> [ =A0694.191711] Internal error: Oops: 5 [#1] PREEMPT
>> >> [ =A0694.196350] last sysfs file:
>> >> /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
>> >> [ =A0694.260375] CPU: 0 =A0 =A0Not tainted =A0(2.6.32.10 #1)
>> >> [ =A0694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
>> >> [ =A0694.270721] LR is at 0xd7017303
>> >> ...
>> >> [ =A0694.525085] Backtrace:
>> >> [ =A0694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap])
>> >> from [<c02f2cc8>] (sock_sendmsg+0xb8
>> >> [ =A0694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044=
>]
>> >> (kernel_sendmsg+0x48/0x80)
>> >> ...
>> >>
>> >> I have a patch which fixes the issue but not sure that there is no
>> >> better way. Waiting for comments.
>> >>
>> >> Currently I am investigating possibility to:
>> >> - implement l2cap_conn reference counting
>> >
>> > sock_owned_by_user() gives the same effect as a ref count. See comment=
s below.
>> >
>>
>> Yes. For this cases this is enough. But proper refcounting is always
>> better than this "effects" ;)
>>
>> >> - use socket backlog queue to process l2cap packets later when socket=
 is not
>> >> owned by the process.
>> >
>> > You actually don't need a backlog queue here. You can process the sign=
al
>> > packet, skipping the l2cap_chan_del() call;
>> >
>> ...
>> >> + =A0 =A0 /* sk is locked in krfcomm process */
>> >> + =A0 =A0 if (sock_owned_by_user(sk)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("sk %p is owned by user", sk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> >> + =A0 =A0 }
>> >
>> > That's wrong. Use the sock_owned_by_user() only to avoid the
>> > l2cap_chan_del() call, so you can process all the rest of the function
>> > and send the Disconnect Response.
>>
>> I have changed the patch so that it only prevents l2cap_chan_del
>> - =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, ECONNREFUSED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* delete l2cap channel if sk is not owned by =
user */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!sock_owned_by_user(sk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, ECONNREFUSE=
D);
>>
>> Then still l2cap_sock_kill(sk) removes sk but in the second patch sk is
>> hold with sock_hold(sk) until rfcomm is still processing packet.
>
> Hmm, I missed the l2cap_sock_kill(). So I guess you can invert the if
> condition and unlock the socket and return if sock is owned by user,
> right?

I am still thinking that my proposal is better.

l2cap_sock_kill(sk) does not delete socket but unlink it from the list
and defer deleting
to the time we get to sock_put(sk) in the other place sk is used.
Socket shall be deleted and this defer deletion is a good solution
IMO.

But I can also create patch with your proposed change.

> Marcel, do you agree with that change?

So what would be the right solution?

Regards,
Andrei

>
>>
>> > The same check should be added to l2cap_connect_rsp() and
>> > l2cap_disconnect_rsp(), since they call l2cap_chan_del() under bh
>> > context as well. ;)
>>
>> Added.
>>
>> Regards,
>> Andrei Emeltchenko
>
>> From 8531c8add8a378fc24b92f2c2311b01a7b1f63fc Mon Sep 17 00:00:00 2001
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> Date: Mon, 17 May 2010 12:10:46 +0300
>> Subject: [PATCH 1/2] Bluetooth: Check sk is not owned before freeing l2c=
ap_conn
>>
>> Check that socket sk is not locked in user process before removing
>> l2cap connection handler.
>>
>> krfcommd kernel thread may be preempted with l2cap tasklet which remove
>> l2cap_conn structure. If krfcommd is in process of sending of RFCOMM rep=
ly
>> (like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.
>>
>> ...
>> [ =A0694.175933] Unable to handle kernel NULL pointer dereference at vir=
tual address 00000000
>> [ =A0694.184936] pgd =3D c0004000
>> [ =A0694.187683] [00000000] *pgd=3D00000000
>> [ =A0694.191711] Internal error: Oops: 5 [#1] PREEMPT
>> [ =A0694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware=
/hci_h4p/loading
>> [ =A0694.260375] CPU: 0 =A0 =A0Not tainted =A0(2.6.32.10 #1)
>> [ =A0694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
>> [ =A0694.270721] LR is at 0xd7017303
>> ...
>> [ =A0694.525085] Backtrace:
>> [ =A0694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) fro=
m [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
>> [ =A0694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] =
(kernel_sendmsg+0x48/0x80)
>> ...
>>
>> Modified version after comments of Gustavo F. Padovan <gustavo@padovan.o=
rg>
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0net/bluetooth/l2cap.c | =A0 14 +++++++++++---
>> =A01 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index bb00015..794f2b7 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -2927,7 +2927,9 @@ static inline int l2cap_connect_rsp(struct l2cap_c=
onn *conn, struct l2cap_cmd_hd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, ECONNREFUSED);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* delete l2cap channel if sk is not owned by =
user */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!sock_owned_by_user(sk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, ECONNREFUSE=
D);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>>
>> @@ -3135,7 +3137,10 @@ static inline int l2cap_disconnect_req(struct l2c=
ap_conn *conn, struct l2cap_cmd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&l2cap_pi(sk)->ack_timer);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 l2cap_chan_del(sk, ECONNRESET);
>> + =A0 =A0 /* delete l2cap channel if sk is not owned by user */
>> + =A0 =A0 if (!sock_owned_by_user(sk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, ECONNRESET);
>> +
>> =A0 =A0 =A0 bh_unlock_sock(sk);
>>
>> =A0 =A0 =A0 l2cap_sock_kill(sk);
>> @@ -3167,7 +3172,10 @@ static inline int l2cap_disconnect_rsp(struct l2c=
ap_conn *conn, struct l2cap_cmd
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&l2cap_pi(sk)->ack_timer);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 l2cap_chan_del(sk, 0);
>> + =A0 =A0 /* delete l2cap channel if sk is not owned by user */
>> + =A0 =A0 if (!sock_owned_by_user(sk))
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_del(sk, 0);
>> +
>> =A0 =A0 =A0 bh_unlock_sock(sk);
>>
>> =A0 =A0 =A0 l2cap_sock_kill(sk);
>> --
>> 1.7.0.4
>>
>
>> From 99ffb4e41ff46022cbc52f3c947425791de7fa39 Mon Sep 17 00:00:00 2001
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> Date: Mon, 17 May 2010 12:28:06 +0300
>> Subject: [PATCH 2/2] Bluetooth: Prevent sk freeing in tasklet using refc=
ount
>>
>> Socket sk may be freed in tasklet while still be in use in krfcommd
>> process. Use refcount to mark sk as used.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0net/bluetooth/l2cap.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 794f2b7..bf762d6 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -1724,6 +1724,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, =
struct socket *sock, struct ms
>> =A0 =A0 =A0 if (msg->msg_flags & MSG_OOB)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>
>> + =A0 =A0 sock_hold(sk);
>> =A0 =A0 =A0 lock_sock(sk);
>>
>> =A0 =A0 =A0 if (sk->sk_state !=3D BT_CONNECTED) {
>> @@ -1808,6 +1809,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, =
struct socket *sock, struct ms
>>
>> =A0done:
>> =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 sock_put(sk);
>> =A0 =A0 =A0 return err;
>> =A0}
>>
>> --
>> 1.7.0.4
>>
>
>
> --
> Gustavo F. Padovan
> http://padovan.org
>
