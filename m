Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E82230BD9
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953340; cv=none; b=TZDbWgDXIKDCRYUxwZfurmNsDw/26rxfYKGVClFUY70FTe5KMA557C91TcW19tq5FOGBHZC4NBsqmpSFkpxbmTJIrV0AoC+sdp0bhNB0q2s407AC2woydqbsG3nM9nUuWhAihTs6zzMgDBoDRL1t+bW9l1V74uj4g0W3xdZkkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953340; c=relaxed/simple;
	bh=KW7uIfWH+bSwhzKD9HTI4iScnOuD3onY1es6PI2nPvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rd9EyzHwcGZ0KMcNLQ6Jz4Yr6vk+v2rUgfSUWaSRMwLhrLyOybzCLAtk79J/q4fgBxNZwVvi/bRKsoygQNnISCs3x+SjBt23If/ih6PC/2gSInLHGi9RkVG4R5OMgbGaBYqYd2fckgZ3fAb1P3X2uT9DRc24OxxSgqyrLymmwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDN4fffd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDN4fffd"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3517d7954deso28791831fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757953333; x=1758558133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0z66q9+ak7pP/1fjtVOVgz35+m3Mqm8VYysiJsj1rY=;
        b=YDN4fffd8OT/DiTqGl2g8d9lQ7EXzWpNPQkNoAbKlq0Na6KdWiC16uAjDQizU/HsTt
         jcHgt1NNhe0+0ZzLoNicCK7Lrrx1vNeD0b+mPBLbtm8sq/S+5A7y73bY7JjvZBGLNKas
         aDn7yo1ukb74wrHZGCCaCFM8m/Oc2DhZC/LqlmQkQA4SEhJrKw/Qxh7345MxXa2gj7IL
         EMKCjAQp4VRnAC79gvn+EqQK2HZUfAb8KAKzGLtgrah8Y1Yz998EsJCbOXBcVJqhRKt0
         FO5kMvOxgbNV1Q3czQ6Y5zsC/8bm9dc2U8SA1OPZwOk7ev71UhNyP3XE4t/9pERTMX34
         h+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953333; x=1758558133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0z66q9+ak7pP/1fjtVOVgz35+m3Mqm8VYysiJsj1rY=;
        b=ZoqGOt5vaimHY509kruKdsU5UeuyTn+rli3EB6wqcqCGw3avZQpE/cnZFoz2B2M4h7
         TA0WXRSAcHSS8eXMG4SiBecptXBg++jPLPMf3OGag28os51tOPgRFvWQ/EUz94mjFxdv
         XDAn/Ekp+NythWYOiqRHth4JlPJJFi7SfpvIGXbRgO69F4Yu+W882o+JOtli4ZcaLZne
         VffE6rSbUMp1D2L55g7SFnR9j6bmZXXE2/RhTx7CWAwJ+4TlCf8sMTCKiGp8IjZt+48S
         C6GgHFclwhiSfNo78U/a6ylzVSDAlZK6wKoMwnGGLqonpzCriInfRXDMNfMQeJfgu/H6
         V9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWodw12DPi4JTZSi+7mJVSVXzcjM06nj51Z9LNcd9Dax60l/jZeipCv55XZHWebXw6ed9yUg9gwJ8AamoyHAUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jQ3aoxVQSvZ51KSD18vbfRWBz//uXQ0dELXW9jepQyWeQZLQ
	82YAieAJOALJci2BT2WhXf7S8aCtYgR3x0ugS5nFOhf4SERimrOudwrLi3W3HOMzMi5dSldzooS
	nDIhhgcrAw08MbrtmJ2g0J20/KCHXpIM=
X-Gm-Gg: ASbGncusMawIBFJycp1uWqyrUbyBGzs8y4TIJmURJLa7iBEQPU0qY7x45yGRISlEM7Z
	mkzfAbHctqblcXwZFoIZ5er6jRBWIdwc9eLH5mzPEOhmdVgv5mPtthmEdj5Qcp4rfYYxwadzVi7
	uhfRqWjxx7ANy0FG9SZFPNOCzxAoW0AagkIDX6ESgiX3DGNbNeRhDHoz/lfC5bmVeXI40T2bp4o
	kB2C/44SLbe35nc
X-Google-Smtp-Source: AGHT+IEX+XGz3gHTqWg/uplMuVtlNgbwhpsw96pRgTDN5S3F/VGmllEqvgfTVGNG2a+mX1MXUAQKizGH9AVXQE2Bo+I=
X-Received: by 2002:a2e:b890:0:b0:352:fe85:b70b with SMTP id
 38308e7fff4ca-352fe85bd4cmr35429501fa.1.1757953332891; Mon, 15 Sep 2025
 09:22:12 -0700 (PDT)
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
 <CAFRLqsWE4W5=NSCWEwT25UYyXjFq8trk4X5YjcgL0qSjxLibjg@mail.gmail.com>
 <CABBYNZLFeeqMpWi4r5Dqh3UyG4r56VatcUMvZ4MRw=K0LOs8xw@mail.gmail.com> <CABBYNZJ4zvkqFY8QjO+7_vJS-LGfqRyzQtRzcgOAToNUo0onFA@mail.gmail.com>
In-Reply-To: <CABBYNZJ4zvkqFY8QjO+7_vJS-LGfqRyzQtRzcgOAToNUo0onFA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Sep 2025 12:21:59 -0400
X-Gm-Features: AS18NWAeSJ5ev_FhJvxno9Tt0uwemck9btPR0EhFyEDqE1t0ptnzeQ5eeedeOD0
Message-ID: <CABBYNZ+fLP_zdh_qL4-LaZFAu6o6k5efz0GgQ2_tZCcD7XeE0A@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Cen Zhang <zzzccc427@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f09a48063ed967b3"

--000000000000f09a48063ed967b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Mon, Sep 15, 2025 at 12:18=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Cen,
>
> On Mon, Sep 15, 2025 at 12:16=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Cen,
> >
> > On Mon, Sep 15, 2025 at 11:40=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com=
> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thank you for the nice patch. I've been testing your patch for some
> > > time now, and it appears to have successfully resolved the original
> > > issue.
> > >
> > > However, during my extended testing, I discovered two similar bugs
> > > that might be worth fixing together. Here's the detailed report:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in set_le_sync+0x86/0x810
> > > net/bluetooth/mgmt.c:2096
> > > Read of size 8 at addr ffff888147503220 by task kworker/u17:6/352
> > >
> > > CPU: 3 UID: 0 PID: 352 Comm: kworker/u17:6 Not tainted
> > > 6.17.0-rc5-ge5bbb70171d1-dirty #15 PREEMPT(voluntary)
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > > Workqueue: hci0 hci_cmd_sync_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:378 [inline]
> > >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> > >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> > >  set_le_sync+0x86/0x810 net/bluetooth/mgmt.c:2096
> >
> > Looks like we are still accessing things like cmd->param before
> > checking if that is still valid.
>
> Hit send too soon, here is the v6 that attempts to clean up the
> existing access of cmd before checking that it is still valid.

And I forgot the attach the patches, here we go again.

> > >  hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
> > >  process_one_work kernel/workqueue.c:3236 [inline]
> > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > >
> > > Allocated by task 193:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> > >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> > >  kmalloc_noprof include/linux/slab.h:905 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> > >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> > >  set_le+0xd73/0x15f0 net/bluetooth/mgmt.c:2547
> > >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> > >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> > >  sock_sendmsg_nosec net/socket.c:714 [inline]
> > >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> > >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> > >  do_iter_readv_writev+0x598/0x760
> > >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> > >  do_writev+0x105/0x270 fs/read_write.c:1103
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Freed by task 6434:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> > >  poison_slab_object mm/kasan/common.c:243 [inline]
> > >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > >  slab_free_hook mm/slub.c:2428 [inline]
> > >  slab_free mm/slub.c:4701 [inline]
> > >  kfree+0x189/0x390 mm/slub.c:4900
> > >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> > >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> > >  __mgmt_power_off+0x19e/0x3e0 net/bluetooth/mgmt.c:9479
> > >  hci_dev_close_sync+0x1064/0x2c10 net/bluetooth/hci_sync.c:5290
> > >  hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
> > >  hci_dev_close+0x232/0x460 net/bluetooth/hci_core.c:526
> > >  hci_sock_ioctl+0x785/0x1000 net/bluetooth/hci_sock.c:1135
> > >  sock_do_ioctl+0x7f/0x2e0 net/socket.c:1238
> > >  sock_ioctl+0x521/0x6a0 net/socket.c:1359
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > The buggy address belongs to the object at ffff888147503200
> > >  which belongs to the cache kmalloc-96 of size 96
> > > The buggy address is located 32 bytes inside of
> > >  freed 96-byte region [ffff888147503200, ffff888147503260)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in set_name_complete+0x8e/0x790
> > > net/bluetooth/mgmt.c:3890
> > > Read of size 8 at addr ffff888145c595a0 by task kworker/u17:3/364
> > >
> > > CPU: 0 UID: 0 PID: 364 Comm: kworker/u17:3 Not tainted
> > > 6.17.0-rc5-ge5bbb70171d1-dirty #15 PREEMPT(voluntary)
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> > > Workqueue: hci0 hci_cmd_sync_work
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> > >  print_address_description mm/kasan/report.c:378 [inline]
> > >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> > >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> > >  set_name_complete+0x8e/0x790 net/bluetooth/mgmt.c:3890
> > >  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
> > >  process_one_work kernel/workqueue.c:3236 [inline]
> > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > >  </TASK>
> > >
> > > Allocated by task 191:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> > >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> > >  kmalloc_noprof include/linux/slab.h:905 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> > >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> > >  set_local_name+0x390/0x910 net/bluetooth/mgmt.c:3975
> > >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> > >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> > >  sock_sendmsg_nosec net/socket.c:714 [inline]
> > >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> > >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> > >  do_iter_readv_writev+0x598/0x760
> > >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> > >  do_writev+0x105/0x270 fs/read_write.c:1103
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Freed by task 23433:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> > >  poison_slab_object mm/kasan/common.c:243 [inline]
> > >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > >  slab_free_hook mm/slub.c:2428 [inline]
> > >  slab_free mm/slub.c:4701 [inline]
> > >  kfree+0x189/0x390 mm/slub.c:4900
> > >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> > >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> > >  __mgmt_power_off+0x19e/0x3e0 net/bluetooth/mgmt.c:9479
> > >  hci_dev_close_sync+0x1064/0x2c10 net/bluetooth/hci_sync.c:5290
> > >  hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
> > >  hci_dev_close+0x232/0x460 net/bluetooth/hci_core.c:526
> > >  hci_sock_ioctl+0x785/0x1000 net/bluetooth/hci_sock.c:1135
> > >  sock_do_ioctl+0x7f/0x2e0 net/socket.c:1238
> > >  sock_ioctl+0x521/0x6a0 net/socket.c:1359
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:598 [inline]
> > >  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > The buggy address belongs to the object at ffff888145c59580
> > >  which belongs to the cache kmalloc-96 of size 96
> > > The buggy address is located 32 bytes inside of
> > >  freed 96-byte region [ffff888145c59580, ffff888145c595e0)
> > >
> > > The buggy address belongs to the physical page:
> > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x=
145c59
> > > flags: 0x200000000000000(node=3D0|zone=3D2)
> > > page_type: f5(slab)
> > > raw: 0200000000000000 ffff888100042280 ffffea0004579a00 dead000000000=
002
> > > raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > >
> > > Memory state around the buggy address:
> > >  ffff888145c59480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >  ffff888145c59500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > >ffff888145c59580: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >                                ^
> > >  ffff888145c59600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >  ffff888145c59680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >
> > > Best regards,
> > > Cen Zhang
> > >
> > > Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 20:59=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Hi Cen,
> > > >
> > > > On Fri, Sep 12, 2025 at 11:01=E2=80=AFPM cen zhang <zzzccc427@gmail=
.com> wrote:
> > > > >
> > > > > Hi Luiz,
> > > > >
> > > > > I've just started testing the patch, and it seems to have introdu=
ced a
> > > > > new issue. I've attached the detailed report below:
> > > > >
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > BUG: KASAN: slab-use-after-free in mgmt_pending_valid+0x8f/0x7e0
> > > > > net/bluetooth/mgmt_util.c:330
> > > > > Read of size 8 at addr ffff888140eae198 by task kworker/u17:2/82
> > > > >
> > > > > CPU: 1 UID: 0 PID: 82 Comm: kworker/u17:2 Not tainted
> > > > > 6.17.0-rc5-ge5bbb70171d1-dirty #8 PREEMPT(voluntary)
> > > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.=
0-1 04/01/2014
> > > > > Workqueue: hci0 hci_cmd_sync_work
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > > >  dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
> > > > >  print_address_description mm/kasan/report.c:378 [inline]
> > > > >  print_report+0x171/0x7f0 mm/kasan/report.c:482
> > > > >  kasan_report+0x139/0x170 mm/kasan/report.c:595
> > > > >  mgmt_pending_valid+0x8f/0x7e0 net/bluetooth/mgmt_util.c:330
> > > >
> > > > Looks like this is the result of trying to access the cmd->hdev, wh=
ich
> > > > is definitely wrong since the whole point of the function is to try=
 to
> > > > determine if cmd is still valid, so please try with the v5.
> > > >
> > > > >  mgmt_set_powered_complete+0x81/0xf20 net/bluetooth/mgmt.c:1326
> > > > >  hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
> > > > >  process_one_work kernel/workqueue.c:3236 [inline]
> > > > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > > > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > > > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > > > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > >  </TASK>
> > > > >
> > > > > Allocated by task 195:
> > > > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > > > >  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> > > > >  __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
> > > > >  kmalloc_noprof include/linux/slab.h:905 [inline]
> > > > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > > > >  mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
> > > > >  mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
> > > > >  set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1406
> > > > >  hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
> > > > >  hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
> > > > >  sock_sendmsg_nosec net/socket.c:714 [inline]
> > > > >  __sock_sendmsg+0x21c/0x270 net/socket.c:729
> > > > >  sock_write_iter+0x1b7/0x250 net/socket.c:1179
> > > > >  do_iter_readv_writev+0x598/0x760
> > > > >  vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
> > > > >  do_writev+0x105/0x270 fs/read_write.c:1103
> > > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > >
> > > > > Freed by task 82:
> > > > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> > > > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
> > > > >  poison_slab_object mm/kasan/common.c:243 [inline]
> > > > >  __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
> > > > >  kasan_slab_free include/linux/kasan.h:233 [inline]
> > > > >  slab_free_hook mm/slub.c:2428 [inline]
> > > > >  slab_free mm/slub.c:4701 [inline]
> > > > >  kfree+0x189/0x390 mm/slub.c:4900
> > > > >  mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
> > > > >  mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
> > > > >  mgmt_power_on+0x43d/0x5e0 net/bluetooth/mgmt.c:9448
> > > > >  hci_dev_open_sync+0x44fa/0x5060 net/bluetooth/hci_sync.c:5137
> > > > >  hci_power_on_sync net/bluetooth/hci_sync.c:5376 [inline]
> > > > >  hci_set_powered_sync+0x43e/0xfa0 net/bluetooth/hci_sync.c:5768
> > > > >  set_powered_sync+0x1e0/0x2c0 net/bluetooth/mgmt.c:1369
> > > > >  hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
> > > > >  process_one_work kernel/workqueue.c:3236 [inline]
> > > > >  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
> > > > >  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
> > > > >  kthread+0x3d4/0x800 kernel/kthread.c:463
> > > > >  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
> > > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > >
> > > > > The buggy address belongs to the object at ffff888140eae180
> > > > >  which belongs to the cache kmalloc-96 of size 96
> > > > > The buggy address is located 24 bytes inside of
> > > > >  freed 96-byte region [ffff888140eae180, ffff888140eae1e0)
> > > > >
> > > > > The buggy address belongs to the physical page:
> > > > > page: refcount:0 mapcount:0 mapping:0000000000000000
> > > > > index:0xffff888140eae200 pfn:0x140eae
> > > > > flags: 0x200000000000200(workingset|node=3D0|zone=3D2)
> > > > > page_type: f5(slab)
> > > > > raw: 0200000000000200 ffff888100042280 ffffea0004763ad0 ffffea000=
4763a90
> > > > > raw: ffff888140eae200 000000000020001f 00000000f5000000 000000000=
0000000
> > > > > page dumped because: kasan: bad access detected
> > > > >
> > > > > Memory state around the buggy address:
> > > > >  ffff888140eae080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc f=
c
> > > > >  ffff888140eae100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc f=
c
> > > > > >ffff888140eae180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc f=
c
> > > > >                             ^
> > > > >  ffff888140eae200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc f=
c
> > > > >  ffff888140eae280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc f=
c
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Best regards,
> > > > > Cen Zhang
> > > > >
> > > > > cen zhang <zzzccc427@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=881=
3=E6=97=A5=E5=91=A8=E5=85=AD 10:16=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hi Luiz,
> > > > > >
> > > > > > Thanks for your patch! It not only addresses the TOCTOU issue w=
e
> > > > > > discussed but may also fix another bug I reported
> > > > > > (https://lore.kernel.org/linux-bluetooth/CAFRLqsWWMnrZ6y8MUMUSK=
=3DtmAb3r8_jfSwqforOoR8_-=3DXgX7g@mail.gmail.com/T/#u).
> > > > > >
> > > > > > I will test it soon to confirm.
> > > > > >
> > > > > > Thanks again for the great work.
> > > > > >
> > > > > > Best regards,
> > > > > >
> > > > > > Cen Zhang
> > > > > >
> > > > > > Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=
=B9=B49=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:29=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > >
> > > > > > > Hi Cen,
> > > > > > >
> > > > > > > On Fri, Sep 12, 2025 at 11:59=E2=80=AFAM cen zhang <zzzccc427=
@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Luiz,
> > > > > > > >
> > > > > > > > Thank you for your quick response and the important clarifi=
cation
> > > > > > > > about hci_cmd_sync_dequeue().
> > > > > > > >
> > > > > > > > You are absolutely correct - I was indeed referring to the =
TOCTOU
> > > > > > > > problem in pending_find(), not the -ECANCELED check. The
> > > > > > > > hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a cruc=
ial detail
> > > > > > > > that I initially overlooked in my analysis.
> > > > > > > >
> > > > > > > > After examining the code more carefully, I can see that whi=
le
> > > > > > > > hci_cmd_sync_dequeue() does attempt to remove pending sync =
commands
> > > > > > > > from the queue, but it cannot prevent the race condition we=
're seeing.
> > > > > > > > The fundamental issue is that hci_cmd_sync_dequeue() can on=
ly remove
> > > > > > > > work items that are still queued, but cannot stop work item=
s that are
> > > > > > > > already executing or about to execute their completion call=
backs.
> > > > > > > >
> > > > > > > > The race window occurs when:
> > > > > > > > 1. mgmt_set_powered_complete() is about to execute (work it=
em has been dequeued)
> > > > > > > > 2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_co=
mplete_rsp() executes
> > > > > > > > 3. hci_cmd_sync_dequeue() removes queued items but cannot a=
ffect the
> > > > > > > > already-running callback
> > > > > > > > 4. mgmt_pending_free() frees the cmd object
> > > > > > > > 5. mgmt_set_powered_complete() still executes and accesses =
freed cmd->param
> > > > > > > >
> > > > > > > > I am sorry that I haven't get a reliable reproducer from sy=
zkaller for
> > > > > > > > this bug may be due to it is timing-sensitive.
> > > > > > >
> > > > > > > Let's try to fix all instances then, since apparently there i=
s more
> > > > > > > than one cmd with this pattern, please test with the attached=
 patch.
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

--000000000000f09a48063ed967b3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v6-0003-Bluetooth-MGMT-Fix-possible-UAFs.patch"
Content-Disposition: attachment; 
	filename="v6-0003-Bluetooth-MGMT-Fix-possible-UAFs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mflc0kav0>
X-Attachment-Id: f_mflc0kav0

RnJvbSAxNDc4M2Q3MmRmZmM2MjEzODk5NDllNDhkZjNiMjQzYWNiMDZlNWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMjUgQXVnIDIwMjUgMTA6MDM6MDcgLTA0MDAKU3ViamVj
dDogW1BBVENIIHY2IDMvM10gQmx1ZXRvb3RoOiBNR01UOiBGaXggcG9zc2libGUgVUFGcwoKVGhp
cyBhdHRlbXBzIHRvIGZpeCBwb3NzaWJsZSBVQUZzIGNhdXNlZCBieSBzdHJ1Y3QgbWdtdF9wZW5k
aW5nIGJlaW5nCmZyZWVkIHdoaWxlIHN0aWxsIGJlaW5nIHByb2Nlc3NlZCBsaWtlIGluIHRoZSBm
b2xsb3dpbmcgdHJhY2UsIGluIG9yZGVyCnRvIGZpeCBtZ210X3BlbmRpbmdfdmFsaWQgaXMgaW50
cm9kdWNlIGFuZCB1c2UgdG8gY2hlY2sgaWYgdGhlCm1nbXRfcGVuZGluZyBoYXNuJ3QgYmVlbiBy
ZW1vdmVkIGZyb20gdGhlIHBlbmRpbmcgbGlzdCwgb24gdGhlIGNvbXBsZXRlCmNhbGxiYWNrcyBp
dCBpcyB1c2VkIHRvIGNoZWNrIGFuZCBpbiBhZGR0aW9uIHJlbW92ZSB0aGUgY21kIGZyb20gdGhl
IGxpc3QKd2hpbGUgaG9sZGluZyBtZ210X3BlbmRpbmdfbG9jayB0byBhdm9pZCBUT0NUT1UgcHJv
YmxlbXMgc2luY2UgaWYgdGhlIGNtZAppcyBsZWZ0IG9uIHRoZSBsaXN0IGl0IGNhbiBzdGlsbCBi
ZSBhY2Nlc3NlZCBhbmQgZnJlZWQuCgpCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGlu
IG1nbXRfYWRkX2Fkdl9wYXR0ZXJuc19tb25pdG9yX3N5bmMrMHgzNS8weDUwIG5ldC9ibHVldG9v
dGgvbWdtdC5jOjUyMjMKUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmODg4MDcwOWQ0ZGMwIGJ5
IHRhc2sga3dvcmtlci91MTE6MC81NQoKQ1BVOiAwIFVJRDogMCBQSUQ6IDU1IENvbW06IGt3b3Jr
ZXIvdTExOjAgTm90IHRhaW50ZWQgNi4xNi40ICMyIFBSRUVNUFQoZnVsbCkKSGFyZHdhcmUgbmFt
ZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xMC4yLTF1
YnVudHUxIDA0LzAxLzIwMTQKV29ya3F1ZXVlOiBoY2kwIGhjaV9jbWRfc3luY193b3JrCkNhbGwg
VHJhY2U6CiA8VEFTSz4KIGR1bXBfc3RhY2tfbHZsKzB4MTg5LzB4MjUwIGxpYi9kdW1wX3N0YWNr
LmM6MTIwCiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uIG1tL2thc2FuL3JlcG9ydC5jOjM3OCBb
aW5saW5lXQogcHJpbnRfcmVwb3J0KzB4Y2EvMHgyNDAgbW0va2FzYW4vcmVwb3J0LmM6NDgyCiBr
YXNhbl9yZXBvcnQrMHgxMTgvMHgxNTAgbW0va2FzYW4vcmVwb3J0LmM6NTk1CiBtZ210X2FkZF9h
ZHZfcGF0dGVybnNfbW9uaXRvcl9zeW5jKzB4MzUvMHg1MCBuZXQvYmx1ZXRvb3RoL21nbXQuYzo1
MjIzCiBoY2lfY21kX3N5bmNfd29yaysweDIxMC8weDNhMCBuZXQvYmx1ZXRvb3RoL2hjaV9zeW5j
LmM6MzMyCiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVldWUuYzozMjM4IFtpbmxpbmVd
CiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGFkZS8weDE3YjAga2VybmVsL3dvcmtxdWV1ZS5j
OjMzMjEKIHdvcmtlcl90aHJlYWQrMHg4YTAvMHhkYTAga2VybmVsL3dvcmtxdWV1ZS5jOjM0MDIK
IGt0aHJlYWQrMHg3MTEvMHg4YTAga2VybmVsL2t0aHJlYWQuYzo0NjQKIHJldF9mcm9tX2Zvcmsr
MHgzZmMvMHg3NzAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDgKIHJldF9mcm9tX2Zvcmtf
YXNtKzB4MWEvMHgzMCBob21lL2t3cWNoZWlpL3NvdXJjZS9mdXp6aW5nL2tlcm5lbC9rYXNhbi9s
aW51eC02LjE2LjQvYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzoyNDUKIDwvVEFTSz4KCkFsbG9j
YXRlZCBieSB0YXNrIDEyMjEwOgoga2FzYW5fc2F2ZV9zdGFjayBtbS9rYXNhbi9jb21tb24uYzo0
NyBbaW5saW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNlLzB4ODAgbW0va2FzYW4vY29tbW9uLmM6
NjgKIHBvaXNvbl9rbWFsbG9jX3JlZHpvbmUgbW0va2FzYW4vY29tbW9uLmM6Mzc3IFtpbmxpbmVd
CiBfX2thc2FuX2ttYWxsb2MrMHg5My8weGIwIG1tL2thc2FuL2NvbW1vbi5jOjM5NAoga2FzYW5f
a21hbGxvYyBpbmNsdWRlL2xpbnV4L2thc2FuLmg6MjYwIFtpbmxpbmVdCiBfX2ttYWxsb2NfY2Fj
aGVfbm9wcm9mKzB4MjMwLzB4M2QwIG1tL3NsdWIuYzo0MzY0CiBrbWFsbG9jX25vcHJvZiBpbmNs
dWRlL2xpbnV4L3NsYWIuaDo5MDUgW2lubGluZV0KIGt6YWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGlu
dXgvc2xhYi5oOjEwMzkgW2lubGluZV0KIG1nbXRfcGVuZGluZ19uZXcrMHg2NS8weDFlMCBuZXQv
Ymx1ZXRvb3RoL21nbXRfdXRpbC5jOjI2OQogbWdtdF9wZW5kaW5nX2FkZCsweDM1LzB4MTQwIG5l
dC9ibHVldG9vdGgvbWdtdF91dGlsLmM6Mjk2CiBfX2FkZF9hZHZfcGF0dGVybnNfbW9uaXRvcisw
eDEzMC8weDIwMCBuZXQvYmx1ZXRvb3RoL21nbXQuYzo1MjQ3CiBhZGRfYWR2X3BhdHRlcm5zX21v
bml0b3IrMHgyMTQvMHgzNjAgbmV0L2JsdWV0b290aC9tZ210LmM6NTM2NAogaGNpX21nbXRfY21k
KzB4OWM5LzB4ZWYwIG5ldC9ibHVldG9vdGgvaGNpX3NvY2suYzoxNzE5CiBoY2lfc29ja19zZW5k
bXNnKzB4NmNhLzB4ZWYwIG5ldC9ibHVldG9vdGgvaGNpX3NvY2suYzoxODM5CiBzb2NrX3NlbmRt
c2dfbm9zZWMgbmV0L3NvY2tldC5jOjcxNCBbaW5saW5lXQogX19zb2NrX3NlbmRtc2crMHgyMTkv
MHgyNzAgbmV0L3NvY2tldC5jOjcyOQogc29ja193cml0ZV9pdGVyKzB4MjU4LzB4MzMwIG5ldC9z
b2NrZXQuYzoxMTMzCiBuZXdfc3luY193cml0ZSBmcy9yZWFkX3dyaXRlLmM6NTkzIFtpbmxpbmVd
CiB2ZnNfd3JpdGUrMHg1YzkvMHhiMzAgZnMvcmVhZF93cml0ZS5jOjY4Ngoga3N5c193cml0ZSsw
eDE0NS8weDI1MCBmcy9yZWFkX3dyaXRlLmM6NzM4CiBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9l
bnRyeS9zeXNjYWxsXzY0LmM6NjMgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHhmYS8weDNiMCBh
cmNoL3g4Ni9lbnRyeS9zeXNjYWxsXzY0LmM6OTQKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDc3LzB4N2YKCkZyZWVkIGJ5IHRhc2sgMTIyMjE6CiBrYXNhbl9zYXZlX3N0YWNrIG1t
L2thc2FuL2NvbW1vbi5jOjQ3IFtpbmxpbmVdCiBrYXNhbl9zYXZlX3RyYWNrKzB4M2UvMHg4MCBt
bS9rYXNhbi9jb21tb24uYzo2OAoga2FzYW5fc2F2ZV9mcmVlX2luZm8rMHg0Ni8weDUwIG1tL2th
c2FuL2dlbmVyaWMuYzo1NzYKIHBvaXNvbl9zbGFiX29iamVjdCBtbS9rYXNhbi9jb21tb24uYzoy
NDcgW2lubGluZV0KIF9fa2FzYW5fc2xhYl9mcmVlKzB4NjIvMHg3MCBtbS9rYXNhbi9jb21tb24u
YzoyNjQKIGthc2FuX3NsYWJfZnJlZSBpbmNsdWRlL2xpbnV4L2thc2FuLmg6MjMzIFtpbmxpbmVd
CiBzbGFiX2ZyZWVfaG9vayBtbS9zbHViLmM6MjM4MSBbaW5saW5lXQogc2xhYl9mcmVlIG1tL3Ns
dWIuYzo0NjQ4IFtpbmxpbmVdCiBrZnJlZSsweDE4ZS8weDQ0MCBtbS9zbHViLmM6NDg0NwogbWdt
dF9wZW5kaW5nX2ZyZWUgbmV0L2JsdWV0b290aC9tZ210X3V0aWwuYzozMTEgW2lubGluZV0KIG1n
bXRfcGVuZGluZ19mb3JlYWNoKzB4MzBkLzB4MzgwIG5ldC9ibHVldG9vdGgvbWdtdF91dGlsLmM6
MjU3CiBfX21nbXRfcG93ZXJfb2ZmKzB4MTY5LzB4MzUwIG5ldC9ibHVldG9vdGgvbWdtdC5jOjk0
NDQKIGhjaV9kZXZfY2xvc2Vfc3luYysweDc1NC8weDEzMzAgbmV0L2JsdWV0b290aC9oY2lfc3lu
Yy5jOjUyOTAKIGhjaV9kZXZfZG9fY2xvc2UgbmV0L2JsdWV0b290aC9oY2lfY29yZS5jOjUwMSBb
aW5saW5lXQogaGNpX2Rldl9jbG9zZSsweDEwOC8weDIwMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb3Jl
LmM6NTI2CiBzb2NrX2RvX2lvY3RsKzB4ZDkvMHgzMDAgbmV0L3NvY2tldC5jOjExOTIKIHNvY2tf
aW9jdGwrMHg1NzYvMHg3OTAgbmV0L3NvY2tldC5jOjEzMTMKIHZmc19pb2N0bCBmcy9pb2N0bC5j
OjUxIFtpbmxpbmVdCiBfX2RvX3N5c19pb2N0bCBmcy9pb2N0bC5jOjkwNyBbaW5saW5lXQogX19z
ZV9zeXNfaW9jdGwrMHhmOS8weDE3MCBmcy9pb2N0bC5jOjg5MwogZG9fc3lzY2FsbF94NjQgYXJj
aC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjYzIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZmEv
MHgzYjAgYXJjaC94ODYvZW50cnkvc3lzY2FsbF82NC5jOjk0CiBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg3Ny8weDdmCgpGaXhlczogYjc0N2E4MzY5MGM4ICgiQmx1ZXRvb3RoOiBo
Y2lfc3luYzogUmVmYWN0b3IgYWRkIEFkdiBNb25pdG9yIikKQ2xvc2VzOiBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9ZTg2NTE0MTljNDRkYmMyYjg3NjgKUmVwb3J0ZWQt
Ynk6IHN5emJvdCtlODY1MTQxOWM0NGRiYzJiODc2OEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
ClNpZ25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGlu
dGVsLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL21nbXQuYyAgICAgIHwgMTkzICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiBuZXQvYmx1ZXRvb3RoL21nbXRfdXRpbC5jIHwg
IDIzICsrKysrCiBuZXQvYmx1ZXRvb3RoL21nbXRfdXRpbC5oIHwgICAyICsKIDMgZmlsZXMgY2hh
bmdlZCwgMTU0IGluc2VydGlvbnMoKyksIDY0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25l
dC9ibHVldG9vdGgvbWdtdC5jIGIvbmV0L2JsdWV0b290aC9tZ210LmMKaW5kZXggOTg5MzIxYjFl
YTI3Li5iOWM1MzgxMGJmMDYgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvbWdtdC5jCisrKyBi
L25ldC9ibHVldG9vdGgvbWdtdC5jCkBAIC0xMzIzLDggKzEzMjMsNyBAQCBzdGF0aWMgdm9pZCBt
Z210X3NldF9wb3dlcmVkX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRh
LCBpbnQgZXJyKQogCXN0cnVjdCBtZ210X21vZGUgKmNwOwogCiAJLyogTWFrZSBzdXJlIGNtZCBz
dGlsbCBvdXRzdGFuZGluZy4gKi8KLQlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwKLQkgICAgY21k
ICE9IHBlbmRpbmdfZmluZChNR01UX09QX1NFVF9QT1dFUkVELCBoZGV2KSkKKwlpZiAoZXJyID09
IC1FQ0FOQ0VMRUQgfHwgIW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIHRydWUpKQogCQly
ZXR1cm47CiAKIAljcCA9IGNtZC0+cGFyYW07CkBAIC0xMzUxLDcgKzEzNTAsNyBAQCBzdGF0aWMg
dm9pZCBtZ210X3NldF9wb3dlcmVkX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lk
ICpkYXRhLCBpbnQgZXJyKQogCQkJCW1nbXRfc3RhdHVzKGVycikpOwogCX0KIAotCW1nbXRfcGVu
ZGluZ19yZW1vdmUoY21kKTsKKwltZ210X3BlbmRpbmdfZnJlZShjbWQpOwogfQogCiBzdGF0aWMg
aW50IHNldF9wb3dlcmVkX3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCkBA
IC0xMzYwLDcgKzEzNTksNyBAQCBzdGF0aWMgaW50IHNldF9wb3dlcmVkX3N5bmMoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiAJc3RydWN0IG1nbXRfbW9kZSAqY3A7CiAKIAkvKiBN
YWtlIHN1cmUgY21kIHN0aWxsIG91dHN0YW5kaW5nLiAqLwotCWlmIChjbWQgIT0gcGVuZGluZ19m
aW5kKE1HTVRfT1BfU0VUX1BPV0VSRUQsIGhkZXYpKQorCWlmICghbWdtdF9wZW5kaW5nX3ZhbGlk
KGhkZXYsIGNtZCwgZmFsc2UpKQogCQlyZXR1cm4gLUVDQU5DRUxFRDsKIAogCWNwID0gY21kLT5w
YXJhbTsKQEAgLTE1MTYsOCArMTUxNSw3IEBAIHN0YXRpYyB2b2lkIG1nbXRfc2V0X2Rpc2NvdmVy
YWJsZV9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAlidF9kZXZf
ZGJnKGhkZXYsICJlcnIgJWQiLCBlcnIpOwogCiAJLyogTWFrZSBzdXJlIGNtZCBzdGlsbCBvdXRz
dGFuZGluZy4gKi8KLQlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwKLQkgICAgY21kICE9IHBlbmRp
bmdfZmluZChNR01UX09QX1NFVF9ESVNDT1ZFUkFCTEUsIGhkZXYpKQorCWlmIChlcnIgPT0gLUVD
QU5DRUxFRCB8fCAhbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwgdHJ1ZSkpCiAJCXJldHVy
bjsKIAogCWhjaV9kZXZfbG9jayhoZGV2KTsKQEAgLTE1MzksMTIgKzE1MzcsMTUgQEAgc3RhdGlj
IHZvaWQgbWdtdF9zZXRfZGlzY292ZXJhYmxlX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB2b2lkICpkYXRhLAogCW5ld19zZXR0aW5ncyhoZGV2LCBjbWQtPnNrKTsKIAogZG9uZToKLQlt
Z210X3BlbmRpbmdfcmVtb3ZlKGNtZCk7CisJbWdtdF9wZW5kaW5nX2ZyZWUoY21kKTsKIAloY2lf
ZGV2X3VubG9jayhoZGV2KTsKIH0KIAogc3RhdGljIGludCBzZXRfZGlzY292ZXJhYmxlX3N5bmMo
c3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiB7CisJaWYgKCFtZ210X3BlbmRpbmdf
dmFsaWQoaGRldiwgZGF0YSwgZmFsc2UpKQorCQlyZXR1cm4gLUVDQU5DRUxFRDsKKwogCUJUX0RC
RygiJXMiLCBoZGV2LT5uYW1lKTsKIAogCXJldHVybiBoY2lfdXBkYXRlX2Rpc2NvdmVyYWJsZV9z
eW5jKGhkZXYpOwpAQCAtMTY5MSw4ICsxNjkyLDcgQEAgc3RhdGljIHZvaWQgbWdtdF9zZXRfY29u
bmVjdGFibGVfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJYnRf
ZGV2X2RiZyhoZGV2LCAiZXJyICVkIiwgZXJyKTsKIAogCS8qIE1ha2Ugc3VyZSBjbWQgc3RpbGwg
b3V0c3RhbmRpbmcuICovCi0JaWYgKGVyciA9PSAtRUNBTkNFTEVEIHx8Ci0JICAgIGNtZCAhPSBw
ZW5kaW5nX2ZpbmQoTUdNVF9PUF9TRVRfQ09OTkVDVEFCTEUsIGhkZXYpKQorCWlmIChlcnIgPT0g
LUVDQU5DRUxFRCB8fCAhbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwgdHJ1ZSkpCiAJCXJl
dHVybjsKIAogCWhjaV9kZXZfbG9jayhoZGV2KTsKQEAgLTE3MDcsNyArMTcwNyw3IEBAIHN0YXRp
YyB2b2lkIG1nbXRfc2V0X2Nvbm5lY3RhYmxlX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB2b2lkICpkYXRhLAogCW5ld19zZXR0aW5ncyhoZGV2LCBjbWQtPnNrKTsKIAogZG9uZToKLQlt
Z210X3BlbmRpbmdfcmVtb3ZlKGNtZCk7CisJbWdtdF9wZW5kaW5nX2ZyZWUoY21kKTsKIAogCWhj
aV9kZXZfdW5sb2NrKGhkZXYpOwogfQpAQCAtMTc0Myw2ICsxNzQzLDkgQEAgc3RhdGljIGludCBz
ZXRfY29ubmVjdGFibGVfdXBkYXRlX3NldHRpbmdzKHN0cnVjdCBoY2lfZGV2ICpoZGV2LAogCiBz
dGF0aWMgaW50IHNldF9jb25uZWN0YWJsZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lk
ICpkYXRhKQogeworCWlmICghbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGRhdGEsIGZhbHNlKSkK
KwkJcmV0dXJuIC1FQ0FOQ0VMRUQ7CisKIAlCVF9EQkcoIiVzIiwgaGRldi0+bmFtZSk7CiAKIAly
ZXR1cm4gaGNpX3VwZGF0ZV9jb25uZWN0YWJsZV9zeW5jKGhkZXYpOwpAQCAtMTkxOSwxNCArMTky
MiwxNyBAQCBzdGF0aWMgdm9pZCBzZXRfc3NwX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB2b2lkICpkYXRhLCBpbnQgZXJyKQogewogCXN0cnVjdCBjbWRfbG9va3VwIG1hdGNoID0geyBO
VUxMLCBoZGV2IH07CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7Ci0Jc3Ry
dWN0IG1nbXRfbW9kZSAqY3AgPSBjbWQtPnBhcmFtOwotCXU4IGVuYWJsZSA9IGNwLT52YWw7CisJ
c3RydWN0IG1nbXRfbW9kZSAqY3A7CisJdTggZW5hYmxlOwogCWJvb2wgY2hhbmdlZDsKIAogCS8q
IE1ha2Ugc3VyZSBjbWQgc3RpbGwgb3V0c3RhbmRpbmcuICovCi0JaWYgKGVyciA9PSAtRUNBTkNF
TEVEIHx8IGNtZCAhPSBwZW5kaW5nX2ZpbmQoTUdNVF9PUF9TRVRfU1NQLCBoZGV2KSkKKwlpZiAo
ZXJyID09IC1FQ0FOQ0VMRUQgfHwgIW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIHRydWUp
KQogCQlyZXR1cm47CiAKKwljcCA9IGNtZC0+cGFyYW07CisJZW5hYmxlID0gY3AtPnZhbDsKKwog
CWlmIChlcnIpIHsKIAkJdTggbWdtdF9lcnIgPSBtZ210X3N0YXR1cyhlcnIpOwogCkBAIC0xOTM1
LDggKzE5NDEsNyBAQCBzdGF0aWMgdm9pZCBzZXRfc3NwX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQogCQkJbmV3X3NldHRpbmdzKGhkZXYsIE5VTEwp
OwogCQl9CiAKLQkJbWdtdF9wZW5kaW5nX2ZvcmVhY2goTUdNVF9PUF9TRVRfU1NQLCBoZGV2LCB0
cnVlLAotCQkJCSAgICAgY21kX3N0YXR1c19yc3AsICZtZ210X2Vycik7CisJCW1nbXRfY21kX3N0
YXR1cyhjbWQtPnNrLCBjbWQtPmhkZXYtPmlkLCBjbWQtPm9wY29kZSwgbWdtdF9lcnIpOwogCQly
ZXR1cm47CiAJfQogCkBAIC0xOTQ2LDcgKzE5NTEsNyBAQCBzdGF0aWMgdm9pZCBzZXRfc3NwX2Nv
bXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQogCQljaGFu
Z2VkID0gaGNpX2Rldl90ZXN0X2FuZF9jbGVhcl9mbGFnKGhkZXYsIEhDSV9TU1BfRU5BQkxFRCk7
CiAJfQogCi0JbWdtdF9wZW5kaW5nX2ZvcmVhY2goTUdNVF9PUF9TRVRfU1NQLCBoZGV2LCB0cnVl
LCBzZXR0aW5nc19yc3AsICZtYXRjaCk7CisJc2V0dGluZ3NfcnNwKGNtZCwgJm1hdGNoKTsKIAog
CWlmIChjaGFuZ2VkKQogCQluZXdfc2V0dGluZ3MoaGRldiwgbWF0Y2guc2spOwpAQCAtMTk2MCwx
MCArMTk2NSwxNSBAQCBzdGF0aWMgdm9pZCBzZXRfc3NwX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQogc3RhdGljIGludCBzZXRfc3NwX3N5bmMoc3Ry
dWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19j
bWQgKmNtZCA9IGRhdGE7Ci0Jc3RydWN0IG1nbXRfbW9kZSAqY3AgPSBjbWQtPnBhcmFtOworCXN0
cnVjdCBtZ210X21vZGUgKmNwOwogCWJvb2wgY2hhbmdlZCA9IGZhbHNlOwogCWludCBlcnI7CiAK
KwlpZiAoIW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIGZhbHNlKSkKKwkJcmV0dXJuIC1F
Q0FOQ0VMRUQ7CisKKwljcCA9IGNtZC0+cGFyYW07CisKIAlpZiAoY3AtPnZhbCkKIAkJY2hhbmdl
ZCA9ICFoY2lfZGV2X3Rlc3RfYW5kX3NldF9mbGFnKGhkZXYsIEhDSV9TU1BfRU5BQkxFRCk7CiAK
QEAgLTIwNjAsMzIgKzIwNzAsNDQgQEAgc3RhdGljIGludCBzZXRfaHMoc3RydWN0IHNvY2sgKnNr
LCBzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwgdTE2IGxlbikKIAogc3RhdGljIHZv
aWQgc2V0X2xlX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQg
ZXJyKQogeworCXN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOwogCXN0cnVjdCBj
bWRfbG9va3VwIG1hdGNoID0geyBOVUxMLCBoZGV2IH07CiAJdTggc3RhdHVzID0gbWdtdF9zdGF0
dXMoZXJyKTsKIAogCWJ0X2Rldl9kYmcoaGRldiwgImVyciAlZCIsIGVycik7CiAKLQlpZiAoc3Rh
dHVzKSB7Ci0JCW1nbXRfcGVuZGluZ19mb3JlYWNoKE1HTVRfT1BfU0VUX0xFLCBoZGV2LCB0cnVl
LCBjbWRfc3RhdHVzX3JzcCwKLQkJCQkgICAgICZzdGF0dXMpOworCWlmIChlcnIgPT0gLUVDQU5D
RUxFRCB8fCAhbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGRhdGEsIHRydWUpKQogCQlyZXR1cm47
CisKKwlpZiAoc3RhdHVzKSB7CisJCW1nbXRfY21kX3N0YXR1cyhjbWQtPnNrLCBjbWQtPmhkZXYt
PmlkLCBjbWQtPm9wY29kZSwgc3RhdHVzKTsKKwkJZ290byBkb25lOwogCX0KIAotCW1nbXRfcGVu
ZGluZ19mb3JlYWNoKE1HTVRfT1BfU0VUX0xFLCBoZGV2LCB0cnVlLCBzZXR0aW5nc19yc3AsICZt
YXRjaCk7CisJc2V0dGluZ3NfcnNwKGNtZCwgJm1hdGNoKTsKIAogCW5ld19zZXR0aW5ncyhoZGV2
LCBtYXRjaC5zayk7CiAKIAlpZiAobWF0Y2guc2spCiAJCXNvY2tfcHV0KG1hdGNoLnNrKTsKKwor
ZG9uZToKKwltZ210X3BlbmRpbmdfZnJlZShjbWQpOwogfQogCiBzdGF0aWMgaW50IHNldF9sZV9z
eW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhKQogewogCXN0cnVjdCBtZ210X3Bl
bmRpbmdfY21kICpjbWQgPSBkYXRhOwotCXN0cnVjdCBtZ210X21vZGUgKmNwID0gY21kLT5wYXJh
bTsKLQl1OCB2YWwgPSAhIWNwLT52YWw7CisJc3RydWN0IG1nbXRfbW9kZSAqY3A7CisJdTggdmFs
OwogCWludCBlcnI7CiAKKwlpZiAoIW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIGZhbHNl
KSkKKwkJcmV0dXJuIC1FQ0FOQ0VMRUQ7CisKKwljcCA9IGNtZC0+cGFyYW07CisJdmFsID0gISFj
cC0+dmFsOworCiAJaWYgKCF2YWwpIHsKIAkJaGNpX2NsZWFyX2Fkdl9pbnN0YW5jZV9zeW5jKGhk
ZXYsIE5VTEwsIDB4MDAsIHRydWUpOwogCkBAIC0yMTI3LDcgKzIxNDksMTIgQEAgc3RhdGljIHZv
aWQgc2V0X21lc2hfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGlu
dCBlcnIpCiB7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7CiAJdTggc3Rh
dHVzID0gbWdtdF9zdGF0dXMoZXJyKTsKLQlzdHJ1Y3Qgc29jayAqc2sgPSBjbWQtPnNrOworCXN0
cnVjdCBzb2NrICpzazsKKworCWlmIChlcnIgPT0gLUVDQU5DRUxFRCB8fCAhbWdtdF9wZW5kaW5n
X3ZhbGlkKGhkZXYsIGNtZCwgdHJ1ZSkpCisJCXJldHVybjsKKworCXNrID0gY21kLT5zazsKIAog
CWlmIChzdGF0dXMpIHsKIAkJbWdtdF9wZW5kaW5nX2ZvcmVhY2goTUdNVF9PUF9TRVRfTUVTSF9S
RUNFSVZFUiwgaGRldiwgdHJ1ZSwKQEAgLTIxNDIsOCArMjE2OSwxNCBAQCBzdGF0aWMgdm9pZCBz
ZXRfbWVzaF9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwgaW50IGVy
cikKIHN0YXRpYyBpbnQgc2V0X21lc2hfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAq
ZGF0YSkKIHsKIAlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKLQlzdHJ1Y3Qg
bWdtdF9jcF9zZXRfbWVzaCAqY3AgPSBjbWQtPnBhcmFtOwotCXNpemVfdCBsZW4gPSBjbWQtPnBh
cmFtX2xlbjsKKwlzdHJ1Y3QgbWdtdF9jcF9zZXRfbWVzaCAqY3A7CisJc2l6ZV90IGxlbjsKKwor
CWlmICghbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwgZmFsc2UpKQorCQlyZXR1cm4gLUVD
QU5DRUxFRDsKKworCWNwID0gY21kLT5wYXJhbTsKKwlsZW4gPSBjbWQtPnBhcmFtX2xlbjsKIAog
CW1lbXNldChoZGV2LT5tZXNoX2FkX3R5cGVzLCAwLCBzaXplb2YoaGRldi0+bWVzaF9hZF90eXBl
cykpOwogCkBAIC0zODY3LDE1ICszOTAwLDE2IEBAIHN0YXRpYyBpbnQgbmFtZV9jaGFuZ2VkX3N5
bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEpCiBzdGF0aWMgdm9pZCBzZXRfbmFt
ZV9jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwgaW50IGVycikKIHsK
IAlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKLQlzdHJ1Y3QgbWdtdF9jcF9z
ZXRfbG9jYWxfbmFtZSAqY3AgPSBjbWQtPnBhcmFtOworCXN0cnVjdCBtZ210X2NwX3NldF9sb2Nh
bF9uYW1lICpjcDsKIAl1OCBzdGF0dXMgPSBtZ210X3N0YXR1cyhlcnIpOwogCiAJYnRfZGV2X2Ri
ZyhoZGV2LCAiZXJyICVkIiwgZXJyKTsKIAotCWlmIChlcnIgPT0gLUVDQU5DRUxFRCB8fAotCSAg
ICBjbWQgIT0gcGVuZGluZ19maW5kKE1HTVRfT1BfU0VUX0xPQ0FMX05BTUUsIGhkZXYpKQorCWlm
IChlcnIgPT0gLUVDQU5DRUxFRCB8fCAhbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwgdHJ1
ZSkpCiAJCXJldHVybjsKIAorCWNwID0gY21kLT5wYXJhbTsKKwogCWlmIChzdGF0dXMpIHsKIAkJ
bWdtdF9jbWRfc3RhdHVzKGNtZC0+c2ssIGhkZXYtPmlkLCBNR01UX09QX1NFVF9MT0NBTF9OQU1F
LAogCQkJCXN0YXR1cyk7CkBAIC0zODg3LDEzICszOTIxLDE4IEBAIHN0YXRpYyB2b2lkIHNldF9u
YW1lX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQog
CQkJaGNpX2NtZF9zeW5jX3F1ZXVlKGhkZXYsIG5hbWVfY2hhbmdlZF9zeW5jLCBOVUxMLCBOVUxM
KTsKIAl9CiAKLQltZ210X3BlbmRpbmdfcmVtb3ZlKGNtZCk7CisJbWdtdF9wZW5kaW5nX2ZyZWUo
Y21kKTsKIH0KIAogc3RhdGljIGludCBzZXRfbmFtZV9zeW5jKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB2b2lkICpkYXRhKQogewogCXN0cnVjdCBtZ210X3BlbmRpbmdfY21kICpjbWQgPSBkYXRhOwot
CXN0cnVjdCBtZ210X2NwX3NldF9sb2NhbF9uYW1lICpjcCA9IGNtZC0+cGFyYW07CisJc3RydWN0
IG1nbXRfY3Bfc2V0X2xvY2FsX25hbWUgKmNwOworCisJaWYgKCFtZ210X3BlbmRpbmdfdmFsaWQo
aGRldiwgY21kLCBmYWxzZSkpCisJCXJldHVybiAtRUNBTkNFTEVEOworCisJY3AgPSBjbWQtPnBh
cmFtOwogCiAJaWYgKGxtcF9icmVkcl9jYXBhYmxlKGhkZXYpKSB7CiAJCWhjaV91cGRhdGVfbmFt
ZV9zeW5jKGhkZXYsIGNwLT5uYW1lKTsKQEAgLTQwNDgsMTMgKzQwODcsMTQgQEAgaW50IG1nbXRf
cGh5X2NvbmZpZ3VyYXRpb25fY2hhbmdlZChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNv
Y2sgKnNraXApCiBzdGF0aWMgdm9pZCBzZXRfZGVmYXVsdF9waHlfY29tcGxldGUoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGludCBlcnIpCiB7CiAJc3RydWN0IG1nbXRfcGVuZGlu
Z19jbWQgKmNtZCA9IGRhdGE7Ci0Jc3RydWN0IHNrX2J1ZmYgKnNrYiA9IGNtZC0+c2tiOworCXN0
cnVjdCBza19idWZmICpza2I7CiAJdTggc3RhdHVzID0gbWdtdF9zdGF0dXMoZXJyKTsKIAotCWlm
IChlcnIgPT0gLUVDQU5DRUxFRCB8fAotCSAgICBjbWQgIT0gcGVuZGluZ19maW5kKE1HTVRfT1Bf
U0VUX1BIWV9DT05GSUdVUkFUSU9OLCBoZGV2KSkKKwlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwg
IW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIHRydWUpKQogCQlyZXR1cm47CiAKKwlza2Ig
PSBjbWQtPnNrYjsKKwogCWlmICghc3RhdHVzKSB7CiAJCWlmICghc2tiKQogCQkJc3RhdHVzID0g
TUdNVF9TVEFUVVNfRkFJTEVEOwpAQCAtNDA4MCwxNSArNDEyMCwyMSBAQCBzdGF0aWMgdm9pZCBz
ZXRfZGVmYXVsdF9waHlfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEs
IGludCBlcnIpCiAJaWYgKHNrYiAmJiAhSVNfRVJSKHNrYikpCiAJCWtmcmVlX3NrYihza2IpOwog
Ci0JbWdtdF9wZW5kaW5nX3JlbW92ZShjbWQpOworCW1nbXRfcGVuZGluZ19mcmVlKGNtZCk7CiB9
CiAKIHN0YXRpYyBpbnQgc2V0X2RlZmF1bHRfcGh5X3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7Ci0J
c3RydWN0IG1nbXRfY3Bfc2V0X3BoeV9jb25maWd1cmF0aW9uICpjcCA9IGNtZC0+cGFyYW07CisJ
c3RydWN0IG1nbXRfY3Bfc2V0X3BoeV9jb25maWd1cmF0aW9uICpjcDsKIAlzdHJ1Y3QgaGNpX2Nw
X2xlX3NldF9kZWZhdWx0X3BoeSBjcF9waHk7Ci0JdTMyIHNlbGVjdGVkX3BoeXMgPSBfX2xlMzJf
dG9fY3B1KGNwLT5zZWxlY3RlZF9waHlzKTsKKwl1MzIgc2VsZWN0ZWRfcGh5czsKKworCWlmICgh
bWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwgZmFsc2UpKQorCQlyZXR1cm4gLUVDQU5DRUxF
RDsKKworCWNwID0gY21kLT5wYXJhbTsKKwlzZWxlY3RlZF9waHlzID0gX19sZTMyX3RvX2NwdShj
cC0+c2VsZWN0ZWRfcGh5cyk7CiAKIAltZW1zZXQoJmNwX3BoeSwgMCwgc2l6ZW9mKGNwX3BoeSkp
OwogCkBAIC01MTg3LDcgKzUyMzMsMTcgQEAgc3RhdGljIHZvaWQgbWdtdF9hZGRfYWR2X3BhdHRl
cm5zX21vbml0b3JfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsCiB7CiAJc3RydWN0IG1n
bXRfcnBfYWRkX2Fkdl9wYXR0ZXJuc19tb25pdG9yIHJwOwogCXN0cnVjdCBtZ210X3BlbmRpbmdf
Y21kICpjbWQgPSBkYXRhOwotCXN0cnVjdCBhZHZfbW9uaXRvciAqbW9uaXRvciA9IGNtZC0+dXNl
cl9kYXRhOworCXN0cnVjdCBhZHZfbW9uaXRvciAqbW9uaXRvcjsKKworCS8qIFRoaXMgaXMgbGlr
ZWx5IHRoZSByZXN1bHQgb2YgaGRldiBiZWluZyBjbG9zZWQgYW5kIG1nbXRfaW5kZXhfcmVtb3Zl
ZAorCSAqIGlzIGF0dGVtcHRpbmcgdG8gY2xlYW4gdXAgYW55IHBlbmRpbmcgY29tbWFuZCBzbwor
CSAqIGhjaV9hZHZfbW9uaXRvcnNfY2xlYXIgaXMgYWJvdXQgdG8gYmUgY2FsbGVkIHdoaWNoIHdp
bGwgdGFrZSBjYXJlIG9mCisJICogZnJlZWluZyB0aGUgYWR2X21vbml0b3IgaW5zdGFuY2VzLgor
CSAqLworCWlmIChzdGF0dXMgPT0gLUVDQU5DRUxFRCAmJiAhbWdtdF9wZW5kaW5nX3ZhbGlkKGhk
ZXYsIGNtZCwgdHJ1ZSkpCisJCXJldHVybjsKKworCW1vbml0b3IgPSBjbWQtPnVzZXJfZGF0YTsK
IAogCWhjaV9kZXZfbG9jayhoZGV2KTsKIApAQCAtNTIxMyw5ICs1MjY5LDExIEBAIHN0YXRpYyB2
b2lkIG1nbXRfYWRkX2Fkdl9wYXR0ZXJuc19tb25pdG9yX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LAogc3RhdGljIGludCBtZ210X2FkZF9hZHZfcGF0dGVybnNfbW9uaXRvcl9zeW5jKHN0
cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhKQogewogCXN0cnVjdCBtZ210X3BlbmRpbmdf
Y21kICpjbWQgPSBkYXRhOwotCXN0cnVjdCBhZHZfbW9uaXRvciAqbW9uaXRvciA9IGNtZC0+dXNl
cl9kYXRhOwogCi0JcmV0dXJuIGhjaV9hZGRfYWR2X21vbml0b3IoaGRldiwgbW9uaXRvcik7CisJ
aWYgKCFtZ210X3BlbmRpbmdfdmFsaWQoaGRldiwgY21kLCBmYWxzZSkpCisJCXJldHVybiAtRUNB
TkNFTEVEOworCisJcmV0dXJuIGhjaV9hZGRfYWR2X21vbml0b3IoaGRldiwgY21kLT51c2VyX2Rh
dGEpOwogfQogCiBzdGF0aWMgaW50IF9fYWRkX2Fkdl9wYXR0ZXJuc19tb25pdG9yKHN0cnVjdCBz
b2NrICpzaywgc3RydWN0IGhjaV9kZXYgKmhkZXYsCkBAIC01NDgyLDcgKzU1NDAsOCBAQCBzdGF0
aWMgaW50IHJlbW92ZV9hZHZfbW9uaXRvcihzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBoY2lfZGV2
ICpoZGV2LAogCQkJICAgICAgIHN0YXR1cyk7CiB9CiAKLXN0YXRpYyB2b2lkIHJlYWRfbG9jYWxf
b29iX2RhdGFfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGludCBl
cnIpCitzdGF0aWMgdm9pZCByZWFkX2xvY2FsX29vYl9kYXRhX2NvbXBsZXRlKHN0cnVjdCBoY2lf
ZGV2ICpoZGV2LCB2b2lkICpkYXRhLAorCQkJCQkgaW50IGVycikKIHsKIAlzdHJ1Y3QgbWdtdF9y
cF9yZWFkX2xvY2FsX29vYl9kYXRhIG1nbXRfcnA7CiAJc2l6ZV90IHJwX3NpemUgPSBzaXplb2Yo
bWdtdF9ycCk7CkBAIC01NTAyLDcgKzU1NjEsOCBAQCBzdGF0aWMgdm9pZCByZWFkX2xvY2FsX29v
Yl9kYXRhX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZQog
CWJ0X2Rldl9kYmcoaGRldiwgInN0YXR1cyAlZCIsIHN0YXR1cyk7CiAKIAlpZiAoc3RhdHVzKSB7
Ci0JCW1nbXRfY21kX3N0YXR1cyhjbWQtPnNrLCBoZGV2LT5pZCwgTUdNVF9PUF9SRUFEX0xPQ0FM
X09PQl9EQVRBLCBzdGF0dXMpOworCQltZ210X2NtZF9zdGF0dXMoY21kLT5zaywgaGRldi0+aWQs
IE1HTVRfT1BfUkVBRF9MT0NBTF9PT0JfREFUQSwKKwkJCQlzdGF0dXMpOwogCQlnb3RvIHJlbW92
ZTsKIAl9CiAKQEAgLTU3ODQsMTcgKzU4NDQsMTIgQEAgc3RhdGljIHZvaWQgc3RhcnRfZGlzY292
ZXJ5X2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQog
CiAJYnRfZGV2X2RiZyhoZGV2LCAiZXJyICVkIiwgZXJyKTsKIAotCWlmIChlcnIgPT0gLUVDQU5D
RUxFRCkKLQkJcmV0dXJuOwotCi0JaWYgKGNtZCAhPSBwZW5kaW5nX2ZpbmQoTUdNVF9PUF9TVEFS
VF9ESVNDT1ZFUlksIGhkZXYpICYmCi0JICAgIGNtZCAhPSBwZW5kaW5nX2ZpbmQoTUdNVF9PUF9T
VEFSVF9MSU1JVEVEX0RJU0NPVkVSWSwgaGRldikgJiYKLQkgICAgY21kICE9IHBlbmRpbmdfZmlu
ZChNR01UX09QX1NUQVJUX1NFUlZJQ0VfRElTQ09WRVJZLCBoZGV2KSkKKwlpZiAoZXJyID09IC1F
Q0FOQ0VMRUQgfHwgIW1nbXRfcGVuZGluZ192YWxpZChoZGV2LCBjbWQsIHRydWUpKQogCQlyZXR1
cm47CiAKIAltZ210X2NtZF9jb21wbGV0ZShjbWQtPnNrLCBjbWQtPmhkZXYtPmlkLCBjbWQtPm9w
Y29kZSwgbWdtdF9zdGF0dXMoZXJyKSwKIAkJCSAgY21kLT5wYXJhbSwgMSk7Ci0JbWdtdF9wZW5k
aW5nX3JlbW92ZShjbWQpOworCW1nbXRfcGVuZGluZ19mcmVlKGNtZCk7CiAKIAloY2lfZGlzY292
ZXJ5X3NldF9zdGF0ZShoZGV2LCBlcnIgPyBESVNDT1ZFUllfU1RPUFBFRDoKIAkJCQlESVNDT1ZF
UllfRklORElORyk7CkBAIC01ODAyLDYgKzU4NTcsOSBAQCBzdGF0aWMgdm9pZCBzdGFydF9kaXNj
b3ZlcnlfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGludCBlcnIp
CiAKIHN0YXRpYyBpbnQgc3RhcnRfZGlzY292ZXJ5X3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHZvaWQgKmRhdGEpCiB7CisJaWYgKCFtZ210X3BlbmRpbmdfdmFsaWQoaGRldiwgZGF0YSwgZmFs
c2UpKQorCQlyZXR1cm4gLUVDQU5DRUxFRDsKKwogCXJldHVybiBoY2lfc3RhcnRfZGlzY292ZXJ5
X3N5bmMoaGRldik7CiB9CiAKQEAgLTYwMDcsMTUgKzYwNjUsMTQgQEAgc3RhdGljIHZvaWQgc3Rv
cF9kaXNjb3ZlcnlfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGlu
dCBlcnIpCiB7CiAJc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCA9IGRhdGE7CiAKLQlpZiAo
ZXJyID09IC1FQ0FOQ0VMRUQgfHwKLQkgICAgY21kICE9IHBlbmRpbmdfZmluZChNR01UX09QX1NU
T1BfRElTQ09WRVJZLCBoZGV2KSkKKwlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwgIW1nbXRfcGVu
ZGluZ192YWxpZChoZGV2LCBjbWQsIHRydWUpKQogCQlyZXR1cm47CiAKIAlidF9kZXZfZGJnKGhk
ZXYsICJlcnIgJWQiLCBlcnIpOwogCiAJbWdtdF9jbWRfY29tcGxldGUoY21kLT5zaywgY21kLT5o
ZGV2LT5pZCwgY21kLT5vcGNvZGUsIG1nbXRfc3RhdHVzKGVyciksCiAJCQkgIGNtZC0+cGFyYW0s
IDEpOwotCW1nbXRfcGVuZGluZ19yZW1vdmUoY21kKTsKKwltZ210X3BlbmRpbmdfZnJlZShjbWQp
OwogCiAJaWYgKCFlcnIpCiAJCWhjaV9kaXNjb3Zlcnlfc2V0X3N0YXRlKGhkZXYsIERJU0NPVkVS
WV9TVE9QUEVEKTsKQEAgLTYwMjMsNiArNjA4MCw5IEBAIHN0YXRpYyB2b2lkIHN0b3BfZGlzY292
ZXJ5X2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQog
CiBzdGF0aWMgaW50IHN0b3BfZGlzY292ZXJ5X3N5bmMoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZv
aWQgKmRhdGEpCiB7CisJaWYgKCFtZ210X3BlbmRpbmdfdmFsaWQoaGRldiwgZGF0YSwgZmFsc2Up
KQorCQlyZXR1cm4gLUVDQU5DRUxFRDsKKwogCXJldHVybiBoY2lfc3RvcF9kaXNjb3Zlcnlfc3lu
YyhoZGV2KTsKIH0KIApAQCAtNjIzMiwxNCArNjI5MiwxOCBAQCBzdGF0aWMgdm9pZCBlbmFibGVf
YWR2ZXJ0aXNpbmdfaW5zdGFuY2Uoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGludCBlcnIpCiAKIHN0
YXRpYyB2b2lkIHNldF9hZHZlcnRpc2luZ19jb21wbGV0ZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwg
dm9pZCAqZGF0YSwgaW50IGVycikKIHsKKwlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0g
ZGF0YTsKIAlzdHJ1Y3QgY21kX2xvb2t1cCBtYXRjaCA9IHsgTlVMTCwgaGRldiB9OwogCXU4IGlu
c3RhbmNlOwogCXN0cnVjdCBhZHZfaW5mbyAqYWR2X2luc3RhbmNlOwogCXU4IHN0YXR1cyA9IG1n
bXRfc3RhdHVzKGVycik7CiAKKwlpZiAoZXJyID09IC1FQ0FOQ0VMRUQgfHwgIW1nbXRfcGVuZGlu
Z192YWxpZChoZGV2LCBkYXRhLCB0cnVlKSkKKwkJcmV0dXJuOworCiAJaWYgKHN0YXR1cykgewot
CQltZ210X3BlbmRpbmdfZm9yZWFjaChNR01UX09QX1NFVF9BRFZFUlRJU0lORywgaGRldiwgdHJ1
ZSwKLQkJCQkgICAgIGNtZF9zdGF0dXNfcnNwLCAmc3RhdHVzKTsKKwkJbWdtdF9jbWRfc3RhdHVz
KGNtZC0+c2ssIGNtZC0+aGRldi0+aWQsIGNtZC0+b3Bjb2RlLCBzdGF0dXMpOworCQltZ210X3Bl
bmRpbmdfZnJlZShjbWQpOwogCQlyZXR1cm47CiAJfQogCkBAIC02MjQ4LDggKzYzMTIsNyBAQCBz
dGF0aWMgdm9pZCBzZXRfYWR2ZXJ0aXNpbmdfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IHZvaWQgKmRhdGEsIGludCBlcnIpCiAJZWxzZQogCQloY2lfZGV2X2NsZWFyX2ZsYWcoaGRldiwg
SENJX0FEVkVSVElTSU5HKTsKIAotCW1nbXRfcGVuZGluZ19mb3JlYWNoKE1HTVRfT1BfU0VUX0FE
VkVSVElTSU5HLCBoZGV2LCB0cnVlLCBzZXR0aW5nc19yc3AsCi0JCQkgICAgICZtYXRjaCk7CisJ
c2V0dGluZ3NfcnNwKGNtZCwgJm1hdGNoKTsKIAogCW5ld19zZXR0aW5ncyhoZGV2LCBtYXRjaC5z
ayk7CiAKQEAgLTYyODEsOCArNjM0NCwxNCBAQCBzdGF0aWMgdm9pZCBzZXRfYWR2ZXJ0aXNpbmdf
Y29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsIGludCBlcnIpCiBzdGF0
aWMgaW50IHNldF9hZHZfc3luYyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSkKIHsK
IAlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kID0gZGF0YTsKLQlzdHJ1Y3QgbWdtdF9tb2Rl
ICpjcCA9IGNtZC0+cGFyYW07Ci0JdTggdmFsID0gISFjcC0+dmFsOworCXN0cnVjdCBtZ210X21v
ZGUgKmNwOworCXU4IHZhbDsKKworCWlmICghbWdtdF9wZW5kaW5nX3ZhbGlkKGhkZXYsIGNtZCwg
ZmFsc2UpKQorCQlyZXR1cm4gLUVDQU5DRUxFRDsKKworCWNwID0gY21kLT5wYXJhbTsKKwl2YWwg
PSAhIWNwLT52YWw7CiAKIAlpZiAoY3AtPnZhbCA9PSAweDAyKQogCQloY2lfZGV2X3NldF9mbGFn
KGhkZXYsIEhDSV9BRFZFUlRJU0lOR19DT05ORUNUQUJMRSk7CkBAIC04MDM3LDEwICs4MTA2LDYg
QEAgc3RhdGljIHZvaWQgcmVhZF9sb2NhbF9vb2JfZXh0X2RhdGFfY29tcGxldGUoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJdTggc3RhdHVzID0gbWdtdF9zdGF0dXMoZXJyKTsK
IAl1MTYgZWlyX2xlbjsKIAotCWlmIChlcnIgPT0gLUVDQU5DRUxFRCB8fAotCSAgICBjbWQgIT0g
cGVuZGluZ19maW5kKE1HTVRfT1BfUkVBRF9MT0NBTF9PT0JfRVhUX0RBVEEsIGhkZXYpKQotCQly
ZXR1cm47Ci0KIAlpZiAoIXN0YXR1cykgewogCQlpZiAoIXNrYikKIAkJCXN0YXR1cyA9IE1HTVRf
U1RBVFVTX0ZBSUxFRDsKQEAgLTgxNDcsNyArODIxMiw3IEBAIHN0YXRpYyB2b2lkIHJlYWRfbG9j
YWxfb29iX2V4dF9kYXRhX2NvbXBsZXRlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRh
LAogCQlrZnJlZV9za2Ioc2tiKTsKIAogCWtmcmVlKG1nbXRfcnApOwotCW1nbXRfcGVuZGluZ19y
ZW1vdmUoY21kKTsKKwltZ210X3BlbmRpbmdfZnJlZShjbWQpOwogfQogCiBzdGF0aWMgaW50IHJl
YWRfbG9jYWxfc3NwX29vYl9yZXEoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBzb2NrICpz
aywKQEAgLTgxNTYsNyArODIyMSw3IEBAIHN0YXRpYyBpbnQgcmVhZF9sb2NhbF9zc3Bfb29iX3Jl
cShzdHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IHNvY2sgKnNrLAogCXN0cnVjdCBtZ210X3Bl
bmRpbmdfY21kICpjbWQ7CiAJaW50IGVycjsKIAotCWNtZCA9IG1nbXRfcGVuZGluZ19hZGQoc2ss
IE1HTVRfT1BfUkVBRF9MT0NBTF9PT0JfRVhUX0RBVEEsIGhkZXYsCisJY21kID0gbWdtdF9wZW5k
aW5nX25ldyhzaywgTUdNVF9PUF9SRUFEX0xPQ0FMX09PQl9FWFRfREFUQSwgaGRldiwKIAkJCSAg
ICAgICBjcCwgc2l6ZW9mKCpjcCkpOwogCWlmICghY21kKQogCQlyZXR1cm4gLUVOT01FTTsKZGlm
ZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdtdF91dGlsLmMgYi9uZXQvYmx1ZXRvb3RoL21nbXRf
dXRpbC5jCmluZGV4IGE4OGEwN2RhMzk0Ny4uYmU2ZDliOGRiNTFiIDEwMDY0NAotLS0gYS9uZXQv
Ymx1ZXRvb3RoL21nbXRfdXRpbC5jCisrKyBiL25ldC9ibHVldG9vdGgvbWdtdF91dGlsLmMKQEAg
LTMyMCw2ICszMjAsMjkgQEAgdm9pZCBtZ210X3BlbmRpbmdfcmVtb3ZlKHN0cnVjdCBtZ210X3Bl
bmRpbmdfY21kICpjbWQpCiAJbWdtdF9wZW5kaW5nX2ZyZWUoY21kKTsKIH0KIAorYm9vbCBtZ210
X3BlbmRpbmdfdmFsaWQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBtZ210X3BlbmRpbmdf
Y21kICpjbWQsCisJCQlib29sIHJlbW92ZSkKK3sKKwlzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAq
dG1wOworCisJaWYgKCFjbWQpCisJCXJldHVybiBmYWxzZTsKKworCW11dGV4X2xvY2soJmhkZXYt
Pm1nbXRfcGVuZGluZ19sb2NrKTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wLCAmaGRldi0+
bWdtdF9wZW5kaW5nLCBsaXN0KSB7CisJCWlmIChjbWQgPT0gdG1wKSB7CisJCQlpZiAocmVtb3Zl
KQorCQkJCWxpc3RfZGVsKCZjbWQtPmxpc3QpOworCQkJbXV0ZXhfdW5sb2NrKCZoZGV2LT5tZ210
X3BlbmRpbmdfbG9jayk7CisJCQlyZXR1cm4gdHJ1ZTsKKwkJfQorCX0KKworCW11dGV4X3VubG9j
aygmaGRldi0+bWdtdF9wZW5kaW5nX2xvY2spOworCXJldHVybiBmYWxzZTsKK30KKwogdm9pZCBt
Z210X21lc2hfZm9yZWFjaChzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIAkJICAgICAgIHZvaWQgKCpj
Yikoc3RydWN0IG1nbXRfbWVzaF90eCAqbWVzaF90eCwgdm9pZCAqZGF0YSksCiAJCSAgICAgICB2
b2lkICpkYXRhLCBzdHJ1Y3Qgc29jayAqc2spCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL21n
bXRfdXRpbC5oIGIvbmV0L2JsdWV0b290aC9tZ210X3V0aWwuaAppbmRleCAwMjRlNTFkZDY5Mzcu
LjVhZWJhNGM3YjA3ZiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9tZ210X3V0aWwuaAorKysg
Yi9uZXQvYmx1ZXRvb3RoL21nbXRfdXRpbC5oCkBAIC02NSw2ICs2NSw4IEBAIHN0cnVjdCBtZ210
X3BlbmRpbmdfY21kICptZ210X3BlbmRpbmdfbmV3KHN0cnVjdCBzb2NrICpzaywgdTE2IG9wY29k
ZSwKIAkJCQkJICB2b2lkICpkYXRhLCB1MTYgbGVuKTsKIHZvaWQgbWdtdF9wZW5kaW5nX2ZyZWUo
c3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCk7CiB2b2lkIG1nbXRfcGVuZGluZ19yZW1vdmUo
c3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCk7Citib29sIG1nbXRfcGVuZGluZ192YWxpZChz
dHJ1Y3QgaGNpX2RldiAqaGRldiwgc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCwKKwkJCWJv
b2wgcmVtb3ZlKTsKIHZvaWQgbWdtdF9tZXNoX2ZvcmVhY2goc3RydWN0IGhjaV9kZXYgKmhkZXYs
CiAJCSAgICAgICB2b2lkICgqY2IpKHN0cnVjdCBtZ210X21lc2hfdHggKm1lc2hfdHgsIHZvaWQg
KmRhdGEpLAogCQkgICAgICAgdm9pZCAqZGF0YSwgc3RydWN0IHNvY2sgKnNrKTsKLS0gCjIuNTEu
MAoK
--000000000000f09a48063ed967b3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v6-0001-Bluetooth-hci_event-Fix-UAF-in-hci_conn_tx_dequeu.patch"
Content-Disposition: attachment; 
	filename="v6-0001-Bluetooth-hci_event-Fix-UAF-in-hci_conn_tx_dequeu.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mflc0kb92>
X-Attachment-Id: f_mflc0kb92

RnJvbSBlZDIxYTc5YjMwNGY0M2E3MGVkNjZmZjY3ZDNkZDA4YWY5MDExY2JjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMjUgQXVnIDIwMjUgMTA6Mjc6MjkgLTA0MDAKU3ViamVj
dDogW1BBVENIIHY2IDEvM10gQmx1ZXRvb3RoOiBoY2lfZXZlbnQ6IEZpeCBVQUYgaW4gaGNpX2Nv
bm5fdHhfZGVxdWV1ZQoKVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIFVBRiBjYXVzZWQgYnkgbm90
IHByb3Blcmx5IGxvY2tpbmcgaGRldiB3aGVuCnByb2Nlc3NpbmcgSENJX0VWX05VTV9DT01QX1BL
VFM6CgpCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIGhjaV9jb25uX3R4X2RlcXVl
dWUrMHgxYmUvMHgyMjAgbmV0L2JsdWV0b290aC9oY2lfY29ubi5jOjMwMzYKUmVhZCBvZiBzaXpl
IDQgYXQgYWRkciBmZmZmODg4MDc0MGYwOTQwIGJ5IHRhc2sga3dvcmtlci91MTE6MC81NAoKQ1BV
OiAxIFVJRDogMCBQSUQ6IDU0IENvbW06IGt3b3JrZXIvdTExOjAgTm90IHRhaW50ZWQgNi4xNi4w
LXJjNyAjMyBQUkVFTVBUKGZ1bGwpCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0
NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTAuMi0xdWJ1bnR1MSAwNC8wMS8yMDE0Cldvcmtx
dWV1ZTogaGNpMSBoY2lfcnhfd29yawpDYWxsIFRyYWNlOgogPFRBU0s+CiBkdW1wX3N0YWNrX2x2
bCsweDE4OS8weDI1MCBsaWIvZHVtcF9zdGFjay5jOjEyMAogcHJpbnRfYWRkcmVzc19kZXNjcmlw
dGlvbiBtbS9rYXNhbi9yZXBvcnQuYzozNzggW2lubGluZV0KIHByaW50X3JlcG9ydCsweGNhLzB4
MjMwIG1tL2thc2FuL3JlcG9ydC5jOjQ4MAoga2FzYW5fcmVwb3J0KzB4MTE4LzB4MTUwIG1tL2th
c2FuL3JlcG9ydC5jOjU5MwogaGNpX2Nvbm5fdHhfZGVxdWV1ZSsweDFiZS8weDIyMCBuZXQvYmx1
ZXRvb3RoL2hjaV9jb25uLmM6MzAzNgogaGNpX251bV9jb21wX3BrdHNfZXZ0KzB4MWM4LzB4YTUw
IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NDQwNAogaGNpX2V2ZW50X2Z1bmMgbmV0L2JsdWV0
b290aC9oY2lfZXZlbnQuYzo3NDc3IFtpbmxpbmVdCiBoY2lfZXZlbnRfcGFja2V0KzB4N2UwLzB4
MTIwMCBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjc1MzEKIGhjaV9yeF93b3JrKzB4NDZhLzB4
ZTgwIG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzo0MDcwCiBwcm9jZXNzX29uZV93b3JrIGtlcm5l
bC93b3JrcXVldWUuYzozMjM4IFtpbmxpbmVdCiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGFl
MS8weDE3YjAga2VybmVsL3dvcmtxdWV1ZS5jOjMzMjEKIHdvcmtlcl90aHJlYWQrMHg4YTAvMHhk
YTAga2VybmVsL3dvcmtxdWV1ZS5jOjM0MDIKIGt0aHJlYWQrMHg3MGUvMHg4YTAga2VybmVsL2t0
aHJlYWQuYzo0NjQKIHJldF9mcm9tX2ZvcmsrMHgzZmMvMHg3NzAgYXJjaC94ODYva2VybmVsL3By
b2Nlc3MuYzoxNDgKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBob21lL2t3cWNoZWlpL3Nv
dXJjZS9mdXp6aW5nL2tlcm5lbC9rYXNhbi9saW51eC02LjE2LXJjNy9hcmNoL3g4Ni9lbnRyeS9l
bnRyeV82NC5TOjI0NQogPC9UQVNLPgoKQWxsb2NhdGVkIGJ5IHRhc2sgNTQ6CiBrYXNhbl9zYXZl
X3N0YWNrIG1tL2thc2FuL2NvbW1vbi5jOjQ3IFtpbmxpbmVdCiBrYXNhbl9zYXZlX3RyYWNrKzB4
M2UvMHg4MCBtbS9rYXNhbi9jb21tb24uYzo2OAogcG9pc29uX2ttYWxsb2NfcmVkem9uZSBtbS9r
YXNhbi9jb21tb24uYzozNzcgW2lubGluZV0KIF9fa2FzYW5fa21hbGxvYysweDkzLzB4YjAgbW0v
a2FzYW4vY29tbW9uLmM6Mzk0CiBrYXNhbl9rbWFsbG9jIGluY2x1ZGUvbGludXgva2FzYW4uaDoy
NjAgW2lubGluZV0KIF9fa21hbGxvY19jYWNoZV9ub3Byb2YrMHgyMzAvMHgzZDAgbW0vc2x1Yi5j
OjQzNTkKIGttYWxsb2Nfbm9wcm9mIGluY2x1ZGUvbGludXgvc2xhYi5oOjkwNSBbaW5saW5lXQog
a3phbGxvY19ub3Byb2YgaW5jbHVkZS9saW51eC9zbGFiLmg6MTAzOSBbaW5saW5lXQogX19oY2lf
Y29ubl9hZGQrMHgyMzMvMHgxYjMwIG5ldC9ibHVldG9vdGgvaGNpX2Nvbm4uYzo5MzkKIGxlX2Nv
bm5fY29tcGxldGVfZXZ0KzB4M2Q2LzB4MTIyMCBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjU2
MjgKIGhjaV9sZV9lbmhfY29ubl9jb21wbGV0ZV9ldnQrMHgxODkvMHg0NzAgbmV0L2JsdWV0b290
aC9oY2lfZXZlbnQuYzo1Nzk0CiBoY2lfZXZlbnRfZnVuYyBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVu
dC5jOjc0NzQgW2lubGluZV0KIGhjaV9ldmVudF9wYWNrZXQrMHg3OGMvMHgxMjAwIG5ldC9ibHVl
dG9vdGgvaGNpX2V2ZW50LmM6NzUzMQogaGNpX3J4X3dvcmsrMHg0NmEvMHhlODAgbmV0L2JsdWV0
b290aC9oY2lfY29yZS5jOjQwNzAKIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dvcmtxdWV1ZS5j
OjMyMzggW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YWUxLzB4MTdiMCBrZXJu
ZWwvd29ya3F1ZXVlLmM6MzMyMQogd29ya2VyX3RocmVhZCsweDhhMC8weGRhMCBrZXJuZWwvd29y
a3F1ZXVlLmM6MzQwMgoga3RocmVhZCsweDcwZS8weDhhMCBrZXJuZWwva3RocmVhZC5jOjQ2NAog
cmV0X2Zyb21fZm9yaysweDNmYy8weDc3MCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0OAog
cmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGhvbWUva3dxY2hlaWkvc291cmNlL2Z1enppbmcv
a2VybmVsL2thc2FuL2xpbnV4LTYuMTYtcmM3L2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ1
CgpGcmVlZCBieSB0YXNrIDk1NzI6CiBrYXNhbl9zYXZlX3N0YWNrIG1tL2thc2FuL2NvbW1vbi5j
OjQ3IFtpbmxpbmVdCiBrYXNhbl9zYXZlX3RyYWNrKzB4M2UvMHg4MCBtbS9rYXNhbi9jb21tb24u
Yzo2OAoga2FzYW5fc2F2ZV9mcmVlX2luZm8rMHg0Ni8weDUwIG1tL2thc2FuL2dlbmVyaWMuYzo1
NzYKIHBvaXNvbl9zbGFiX29iamVjdCBtbS9rYXNhbi9jb21tb24uYzoyNDcgW2lubGluZV0KIF9f
a2FzYW5fc2xhYl9mcmVlKzB4NjIvMHg3MCBtbS9rYXNhbi9jb21tb24uYzoyNjQKIGthc2FuX3Ns
YWJfZnJlZSBpbmNsdWRlL2xpbnV4L2thc2FuLmg6MjMzIFtpbmxpbmVdCiBzbGFiX2ZyZWVfaG9v
ayBtbS9zbHViLmM6MjM4MSBbaW5saW5lXQogc2xhYl9mcmVlIG1tL3NsdWIuYzo0NjQzIFtpbmxp
bmVdCiBrZnJlZSsweDE4ZS8weDQ0MCBtbS9zbHViLmM6NDg0MgogZGV2aWNlX3JlbGVhc2UrMHg5
Yy8weDFjMAoga29iamVjdF9jbGVhbnVwIGxpYi9rb2JqZWN0LmM6Njg5IFtpbmxpbmVdCiBrb2Jq
ZWN0X3JlbGVhc2UgbGliL2tvYmplY3QuYzo3MjAgW2lubGluZV0KIGtyZWZfcHV0IGluY2x1ZGUv
bGludXgva3JlZi5oOjY1IFtpbmxpbmVdCiBrb2JqZWN0X3B1dCsweDIyYi8weDQ4MCBsaWIva29i
amVjdC5jOjczNwogaGNpX2Nvbm5fY2xlYW51cCBuZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmM6MTc1
IFtpbmxpbmVdCiBoY2lfY29ubl9kZWwrMHg4ZmYvMHhjYjAgbmV0L2JsdWV0b290aC9oY2lfY29u
bi5jOjExNzMKIGhjaV9hYm9ydF9jb25uX3N5bmMrMHg1ZDEvMHhkZjAgbmV0L2JsdWV0b290aC9o
Y2lfc3luYy5jOjU2ODkKIGhjaV9jbWRfc3luY193b3JrKzB4MjEwLzB4M2EwIG5ldC9ibHVldG9v
dGgvaGNpX3N5bmMuYzozMzIKIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dvcmtxdWV1ZS5jOjMy
MzggW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YWUxLzB4MTdiMCBrZXJuZWwv
d29ya3F1ZXVlLmM6MzMyMQogd29ya2VyX3RocmVhZCsweDhhMC8weGRhMCBrZXJuZWwvd29ya3F1
ZXVlLmM6MzQwMgoga3RocmVhZCsweDcwZS8weDhhMCBrZXJuZWwva3RocmVhZC5jOjQ2NAogcmV0
X2Zyb21fZm9yaysweDNmYy8weDc3MCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0OAogcmV0
X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGhvbWUva3dxY2hlaWkvc291cmNlL2Z1enppbmcva2Vy
bmVsL2thc2FuL2xpbnV4LTYuMTYtcmM3L2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ1CgpG
aXhlczogMTM0ZjRiMzlkZjdiICgiQmx1ZXRvb3RoOiBhZGQgc3VwcG9ydCBmb3Igc2tiIFRYIFNO
RC9DT01QTEVUSU9OIHRpbWVzdGFtcGluZyIpClJlcG9ydGVkLWJ5OiBKdW52eXlhbmcsIFRlbmNl
bnQgWmh1cXVlIExhYiA8emh1cXVlQHRlbmNlbnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogbmV0L2JsdWV0
b290aC9oY2lfZXZlbnQuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgYi9uZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jCmluZGV4IDU3MWI3Y2EwMTFjMi4uYWJiMTdkYWRmMDNjIDEwMDY0NAotLS0g
YS9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jCisrKyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50
LmMKQEAgLTQzOTEsNiArNDM5MSw4IEBAIHN0YXRpYyB2b2lkIGhjaV9udW1fY29tcF9wa3RzX2V2
dChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAogCWJ0X2Rldl9kYmcoaGRldiwg
Im51bSAlZCIsIGV2LT5udW0pOwogCisJaGNpX2Rldl9sb2NrKGhkZXYpOworCiAJZm9yIChpID0g
MDsgaSA8IGV2LT5udW07IGkrKykgewogCQlzdHJ1Y3QgaGNpX2NvbXBfcGt0c19pbmZvICppbmZv
ID0gJmV2LT5oYW5kbGVzW2ldOwogCQlzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm47CkBAIC00NDYyLDYg
KzQ0NjQsOCBAQCBzdGF0aWMgdm9pZCBoY2lfbnVtX2NvbXBfcGt0c19ldnQoc3RydWN0IGhjaV9k
ZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJfQogCiAJcXVldWVfd29yayhoZGV2LT53b3JrcXVldWUs
ICZoZGV2LT50eF93b3JrKTsKKworCWhjaV9kZXZfdW5sb2NrKGhkZXYpOwogfQogCiBzdGF0aWMg
dm9pZCBoY2lfbW9kZV9jaGFuZ2VfZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRh
LAotLSAKMi41MS4wCgo=
--000000000000f09a48063ed967b3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v6-0002-Bluetooth-hci_event-Fix-UAF-in-hci_acl_create_con.patch"
Content-Disposition: attachment; 
	filename="v6-0002-Bluetooth-hci_event-Fix-UAF-in-hci_acl_create_con.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mflc0kb61>
X-Attachment-Id: f_mflc0kb61

RnJvbSBkMTYxNDZjOTZiOTllYmFkZDYxOTI3NjJmMGMzZDcyMzhjNTkxNWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IE1vbiwgMjUgQXVnIDIwMjUgMTE6MTA6MjAgLTA0MDAKU3ViamVj
dDogW1BBVENIIHY2IDIvM10gQmx1ZXRvb3RoOiBoY2lfZXZlbnQ6IEZpeCBVQUYgaW4KIGhjaV9h
Y2xfY3JlYXRlX2Nvbm5fc3luYwoKVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIFVGQSBpbiBoY2lf
YWNsX2NyZWF0ZV9jb25uX3N5bmMgd2hlcmUgYQpjb25uZWN0aW9uIHN0aWxsIHBlbmRpbmcgaXMg
Y29tbWFuZCBzdWJtaXNzaW9uIChjb25uLT5zdGF0ZSA9PSBCVF9PUEVOKQptYXliZSBmcmVlZCwg
YWxzbyBzaW5jZSB0aGlzIGFsc28gY2FuIGhhcHBlbiB3aXRoIHRoZSBsaWtlcyBvZgpoY2lfbGVf
Y3JlYXRlX2Nvbm5fc3luYyBmaXggaXQgYXMgd2VsbDoKCkJVRzogS0FTQU46IHNsYWItdXNlLWFm
dGVyLWZyZWUgaW4gaGNpX2FjbF9jcmVhdGVfY29ubl9zeW5jKzB4NWVmLzB4NzkwIG5ldC9ibHVl
dG9vdGgvaGNpX3N5bmMuYzo2ODYxCldyaXRlIG9mIHNpemUgMiBhdCBhZGRyIGZmZmY4ODgwNWZm
Y2MwMzggYnkgdGFzayBrd29ya2VyL3UxMToyLzk1NDEKCkNQVTogMSBVSUQ6IDAgUElEOiA5NTQx
IENvbW06IGt3b3JrZXIvdTExOjIgTm90IHRhaW50ZWQgNi4xNi4wLXJjNyAjMyBQUkVFTVBUKGZ1
bGwpCkhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYp
LCBCSU9TIDEuMTAuMi0xdWJ1bnR1MSAwNC8wMS8yMDE0CldvcmtxdWV1ZTogaGNpMyBoY2lfY21k
X3N5bmNfd29yawpDYWxsIFRyYWNlOgogPFRBU0s+CiBkdW1wX3N0YWNrX2x2bCsweDE4OS8weDI1
MCBsaWIvZHVtcF9zdGFjay5jOjEyMAogcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbiBtbS9rYXNh
bi9yZXBvcnQuYzozNzggW2lubGluZV0KIHByaW50X3JlcG9ydCsweGNhLzB4MjMwIG1tL2thc2Fu
L3JlcG9ydC5jOjQ4MAoga2FzYW5fcmVwb3J0KzB4MTE4LzB4MTUwIG1tL2thc2FuL3JlcG9ydC5j
OjU5MwogaGNpX2FjbF9jcmVhdGVfY29ubl9zeW5jKzB4NWVmLzB4NzkwIG5ldC9ibHVldG9vdGgv
aGNpX3N5bmMuYzo2ODYxCiBoY2lfY21kX3N5bmNfd29yaysweDIxMC8weDNhMCBuZXQvYmx1ZXRv
b3RoL2hjaV9zeW5jLmM6MzMyCiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVldWUuYzoz
MjM4IFtpbmxpbmVdCiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGFlMS8weDE3YjAga2VybmVs
L3dvcmtxdWV1ZS5jOjMzMjEKIHdvcmtlcl90aHJlYWQrMHg4YTAvMHhkYTAga2VybmVsL3dvcmtx
dWV1ZS5jOjM0MDIKIGt0aHJlYWQrMHg3MGUvMHg4YTAga2VybmVsL2t0aHJlYWQuYzo0NjQKIHJl
dF9mcm9tX2ZvcmsrMHgzZmMvMHg3NzAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDgKIHJl
dF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBob21lL2t3cWNoZWlpL3NvdXJjZS9mdXp6aW5nL2tl
cm5lbC9rYXNhbi9saW51eC02LjE2LXJjNy9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI0NQog
PC9UQVNLPgoKQWxsb2NhdGVkIGJ5IHRhc2sgMTIzNzM2Ogoga2FzYW5fc2F2ZV9zdGFjayBtbS9r
YXNhbi9jb21tb24uYzo0NyBbaW5saW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNlLzB4ODAgbW0v
a2FzYW4vY29tbW9uLmM6NjgKIHBvaXNvbl9rbWFsbG9jX3JlZHpvbmUgbW0va2FzYW4vY29tbW9u
LmM6Mzc3IFtpbmxpbmVdCiBfX2thc2FuX2ttYWxsb2MrMHg5My8weGIwIG1tL2thc2FuL2NvbW1v
bi5jOjM5NAoga2FzYW5fa21hbGxvYyBpbmNsdWRlL2xpbnV4L2thc2FuLmg6MjYwIFtpbmxpbmVd
CiBfX2ttYWxsb2NfY2FjaGVfbm9wcm9mKzB4MjMwLzB4M2QwIG1tL3NsdWIuYzo0MzU5CiBrbWFs
bG9jX25vcHJvZiBpbmNsdWRlL2xpbnV4L3NsYWIuaDo5MDUgW2lubGluZV0KIGt6YWxsb2Nfbm9w
cm9mIGluY2x1ZGUvbGludXgvc2xhYi5oOjEwMzkgW2lubGluZV0KIF9faGNpX2Nvbm5fYWRkKzB4
MjMzLzB4MWIzMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmM6OTM5CiBoY2lfY29ubl9hZGRfdW5z
ZXQgbmV0L2JsdWV0b290aC9oY2lfY29ubi5jOjEwNTEgW2lubGluZV0KIGhjaV9jb25uZWN0X2Fj
bCsweDE2Yy8weDRlMCBuZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmM6MTYzNAogcGFpcl9kZXZpY2Ur
MHg0MTgvMHhhNzAgbmV0L2JsdWV0b290aC9tZ210LmM6MzU1NgogaGNpX21nbXRfY21kKzB4OWM5
LzB4ZWYwIG5ldC9ibHVldG9vdGgvaGNpX3NvY2suYzoxNzE5CiBoY2lfc29ja19zZW5kbXNnKzB4
NmNhLzB4ZWYwIG5ldC9ibHVldG9vdGgvaGNpX3NvY2suYzoxODM5CiBzb2NrX3NlbmRtc2dfbm9z
ZWMgbmV0L3NvY2tldC5jOjcxMiBbaW5saW5lXQogX19zb2NrX3NlbmRtc2crMHgyMTkvMHgyNzAg
bmV0L3NvY2tldC5jOjcyNwogc29ja193cml0ZV9pdGVyKzB4MjU4LzB4MzMwIG5ldC9zb2NrZXQu
YzoxMTMxCiBuZXdfc3luY193cml0ZSBmcy9yZWFkX3dyaXRlLmM6NTkzIFtpbmxpbmVdCiB2ZnNf
d3JpdGUrMHg1NGIvMHhhOTAgZnMvcmVhZF93cml0ZS5jOjY4Ngoga3N5c193cml0ZSsweDE0NS8w
eDI1MCBmcy9yZWFkX3dyaXRlLmM6NzM4CiBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9z
eXNjYWxsXzY0LmM6NjMgW2lubGluZV0KIGRvX3N5c2NhbGxfNjQrMHhmYS8weDNiMCBhcmNoL3g4
Ni9lbnRyeS9zeXNjYWxsXzY0LmM6OTQKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDc3LzB4N2YKCkZyZWVkIGJ5IHRhc2sgMTAzNjgwOgoga2FzYW5fc2F2ZV9zdGFjayBtbS9rYXNh
bi9jb21tb24uYzo0NyBbaW5saW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNlLzB4ODAgbW0va2Fz
YW4vY29tbW9uLmM6NjgKIGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4NDYvMHg1MCBtbS9rYXNhbi9n
ZW5lcmljLmM6NTc2CiBwb2lzb25fc2xhYl9vYmplY3QgbW0va2FzYW4vY29tbW9uLmM6MjQ3IFtp
bmxpbmVdCiBfX2thc2FuX3NsYWJfZnJlZSsweDYyLzB4NzAgbW0va2FzYW4vY29tbW9uLmM6MjY0
CiBrYXNhbl9zbGFiX2ZyZWUgaW5jbHVkZS9saW51eC9rYXNhbi5oOjIzMyBbaW5saW5lXQogc2xh
Yl9mcmVlX2hvb2sgbW0vc2x1Yi5jOjIzODEgW2lubGluZV0KIHNsYWJfZnJlZSBtbS9zbHViLmM6
NDY0MyBbaW5saW5lXQoga2ZyZWUrMHgxOGUvMHg0NDAgbW0vc2x1Yi5jOjQ4NDIKIGRldmljZV9y
ZWxlYXNlKzB4OWMvMHgxYzAKIGtvYmplY3RfY2xlYW51cCBsaWIva29iamVjdC5jOjY4OSBbaW5s
aW5lXQoga29iamVjdF9yZWxlYXNlIGxpYi9rb2JqZWN0LmM6NzIwIFtpbmxpbmVdCiBrcmVmX3B1
dCBpbmNsdWRlL2xpbnV4L2tyZWYuaDo2NSBbaW5saW5lXQoga29iamVjdF9wdXQrMHgyMmIvMHg0
ODAgbGliL2tvYmplY3QuYzo3MzcKIGhjaV9jb25uX2NsZWFudXAgbmV0L2JsdWV0b290aC9oY2lf
Y29ubi5jOjE3NSBbaW5saW5lXQogaGNpX2Nvbm5fZGVsKzB4OGZmLzB4Y2IwIG5ldC9ibHVldG9v
dGgvaGNpX2Nvbm4uYzoxMTczCiBoY2lfY29ubl9jb21wbGV0ZV9ldnQrMHgzYzcvMHgxMDQwIG5l
dC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6MzE5OQogaGNpX2V2ZW50X2Z1bmMgbmV0L2JsdWV0b290
aC9oY2lfZXZlbnQuYzo3NDc3IFtpbmxpbmVdCiBoY2lfZXZlbnRfcGFja2V0KzB4N2UwLzB4MTIw
MCBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjc1MzEKIGhjaV9yeF93b3JrKzB4NDZhLzB4ZTgw
IG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzo0MDcwCiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93
b3JrcXVldWUuYzozMjM4IFtpbmxpbmVdCiBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGFlMS8w
eDE3YjAga2VybmVsL3dvcmtxdWV1ZS5jOjMzMjEKIHdvcmtlcl90aHJlYWQrMHg4YTAvMHhkYTAg
a2VybmVsL3dvcmtxdWV1ZS5jOjM0MDIKIGt0aHJlYWQrMHg3MGUvMHg4YTAga2VybmVsL2t0aHJl
YWQuYzo0NjQKIHJldF9mcm9tX2ZvcmsrMHgzZmMvMHg3NzAgYXJjaC94ODYva2VybmVsL3Byb2Nl
c3MuYzoxNDgKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBob21lL2t3cWNoZWlpL3NvdXJj
ZS9mdXp6aW5nL2tlcm5lbC9rYXNhbi9saW51eC02LjE2LXJjNy9hcmNoL3g4Ni9lbnRyeS9lbnRy
eV82NC5TOjI0NQoKTGFzdCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3JlYXRpb246CiBrYXNh
bl9zYXZlX3N0YWNrKzB4M2UvMHg2MCBtbS9rYXNhbi9jb21tb24uYzo0Nwoga2FzYW5fcmVjb3Jk
X2F1eF9zdGFjaysweGJkLzB4ZDAgbW0va2FzYW4vZ2VuZXJpYy5jOjU0OAogaW5zZXJ0X3dvcmsr
MHgzZC8weDMzMCBrZXJuZWwvd29ya3F1ZXVlLmM6MjE4MwogX19xdWV1ZV93b3JrKzB4YmQ5LzB4
ZmUwIGtlcm5lbC93b3JrcXVldWUuYzoyMzQ1CiBxdWV1ZV9kZWxheWVkX3dvcmtfb24rMHgxOGIv
MHgyODAga2VybmVsL3dvcmtxdWV1ZS5jOjI1NjEKIHBhaXJpbmdfY29tcGxldGUrMHgxZTcvMHgy
YjAgbmV0L2JsdWV0b290aC9tZ210LmM6MzQ1MQogcGFpcmluZ19jb21wbGV0ZV9jYisweDFhYy8w
eDIzMCBuZXQvYmx1ZXRvb3RoL21nbXQuYzozNDg3CiBoY2lfY29ubmVjdF9jZm0gaW5jbHVkZS9u
ZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmg6MjA2NCBbaW5saW5lXQogaGNpX2Nvbm5fZmFpbGVkKzB4
MjRkLzB4MzEwIG5ldC9ibHVldG9vdGgvaGNpX2Nvbm4uYzoxMjc1CiBoY2lfY29ubl9jb21wbGV0
ZV9ldnQrMHgzYzcvMHgxMDQwIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6MzE5OQogaGNpX2V2
ZW50X2Z1bmMgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzo3NDc3IFtpbmxpbmVdCiBoY2lfZXZl
bnRfcGFja2V0KzB4N2UwLzB4MTIwMCBuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjc1MzEKIGhj
aV9yeF93b3JrKzB4NDZhLzB4ZTgwIG5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzo0MDcwCiBwcm9j
ZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVldWUuYzozMjM4IFtpbmxpbmVdCiBwcm9jZXNzX3Nj
aGVkdWxlZF93b3JrcysweGFlMS8weDE3YjAga2VybmVsL3dvcmtxdWV1ZS5jOjMzMjEKIHdvcmtl
cl90aHJlYWQrMHg4YTAvMHhkYTAga2VybmVsL3dvcmtxdWV1ZS5jOjM0MDIKIGt0aHJlYWQrMHg3
MGUvMHg4YTAga2VybmVsL2t0aHJlYWQuYzo0NjQKIHJldF9mcm9tX2ZvcmsrMHgzZmMvMHg3NzAg
YXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDgKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgz
MCBob21lL2t3cWNoZWlpL3NvdXJjZS9mdXp6aW5nL2tlcm5lbC9rYXNhbi9saW51eC02LjE2LXJj
Ny9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI0NQoKRml4ZXM6IGFlZjJhYTRmYTk4ZSAoIkJs
dWV0b290aDogaGNpX2V2ZW50OiBGaXggY3JlYXRpbmcgaGNpX2Nvbm4gb2JqZWN0IG9uIGVycm9y
IHN0YXR1cyIpClJlcG9ydGVkLWJ5OiBKdW52eXlhbmcsIFRlbmNlbnQgWmh1cXVlIExhYiA8emh1
cXVlQHRlbmNlbnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxs
dWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9j
b3JlLmggfCAyMSArKysrKysrKysrKysrKysrKysrKysKIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50
LmMgICAgICAgIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKystLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgNDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29y
ZS5oCmluZGV4IDY2NTIzYjc0ZjgyOC4uMjkyNGMyYmYyYTk4IDEwMDY0NAotLS0gYS9pbmNsdWRl
L25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaAorKysgYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNp
X2NvcmUuaApAQCAtMTI0Niw2ICsxMjQ2LDI3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGhjaV9j
b25uICpoY2lfY29ubl9oYXNoX2xvb2t1cF9iYShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKIAlyZXR1
cm4gTlVMTDsKIH0KIAorc3RhdGljIGlubGluZSBzdHJ1Y3QgaGNpX2Nvbm4gKmhjaV9jb25uX2hh
c2hfbG9va3VwX3JvbGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsCisJCQkJCQkJIF9fdTggdHlwZSwg
X191OCByb2xlLAorCQkJCQkJCSBiZGFkZHJfdCAqYmEpCit7CisJc3RydWN0IGhjaV9jb25uX2hh
c2ggKmggPSAmaGRldi0+Y29ubl9oYXNoOworCXN0cnVjdCBoY2lfY29ubiAgKmM7CisKKwlyY3Vf
cmVhZF9sb2NrKCk7CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShjLCAmaC0+bGlzdCwgbGlz
dCkgeworCQlpZiAoYy0+dHlwZSA9PSB0eXBlICYmIGMtPnJvbGUgPT0gcm9sZSAmJiAhYmFjbXAo
JmMtPmRzdCwgYmEpKSB7CisJCQlyY3VfcmVhZF91bmxvY2soKTsKKwkJCXJldHVybiBjOworCQl9
CisJfQorCisJcmN1X3JlYWRfdW5sb2NrKCk7CisKKwlyZXR1cm4gTlVMTDsKK30KKwogc3RhdGlj
IGlubGluZSBzdHJ1Y3QgaGNpX2Nvbm4gKmhjaV9jb25uX2hhc2hfbG9va3VwX2xlKHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LAogCQkJCQkJICAgICAgIGJkYWRkcl90ICpiYSwKIAkJCQkJCSAgICAgICBf
X3U4IGJhX3R5cGUpCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jIGIvbmV0
L2JsdWV0b290aC9oY2lfZXZlbnQuYwppbmRleCBhYmIxN2RhZGYwM2MuLmQ3OTBiMGQ0ZWI5YSAx
MDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYworKysgYi9uZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jCkBAIC0zMDg3LDggKzMwODcsMTggQEAgc3RhdGljIHZvaWQgaGNpX2Nvbm5f
Y29tcGxldGVfZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLAogCiAJaGNpX2Rl
dl9sb2NrKGhkZXYpOwogCisJLyogQ2hlY2sgZm9yIGV4aXN0aW5nIGNvbm5lY3Rpb246CisJICoK
KwkgKiAxLiBJZiBpdCBkb2Vzbid0IGV4aXN0IHRoZW4gaXQgbXVzdCBiZSByZWNlaXZlci9zbGF2
ZSByb2xlLgorCSAqIDIuIElmIGl0IGRvZXMgZXhpc3QgY29uZmlybSB0aGF0IGl0IGlzIGNvbm5l
Y3RpbmcvQlRfQ09OTkVDVCBpbiBjYXNlCisJICogICAgb2YgaW5pdGlhdG9yL21hc3RlciByb2xl
IHNpbmNlIHRoZXJlIGNvdWxkIGJlIGEgY29sbGlzaW9uIHdoZXJlCisJICogICAgZWl0aGVyIHNp
ZGUgaXMgYXR0ZW1wdGluZyB0byBjb25uZWN0IG9yIHNvbWV0aGluZyBsaWtlIGEgZnV6emluZwor
CSAqICAgIHRlc3RpbmcgaXMgdHJ5aW5nIHRvIHBsYXkgdHJpY2tzIHRvIGRlc3Ryb3kgdGhlIGhj
b24gb2JqZWN0IGJlZm9yZQorCSAqICAgIGl0IGV2ZW4gYXR0ZW1wdHMgdG8gY29ubmVjdCAoZS5n
LiBoY29uLT5zdGF0ZSA9PSBCVF9PUEVOKS4KKwkgKi8KIAljb25uID0gaGNpX2Nvbm5faGFzaF9s
b29rdXBfYmEoaGRldiwgZXYtPmxpbmtfdHlwZSwgJmV2LT5iZGFkZHIpOwotCWlmICghY29ubikg
eworCWlmICghY29ubiB8fAorCSAgICAoY29ubi0+cm9sZSA9PSBIQ0lfUk9MRV9NQVNURVIgJiYg
Y29ubi0+c3RhdGUgIT0gQlRfQ09OTkVDVCkpIHsKIAkJLyogSW4gY2FzZSBvZiBlcnJvciBzdGF0
dXMgYW5kIHRoZXJlIGlzIG5vIGNvbm5lY3Rpb24gcGVuZGluZwogCQkgKiBqdXN0IHVubG9jayBh
cyB0aGVyZSBpcyBub3RoaW5nIHRvIGNsZWFudXAuCiAJCSAqLwpAQCAtNTYyOCw4ICs1NjM4LDE4
IEBAIHN0YXRpYyB2b2lkIGxlX2Nvbm5fY29tcGxldGVfZXZ0KHN0cnVjdCBoY2lfZGV2ICpoZGV2
LCB1OCBzdGF0dXMsCiAJICovCiAJaGNpX2Rldl9jbGVhcl9mbGFnKGhkZXYsIEhDSV9MRV9BRFYp
OwogCi0JY29ubiA9IGhjaV9jb25uX2hhc2hfbG9va3VwX2JhKGhkZXYsIExFX0xJTkssIGJkYWRk
cik7Ci0JaWYgKCFjb25uKSB7CisJLyogQ2hlY2sgZm9yIGV4aXN0aW5nIGNvbm5lY3Rpb246CisJ
ICoKKwkgKiAxLiBJZiBpdCBkb2Vzbid0IGV4aXN0IHRoZW4gdXNlIHRoZSByb2xlIHRvIGNyZWF0
ZSBhIG5ldyBvYmplY3QuCisJICogMi4gSWYgaXQgZG9lcyBleGlzdCBjb25maXJtIHRoYXQgaXQg
aXMgY29ubmVjdGluZy9CVF9DT05ORUNUIGluIGNhc2UKKwkgKiAgICBvZiBpbml0aWF0b3IvbWFz
dGVyIHJvbGUgc2luY2UgdGhlcmUgY291bGQgYmUgYSBjb2xsaXNpb24gd2hlcmUKKwkgKiAgICBl
aXRoZXIgc2lkZSBpcyBhdHRlbXB0aW5nIHRvIGNvbm5lY3Qgb3Igc29tZXRoaW5nIGxpa2UgYSBm
dXp6aW5nCisJICogICAgdGVzdGluZyBpcyB0cnlpbmcgdG8gcGxheSB0cmlja3MgdG8gZGVzdHJv
eSB0aGUgaGNvbiBvYmplY3QgYmVmb3JlCisJICogICAgaXQgZXZlbiBhdHRlbXB0cyB0byBjb25u
ZWN0IChlLmcuIGhjb24tPnN0YXRlID09IEJUX09QRU4pLgorCSAqLworCWNvbm4gPSBoY2lfY29u
bl9oYXNoX2xvb2t1cF9yb2xlKGhkZXYsIExFX0xJTkssIHJvbGUsIGJkYWRkcik7CisJaWYgKCFj
b25uIHx8CisJICAgIChjb25uLT5yb2xlID09IEhDSV9ST0xFX01BU1RFUiAmJiBjb25uLT5zdGF0
ZSAhPSBCVF9DT05ORUNUKSkgewogCQkvKiBJbiBjYXNlIG9mIGVycm9yIHN0YXR1cyBhbmQgdGhl
cmUgaXMgbm8gY29ubmVjdGlvbiBwZW5kaW5nCiAJCSAqIGp1c3QgdW5sb2NrIGFzIHRoZXJlIGlz
IG5vdGhpbmcgdG8gY2xlYW51cC4KIAkJICovCi0tIAoyLjUxLjAKCg==
--000000000000f09a48063ed967b3--
