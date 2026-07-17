Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC6369D5E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303431; cv=pass; b=A5TaW6axdfR2OosBnDAMr2e7aYbUUB5ojfasucQ+A7WkXYxZqchD2RgflB1rnVwaRUveokWHV0rAP/53Q6N9JQts45ZbXzgyATI9kmAukvwnY82JkT5OB1JvtjZBlDhxBsmRMwBUFwy18iY6xQA7BxlPT9ZgqEEYONBfft1y4yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303431; c=relaxed/simple;
	bh=YWKKTB+wzqgDQRUJckASts+GWUA3XW92Sw5I7CSLHZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmSuctE/b3CpX1G63buaAl/J/Px1yG98NYPkYfcIqMGTHN9gnly+nTl8/Ja7BgLE3VulUzWFzCox///M2LTbWAu7GNw8VQDNtErDNuVrZfJOYlzW6rmqW3jbidq0VCAXFc7BQbaLc3exxbhTDrKykjVCqm2g8NLE5k2/kCcp5nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTcvAP4U; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTcvAP4U"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81dfdbd86d1so45395547b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303429; cv=none;
        d=google.com; s=arc-20260327;
        b=UZXLwJ/LsRuIIuEV0HffEH7pOdjNe0M3mw36vZZNpP0hhkkefHm53awi2OzuMgrobX
         QFgl4T4CoYjBvQ7xdWbY3L2kwVpW42opsxIcDKFq6rUDTpByBseHYhvWmwDkKMw+2ueK
         qTMifD3WqpaWhwVuMt2If8nsdHXRoOFvVEIRpnYBPca0IACMH6TtPIFgHll1kl6b9CO3
         HnPDvQHjusVBx1Ow3y3zpKKdfK5sIQMnJREvwiBo8V7aa8IL4seWSPFWr/FwXGQt7H7N
         zPMpbOrYO+i5FeNFMFHQnODStVLoRGJHuk24JLzcGJQom+5mJLgMvtsHApI1usOX1KUp
         YhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6SPDYLCvNHt56qK0RkuimcfIqFeVqqejvAiZGhKCWnM=;
        fh=wSS+WkUQ4CZ7S5Y+qEtKoFEt6jCIslD5a1OUkLSIAWk=;
        b=lzv45nyBFxupaGF6d3MLSc6zOg+czy8JfhgndpcBdVTklQjadOyKEJXqBT/BWDf6/r
         R3q3VX/oeg4a08iysXm/g4Nkhce+HDZfrH1IlF+mo6tnneA7v8NXEAEla/LIPUEvwPlt
         JK/xEtxDYMSQFrGSiGMPxJg/1wOW4cKiN1ebZUPqTK9DMis1rCbN61evUBE2XaDLoGIi
         J2b/ApKbcCa5NYySYt+qGFBb8V2a+b3fHJibgOXmlcYpGj2V+ulO2y5+Nd75nSa36wAv
         ElNEHt6jVRTZNPvNMAEWLHJ1R1BDMvlg5hDm0/9IfofSsduckc7CHIukzZMZtPMPXxXb
         2n0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303429; x=1784908229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6SPDYLCvNHt56qK0RkuimcfIqFeVqqejvAiZGhKCWnM=;
        b=gTcvAP4UwWa6cr5HhnyjTSVCGSOMpNlYj3iVaQe2bPiyW4B9qbOSYfBKWoHcuszf5W
         UCat5kB3R6399TDWJfFta0AJkjf6bWtmMgbDbe2RRka/r1EQ4seHY4+MEIGnsupjfOP6
         IGjmV2FDxEtfd2Gyf+iim7fPpws7spRykFwTqy+kk3K9JpryDPRTmR5lBY3QTUN1ij6u
         4mMwgarLsC8FF9hBdpvEDDm7XFPtihXq/mfmvZG0RPjlX5H7JXa6gFOg5Peld+5fXX6X
         R/FeX2H0yy8ub+ZfQKiBAQAgVKA0v9bU1OYeKXpZDLZgztv/AUdy7udQwFXrTCoSOcz1
         j3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303429; x=1784908229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SPDYLCvNHt56qK0RkuimcfIqFeVqqejvAiZGhKCWnM=;
        b=lPaSwvC60oIVQm9PpOIJ0X685beFs9z/b6YAfuw5tA4yu9H/0y5LCgr4RjOss8VzRE
         OPebJwcsJWspvLkv/2TW+aKFiob9HpsaduVpDDPUI8FNCjAZOTrJs1vkRcznqisPN9aS
         71kUdumvYnn733eDRrjjWobMYW+c5AAK8iXkgQfAbNm6+5nLK0KG57fnp33Zg+6sh2Eu
         xNEZTkGKM0Z29qOz96aAGxZ2LKVQZHt1G0fgSrwn8NlGQmDqwXNNyC2nOAxbzBal8H6H
         ywzq8iCKNXIxdDkbc7BZ+5NCOgRddI9YhpXlm8AbIhA80Rm+tBOclBlYShsjLlEOBsnd
         /c5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrsHfRq0WlnzPKjyGhf/zYAoQY3FxLik+S1EVFw+FAYlojnVc2P2ADEGArNucODCfsg1+CcGIirPY+mW060rwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2zdc6LrkQhbHfQSI6jr2p4Zqwq3EXrp+fhsWCsZSQgVyU4PgO
	R3EqUY1bCcJ9lnhOLD31/J/6glR53W3M9Mfy0rMEVFMcQZ4vQ1UstOh5E2gjEOgglJVNGIlYms0
	K2yzhC/of5nl4MobXHdRm7fvX9NMNT0fRGOHA
X-Gm-Gg: AfdE7cmJoGksH5mLX83m3ghSRd5yy9o4gtpVTOwa3fPePCSAdfb4WqM7EoOWoW2hXoT
	wQzDOCTm6OJEqVZW9gAToQS2tYvYpAhOdHHMoPNkQsWs6kQEJ7WFVYAO4m4MfYf8XaFm7pSpFxf
	BIynYGR/Qd6ZSbzqInXTYbQc4sCah7QDJ7Hci14sSP/FAq6LLeqhoMe4cwJKyHk6IxezDhfl7z/
	KKLnUEqwM1ErUcIPpyZ/d6tze04rRAG82kbuBygG3wcy8nE7lJcJ01R5r7Qu2dn4Kqj2SHDubD8
	D8ZUDVPVBi6ZjHHPldHJ6G3ZUffrmqUSNDzq89bHVz6n4NM+
X-Received: by 2002:a05:690c:e3cd:b0:81e:89b2:93db with SMTP id
 00721157ae682-81ef22d43c5mr10352427b3.15.1784303428831; Fri, 17 Jul 2026
 08:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060024.570535-1-zzzccc427@gmail.com> <CAFRLqsVdaKE63gAKVuAjv++CM1z8hX1hYh6N3BxHkVaoyKnKVw@mail.gmail.com>
In-Reply-To: <CAFRLqsVdaKE63gAKVuAjv++CM1z8hX1hYh6N3BxHkVaoyKnKVw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 11:50:16 -0400
X-Gm-Features: AUfX_myg_vVGdSTO2roBDTOJ5PnSRdOaE466RNDUIhofs7qK-XmcxQUQVOdEsb0
Message-ID: <CABBYNZKQKpt9gdJUYb6YS_6ryGZLjrofO0OEpu4jsvmA7f00uw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: dequeue queued mesh send before freeing
 canceled tx
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Fri, Jul 17, 2026 at 11:46=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wr=
ote:
>
> Hi Marcel, Luiz,
>
> Gentle ping on this patch.
>
> Could you please take a look when you have a chance?

If you really want to bump it just resend it. Sending pings like this
won't retrigger the CI to pick it up and test it.

> Thanks!
>
> Best regards,
> Cen Zhang
>
> Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=94 14:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > mesh_next() queues mesh_send_sync() with a raw mgmt_mesh_tx pointer aft=
er
> > a previous mesh send completes. MGMT_OP_MESH_SEND_CANCEL can already be
> > queued on the same hci_cmd_sync_work list. If cancel runs before the qu=
eued
> > send, it can remove and free the same mgmt_mesh_tx while mesh_send_sync=
()
> > still carries that pointer as callback data.
> >
> > The buggy scenario involves two paths, with each column showing the ord=
er
> > within that path:
> >
> >   mesh completion path:              cancel command path:
> >   1. mesh_send_done_sync() returns   1. send_cancel is already queued
> >   2. mesh_next() selects next_tx     2. send_cancel finds next_tx
> >   3. mesh_next() queues              3. send_cancel frees next_tx
> >      mesh_send_sync(next_tx)
> >   4. mesh_send_sync() later
> >      dereferences next_tx
> >
> > Validation reproduced this kernel report:
> > BUG: KASAN: slab-use-after-free in mesh_send_sync+0x5a/0x1c0 [bluetooth=
]
> > Read of size 1 at addr ffff88811a01d13b by task kworker/u17:0/562
> > Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> >
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x66/0xa0
> >  print_report+0xce/0x5f0
> >  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
> >  ? __virt_addr_valid+0x19f/0x330
> >  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
> >  kasan_report+0xe0/0x110
> >  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
> >  ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
> >  mesh_send_sync+0x5a/0x1c0 [bluetooth]
> >  ? mesh_send_sync+0x9/0x1c0 [bluetooth]
> >  ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
> >  hci_cmd_sync_work+0x187/0x210 [bluetooth]
> >  process_one_work+0x4fd/0xbc0
> >  worker_thread+0x2d8/0x570
> >  kthread+0x1ad/0x1f0
> >  ret_from_fork+0x3c9/0x540
> >  ret_from_fork_asm+0x1a/0x30
> >
> > Allocated by task 602:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x17/0x60
> >  __kasan_kmalloc+0xaa/0xb0
> >  mgmt_mesh_add+0x41/0x1a0 [bluetooth]
> >  mesh_send+0x197/0x3a0 [bluetooth]
> >  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
> >  __sys_sendto+0x2bc/0x2d0
> >  __x64_sys_sendto+0x76/0x90
> >  do_syscall_64+0x115/0x6a0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 562:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x17/0x60
> >  kasan_save_free_info+0x3b/0x60
> >  __kasan_slab_free+0x5f/0x80
> >  kfree+0x313/0x590
> >  send_cancel+0x1d8/0x210 [bluetooth]
> >  hci_cmd_sync_work+0x187/0x210 [bluetooth]
> >  process_one_work+0x4fd/0xbc0
> >  worker_thread+0x2d8/0x570
> >  kthread+0x1ad/0x1f0
> >  ret_from_fork+0x3c9/0x540
> >  ret_from_fork_asm+0x1a/0x30
> >
> > Dequeue any queued mesh_send_sync() for the target tx from send_cancel(=
).
> > When a queued send is found, the dequeue path invokes
> > mesh_send_start_complete(), which completes and frees the tx; send_canc=
el()
> > must not complete it again.
> >
> > Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> >  net/bluetooth/mgmt.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 733a4b70e10c..ac4922cb39b5 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -2416,17 +2416,28 @@ static int send_cancel(struct hci_dev *hdev, vo=
id *data)
> >         struct mgmt_mesh_tx *mesh_tx;
> >
> >         if (!cancel->handle) {
> > -               do {
> > +               for (;;) {
> >                         mesh_tx =3D mgmt_mesh_next(hdev, cmd->sk);
> >
> > -                       if (mesh_tx)
> > -                               mesh_send_complete(hdev, mesh_tx, false=
);
> > -               } while (mesh_tx);
> > +                       if (!mesh_tx)
> > +                               break;
> > +
> > +                       /* Dequeue any queued send before freeing the t=
x. */
> > +                       if (hci_cmd_sync_dequeue(hdev, mesh_send_sync, =
mesh_tx,
> > +                                                mesh_send_start_comple=
te))
> > +                               continue;
> > +
> > +                       mesh_send_complete(hdev, mesh_tx, false);
> > +               }
> >         } else {
> >                 mesh_tx =3D mgmt_mesh_find(hdev, cancel->handle);
> >
> > -               if (mesh_tx && mesh_tx->sk =3D=3D cmd->sk)
> > -                       mesh_send_complete(hdev, mesh_tx, false);
> > +               if (mesh_tx && mesh_tx->sk =3D=3D cmd->sk) {
> > +                       /* Dequeue any queued send before freeing the t=
x. */
> > +                       if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,=
 mesh_tx,
> > +                                                 mesh_send_start_compl=
ete))
> > +                               mesh_send_complete(hdev, mesh_tx, false=
);
> > +               }
> >         }
> >
> >         mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
> > --
> > 2.43.0



--=20
Luiz Augusto von Dentz
