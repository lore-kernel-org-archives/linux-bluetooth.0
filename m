Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD17BA3;
	Thu,  3 Oct 2024 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986016; cv=none; b=h6KCkiD1xIXGEnApRurL5AzuejWrxbz1WRenQ20DReqaD7OnhZb3aAlTI95W/VpB443ULRZPLhIg/9nAwqeWw/8RHryWhTeF5KGqUs/D/NS3/C46WGSdpoqr3a7i9wUJSiugkRMpI5ppABjddxTuFMMfRmL87rsOhifgGpWUmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986016; c=relaxed/simple;
	bh=bCnLictlhBIPRVNLjxT8BBhviw5Ako2xKMMutbonf/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6boxTNmS2rwsdQ3ixq8Cgby9FPIswuTfN4H6nVwPAIvwSLllDFdhN/63l49SY1g4CzTi+kMN1NTOpLkslxvkxB5+D9rlPk0ZJyeD3ABX5GzPrDiNPXWfGh5uNclO/TF1prEmIKbSMkehqL8V4gMhXzTbdn3mDioN/2TE/pd270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haER7rpP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haER7rpP"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac49b17ebso11880391fa.0;
        Thu, 03 Oct 2024 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727986013; x=1728590813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG8GHLHLnk5O2D7naAH4k2TDEGBlQnCl1EkThLbLbfo=;
        b=haER7rpPHYYapJLAfnVQEVtA5yn8XUvkp0zK953+f6BLO1aVOOo3p7cLHbTRSnYt74
         4mj/bwwzN9MxkDTv+5E9CAieDMQlA2jzK4PsyGDEfte6aZMv6b6YEGhWcOkw0yLMavuf
         9pegq1kHd16yqTxlx5UJ9VJJ/Kv7wanjTzGKzdwKlSFSzITQVk3SnoGAwPuyeu/Lwfpe
         xiiGyJ+43R0y1H94QgD7/hFWYpPjsBWfwwXN05vlkSOoSFq6PVSIQhabi/KIyjFK2cNF
         fRahKTy02wN7wIqgAau3enisuBhyQKts4Lc23kG/Aj8mRlnrUc2oUvudYI+jzTFE8dB4
         Jetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986013; x=1728590813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG8GHLHLnk5O2D7naAH4k2TDEGBlQnCl1EkThLbLbfo=;
        b=odiVrybaRBR3rKWC2zoKBrfsGaWpeTGUqnLNY1aGVRcpLX3l0hVi/xSQO+ew2MbFxv
         meTU6LE2BSv5Za4h822u7NW/EefOsvA4hbWCjbXgARAbnz58Ft2/p3JzUh5mO7n297hl
         gJ2v6bGl2wogJfrXT67fzpzTI9vMrcPQmXFKYl0g09lYZ31oighwYc3b67R6z9ulmGs2
         IbSnEijf005TXTh9r8IFbDKwVX2pIgKwWITjLcWMES7WLQEPC2zs3Cz9K/3xj6OvI8td
         eXdzNNq6jAdUsyNq+j9pfluR8GNPOHA+Acg3kAEUpZXJHVjvzy3EFPDQG3aKzH6iJDUr
         WIKg==
X-Forwarded-Encrypted: i=1; AJvYcCV/06/pfiQEp4YovKVuS828y138s1dkf1T5X3NMg6rS3e2X2jmmgtsYEKac7psF18r4IxvfvoMvdslUvSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvKiU1i5SyWOqzqgG6NeQO7XKJGz1wBKBITGJ6bQdzgxsWZBo
	hkhggL9V2ZRXpqmUVrA7ktMfXc5Ktu0Nwat7K1bQpsa/nw7efIgvnCUHhMdrB6Epgzu25BTUswI
	UScjmMYzGzK2GwMjrMNV+mWArun02hA==
X-Google-Smtp-Source: AGHT+IEsV2DrzLNY/HqpeWIvRqyl8PbAuQTZC1Nqz9USnFbzYKqjzheuq4QDb8MKB2beEC7sCxMEKns3HckEx9IjSew=
X-Received: by 2002:a2e:4601:0:b0:2fa:d386:c8a4 with SMTP id
 38308e7fff4ca-2faf3c146demr976631fa.12.1727986012330; Thu, 03 Oct 2024
 13:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+=iNpM0TF4jDCqfJM4VWHY+CY5Vp1Ah91i8jGNKUeMKQ@mail.gmail.com>
 <66fef402.050a0220.9ec68.005b.GAE@google.com>
In-Reply-To: <66fef402.050a0220.9ec68.005b.GAE@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Oct 2024 16:06:39 -0400
Message-ID: <CABBYNZJ4OqHGHh-y4vLYpUjoS+zTSS=rRzfoW1=JRKmN8cQdWA@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
To: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:44=E2=80=AFPM syzbot
<syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> KASAN: slab-use-after-free Write in sco_sock_timeout
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/l=
inux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux=
/atomic/atomic-instrumented.h:252 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.=
h:184 [inline]
> BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.=
h:241 [inline]
> BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:=
258 [inline]
> BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inli=
ne]
> BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x8b/0x270 net/blueto=
oth/sco.c:92
> Write of size 4 at addr ffff88802639a080 by task kworker/1:2/1808

This really doesn't make much sense, it seems this is catching a UAF
on sock_hold but the backtrace shows it was freed with skb_free, even
if the memory was reclaimed and then reallocated that would just it
more difficult to find out why this is happening.

> CPU: 1 UID: 0 PID: 1808 Comm: kworker/1:2 Not tainted 6.12.0-rc1-syzkalle=
r-00113-g8c245fe7dde3-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Workqueue: events sco_sock_timeout
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 =
[inline]
>  __refcount_add include/linux/refcount.h:184 [inline]
>  __refcount_inc include/linux/refcount.h:241 [inline]
>  refcount_inc include/linux/refcount.h:258 [inline]
>  sock_hold include/net/sock.h:781 [inline]
>  sco_sock_timeout+0x8b/0x270 net/bluetooth/sco.c:92
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 25:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:257 [inline]
>  __do_kmalloc_node mm/slub.c:4265 [inline]
>  __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4284
>  kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
>  __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
>  alloc_skb include/linux/skbuff.h:1322 [inline]
>  nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
>  nsim_dev_trap_report_work+0x254/0xaa0 drivers/net/netdevsim/dev.c:850
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Freed by task 25:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:2343 [inline]
>  slab_free mm/slub.c:4580 [inline]
>  kfree+0x1a0/0x440 mm/slub.c:4728
>  skb_kfree_head net/core/skbuff.c:1086 [inline]
>  skb_free_head net/core/skbuff.c:1098 [inline]
>  skb_release_data+0x6a0/0x8a0 net/core/skbuff.c:1125
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb net/core/skbuff.c:1204 [inline]
>  consume_skb+0x9f/0xf0 net/core/skbuff.c:1436
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
>  nsim_dev_trap_report_work+0x765/0xaa0 drivers/net/netdevsim/dev.c:850
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> The buggy address belongs to the object at ffff88802639a000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 128 bytes inside of
>  freed 4096-byte region [ffff88802639a000, ffff88802639b000)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2639=
8
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
> head: 00fff00000000040 ffff888015442140 dead000000000122 0000000000000000
> head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
> head: 00fff00000000003 ffffea000098e601 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(=
__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5398,=
 tgid 5398 (udevd), ts 123333990998, free_ts 123322335448
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  alloc_slab_page+0x6a/0x120 mm/slub.c:2413
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2579
>  new_slab mm/slub.c:2632 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
>  __slab_alloc+0x58/0xa0 mm/slub.c:3909
>  __slab_alloc_node mm/slub.c:3962 [inline]
>  slab_alloc_node mm/slub.c:4123 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
>  kmalloc_noprof include/linux/slab.h:882 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path2_perm+0x3eb/0xbb0 security/tomoyo/file.c:923
>  tomoyo_path_rename+0x198/0x1e0 security/tomoyo/hooks.h:274
>  security_path_rename+0x266/0x4e0 security/security.c:2020
>  do_renameat2+0x94a/0x13f0 fs/namei.c:5157
>  __do_sys_rename fs/namei.c:5217 [inline]
>  __se_sys_rename fs/namei.c:5215 [inline]
>  __x64_sys_rename+0x82/0x90 fs/namei.c:5215
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> page last free pid 4548 tgid 4548 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1108 [inline]
>  free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>  __slab_free+0x31b/0x3d0 mm/slub.c:4491
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:247 [inline]
>  slab_post_alloc_hook mm/slub.c:4086 [inline]
>  slab_alloc_node mm/slub.c:4135 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4277
>  kmalloc_noprof include/linux/slab.h:882 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
>  security_inode_getattr+0x130/0x330 security/security.c:2371
>  vfs_getattr+0x45/0x430 fs/stat.c:204
>  vfs_fstat fs/stat.c:229 [inline]
>  vfs_fstatat+0xe4/0x190 fs/stat.c:338
>  __do_sys_newfstatat fs/stat.c:505 [inline]
>  __se_sys_newfstatat fs/stat.c:499 [inline]
>  __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888026399f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802639a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88802639a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff88802639a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88802639a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Tested on:
>
> commit:         8c245fe7 Merge tag 'net-6.12-rc2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1315630798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd0ca089c3fc6b=
54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde78711=
6d465
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1737758058=
0000
>


--=20
Luiz Augusto von Dentz
