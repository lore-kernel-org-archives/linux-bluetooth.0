Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DA2A1BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953143; cv=none; b=aGbA8RmA5Vs6jdGhUTqS4G1nCgxJ4n6SjB5ZDFjcdVVIRlwSVuF0ZDuCpPvJXX7HsHW6tydFRz2prftOKx5YN8gbF76QepjFt+GNi4Wft54esCCcq+PjeW3MjUupgGTEEOG0MfE+hyAv0ogYxHfTu0MPqgytYdcpB2m9k5EVsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953143; c=relaxed/simple;
	bh=AAUT5EYlVHXAD7p9N+Ar4Hdtx2Nt09/lh/a2WscHJE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbkQ2UsFNwFKr29ftfg30Vs+Al/DUaHR7pR5yjlmyMkza8T3kNhRS7nfmc54fZHJNbUjD+quhJvGXKH7apfgUZbVG9HDsE9HcEECzfmki8yHrGRLSSUmr31EVMhicFHqOLUz+odsNif7zx9lwgitRm638fNIm66rICq9UrOXNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSmcjHyM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSmcjHyM"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33730e1cda7so42068591fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757953139; x=1758557939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhDaadvtXy5p2LyC8jwX2nHIpwG3lCqez/78N2RcOfU=;
        b=eSmcjHyMP1JvNR+TEs9GxoLuKEE++Z7bZ5gLlGs0IoRwYcUmkcjsWl39urm9OMgEfF
         qHGh8XLZyffD7F3IBazdIHEANvt9GmzKrsrqyGzVuzjW7k8N7qdjobmAmoD4Xz8d+nPo
         HgJqu+w1AsNPnU8WDzKEZcbby3rV2Q5f3n0mPupNbpOV4J7AcO3i3VtPUDcrmvnFc26Q
         UqguBTyky2YIdk4Q2FSGVd0txIKGk6bAd1HK1G37xXKnx89+GNdCFgRMY+1YCzl2mxju
         KTDu8vACORymB7Ipj/Uuc2JahGqyxR55LFLhgC9JiIlTN+kdCo7OojecCr3uDfJixIHy
         tJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953139; x=1758557939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhDaadvtXy5p2LyC8jwX2nHIpwG3lCqez/78N2RcOfU=;
        b=Gv3gyfIPChRpFrdxdxrCKIGdWMfpCOjEJ54Sbv8U9R1KEgx3Nb+Fdwox+pdFctGlw0
         HnfwOHw/n73iVe1NV82eWWaMJRQwUKx+Sr+yJsi6GpXo7RqwJYtI/9gU8zKw+w8VrU2u
         M3cahqxNNtHCCgoAPtsXNvvkzIvS5LXBoNfUTD6hm0J05MSXBuHIR/P81cR2L+/ZbAuT
         nipsPnAQen68wMC2GlBSBz54KxjCPg4jelKUzUAbjt1DqJr1KgNXgX+DVHNsRzVrEeTr
         x+yaQ9eYDoUphfc1FLa7B0crQ50fBV2EiuV3TyHPNAtqYRESyKxod5pLyJzsL9yWjlXD
         7pZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNOUE19T8ck7DmXxnpsiZHecfJn07JMs7VQVu13RCnApHQVOD1da/yZTD8d6irFe1QCJyV9pcnSvbmaSZWN7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrLUv1Xok+nqBhHsfwIQrETBpXBqOkk9vbk7aoeUo0wuqmhYe
	ptPYDfkw7pGyK0vEpPR4ZCBbMqm+xoZkloLdZOPMljPYGtEh0alV9S1EVIul5pHlGLJX8VQyQj+
	+dwFsvBhkI63eEM+92zLN+c8Samlw4ZQ=
X-Gm-Gg: ASbGnctoDCmTOOeRmTWrIXA3htoO+rj9ql6/iY2RPx4MgT/Kgk1vU4WmnMdspHiQyto
	fj5bxFL4bikv5S40gvjSFK6gM0CT+ui08k/nmV4gKz5W1UnJdVoJBiC8rtEL3ZL6ulYFKzS/oCT
	KoGtKBTnrHEUt+haQu2/t/UD8dkvDY4Tnv2UvNaTUb6eCiDNu0g8XQ7KDhu6b9UVpxtr5lFo82j
	bzvSA==
X-Google-Smtp-Source: AGHT+IEntEXv+YH80/nPztjtm5B5JrkFf6j3fN24OzTErPfkatgJv2nw43kziMa+SkUtCX91zJluE5qtC7gAlRCn0Ok=
X-Received: by 2002:a05:651c:4384:10b0:337:ec9a:a516 with SMTP id
 38308e7fff4ca-3513a1399e1mr30851241fa.13.1757953138618; Mon, 15 Sep 2025
 09:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
 <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
 <CAFRLqsUE84wW0JKbsh6Lw0USQbnCbokXd3PANc+4i_nsnEUMYA@mail.gmail.com>
 <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com>
 <CAFRLqsVj28niHO9XejYrMu2g3fCrDXXgArshP-kr4CM=eV2smQ@mail.gmail.com>
 <CAFRLqsV4m5GNr9fHsSneJkxG=crm5R75rJJJO4w5yQUd324znA@mail.gmail.com>
 <CABBYNZJBy-9ZP1DxihFxH6GOjSkbNRasjnThnVg+SJ6uPYLOHQ@mail.gmail.com>
 <CAFRLqsWE4W5=NSCWEwT25UYyXjFq8trk4X5YjcgL0qSjxLibjg@mail.gmail.com> <CABBYNZLFeeqMpWi4r5Dqh3UyG4r56VatcUMvZ4MRw=K0LOs8xw@mail.gmail.com>
In-Reply-To: <CABBYNZLFeeqMpWi4r5Dqh3UyG4r56VatcUMvZ4MRw=K0LOs8xw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Sep 2025 12:18:45 -0400
X-Gm-Features: AS18NWCnQa4WvBg-93sSK9z8nE5TCUiNiOGThA9K9vkNlSYg9NP1M44qXZwUaLg
Message-ID: <CABBYNZJ4zvkqFY8QjO+7_vJS-LGfqRyzQtRzcgOAToNUo0onFA@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Cen Zhang <zzzccc427@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Mon, Sep 15, 2025 at 12:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Cen,
>
> On Mon, Sep 15, 2025 at 11:40=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> =
wrote:
> >
> > Hi Luiz,
> >
> > Thank you for the nice patch. I've been testing your patch for some
> > time now, and it appears to have successfully resolved the original
> > issue.
> >
> > However, during my extended testing, I discovered two similar bugs
> > that might be worth fixing together. Here's the detailed report:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in set_le_sync+0x86/0x810
> > net/bluetooth/mgmt.c:2096
> > Read of size 8 at addr ffff888147503220 by task kworker/u17:6/352
> >
> > CPU: 3 UID: 0 PID: 352 Comm: kworker/u17:6 Not tainted
> > 6.17.0-rc5-ge5bbb70171d1-dirty #15 PREEMPT(voluntary)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> >  set_le_sync+0x86/0x810 net/bluetooth/mgmt.c:2096
>
> Looks like we are still accessing things like cmd->param before
> checking if that is still valid.

Hit send too soon, here is the v6 that attempts to clean up the
existing access of cmd before checking that it is still valid.

> >  hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
> >  process_one_work kernel/workqueue.c:3236 [inline]
> >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> >  kthread+0x3d4/0x800 kernel/kthread.c:463
> >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 193:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> >  kmalloc_noprof include/linux/slab.h:905 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> >  set_le+0xd73/0x15f0 net/bluetooth/mgmt.c:2547
> >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> >  sock_sendmsg_nosec net/socket.c:714 [inline]
> >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> >  do_iter_readv_writev+0x598/0x760
> >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> >  do_writev+0x105/0x270 fs/read_write.c:1103
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 6434:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:243 [inline]
> >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2428 [inline]
> >  slab_free mm/slub.c:4701 [inline]
> >  kfree+0x189/0x390 mm/slub.c:4900
> >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> >  __mgmt_power_off+0x19e/0x3e0 net/bluetooth/mgmt.c:9479
> >  hci_dev_close_sync+0x1064/0x2c10 net/bluetooth/hci_sync.c:5290
> >  hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
> >  hci_dev_close+0x232/0x460 net/bluetooth/hci_core.c:526
> >  hci_sock_ioctl+0x785/0x1000 net/bluetooth/hci_sock.c:1135
> >  sock_do_ioctl+0x7f/0x2e0 net/socket.c:1238
> >  sock_ioctl+0x521/0x6a0 net/socket.c:1359
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff888147503200
> >  which belongs to the cache kmalloc-96 of size 96
> > The buggy address is located 32 bytes inside of
> >  freed 96-byte region [ffff888147503200, ffff888147503260)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in set_name_complete+0x8e/0x790
> > net/bluetooth/mgmt.c:3890
> > Read of size 8 at addr ffff888145c595a0 by task kworker/u17:3/364
> >
> > CPU: 0 UID: 0 PID: 364 Comm: kworker/u17:3 Not tainted
> > 6.17.0-rc5-ge5bbb70171d1-dirty #15 PREEMPT(voluntary)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> >  set_name_complete+0x8e/0x790 net/bluetooth/mgmt.c:3890
> >  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
> >  process_one_work kernel/workqueue.c:3236 [inline]
> >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> >  kthread+0x3d4/0x800 kernel/kthread.c:463
> >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 191:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> >  kmalloc_noprof include/linux/slab.h:905 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> >  set_local_name+0x390/0x910 net/bluetooth/mgmt.c:3975
> >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> >  sock_sendmsg_nosec net/socket.c:714 [inline]
> >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> >  do_iter_readv_writev+0x598/0x760
> >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> >  do_writev+0x105/0x270 fs/read_write.c:1103
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 23433:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:243 [inline]
> >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2428 [inline]
> >  slab_free mm/slub.c:4701 [inline]
> >  kfree+0x189/0x390 mm/slub.c:4900
> >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> >  __mgmt_power_off+0x19e/0x3e0 net/bluetooth/mgmt.c:9479
> >  hci_dev_close_sync+0x1064/0x2c10 net/bluetooth/hci_sync.c:5290
> >  hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
> >  hci_dev_close+0x232/0x460 net/bluetooth/hci_core.c:526
> >  hci_sock_ioctl+0x785/0x1000 net/bluetooth/hci_sock.c:1135
> >  sock_do_ioctl+0x7f/0x2e0 net/socket.c:1238
> >  sock_ioctl+0x521/0x6a0 net/socket.c:1359
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff888145c59580
> >  which belongs to the cache kmalloc-96 of size 96
> > The buggy address is located 32 bytes inside of
> >  freed 96-byte region [ffff888145c59580, ffff888145c595e0)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14=
5c59
> > flags: 0x200000000000000(node=3D0|zone=3D2)
> > page_type: f5(slab)
> > raw: 0200000000000000 ffff888100042280 ffffea0004579a00 dead00000000000=
2
> > raw: 0000000000000000 0000000000200020 00000000f5000000 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff888145c59480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >  ffff888145c59500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >ffff888145c59580: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >                                ^
> >  ffff888145c59600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >  ffff888145c59680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > Best regards,
> > Cen Zhang
> >
> > Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 20:59=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Cen,
> > >
> > > On Fri, Sep 12, 2025 at 11:01=E2=80=AFPM cen zhang <zzzccc427@gmail.c=
om> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > I've just started testing the patch, and it seems to have introduce=
d a
> > > > new issue. I've attached the detailed report below:
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-use-after-free in mgmt_pending_valid+0x8f/0x7e0
> > > > net/bluetooth/mgmt_util.c:330
> > > > Read of size 8 at addr ffff888140eae198 by task kworker/u17:2/82
> > > >
> > > > CPU: 1 UID: 0 PID: 82 Comm: kworker/u17:2 Not tainted
> > > > 6.17.0-rc5-ge5bbb70171d1-dirty #8 PREEMPT(voluntary)
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-=
1 04/01/2014
> > > > Workqueue: hci0 hci_cmd_sync_work
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> > > >  print_address_description mm/kasan/report.c:378 [inline]
> > > >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> > > >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> > > >  mgmt_pending_valid+0x8f/0x7e0 net/bluetooth/mgmt_util.c:330
> > >
> > > Looks like this is the result of trying to access the cmd->hdev, whic=
h
> > > is definitely wrong since the whole point of the function is to try t=
o
> > > determine if cmd is still valid, so please try with the v5.
> > >
> > > >  mgmt_set_powered_complete+0x81/0xf20 net/bluetooth/mgmt.c:1326
> > > >  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
> > > >  process_one_work kernel/workqueue.c:3236 [inline]
> > > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > >  </TASK>
> > > >
> > > > Allocated by task 195:
> > > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > > >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> > > >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> > > >  kmalloc_noprof include/linux/slab.h:905 [inline]
> > > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > > >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> > > >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> > > >  set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1406
> > > >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> > > >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> > > >  sock_sendmsg_nosec net/socket.c:714 [inline]
> > > >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> > > >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> > > >  do_iter_readv_writev+0x598/0x760
> > > >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> > > >  do_writev+0x105/0x270 fs/read_write.c:1103
> > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > Freed by task 82:
> > > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> > > >  poison_slab_object mm/kasan/common.c:243 [inline]
> > > >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> > > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > > >  slab_free_hook mm/slub.c:2428 [inline]
> > > >  slab_free mm/slub.c:4701 [inline]
> > > >  kfree+0x189/0x390 mm/slub.c:4900
> > > >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> > > >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> > > >  mgmt_power_on+0x43d/0x5e0 net/bluetooth/mgmt.c:9448
> > > >  hci_dev_open_sync+0x44fa/0x5060 net/bluetooth/hci_sync.c:5137
> > > >  hci_power_on_sync net/bluetooth/hci_sync.c:5376 [inline]
> > > >  hci_set_powered_sync+0x43e/0xfa0 net/bluetooth/hci_sync.c:5768
> > > >  set_powered_sync+0x1e0/0x2c0 net/bluetooth/mgmt.c:1369
> > > >  hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
> > > >  process_one_work kernel/workqueue.c:3236 [inline]
> > > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > >
> > > > The buggy address belongs to the object at ffff888140eae180
> > > >  which belongs to the cache kmalloc-96 of size 96
> > > > The buggy address is located 24 bytes inside of
> > > >  freed 96-byte region [ffff888140eae180, ffff888140eae1e0)
> > > >
> > > > The buggy address belongs to the physical page:
> > > > page: refcount:0 mapcount:0 mapping:0000000000000000
> > > > index:0xffff888140eae200 pfn:0x140eae
> > > > flags: 0x200000000000200(workingset|node=3D0|zone=3D2)
> > > > page_type: f5(slab)
> > > > raw: 0200000000000200 ffff888100042280 ffffea0004763ad0 ffffea00047=
63a90
> > > > raw: ffff888140eae200 000000000020001f 00000000f5000000 00000000000=
00000
> > > > page dumped because: kasan: bad access detected
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff888140eae080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > >  ffff888140eae100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > >ffff888140eae180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > >                             ^
> > > >  ffff888140eae200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > >  ffff888140eae280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Best regards,
> > > > Cen Zhang
> > > >
> > > > cen zhang <zzzccc427@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=85=AD 10:16=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > Thanks for your patch! It not only addresses the TOCTOU issue we
> > > > > discussed but may also fix another bug I reported
> > > > > (https://lore.kernel.org/linux-bluetooth/CAFRLqsWWMnrZ6y8MUMUSK=
=3DtmAb3r8_jfSwqforOoR8_-=3DXgX7g@mail.gmail.com/T/#u).
> > > > >
> > > > > I will test it soon to confirm.
> > > > >
> > > > > Thanks again for the great work.
> > > > >
> > > > > Best regards,
> > > > >
> > > > > Cen Zhang
> > > > >
> > > > > Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=
=B49=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:29=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hi Cen,
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 11:59=E2=80=AFAM cen zhang <zzzccc427@g=
mail.com> wrote:
> > > > > > >
> > > > > > > Hi Luiz,
> > > > > > >
> > > > > > > Thank you for your quick response and the important clarifica=
tion
> > > > > > > about hci_cmd_sync_dequeue().
> > > > > > >
> > > > > > > You are absolutely correct - I was indeed referring to the TO=
CTOU
> > > > > > > problem in pending_find(), not the -ECANCELED check. The
> > > > > > > hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a crucia=
l detail
> > > > > > > that I initially overlooked in my analysis.
> > > > > > >
> > > > > > > After examining the code more carefully, I can see that while
> > > > > > > hci_cmd_sync_dequeue() does attempt to remove pending sync co=
mmands
> > > > > > > from the queue, but it cannot prevent the race condition we'r=
e seeing.
> > > > > > > The fundamental issue is that hci_cmd_sync_dequeue() can only=
 remove
> > > > > > > work items that are still queued, but cannot stop work items =
that are
> > > > > > > already executing or about to execute their completion callba=
cks.
> > > > > > >
> > > > > > > The race window occurs when:
> > > > > > > 1. mgmt_set_powered_complete() is about to execute (work item=
 has been dequeued)
> > > > > > > 2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_comp=
lete_rsp() executes
> > > > > > > 3. hci_cmd_sync_dequeue() removes queued items but cannot aff=
ect the
> > > > > > > already-running callback
> > > > > > > 4. mgmt_pending_free() frees the cmd object
> > > > > > > 5. mgmt_set_powered_complete() still executes and accesses fr=
eed cmd->param
> > > > > > >
> > > > > > > I am sorry that I haven't get a reliable reproducer from syzk=
aller for
> > > > > > > this bug may be due to it is timing-sensitive.
> > > > > >
> > > > > > Let's try to fix all instances then, since apparently there is =
more
> > > > > > than one cmd with this pattern, please test with the attached p=
atch.
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
