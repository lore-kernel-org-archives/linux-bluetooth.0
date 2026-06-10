Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6740E8DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099582; cv=none; b=Ge/MYIgZl+f99HsKHqhSn6OhGmH7FD1uhHj8QHit/H74nqRyn+g10UpaAavxLMF3gQZKXT8t8b3niXZc5KKiYueeVEF2E+aGLffyJ/xCF8pBX9ZIVTO+5LO8yJsjqULxRw8EWao29U1Xepgn0RC0ay63PiVlNPlJN1uqj6rZlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099582; c=relaxed/simple;
	bh=vWyd2xktOkEs31/eT+e9fXAWFWCVUxPM05UpcuGTHeA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K2WQIIN/4JnCm6C8fv7Ex22Ef3TFJ6XHLbhmPluLxeDQUZ+rH1zh/aZ3eQ+sYoaCiGTx7zYS/2DcpW1BGV7O3Np8ucnGpXtlutWEkjbVmUxdbmFdiDz2RV6PR3RKQF0/lM2GBQYlFzPqa4NdRrm6EIgRW7tKrK7h9//s6PNeJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=UFIYsn7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2BrR+Mn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="UFIYsn7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2BrR+Mn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B085B1D000A8;
	Wed, 10 Jun 2026 09:52:54 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 09:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781099574;
	 x=1781185974; bh=WUhMg311k90CxH7h2uSPr/7noVRTdaFV06vlAkBK5tk=; b=
	UFIYsn7tqq1vVgpvRtn1lXypu/jwI1sljbiBDGtc/Pb8d61xFzjoGWsiBmiyiHL/
	p2E3zjSlNk+itnCIIkjyAM02epyN9G7D7PQSNLjLEpO+mZ8/U9m6P6xips8YZQ+a
	jCyT9IRpSaNyhlfxnv+y7H1im9VsXmTojyNNAGTvNqOzpl+VjQrTN3T3KHxPxKq5
	Iztv28iw8RqfauhujsxJd2TV6eS1Z3hvNrdE/+d9t+W9a7sMKnTo7XipWcT7ede6
	vhwd4Uq6fgSoOo+b3dm0gUKXYyfihOXQf3WVrd9Nzo2gnPL5cAGHlK+i6bdVGDEE
	nxqI3OxS/Xr/lR9/C+bP1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781099574; x=
	1781185974; bh=WUhMg311k90CxH7h2uSPr/7noVRTdaFV06vlAkBK5tk=; b=h
	2BrR+MnpFFwlgWlBogO48PDGT7yIh/r1OlJ/MDYtaImcyAAa5r/XmrZ85PUN4g44
	jmmWjTg4o04p89m7Gt0hyFtaG+pykuuiqLt2z2yOGs0MY2A+ADWCJANc/r1+wGKq
	VIb+4J0pxg9C0YFAa7hG+n/GljsPrFizaHb51vik7lE3PpIzzlBq1I0XtW112gw6
	NpgNwF0VmDB9TrdK0ixbnkmvl1p7q6Dxm+QjLNHbHogrY1QAG9ej61KOqgoZkIgr
	vpTUeNSHollopw8N0REuB+oSXGMKdBJA9fgqfHM4oblOSUu47vAfDlVZDF8YAqFq
	SkIfr1fE6bab+wvuDJTYw==
X-ME-Sender: <xms:NmwpalMQtO4MdvqkUMwmscCYV1pzpzV3hOx7v3IW0oHA6nPCUySU2g>
    <xme:NmwpaixZaEsu2iyHpaNW6dYIXEKHr7JHdx1fapOggH3XUtIgf-ur7oWe69RCsu7PC
    FAAA3DPFNwQQH98lmoNbm5KD1qcdBVCDq44DDxm5tfLFqvatxn8uMaB>
X-ME-Proxy-Cause: dmFkZTFUfulRLe6ZSXsT+2sPD8iH9J7V+sK3ZTCkmJFkyXzTAOcvgy4qia/zWzMNC/+Tx4
    dIzoma4YJg6sVeMjph/IgdGdmO58qGD174OnyTODP1a3bqUjmiF1v1NW5O7E6KQTznxlZY
    w532ltoulpatZAYAXIe61XD/Z0sZiFeo/QkP8u3rTcZmuFN0HR2NziQZJEBFiTMzgVkW5H
    nhTl35U81/nlJJtgFls0g9jT49orHmkY/dZqKwfA0f91QwS66dZNiRmAr3e4Ca26Qn7iYD
    QFsnz+Q1eDCPze+1fvWvr0muoOeqnOSSz8ptmnEB3F1jCtCM7NY99kkQEV+mV/OF5SwlBR
    Xy3v9Mx/s/hIMQEQFhtUhrIubb6wcESOkqG0OvDD8eteKRMkLbUNugHEK7BSU2XTRoDSkG
    WcNAkaSxpCtErLHjQFBkqk+KE5hY/zS3qfc5bJfIMctlRQVWYAtjFH9r7EJHAtaAqCsCoo
    G4WlzK6rgHAhQ8zqRI8kcjcdgO/iq/7XuRHJShHgmGpr4V63af1eX4mDvlCxt+G3uryRkc
    3eDnVoXzmYCSK2gM9E8OGSOq9ZVQvRfnN3/q9WpuJ/Uk9WxiBstrsguvSSz5p8evMr6Qwh
    XNatV5+LRP0rSa7ZpRlTEkqYO5MGJ85yDkFQNO82dTduVY21NCVEvuWFnzRQ
X-ME-Proxy: <xmx:Nmwpaj4yv4Ty3tKSj2IDGg0yuuXJBRSPxj7acuWkIaxmOwqGg09Gjg>
    <xmx:Nmwpam1hjon8x3yudAnQsn1kPGsCoFJe38ydhwl7is443Czjs72Cmw>
    <xmx:NmwpaiDnab0S5wKtmVg1SHcbJw0KT_JTSJjdUO1GuMZ9o-8_4HI7uA>
    <xmx:Nmwpag0U1jrbFk2pmVcvnjkAYCR7lRUgdlXaWHSLupEkyNA2w4wGig>
    <xmx:NmwpanjIDKJ4TfrwYah8bSJDSi4UIHelR-Cv7JmAnhitOtkzq8odIXjE>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35EEA216008A; Wed, 10 Jun 2026 09:52:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0J09q5gusMF
Date: Wed, 10 Jun 2026 09:52:32 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88931814-4915-40a5-8e21-66ddbdb2a530@app.fastmail.com>
In-Reply-To: 
 <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
References: <20260610130648.1091326-1-oss@fourdim.xyz>
 <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, Jun 10, 2026, at 9:14 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, Jun 10, 2026 at 9:07=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a connection
>> is pending, but hdev->sent_cmd can be NULL while req_status is still
>> HCI_REQ_PEND
>
> Can it really be NULL? If it can then I don't think we are handling
> HCI_REQ_PEND well and perhaps should instead just check hdev->sent_cmd
> directly instead of bothering with hdev->req_status.
>

This is the crash stack.

Title: general protection fault in hci_abort_conn
Type: general protection fault
Function: hci_abort_conn
Signature: f64ebf7af5cee01a
Time: 2026-06-01-12:48:57
---
[ 1266.952280] Oops: general protection fault, probably for non-canonica=
l address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
[ 1266.954486] KASAN: null-ptr-deref in range [0x0000000000000038-0x0000=
00000000003f]
[ 1266.955864] CPU: 0 UID: 0 PID: 384 Comm: kworker/u9:1 Tainted: G     =
   W           7.0.8-g8de79710cf39 #4 PREEMPT(lazy)=20
[ 1266.957695] Tainted: [W]=3DWARN
[ 1266.958535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1266.960480] Workqueue: hci0 hci_rx_work
[ 1266.961483] RIP: 0010:hci_abort_conn+0x179/0x2d0
[ 1266.962296] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28 =
00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 =
03 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
[ 1266.965380] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
[ 1266.966267] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 00000000=
00000000
[ 1266.967770] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 00000000=
00000001
[ 1266.969054] RBP: 0000000000000001 R08: 0000000000000001 R09: 00000000=
00000000
[ 1266.970874] R10: 0000000000000000 R11: ffffffff85464c1b R12: 00000000=
00000005
[ 1266.972036] R13: dffffc0000000000 R14: ffff88810f810000 R15: 00000000=
0000003b
[ 1266.973213] FS:  0000000000000000(0000) GS:ffff888190689000(0000) knl=
GS:0000000000000000
[ 1266.974917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1266.975867] CR2: 00007f51ba4e2020 CR3: 000000010fea7000 CR4: 00000000=
000006f0
[ 1266.977409] Call Trace:
[ 1266.977895]  <TASK>
[ 1266.978676]  hci_disconnect+0xe8/0x250 net/bluetooth/hci_conn.c:197
[ 1266.979781]  ? lock_release+0xf8/0x370 kernel/locking/lockdep.c:5889
[ 1266.980541]  ? __pfx_hci_disconnect+0x10/0x10 net/bluetooth/hci_conn.=
c:179
[ 1266.981926]  ? hci_conn_hash_lookup_ba+0x29e/0x2c0 include/net/blueto=
oth/hci_core.h:1259
[ 1266.982879]  ? __crypto_memneq+0x47/0x490 lib/crypto/memneq.c:169
[ 1266.983884]  hci_link_key_notify_evt+0x21d/0xa50 net/bluetooth/hci_ev=
ent.c:4750
[ 1266.984987]  ? __pfx___mutex_unlock_slowpath+0x10/0x10 kernel/locking=
/mutex.c:932
[ 1266.985918]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth/=
hci_event.c:4730
[ 1266.986769]  ? skb_pull_data+0x100/0x1b0 net/core/skbuff.c:2710
[ 1266.987754]  hci_event_packet+0x65e/0xd50
[ 1266.988429]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluetooth/=
hci_event.c:4730
[ 1266.989277]  ? __pfx_hci_event_packet+0x10/0x10 net/bluetooth/hci_eve=
nt.c:7803
[ 1266.990051]  ? lockdep_hardirqs_on_prepare+0x168/0x230 kernel/locking=
/lockdep.c:4410
[ 1266.991088]  ? hci_send_to_monitor+0xdd/0x510
[ 1266.991977]  hci_rx_work+0x3d1/0x8d0 net/bluetooth/hci_core.c:4078
[ 1266.993050]  ? process_scheduled_works+0xa01/0x1760 kernel/workqueue.=
c:3371
[ 1266.994019]  process_scheduled_works+0xac1/0x1760 kernel/workqueue.c:=
3371
[ 1266.995274]  ? trace_sched_exit_tp+0x35/0x130 include/trace/events/sc=
hed.h:886
[ 1266.996155]  ? __pfx_process_scheduled_works+0x10/0x10 kernel/workque=
ue.c:3361
[ 1266.997132]  ? do_raw_spin_lock+0x126/0x270 kernel/locking/spinlock_d=
ebug.c:116
[ 1266.997955]  ? assign_work+0x333/0x4d0
[ 1266.998706]  worker_thread+0xa22/0xf80 kernel/workqueue.c:3453
[ 1266.999792]  ? __kthread_parkme+0x1a5/0x200
[ 1267.000591]  kthread+0x38b/0x480 kernel/kthread.c:438
[ 1267.001680]  ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:3398
[ 1267.002499]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
[ 1267.003154]  ret_from_fork+0x436/0x950 arch/x86/kernel/process.c:164
[ 1267.003797]  ? __pfx_ret_from_fork+0x10/0x10 arch/x86/kernel/process.=
c:153
[ 1267.004501]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
[ 1267.005137]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:258
[ 1267.005855]  </TASK>
[ 1267.006918] Modules linked in:
[ 1267.008266] ---[ end trace 0000000000000000 ]---
[ 1267.010119] RIP: 0010:hci_abort_conn+0x179/0x2d0
[ 1267.011723] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28 =
00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c1 e8 =
03 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48 c7
[ 1267.015717] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
[ 1267.016793] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 00000000=
00000000
[ 1267.018342] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 00000000=
00000001
[ 1267.019857] RBP: 0000000000000001 R08: 0000000000000001 R09: 00000000=
00000000
[ 1267.021481] R10: 0000000000000000 R11: ffffffff85464c1b R12: 00000000=
00000005
[ 1267.022973] R13: dffffc0000000000 R14: ffff88810f810000 R15: 00000000=
0000003b
[ 1267.024217] FS:  0000000000000000(0000) GS:ffff888190689000(0000) knl=
GS:0000000000000000
[ 1267.025954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

>> , leading to a NULL pointer dereference and a general
>> protection fault from the hci_rx_work() receive path.
>>
>> Check hdev->sent_cmd before dereferencing it.
>>
>> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for abort=
ing connections")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  net/bluetooth/hci_conn.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 54eabaa46960..43fdacb2c9b2 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 re=
ason)
>>          * hci_connect_le serializes the connection attempts so only =
one
>>          * connection can be in BT_CONNECT at time.
>>          */
>> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_stat=
us) =3D=3D HCI_REQ_PEND) {
>> +       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_stat=
us) =3D=3D HCI_REQ_PEND &&
>> +           hdev->sent_cmd) {
>>                 switch (hci_skb_event(hdev->sent_cmd)) {
>>                 case HCI_EV_CONN_COMPLETE:
>>                 case HCI_EV_LE_CONN_COMPLETE:
>> --
>> 2.54.0
>>

There is an else if branch after it:

	if (conn->state =3D=3D BT_CONNECT && hdev->sent_cmd) {
		switch (hci_skb_event(hdev->sent_cmd)) {
		case HCI_EV_CONN_COMPLETE:
		case HCI_EV_LE_CONN_COMPLETE:
		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
		case HCI_EVT_LE_CIS_ESTABLISHED:
			hci_cmd_sync_cancel(hdev, ECANCELED);
			break;
		}
	/* Cancel connect attempt if still queued/pending */
	} else if (!hci_cancel_connect_sync(hdev, conn)) {
		return 0;
	}

I don't think replacing it is a wise choice as else if branch might be e=
scaped accidentally.

e.g. status !=3D pending can go to if branch and cancel in else if branc=
h can never be executed.

>
>
> --=20
> Luiz Augusto von Dentz

BTW, could you please check my explanation for another patch as well?
https://lore.kernel.org/linux-bluetooth/20260603150835.3539963-1-oss@fou=
rdim.xyz/T/#m0702d8586e0fb10775f4bd52998bf42e09b85af7

Thank you.

Best,
Siwei
