Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C830C366
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104886; cv=pass; b=h85sEgbBlEl2K7F2dWyejGGpvipojeumtKoP0pOO8O7zuy92urNTou/bqOr83PbNrROvDejmWeov80Qg2PYVUzot51GCcSBht2cS5tq0JwlU6IbM/k1B/pMRwTg4DUtzjyACPYKkm06hw0x4pABBGX/vQCDw50sjbLck3trXsBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104886; c=relaxed/simple;
	bh=avwAT7aCg9UWATSdZ2xk0r99xP+7jqPNkFeWXyilKaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOKAd3iYLfeejce57NpNgQe1IazhhSbK60QdAN5Z4DMxl0LaZBjpJM7OiE7cvRAvT9C7ZMchEe2wDbMVbiO1faz9s3PtPlhiMJX+ep2KmX1wGQf5evHRWob6E/lAQulf1u8RoRRO3nNPGXym3OCvlQt/grf/7Nukl5jX45paXRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HXVk7GNM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HXVk7GNM"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gb8cr5l5gz49Pyt;
	Wed, 10 Jun 2026 18:21:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781104877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ebk968dt4Xov0Mh0tHh20jF4zNXZVVOiv76hlAbV6c=;
	b=HXVk7GNMQ1T44q1OxxphRXFCqDqhpnFTG8nZj5H4YBSGmDFO6FCq7eqgx/CZ8zqBD8ycB/
	NCfJ6r29g+QkKswcus9AfXI3QA+1p1k8HKDgyfAnrNSt7/Nh6ikafVoOZzsJxYClVlmzTF
	8anhIHYfDsNyHZGQE7q90AIYIumJDQsgUeZ5noCnNeNT3QxUAxeDj5YwwP9rCx4/nUYvM0
	alTfq++1CsFCEbxw7RHbtlF5/e09Bs0/qopY8sAlPJ9r9FgWX1WeT2RUWV/CQ5cys/C3G/
	TsZZxmwOY3yQB62Nfu1XqLTH1Xr0RXhYLS/SUZn4l4YZ35su0vnCzTLYnlK8cw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781104877;
	b=hylnmxS99msSo8WttFFAdN4j1Ev+SNgPgHmCsokF1USQBAWSECiRG7yZSrHEtTeA6Mce8I
	PqBKnqxXV6OoisElTE7BtQ5whynD5PUcGfr3pu4zscNcDwmavBMDACLGAfDEwwSgk+efOn
	pQKdM1aTdUZcbqvOe15eJwl5GJmWdEJsV/GCc9Uk868HR9ldhn4Vf7MyQ04ZyYjP2v+CEn
	R3ZkLATcgJ0vGW8e9UGN9l5a5+oJ1xxpN29dXD1WlVjCC0ivelZm7aM6BHT4lGjev121V2
	6mK/xaO9Iq6H3RlbarCMwBTp5WKoAqlJLEkQe2sKqwRTmsPHxwL9sCe5mCxqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781104877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ebk968dt4Xov0Mh0tHh20jF4zNXZVVOiv76hlAbV6c=;
	b=T1e8PeUnexXUxyDO/PeCQRbL/XTnOTGPbTnaaNCGVw4pl8legvCBVRKvD8KoI+2Z2cqXtL
	7wP9VYgT0I9IU8ixwYnFyfvISo67PHu12ug2TZ8q7f6hPybomVGoKYL7NKF9+LRvBbrfxK
	NmDr7qQFNqvz+b1BU8Y/fGRdBmkWwlMbgOrZRgIG6feANjDg7v2dwPpgBlxeOKpr9o2nWN
	5ds2vYoMqQNVK/iK0YNJWi8c0T0ULIr3GS+V1njp3rkieA/nwEwX0kg1SLzwAHLFWyCRf0
	3aOlNsOFZ0Ii5BwRizjkSAUp5rjM5kdYY8Y1MOq4kmNzUere9UkXezg7jYierA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <9771585a101e05bb020e374f69c18d9198964fec.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in
 hci_abort_conn()
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Siwei Zhang
 <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Jun 2026 18:21:13 +0300
In-Reply-To: <CABBYNZKt14=Q_4RPpnZRBsnTZaOmBG3fvDHyB21+0_ndNXb5aw@mail.gmail.com>
References: <20260610130648.1091326-1-oss@fourdim.xyz>
	 <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
	 <88931814-4915-40a5-8e21-66ddbdb2a530@app.fastmail.com>
	 <CABBYNZKt14=Q_4RPpnZRBsnTZaOmBG3fvDHyB21+0_ndNXb5aw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-06-10 kello 10:02 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Siwei,
>=20
> On Wed, Jun 10, 2026 at 9:52=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wro=
te:
> >=20
> > Hi Luiz,
> >=20
> > On Wed, Jun 10, 2026, at 9:14 AM, Luiz Augusto von Dentz wrote:
> > > Hi Siwei,
> > >=20
> > > On Wed, Jun 10, 2026 at 9:07=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
> > > >=20
> > > > hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a connect=
ion
> > > > is pending, but hdev->sent_cmd can be NULL while req_status is stil=
l
> > > > HCI_REQ_PEND
> > >=20
> > > Can it really be NULL? If it can then I don't think we are handling
> > > HCI_REQ_PEND well and perhaps should instead just check hdev->sent_cm=
d
> > > directly instead of bothering with hdev->req_status.
> > >=20
> >=20
> > This is the crash stack.
> >=20
> > Title: general protection fault in hci_abort_conn
> > Type: general protection fault
> > Function: hci_abort_conn
> > Signature: f64ebf7af5cee01a
> > Time: 2026-06-01-12:48:57
> > ---
> > [ 1266.952280] Oops: general protection fault, probably for non-canonic=
al address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
> > [ 1266.954486] KASAN: null-ptr-deref in range [0x0000000000000038-0x000=
000000000003f]
> > [ 1266.955864] CPU: 0 UID: 0 PID: 384 Comm: kworker/u9:1 Tainted: G    =
    W           7.0.8-g8de79710cf39 #4 PREEMPT(lazy)
> > [ 1266.957695] Tainted: [W]=3DWARN
> > [ 1266.958535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 1266.960480] Workqueue: hci0 hci_rx_work
> > [ 1266.961483] RIP: 0010:hci_abort_conn+0x179/0x2d0
> > [ 1266.962296] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28=
 00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 03=
 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
> > [ 1266.965380] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
> > [ 1266.966267] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 0000000=
000000000
> > [ 1266.967770] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 0000000=
000000001
> > [ 1266.969054] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000=
000000000
> > [ 1266.970874] R10: 0000000000000000 R11: ffffffff85464c1b R12: 0000000=
000000005
> > [ 1266.972036] R13: dffffc0000000000 R14: ffff88810f810000 R15: 0000000=
00000003b
> > [ 1266.973213] FS:  0000000000000000(0000) GS:ffff888190689000(0000) kn=
lGS:0000000000000000
> > [ 1266.974917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1266.975867] CR2: 00007f51ba4e2020 CR3: 000000010fea7000 CR4: 0000000=
0000006f0
> > [ 1266.977409] Call Trace:
> > [ 1266.977895]  <TASK>
> > [ 1266.978676]  hci_disconnect+0xe8/0x250 net/bluetooth/hci_conn.c:197
> > [ 1266.979781]  ? lock_release+0xf8/0x370 kernel/locking/lockdep.c:5889
> > [ 1266.980541]  ? __pfx_hci_disconnect+0x10/0x10 net/bluetooth/hci_conn=
.c:179
> > [ 1266.981926]  ? hci_conn_hash_lookup_ba+0x29e/0x2c0 include/net/bluet=
ooth/hci_core.h:1259
> > [ 1266.982879]  ? __crypto_memneq+0x47/0x490 lib/crypto/memneq.c:169
> > [ 1266.983884]  hci_link_key_notify_evt+0x21d/0xa50 net/bluetooth/hci_e=
vent.c:4750
> > [ 1266.984987]  ? __pfx___mutex_unlock_slowpath+0x10/0x10 kernel/lockin=
g/mutex.c:932
> > [ 1266.985918]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth=
/hci_event.c:4730
> > [ 1266.986769]  ? skb_pull_data+0x100/0x1b0 net/core/skbuff.c:2710
> > [ 1266.987754]  hci_event_packet+0x65e/0xd50
> > [ 1266.988429]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth=
/hci_event.c:4730
> > [ 1266.989277]  ? __pfx_hci_event_packet+0x10/0x10 net/bluetooth/hci_ev=
ent.c:7803
> > [ 1266.990051]  ? lockdep_hardirqs_on_prepare+0x168/0x230 kernel/lockin=
g/lockdep.c:4410
> > [ 1266.991088]  ? hci_send_to_monitor+0xdd/0x510
> > [ 1266.991977]  hci_rx_work+0x3d1/0x8d0 net/bluetooth/hci_core.c:4078
> > [ 1266.993050]  ? process_scheduled_works+0xa01/0x1760 kernel/workqueue=
.c:3371
> > [ 1266.994019]  process_scheduled_works+0xac1/0x1760 kernel/workqueue.c=
:3371
> > [ 1266.995274]  ? trace_sched_exit_tp+0x35/0x130 include/trace/events/s=
ched.h:886
> > [ 1266.996155]  ? __pfx_process_scheduled_works+0x10/0x10 kernel/workqu=
eue.c:3361
> > [ 1266.997132]  ? do_raw_spin_lock+0x126/0x270 kernel/locking/spinlock_=
debug.c:116
> > [ 1266.997955]  ? assign_work+0x333/0x4d0
> > [ 1266.998706]  worker_thread+0xa22/0xf80 kernel/workqueue.c:3453
> > [ 1266.999792]  ? __kthread_parkme+0x1a5/0x200
> > [ 1267.000591]  kthread+0x38b/0x480 kernel/kthread.c:438
> > [ 1267.001680]  ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3398
> > [ 1267.002499]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
> > [ 1267.003154]  ret_from_fork+0x436/0x950 arch/x86/kernel/process.c:164
> > [ 1267.003797]  ? __pfx_ret_from_fork+0x10/0x10 arch/x86/kernel/process=
.c:153
> > [ 1267.004501]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
> > [ 1267.005137]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:2=
58
> > [ 1267.005855]  </TASK>
> > [ 1267.006918] Modules linked in:
> > [ 1267.008266] ---[ end trace 0000000000000000 ]---
> > [ 1267.010119] RIP: 0010:hci_abort_conn+0x179/0x2d0
> > [ 1267.011723] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28=
 00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 03=
 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
> > [ 1267.015717] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
> > [ 1267.016793] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 0000000=
000000000
> > [ 1267.018342] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 0000000=
000000001
> > [ 1267.019857] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000=
000000000
> > [ 1267.021481] R10: 0000000000000000 R11: ffffffff85464c1b R12: 0000000=
000000005
> > [ 1267.022973] R13: dffffc0000000000 R14: ffff88810f810000 R15: 0000000=
00000003b
> > [ 1267.024217] FS:  0000000000000000(0000) GS:ffff888190689000(0000) kn=
lGS:0000000000000000
> > [ 1267.025954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >=20
> > > > , leading to a NULL pointer dereference and a general
> > > > protection fault from the hci_rx_work() receive path.
> > > >=20
> > > > Check hdev->sent_cmd before dereferencing it.
> > > >=20
> > > > Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for abo=
rting connections")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> > > > ---
> > > >  net/bluetooth/hci_conn.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > index 54eabaa46960..43fdacb2c9b2 100644
> > > > --- a/net/bluetooth/hci_conn.c
> > > > +++ b/net/bluetooth/hci_conn.c
> > > > @@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 =
reason)
> > > >          * hci_connect_le serializes the connection attempts so onl=
y one
> > > >          * connection can be in BT_CONNECT at time.
> > > >          */
> > > > -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_st=
atus) =3D=3D HCI_REQ_PEND) {
> > > > +       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_st=
atus) =3D=3D HCI_REQ_PEND &&
> > > > +           hdev->sent_cmd) {
> > > >                 switch (hci_skb_event(hdev->sent_cmd)) {

The hdev->sent_cmd access here looks unsafe vs synchronization:

* hdev->sent_cmd pointer is modified (only) from hci_cmd_work() which
runs in hdev->workqueue.

* No lock is held, only the ordered hdev->workqueue synchronizes

* The skb pointed to is also freed from hdev->workqueue.

* Even if valid pointer to it is obtained, the skb may be freed under
us here

hci_abort_conn() is called from places like smp->security_timer ->
hci_disconnect() which run in kernel default workqueues -> potential
UAF here.

MGMT unpair_device_sync() appears to call it from hdev->req_workqueue,
which is then the same.

Taking hdev_lock doesn't help here, as it's only synchronized by the
workqueue.

The hdev->sent_cmd probably needs some new locking primitive, not sure
hdev->lock and hdev->req_lock can be used here as not sure what locking
contexts this is called from.

> > > >                 case HCI_EV_CONN_COMPLETE:
> > > >                 case HCI_EV_LE_CONN_COMPLETE:
> > > > --
> > > > 2.54.0
> > > >=20
> >=20
> > There is an else if branch after it:
> >=20
> >         if (conn->state =3D=3D BT_CONNECT && hdev->sent_cmd) {
> >                 switch (hci_skb_event(hdev->sent_cmd)) {
> >                 case HCI_EV_CONN_COMPLETE:
> >                 case HCI_EV_LE_CONN_COMPLETE:
> >                 case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
> >                 case HCI_EVT_LE_CIS_ESTABLISHED:
> >                         hci_cmd_sync_cancel(hdev, ECANCELED);
> >                         break;
> >                 }
> >         /* Cancel connect attempt if still queued/pending */
> >         } else if (!hci_cancel_connect_sync(hdev, conn)) {
> >                 return 0;
> >         }
> >=20
> > I don't think replacing it is a wise choice as else if branch might be =
escaped accidentally.
>=20
> Perhaps we should change it. Maybe `hci_conn` could set a bit if it is
> pending or just scheduled and it would probably be cleaner if
> hci_cancel_connect_sync handles this internally.
>=20
> > e.g. status !=3D pending can go to if branch and cancel in else if bran=
ch can never be executed.
> >=20
> > >=20
> > >=20
> > > --
> > > Luiz Augusto von Dentz
> >=20
> > BTW, could you please check my explanation for another patch as well?
> > https://lore.kernel.org/linux-bluetooth/20260603150835.3539963-1-oss@fo=
urdim.xyz/T/#m0702d8586e0fb10775f4bd52998bf42e09b85af7
> >=20
> > Thank you.
> >=20
> > Best,
> > Siwei
>=20
>=20

--=20
Pauli Virtanen
