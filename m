Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D63275870
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100191; cv=pass; b=jPnIDIkH/+nxr6TyKwNoiTFTlt6uegMdYiDFjJfEpK0y8UAaJAEOzJ5BInNgbXZ98ccdXanLLeqI8gKhLl3RDCWy3VMUNbCjAzR2jC9NJ28Y+DIDecD0sM1quK+u7W7QuafZdNzt6MBLUgaOWwtsg3/rKLvdzoLuX52VzKZvpqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100191; c=relaxed/simple;
	bh=Xmr41SpejNivERD2odYMkL77+GDQHWdqe673vwGygug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa09/3WBC9PdhFUAjHHfI+dj6nCG2PAo9ZUIYJ3XXkaUsf0Ho2OiI6baw3BkiekKv0Ky3ION1peQo+ZU2qkjAfw3uYPKSXncQQw8qOfqYgILJ7W3m2p3F4uDopeV9XTCkgQz5IH3TKFLIrULVXVjHRhVpxeLWPMwvbhPpcWZm+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUEhg3zS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUEhg3zS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6611689dc10so4265085d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781100189; cv=none;
        d=google.com; s=arc-20240605;
        b=dz903ejDI0H3+W5J3E4ANkpGmDQO36iR1AUyewBHwBX5tY5hHnUVoRHXi7Qj+0QM7C
         lyLTFBfooNsodb/OCLdqniMmsbQvnFOixehSp/836sdgf6AH548KRCoUrHq0prl2CBPg
         zF1O/FDCJPW63O11pbEBwD+BNJ+k3mXlQft7JqE5iCYkTg1O26AqMt169U10Iv0Q9u/i
         yLE0vucIw8MqtqliFEN/xU4DFPAA488KH5a5Xv7A05gqy8CUG4oucs25pU80D6J84QmH
         gLWNHWyPoenyN5LdzIlH94w0KsFzuuW7/neXcTR3nf9N5xSQbcvN8hfE/dDEr6gcq3PS
         KYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8nvgDne4n8n30Xiex/roG477+hso1GypVjDsibzg0k=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=a1z1TtXm0WB2SFICxj3qY0EmARpKNMjhGo/dfvtjT95rsgra9fNgi+F3LEe9Wpmcfm
         MmYPnbO13RX64ysw/DxS0I6E8i7gBwUpu1HOsNaLKy+MOB5spo4+RXz4RliEcnvVvySS
         oNNGqtgNZP5QHeNQYV29m3uyF6dCxsL5x9x2/0e3sqi6P4P4rLwiDKaSLNBBD5iXdnRs
         uAI5bttj6cDNTUS8Ddnu9H6XnHeerxMEOSEVY/KlbZkNRnr0Zjp5vVEtLnXinEEWtP7t
         97VFxF2VbJWMwwUOWuS/l37MFWyC5WDlO77ZY9ZrzJKI4eZ32Fsdj6MgtyoC6R/HnE8i
         MXYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781100189; x=1781704989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8nvgDne4n8n30Xiex/roG477+hso1GypVjDsibzg0k=;
        b=pUEhg3zSc/tXvq4wTAxXZqhXGtqyN17GQvyipa0ds39ZU3SsWjq5gvqTSz2yO9QLfT
         sQwF2fRYRRTHRs2/f8Rd6xm9qrVNpz5wXbmp558SlInpXM2rskqs/pwDzAa03LpzNI4H
         RMFy/Bp3y1ZYB0tLnJpbDBtwrvvcE20a219yAeCk2kMd+FYpkvYz7AMHhmcW5IXvx7yh
         8+5zKjmK3dXckknEYV5nvh55/p8HcnnGD/LQ1eQ4Xs236UukJJE8D/UEssOYLUq6O4IO
         pg8iXKHxSkeylMrfZkm7ABtSj3RJ6bM1j1zWETWFo7zeYHtwBvfQmbu/AMov5AOPGegU
         8CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781100189; x=1781704989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8nvgDne4n8n30Xiex/roG477+hso1GypVjDsibzg0k=;
        b=gBLBcZ5kR4kqV/Iyi+EaTxYpzWKRwoWdmPoDN/RmNPyGZUWZtEd1o6QiHmpFAS6MSV
         S6Yxpyni7uvcVVHo4YovcDySyygL99G6oC6ymUiED4SOb4fx66/FFZ5PdLuKfoKfW3X1
         F76g+UQ5PvjLNuWTrMQ8KrAtpfjFmsmwUQwKByZvKQHYCcZJpGmUj2M5R+Zwu6no8wdg
         qmIk7cX40xpl4JbqEn/Iztwsy3jrV6yxrEFUoVXMu5z6dnyfEKhIYqEJP+jcfUJ/3uWe
         vOCbCazoj4I1dlnBBdXnsCyCu2D4S58ExSnVeMk/Fhcbdgg2/y3l0TyNkfQTJ/lkv1Q2
         UHcQ==
X-Gm-Message-State: AOJu0YzbQN3LBpP8sospm180fEeEeEJ2UTopKiSfukSC0IHS98s9m6PS
	lIdblwvQom+q8s4b5WnbboV5tCMjBNkVSSRnZGvwWNIYkHA7pw7MI5gkhrQGeSemhvHwfiRO8e8
	CMem/SehmmwaIdFRG7hiIdTMZut+ftLxNztMT
X-Gm-Gg: Acq92OGiUtE0oR2fRl7yWUDFL6VSjkbkw6ZL0x2AG+1iQnTlV1H3RAoGnCYB9QJNYfl
	/vLbiK2ScHoTZOuuvBWWqQ2rwM8zAYMM93MaLUywK9tgRMKUBRLsoL/yHY1Z+8wBMV0BG/q66wQ
	R4idRmCivPg3eh7nuTsBpW5pYEltt8Z58eN0Q+bWwtB6ve4qyf54P2rI/jtytDBtgmzCF+duGt2
	l5FEG7eE73m3yTmL7rPxYetQ1EoQDz3ND9Oq0IaygVXXG5llvPxSNTORC0HzdZN8z6b3rdyfNoF
	zfNgY8EhfhUqYx/mW1ZkLHFgfYsjyB8LjMC5OKxA3joZNT6fe9Uxwjy4atYy5eGlczpTlYyupDv
	TJw==
X-Received: by 2002:a05:690e:1a4f:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-66107019dd5mr17041427d50.34.1781100188108; Wed, 10 Jun 2026
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610130648.1091326-1-oss@fourdim.xyz> <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
 <88931814-4915-40a5-8e21-66ddbdb2a530@app.fastmail.com>
In-Reply-To: <88931814-4915-40a5-8e21-66ddbdb2a530@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 10:02:56 -0400
X-Gm-Features: AVVi8CdQSji5izNbH4nywWwUbGkdRgrxfoTvymJhmHIyIUIl7BAYzU0jzOaSxJ8
Message-ID: <CABBYNZKt14=Q_4RPpnZRBsnTZaOmBG3fvDHyB21+0_ndNXb5aw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 10, 2026 at 9:52=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> Hi Luiz,
>
> On Wed, Jun 10, 2026, at 9:14 AM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Wed, Jun 10, 2026 at 9:07=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> w=
rote:
> >>
> >> hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a connection
> >> is pending, but hdev->sent_cmd can be NULL while req_status is still
> >> HCI_REQ_PEND
> >
> > Can it really be NULL? If it can then I don't think we are handling
> > HCI_REQ_PEND well and perhaps should instead just check hdev->sent_cmd
> > directly instead of bothering with hdev->req_status.
> >
>
> This is the crash stack.
>
> Title: general protection fault in hci_abort_conn
> Type: general protection fault
> Function: hci_abort_conn
> Signature: f64ebf7af5cee01a
> Time: 2026-06-01-12:48:57
> ---
> [ 1266.952280] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
> [ 1266.954486] KASAN: null-ptr-deref in range [0x0000000000000038-0x00000=
0000000003f]
> [ 1266.955864] CPU: 0 UID: 0 PID: 384 Comm: kworker/u9:1 Tainted: G      =
  W           7.0.8-g8de79710cf39 #4 PREEMPT(lazy)
> [ 1266.957695] Tainted: [W]=3DWARN
> [ 1266.958535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.2-debian-1.16.2-1 04/01/2014
> [ 1266.960480] Workqueue: hci0 hci_rx_work
> [ 1266.961483] RIP: 0010:hci_abort_conn+0x179/0x2d0
> [ 1266.962296] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28 0=
0 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 03 <=
42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
> [ 1266.965380] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
> [ 1266.966267] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 000000000=
0000000
> [ 1266.967770] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 000000000=
0000001
> [ 1266.969054] RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000=
0000000
> [ 1266.970874] R10: 0000000000000000 R11: ffffffff85464c1b R12: 000000000=
0000005
> [ 1266.972036] R13: dffffc0000000000 R14: ffff88810f810000 R15: 000000000=
000003b
> [ 1266.973213] FS:  0000000000000000(0000) GS:ffff888190689000(0000) knlG=
S:0000000000000000
> [ 1266.974917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1266.975867] CR2: 00007f51ba4e2020 CR3: 000000010fea7000 CR4: 000000000=
00006f0
> [ 1266.977409] Call Trace:
> [ 1266.977895]  <TASK>
> [ 1266.978676]  hci_disconnect+0xe8/0x250 net/bluetooth/hci_conn.c:197
> [ 1266.979781]  ? lock_release+0xf8/0x370 kernel/locking/lockdep.c:5889
> [ 1266.980541]  ? __pfx_hci_disconnect+0x10/0x10 net/bluetooth/hci_conn.c=
:179
> [ 1266.981926]  ? hci_conn_hash_lookup_ba+0x29e/0x2c0 include/net/bluetoo=
th/hci_core.h:1259
> [ 1266.982879]  ? __crypto_memneq+0x47/0x490 lib/crypto/memneq.c:169
> [ 1266.983884]  hci_link_key_notify_evt+0x21d/0xa50 net/bluetooth/hci_eve=
nt.c:4750
> [ 1266.984987]  ? __pfx___mutex_unlock_slowpath+0x10/0x10 kernel/locking/=
mutex.c:932
> [ 1266.985918]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth/h=
ci_event.c:4730
> [ 1266.986769]  ? skb_pull_data+0x100/0x1b0 net/core/skbuff.c:2710
> [ 1266.987754]  hci_event_packet+0x65e/0xd50
> [ 1266.988429]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth/h=
ci_event.c:4730
> [ 1266.989277]  ? __pfx_hci_event_packet+0x10/0x10 net/bluetooth/hci_even=
t.c:7803
> [ 1266.990051]  ? lockdep_hardirqs_on_prepare+0x168/0x230 kernel/locking/=
lockdep.c:4410
> [ 1266.991088]  ? hci_send_to_monitor+0xdd/0x510
> [ 1266.991977]  hci_rx_work+0x3d1/0x8d0 net/bluetooth/hci_core.c:4078
> [ 1266.993050]  ? process_scheduled_works+0xa01/0x1760 kernel/workqueue.c=
:3371
> [ 1266.994019]  process_scheduled_works+0xac1/0x1760 kernel/workqueue.c:3=
371
> [ 1266.995274]  ? trace_sched_exit_tp+0x35/0x130 include/trace/events/sch=
ed.h:886
> [ 1266.996155]  ? __pfx_process_scheduled_works+0x10/0x10 kernel/workqueu=
e.c:3361
> [ 1266.997132]  ? do_raw_spin_lock+0x126/0x270 kernel/locking/spinlock_de=
bug.c:116
> [ 1266.997955]  ? assign_work+0x333/0x4d0
> [ 1266.998706]  worker_thread+0xa22/0xf80 kernel/workqueue.c:3453
> [ 1266.999792]  ? __kthread_parkme+0x1a5/0x200
> [ 1267.000591]  kthread+0x38b/0x480 kernel/kthread.c:438
> [ 1267.001680]  ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3398
> [ 1267.002499]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
> [ 1267.003154]  ret_from_fork+0x436/0x950 arch/x86/kernel/process.c:164
> [ 1267.003797]  ? __pfx_ret_from_fork+0x10/0x10 arch/x86/kernel/process.c=
:153
> [ 1267.004501]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
> [ 1267.005137]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:258
> [ 1267.005855]  </TASK>
> [ 1267.006918] Modules linked in:
> [ 1267.008266] ---[ end trace 0000000000000000 ]---
> [ 1267.010119] RIP: 0010:hci_abort_conn+0x179/0x2d0
> [ 1267.011723] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28 0=
0 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 03 <=
42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
> [ 1267.015717] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
> [ 1267.016793] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 000000000=
0000000
> [ 1267.018342] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 000000000=
0000001
> [ 1267.019857] RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000=
0000000
> [ 1267.021481] R10: 0000000000000000 R11: ffffffff85464c1b R12: 000000000=
0000005
> [ 1267.022973] R13: dffffc0000000000 R14: ffff88810f810000 R15: 000000000=
000003b
> [ 1267.024217] FS:  0000000000000000(0000) GS:ffff888190689000(0000) knlG=
S:0000000000000000
> [ 1267.025954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
> >> , leading to a NULL pointer dereference and a general
> >> protection fault from the hci_rx_work() receive path.
> >>
> >> Check hdev->sent_cmd before dereferencing it.
> >>
> >> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborti=
ng connections")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> ---
> >>  net/bluetooth/hci_conn.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >> index 54eabaa46960..43fdacb2c9b2 100644
> >> --- a/net/bluetooth/hci_conn.c
> >> +++ b/net/bluetooth/hci_conn.c
> >> @@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 rea=
son)
> >>          * hci_connect_le serializes the connection attempts so only o=
ne
> >>          * connection can be in BT_CONNECT at time.
> >>          */
> >> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_statu=
s) =3D=3D HCI_REQ_PEND) {
> >> +       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_statu=
s) =3D=3D HCI_REQ_PEND &&
> >> +           hdev->sent_cmd) {
> >>                 switch (hci_skb_event(hdev->sent_cmd)) {
> >>                 case HCI_EV_CONN_COMPLETE:
> >>                 case HCI_EV_LE_CONN_COMPLETE:
> >> --
> >> 2.54.0
> >>
>
> There is an else if branch after it:
>
>         if (conn->state =3D=3D BT_CONNECT && hdev->sent_cmd) {
>                 switch (hci_skb_event(hdev->sent_cmd)) {
>                 case HCI_EV_CONN_COMPLETE:
>                 case HCI_EV_LE_CONN_COMPLETE:
>                 case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
>                 case HCI_EVT_LE_CIS_ESTABLISHED:
>                         hci_cmd_sync_cancel(hdev, ECANCELED);
>                         break;
>                 }
>         /* Cancel connect attempt if still queued/pending */
>         } else if (!hci_cancel_connect_sync(hdev, conn)) {
>                 return 0;
>         }
>
> I don't think replacing it is a wise choice as else if branch might be es=
caped accidentally.

Perhaps we should change it. Maybe `hci_conn` could set a bit if it is
pending or just scheduled and it would probably be cleaner if
hci_cancel_connect_sync handles this internally.

> e.g. status !=3D pending can go to if branch and cancel in else if branch=
 can never be executed.
>
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> BTW, could you please check my explanation for another patch as well?
> https://lore.kernel.org/linux-bluetooth/20260603150835.3539963-1-oss@four=
dim.xyz/T/#m0702d8586e0fb10775f4bd52998bf42e09b85af7
>
> Thank you.
>
> Best,
> Siwei



--=20
Luiz Augusto von Dentz
