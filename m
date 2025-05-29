Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3F18DB03
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534967; cv=none; b=r1hNRFBGcDS+6W9n/u4IXFq2Ti56exPMBHsots7L5CLaH74bHZ62hVA6sM5xZx/gpiHQn+9xP7QYKImGGoUSCgIDMckgo19og0rXcfJGowHHR7QyNn7215c+K5RBQEPcHRi+cEbVs62vwgddXG43byxGi++XUPgJYfSzQoc4xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534967; c=relaxed/simple;
	bh=0zNjJI+C7g1JKU0wyT3NDjlXUrL2fk39nOu40/0uTUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btbWG3OuXf5TEbR4Hq8CTS+A65i8N8LLVi6p3Ta9nyYiB5D3PgR0ktOtcbzZox/dQgtphFCvwreXz5Be7/OriysAw+m205mHg7MWwaue568Ux7ju5F1AXQUgABHNRL/zMmf97tRiYHpGALjXDaZupsiKHP3hflN9ecbX2h3/dnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh+fZ0vF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh+fZ0vF"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32a5eb73ad4so9246621fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748534964; x=1749139764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opj1xOujMCvsIvEbCrpKa51hvfF5AeAgCb0DoFvMsUE=;
        b=Vh+fZ0vFhF/XQhUBRdR9ROEikmk900Xseq9R/LemPdqoRWNlFcv+Qlr74H1HzsU/Qh
         /fXutcK5U9roBUd2mTib1grKvzSsm1+l5oGpBmfDWp0U6zsHYkPHpPTgJ8ByyXTYxHI1
         I0w45qIcT3CYAItrzxX5hwKMeX21xtUhaxyBH4IXmw4CzuOLGp53k4GDVLZrTW3rCKID
         xDjJHYEjTNxZMKOQKNrWcmFz8JKCbkDQX4JhTAY6VH9cUV3jTAqFTho2/pt3SCUY10Kz
         Wq5lz17v48mVIYleHHRNfO98w8Pbe5ppqdPByjQHiUNqHtyKv4xhokOxpbNuYn2QjlkI
         dqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748534964; x=1749139764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opj1xOujMCvsIvEbCrpKa51hvfF5AeAgCb0DoFvMsUE=;
        b=egoa4UQ0Fpyum43NJ5tXZw6XM7+nxOxhjw2VdU/DGLISLgW/IfpJ3Oq3MbC7Qn0Y4z
         mhitIgZ4cwRdodjNeVfn/qvl+t3ixsk62/AJHXveguwda5ifeUOrliFjZ+r9r54XFOtg
         m7bFtTMvkuS/7UWLbufjX0w5am9LydKS9ET666Pk+6VvyvHlkM4K4N1eSykKFUMNdaQX
         H6TxgY2TXoxeK+u8v2T/Thpbc1kTaBqiRmt/u9W7oRP71h7pE6j09aDdUd3Th0ceKDDe
         IedZTXZoREh8y1pKWFEf3mYu4LiK0mw9ZPaNaSBqiDDYJxWjjJMSdLhpGSNm2e51POVO
         xoOQ==
X-Gm-Message-State: AOJu0YyfMr6Seam9ajqfIsKxS1g78/WjVmtH5VemCrAJQgbBhNDxi6RB
	IluJ0r/V3PP+NsWwVYloQQnZugyvS2ysw+yy4LmgXm2MedZgzWKVgmX8p727P3JOHdb0ZNsull0
	AOEMo5x0iJ0lAmUeJHqNS+6Esl2NMNGmKf5/EfiA=
X-Gm-Gg: ASbGncslgCSmz6qy3qSLCYnVzO5F4R6wcfqECwHUPHTXcYjujBIQwQJLYawhZkybdOD
	iWAk92iElaTUeQf4iyiHF6nfKB8T+evsatpCikCRsAYhXs1zZYNAoX+RL93OdAnnUsMeT9qUygh
	On7h8nS9E8sp6ItScSDtaQYceNK5pT1xc=
X-Google-Smtp-Source: AGHT+IG3K6PJ2g3maNYiyDbXXQm6E5i6ECIIoJmqVVDi71aKn6hUAP3Q4IvLCN7Np/e72U2PD7mOdywXWBDPEsY+l38=
X-Received: by 2002:a05:651c:542:b0:32a:6312:bfc2 with SMTP id
 38308e7fff4ca-32a8ce4198dmr1424091fa.38.1748534963305; Thu, 29 May 2025
 09:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528210718.100679-1-luiz.dentz@gmail.com> <8b0bd8c9380eba6a0b511212f5a187f663fab0d7.camel@iki.fi>
In-Reply-To: <8b0bd8c9380eba6a0b511212f5a187f663fab0d7.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 May 2025 12:09:09 -0400
X-Gm-Features: AX0GCFuK9AEaPs1fjDoIFMob2vavferwIzJFzH19c7Tx3YN-GUnwFp-OpnWgZCk
Message-ID: <CABBYNZ+9=907SahnRGOVh2_4eE1zyk97+Zz1pBZ-4pm0WstV=w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: Use RCU-protected in mgmt_pending list
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, May 29, 2025 at 10:21=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-05-28 kello 17:07 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This uses RCU procedures to protect from concurrent access of
> > mgmt_pending list which can cause crashes like:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe=
5/0x540 net/bluetooth/mgmt.c:5405
> > Read of size 8 at addr ffff888048891a18 by task kworker/u5:8/5333
> >
> > CPU: 0 UID: 0 PID: 5333 Comm: kworker/u5:8 Not tainted 6.15.0-rc5-syzka=
ller-00197-gea34704d6ad7 #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2~bpo12+1 04/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:408 [inline]
> >  print_report+0xb4/0x290 mm/kasan/report.c:521
> >  kasan_report+0x118/0x150 mm/kasan/report.c:634
> >  mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
> >  hci_cmd_sync_work+0x25e/0x3a0 net/bluetooth/hci_sync.c:334
> >  process_one_work kernel/workqueue.c:3238 [inline]
> >  process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
> >  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
> >  kthread+0x70e/0x8a0 kernel/kthread.c:464
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 5702:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
> >  kasan_kmalloc include/linux/kasan.h:260 [inline]
> >  __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
> >  kmalloc_noprof include/linux/slab.h:905 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  mgmt_pending_new+0x65/0x240 net/bluetooth/mgmt_util.c:252
> >  mgmt_pending_add+0x34/0x120 net/bluetooth/mgmt_util.c:279
> >  remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5453
> >  hci_mgmt_cmd+0x9c6/0xef0 net/bluetooth/hci_sock.c:1712
> >  hci_sock_sendmsg+0x6ca/0xee0 net/bluetooth/hci_sock.c:1832
> >  sock_sendmsg_nosec net/socket.c:712 [inline]
> >  __sock_sendmsg+0x219/0x270 net/socket.c:727
> >  sock_write_iter+0x258/0x330 net/socket.c:1131
> >  new_sync_write fs/read_write.c:591 [inline]
> >  vfs_write+0x548/0xa90 fs/read_write.c:684
> >  ksys_write+0x145/0x250 fs/read_write.c:736
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 5700:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2380 [inline]
> >  slab_free mm/slub.c:4642 [inline]
> >  kfree+0x193/0x440 mm/slub.c:4841
> >  mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
> >  mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9362
> >  hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1307
> >  __sys_bind_socket net/socket.c:1810 [inline]
> >  __sys_bind+0x2c3/0x3e0 net/socket.c:1841
> >  __do_sys_bind net/socket.c:1846 [inline]
> >  __se_sys_bind net/socket.c:1844 [inline]
> >  __x64_sys_bind+0x7a/0x90 net/socket.c:1844
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Fixes: a380b6cff1a2 ("Bluetooth: Add generic mgmt helper API")
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dfeb0dc579bbe30a13190
> > Closes: https://syzkaller.appspot.com/bug?extid=3D0a7039d5d9986ff4ececi
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dcc0cc52e7f43dc9e6df1
> > Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
> > Tested-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
> > Tested-by: syzbot+0a7039d5d9986ff4ecec@syzkaller.appspotmail.com
> > Tested-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/mgmt_util.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> > index 3713ff490c65..c2dc8ddf5f78 100644
> > --- a/net/bluetooth/mgmt_util.c
> > +++ b/net/bluetooth/mgmt_util.c
> > @@ -219,13 +219,20 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsign=
ed short channel, u16 opcode,
> >  {
> >       struct mgmt_pending_cmd *cmd;
> >
> > -     list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> > +     rcu_read_lock();
> > +
> > +     list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
> >               if (hci_sock_get_channel(cmd->sk) !=3D channel)
> >                       continue;
> > -             if (cmd->opcode =3D=3D opcode)
> > +
> > +             if (cmd->opcode =3D=3D opcode) {
> > +                     rcu_read_unlock();
> >                       return cmd;
>
> RCU does not guarantee the returned pointer is not already freed when
> this returns. AFAIK this is exactly the "BUG!!!" mentioned in
> https://docs.kernel.org/RCU/whatisRCU.html#rcu-dereference
>
> Instead of calling rcu_read_lock/unlock here, maybe instead
>
>         list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list,
>                                 lockdep_is_held(&hdev->lock))
>
> to force caller to either hold rcu_read_lock() or hdev->lock to protect
> the return value for the time it needs it.

This is not so different then the current design though, perhaps we
should refcount the entries so the likes of mgmt_pending_find returns
a new reference using a kref.

> > +             }
> >       }
> >
> > +     rcu_read_unlock();
> > +
> >       return NULL;
> >  }
> >
> > @@ -233,14 +240,11 @@ void mgmt_pending_foreach(u16 opcode, struct hci_=
dev *hdev,
> >                         void (*cb)(struct mgmt_pending_cmd *cmd, void *=
data),
> >                         void *data)
> >  {
> > -     struct mgmt_pending_cmd *cmd, *tmp;
> > -
> > -     list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
> > -             if (opcode > 0 && cmd->opcode !=3D opcode)
> > -                     continue;
> > +     struct mgmt_pending_cmd *cmd;
> >
> > +     cmd =3D mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
> > +     if (cmd)
> >               cb(cmd, data);
>
> Hence, this is potential UAF, so caller probably shall hold locks as
> above.
>
> With the change in list_for_each_entry_rcu(), you'd then get lockdep
> splats if caller doesn't hold right locks.
>
> E.g. the UAF in
>
>         struct mgmt_pending_cmd *cmd =3D data;
>         if (cmd !=3D pending_find(MGMT_OP_SET_POWERED, hdev))
>                 return -ECANCELED;
>
>         hci_dev_lock(hdev);
>         /* operate on cmd */
>         hci_dev_unlock(hdev);
>
> should be found directly by the assert.
>
> Note that such pattern of checking if a pointer in the "data" of a
> delayed callback corresponds to an "alive" object in principle also has
> ABA problem (mgmt_pending_free(cmd) + mgmt_pending_add() allocating at
> same address -> operates on wrong item). Also hci_conn_valid() has this
> issue.

These are normally run at the callback of cmd_sync and triggered with
a MGMT command, so I very much doubt you can create a scenario where
the same MGMT command, yes it needs to be the same opcode at least so
pending_find will need to return a pointer, can be scheduled,
cancelled and then rescheduled with the very same pointer, anyway even
if that in theory is possible them we quite possible have a problem
with cmd_sync work carrying a pointer that has been freed.

> > -     }
> >  }
> >
> >  struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
> > @@ -280,7 +284,7 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct so=
ck *sk, u16 opcode,
> >       if (!cmd)
> >               return NULL;
> >
> > -     list_add_tail(&cmd->list, &hdev->mgmt_pending);
> > +     list_add_tail_rcu(&cmd->list, &hdev->mgmt_pending);
> >
> >       return cmd;
> >  }
> > @@ -294,7 +298,8 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd=
)
> >
> >  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
> >  {
> > -     list_del(&cmd->list);
> > +     list_del_rcu(&cmd->list);
> > +     synchronize_rcu();
>
> Maybe it would be useful to add lockdep_assert_held(&hdev->lock) here
> and in mgmt_pending_add() to make sure callers hold right lock?
>
> These compile to nothing with !CONFIG_LOCKDEP so IIUC could be used
> more.

Or we just introduce a mgmt_lock, since it appears we will need a lock anyw=
ay.

> >       mgmt_pending_free(cmd);
> >  }
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
