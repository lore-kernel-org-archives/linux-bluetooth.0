Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690873BCD1C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105707; cv=none; b=CYWF2FVJA8sZYui6gfjKkSDJs7zaIjLmXuA9KVuX/WXV+dvai0yLIj2vRPovRoKyOuha+nXH7L5iKj7rh9C6ghkhdfze2Z/Oua9D1RgqdsdXyzZmqxf+PZ5t/nXuc4olrbT1QItLr7DoFhJYXZusDLpXaI5ac37aOkPQpjlw+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105707; c=relaxed/simple;
	bh=Z1VX1gwYQlgrXme4CIuu17RTpH6GHknPf6/WH2h+j9U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YEUsuQzjcD6LGPTOppL8YemSD6JTWvieB68ak2LWzgPCGRdYmc9wAUcSLBdtv6sX0Q7Rm0eocInxoWEIJ9cth4nB8X6a17h+M8OdcbsGfauc1j9zt3dFQGMsSm5a+1P4iiwPgZLWgCpA1FY5y9WHaginzGCEFbcyG5+waM4mBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=goQ81BtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxfQHF5T; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="goQ81BtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxfQHF5T"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 967071D000FF;
	Wed, 10 Jun 2026 11:35:04 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 11:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781105704;
	 x=1781192104; bh=msCMeEr1g6DsK3OJMLN1AqIuPNFi/eIa/kc9RLkobOk=; b=
	goQ81BtPtGZ0M3HbpXMIw8UYYpklECTSGIbt7Yyz2HzSDsTmvQ3kU+iWwNPQiVs4
	wLgApWa2/HMOoRDaqTyRwhSLrLmwQOAgO9uVxq2IC53VWQAO3jN7xnX9O9cAEAba
	rMLtqnQcq0YpXJq+Whq7+IvfG8c3ArkTfv+rIys0x1PXOnYfqkeyckJRssZnqWa6
	QTLU4xxPNUufXrwW3jNuG8EEK428lydRD6J5WLa3Qi8GySe+VmGsb9OOjlazyPJg
	keW6bLaohpTwlCMND6+1tfSg3/KWURGtQjRUqrctPkOzZAXiLAS3MZzY25RcRImu
	ovosQ4X1Hu6EI6gy2Wpnhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781105704; x=
	1781192104; bh=msCMeEr1g6DsK3OJMLN1AqIuPNFi/eIa/kc9RLkobOk=; b=d
	xfQHF5T0xA+PEA86UaZuqFl1e+9TCm0Bh1CBijyV9gLp+NWeb+/NgecCVG9ADZVo
	DHMGwvuIZu7HX2kOwIIEkv39yFuAowNVm1ID5zP5rkQ9l8HfCZwfjBhC3lEwCrAV
	+OUwjKaAczYrY/BHXzqfqOu6CWp/y+h+Kp35r/ersWFeTM7cMeyrEq6+u8F1KN4+
	rIv/86HTegI4El4Vi8+eZEE3S1SaGDqRiCgTTPVviZjX6NtATHQkm3WJKsKULoAn
	fpbAQhv37lhoqEct7HQC7WdVPDyxvR6Y9N19JuOzSwkd1X9JP5mYNPGYnE/yueBU
	GjecpOqTpjTTy1AhiKQXQ==
X-ME-Sender: <xms:KIQpap5Q5_MSND67zo0twYlLqRCrqa8ogl_8yTdcsI5dBEeDqCM39A>
    <xme:KIQpahsbIt0oexvFMFxkp_0MuEIFLoLBqEKkjbBgDQ3h2P-amqeMtZCeEVSNbC3p7
    8dCwNz4pYM-1kP2f5IdWbhQ4tTmKscvZIJkBldxfu5G1Ob5_dg3r7k>
X-ME-Proxy-Cause: dmFkZTGme2tMdEuaBvEwZzzIt61G0rOvwf1m17nmXubByB62qs+WePtme8vy8G2nTriJJe
    ayjGf6scjZnjbynxdLgmGKlk9nU2XCn+bONOSWxzbtge7gOyrNGN3MGOggnOTSdmVVEErl
    E2qY9c1c19LPe8rDd1y6D8I2wttSLdgGzW1pqdeEy7xamCBRIklWChNn+RLR/SLou7kBR5
    9WAXN2wns7YHjwdUrK72hxrITmsmZu2PzjLk895YC1dmWb0fNypauwYJuKHmHznZ3SXfHz
    LnQLz0rYKhogxT/0BBAjM3KNAToXHccP0/YFzIrBUn4g787G+fJyA7H2gzO9UlrgZU4RX9
    YLDz3OrAcgMBxIoJ8SU7Ie3R7QhYMII3Jbm3j0G2X3uEAQuVPrC7Fmg2vi2WquvC0OY/BQ
    1fGvnpT9Re5ZBROgf/N53QGfe+kI17ORpDVIlW04HzAlpgw5gd3wZJ9lYm6vthSxZBvqer
    NI4xTFu1GwpyfB7g9qNY/aY8i5gAaKP46Iqg0nJVCeh+03/bf+6NtxaJtRVs0opPDi6Uym
    Iz7WY7V2Vci7INvLJxOFT1a0a9MSGF3p11kyAzgeVt5YdyiLg4dNQ6KXQ1AftILAzekvBX
    aa/n3kwBIq2Nw4lZLVMaiOpRFVDzGZ2nUgjr27X4hyRT4hqRXyD5b0tZ7ajA
X-ME-Proxy: <xmx:KIQpaoUwddK6LiJPjC7YLoJZ_-r1Bq6EkLmXkUQVyS9vre8wx5__VQ>
    <xmx:KIQpakWq496rmE-EWeBPBrIkEFy7EOgGsHTG-TYZZi64RhGVap5ipA>
    <xmx:KIQpavf45qmCTSJJQuFJqsoz_VcvV72cRh80fTkiOKGsETb4KoUNPw>
    <xmx:KIQpalVsS5uAcx0a_2ZKG232dAROKB_UgTb5MiRAc1uNcQKHb5a4iA>
    <xmx:KIQpagelNLwyEhGmsSmJDAeCdGzcmp7T7u4GJkrNTTiu0K83HpDqXrNx>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C8B22160098; Wed, 10 Jun 2026 11:35:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A0J09q5gusMF
Date: Wed, 10 Jun 2026 11:34:38 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Pauli Virtanen" <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Message-Id: <4d239b86-6e8f-4f9b-9086-642ac52e92aa@app.fastmail.com>
In-Reply-To: <9771585a101e05bb020e374f69c18d9198964fec.camel@iki.fi>
References: <20260610130648.1091326-1-oss@fourdim.xyz>
 <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
 <88931814-4915-40a5-8e21-66ddbdb2a530@app.fastmail.com>
 <CABBYNZKt14=Q_4RPpnZRBsnTZaOmBG3fvDHyB21+0_ndNXb5aw@mail.gmail.com>
 <9771585a101e05bb020e374f69c18d9198964fec.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Jun 10, 2026, at 11:21 AM, Pauli Virtanen wrote:
> Hi,
>
> ke, 2026-06-10 kello 10:02 -0400, Luiz Augusto von Dentz kirjoitti:
>> Hi Siwei,
>>=20
>> On Wed, Jun 10, 2026 at 9:52=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>> >=20
>> > Hi Luiz,
>> >=20
>> > On Wed, Jun 10, 2026, at 9:14 AM, Luiz Augusto von Dentz wrote:
>> > > Hi Siwei,
>> > >=20
>> > > On Wed, Jun 10, 2026 at 9:07=E2=80=AFAM Siwei Zhang <oss@fourdim.=
xyz> wrote:
>> > > >=20
>> > > > hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a con=
nection
>> > > > is pending, but hdev->sent_cmd can be NULL while req_status is =
still
>> > > > HCI_REQ_PEND
>> > >=20
>> > > Can it really be NULL? If it can then I don't think we are handli=
ng
>> > > HCI_REQ_PEND well and perhaps should instead just check hdev->sen=
t_cmd
>> > > directly instead of bothering with hdev->req_status.
>> > >=20
>> >=20
>> > This is the crash stack.
>> >=20
>> > Title: general protection fault in hci_abort_conn
>> > Type: general protection fault
>> > Function: hci_abort_conn
>> > Signature: f64ebf7af5cee01a
>> > Time: 2026-06-01-12:48:57
>> > ---
>> > [ 1266.952280] Oops: general protection fault, probably for non-can=
onical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
>> > [ 1266.954486] KASAN: null-ptr-deref in range [0x0000000000000038-0=
x000000000000003f]
>> > [ 1266.955864] CPU: 0 UID: 0 PID: 384 Comm: kworker/u9:1 Tainted: G=
        W           7.0.8-g8de79710cf39 #4 PREEMPT(lazy)
>> > [ 1266.957695] Tainted: [W]=3DWARN
>> > [ 1266.958535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> > [ 1266.960480] Workqueue: hci0 hci_rx_work
>> > [ 1266.961483] RIP: 0010:hci_abort_conn+0x179/0x2d0
>> > [ 1266.962296] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3=
c 28 00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c=
1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48=
 c7
>> > [ 1266.965380] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
>> > [ 1266.966267] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 000=
0000000000000
>> > [ 1266.967770] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 000=
0000000000001
>> > [ 1266.969054] RBP: 0000000000000001 R08: 0000000000000001 R09: 000=
0000000000000
>> > [ 1266.970874] R10: 0000000000000000 R11: ffffffff85464c1b R12: 000=
0000000000005
>> > [ 1266.972036] R13: dffffc0000000000 R14: ffff88810f810000 R15: 000=
000000000003b
>> > [ 1266.973213] FS:  0000000000000000(0000) GS:ffff888190689000(0000=
) knlGS:0000000000000000
>> > [ 1266.974917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [ 1266.975867] CR2: 00007f51ba4e2020 CR3: 000000010fea7000 CR4: 000=
00000000006f0
>> > [ 1266.977409] Call Trace:
>> > [ 1266.977895]  <TASK>
>> > [ 1266.978676]  hci_disconnect+0xe8/0x250 net/bluetooth/hci_conn.c:=
197
>> > [ 1266.979781]  ? lock_release+0xf8/0x370 kernel/locking/lockdep.c:=
5889
>> > [ 1266.980541]  ? __pfx_hci_disconnect+0x10/0x10 net/bluetooth/hci_=
conn.c:179
>> > [ 1266.981926]  ? hci_conn_hash_lookup_ba+0x29e/0x2c0 include/net/b=
luetooth/hci_core.h:1259
>> > [ 1266.982879]  ? __crypto_memneq+0x47/0x490 lib/crypto/memneq.c:169
>> > [ 1266.983884]  hci_link_key_notify_evt+0x21d/0xa50 net/bluetooth/h=
ci_event.c:4750
>> > [ 1266.984987]  ? __pfx___mutex_unlock_slowpath+0x10/0x10 kernel/lo=
cking/mutex.c:932
>> > [ 1266.985918]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluet=
ooth/hci_event.c:4730
>> > [ 1266.986769]  ? skb_pull_data+0x100/0x1b0 net/core/skbuff.c:2710
>> > [ 1266.987754]  hci_event_packet+0x65e/0xd50
>> > [ 1266.988429]  ? __pfx_hci_link_key_notify_evt+0x10/0x10 net/bluet=
ooth/hci_event.c:4730
>> > [ 1266.989277]  ? __pfx_hci_event_packet+0x10/0x10 net/bluetooth/hc=
i_event.c:7803
>> > [ 1266.990051]  ? lockdep_hardirqs_on_prepare+0x168/0x230 kernel/lo=
cking/lockdep.c:4410
>> > [ 1266.991088]  ? hci_send_to_monitor+0xdd/0x510
>> > [ 1266.991977]  hci_rx_work+0x3d1/0x8d0 net/bluetooth/hci_core.c:40=
78
>> > [ 1266.993050]  ? process_scheduled_works+0xa01/0x1760 kernel/workq=
ueue.c:3371
>> > [ 1266.994019]  process_scheduled_works+0xac1/0x1760 kernel/workque=
ue.c:3371
>> > [ 1266.995274]  ? trace_sched_exit_tp+0x35/0x130 include/trace/even=
ts/sched.h:886
>> > [ 1266.996155]  ? __pfx_process_scheduled_works+0x10/0x10 kernel/wo=
rkqueue.c:3361
>> > [ 1266.997132]  ? do_raw_spin_lock+0x126/0x270 kernel/locking/spinl=
ock_debug.c:116
>> > [ 1266.997955]  ? assign_work+0x333/0x4d0
>> > [ 1266.998706]  worker_thread+0xa22/0xf80 kernel/workqueue.c:3453
>> > [ 1266.999792]  ? __kthread_parkme+0x1a5/0x200
>> > [ 1267.000591]  kthread+0x38b/0x480 kernel/kthread.c:438
>> > [ 1267.001680]  ? __pfx_worker_thread+0x10/0x10 kernel/workqueue.c:=
3398
>> > [ 1267.002499]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
>> > [ 1267.003154]  ret_from_fork+0x436/0x950 arch/x86/kernel/process.c=
:164
>> > [ 1267.003797]  ? __pfx_ret_from_fork+0x10/0x10 arch/x86/kernel/pro=
cess.c:153
>> > [ 1267.004501]  ? __pfx_kthread+0x10/0x10 kernel/kthread.c:381
>> > [ 1267.005137]  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64=
.S:258
>> > [ 1267.005855]  </TASK>
>> > [ 1267.006918] Modules linked in:
>> > [ 1267.008266] ---[ end trace 0000000000000000 ]---
>> > [ 1267.010119] RIP: 0010:hci_abort_conn+0x179/0x2d0
>> > [ 1267.011723] Code: 8d be 48 0e 00 00 4c 89 f8 48 c1 e8 03 42 80 3=
c 28 00 74 08 4c 89 ff e8 05 a8 9b fc 4d 8b 3f 49 83 c7 3b 4c 89 f8 48 c=
1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 29 01 00 00 45 0f b6 3f 4c 89 ff 48=
 c7
>> > [ 1267.015717] RSP: 0018:ffffc9000a277760 EFLAGS: 00010212
>> > [ 1267.016793] RAX: 0000000000000007 RBX: ffff888114d4c000 RCX: 000=
0000000000000
>> > [ 1267.018342] RDX: ffff8881110f3600 RSI: 0000000000000001 RDI: 000=
0000000000001
>> > [ 1267.019857] RBP: 0000000000000001 R08: 0000000000000001 R09: 000=
0000000000000
>> > [ 1267.021481] R10: 0000000000000000 R11: ffffffff85464c1b R12: 000=
0000000000005
>> > [ 1267.022973] R13: dffffc0000000000 R14: ffff88810f810000 R15: 000=
000000000003b
>> > [ 1267.024217] FS:  0000000000000000(0000) GS:ffff888190689000(0000=
) knlGS:0000000000000000
>> > [ 1267.025954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >=20
>> > > > , leading to a NULL pointer dereference and a general
>> > > > protection fault from the hci_rx_work() receive path.
>> > > >=20
>> > > > Check hdev->sent_cmd before dereferencing it.
>> > > >=20
>> > > > Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for=
 aborting connections")
>> > > > Cc: stable@vger.kernel.org
>> > > > Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> > > > ---
>> > > >  net/bluetooth/hci_conn.c | 3 ++-
>> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > > >=20
>> > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> > > > index 54eabaa46960..43fdacb2c9b2 100644
>> > > > --- a/net/bluetooth/hci_conn.c
>> > > > +++ b/net/bluetooth/hci_conn.c
>> > > > @@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn,=
 u8 reason)
>> > > >          * hci_connect_le serializes the connection attempts so=
 only one
>> > > >          * connection can be in BT_CONNECT at time.
>> > > >          */
>> > > > -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->re=
q_status) =3D=3D HCI_REQ_PEND) {
>> > > > +       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->re=
q_status) =3D=3D HCI_REQ_PEND &&
>> > > > +           hdev->sent_cmd) {
>> > > >                 switch (hci_skb_event(hdev->sent_cmd)) {
>
> The hdev->sent_cmd access here looks unsafe vs synchronization:
>
> * hdev->sent_cmd pointer is modified (only) from hci_cmd_work() which
> runs in hdev->workqueue.
>
> * No lock is held, only the ordered hdev->workqueue synchronizes
>
> * The skb pointed to is also freed from hdev->workqueue.
>
> * Even if valid pointer to it is obtained, the skb may be freed under
> us here
>
> hci_abort_conn() is called from places like smp->security_timer ->
> hci_disconnect() which run in kernel default workqueues -> potential
> UAF here.
>
> MGMT unpair_device_sync() appears to call it from hdev->req_workqueue,
> which is then the same.
>
> Taking hdev_lock doesn't help here, as it's only synchronized by the
> workqueue.
>
> The hdev->sent_cmd probably needs some new locking primitive, not sure
> hdev->lock and hdev->req_lock can be used here as not sure what locking
> contexts this is called from.
>

Thanks for your review. The patch v2 eliminate hdev->sent_cmd
access here. Please check:

https://lore.kernel.org/linux-bluetooth/20260610150704.1234558-1-oss@fou=
rdim.xyz/T/#u

>> > > >                 case HCI_EV_CONN_COMPLETE:
>> > > >                 case HCI_EV_LE_CONN_COMPLETE:
>> > > > --
>> > > > 2.54.0
>> > > >=20
>> >=20
>> > There is an else if branch after it:
>> >=20
>> >         if (conn->state =3D=3D BT_CONNECT && hdev->sent_cmd) {
>> >                 switch (hci_skb_event(hdev->sent_cmd)) {
>> >                 case HCI_EV_CONN_COMPLETE:
>> >                 case HCI_EV_LE_CONN_COMPLETE:
>> >                 case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
>> >                 case HCI_EVT_LE_CIS_ESTABLISHED:
>> >                         hci_cmd_sync_cancel(hdev, ECANCELED);
>> >                         break;
>> >                 }
>> >         /* Cancel connect attempt if still queued/pending */
>> >         } else if (!hci_cancel_connect_sync(hdev, conn)) {
>> >                 return 0;
>> >         }
>> >=20
>> > I don't think replacing it is a wise choice as else if branch might=
 be escaped accidentally.
>>=20
>> Perhaps we should change it. Maybe `hci_conn` could set a bit if it is
>> pending or just scheduled and it would probably be cleaner if
>> hci_cancel_connect_sync handles this internally.
>>=20
>> > e.g. status !=3D pending can go to if branch and cancel in else if =
branch can never be executed.
>> >=20
>> > >=20
>> > >=20
>> > > --
>> > > Luiz Augusto von Dentz
>> >=20
>> > BTW, could you please check my explanation for another patch as wel=
l?
>> > https://lore.kernel.org/linux-bluetooth/20260603150835.3539963-1-os=
s@fourdim.xyz/T/#m0702d8586e0fb10775f4bd52998bf42e09b85af7
>> >=20
>> > Thank you.
>> >=20
>> > Best,
>> > Siwei
>>=20
>>=20
>
> --=20
> Pauli Virtanen

Best,
Siwei
