Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBF218845
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454441; cv=pass; b=OXFgHh0iqIDPcq7l4SpfPAfr+73JdnJOQQin8UmPtl04Soh4AHb8DzbD8lwETs/gdZyNscVTgSbA4cAYNZQ5wbtfrg0/NeW+vkZRtetmqbq0Yr7WEeBlLyouulifmbgiWbiH95CvDY5FqRdpZGlTeto6wQqy6GM4dKtBVIylkl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454441; c=relaxed/simple;
	bh=vr3GbUYe6UvmQIiFsbIophMRVF8VHMAmajfQWxwI7ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAvSPpwURytLSNz4LExRnTxmfkagMnrHcePz+Xo6f4Pw3FbWyoaibKA1gv1ikV5RO7PVMY7qwxIzOEjTYkdoZPAK4tkAMrdZLGeZfksfRKZ4tVqeruFnT5K2iiBLFZ4hs162alVN0KV+efvR+50FFzXtJHnAzAZS6zkXAx7VmM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPLOLE46; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPLOLE46"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae222d87dso8258d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 09:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774454439; cv=none;
        d=google.com; s=arc-20240605;
        b=ck04y4t6axIRIahINlN9FKVS4XDHZ7zM6S5aMrtg0OP2QYAlka9Gx4GYgY9KedaTAd
         XYXY/i5OBfhTvIcyfemtZbFfrwfiRvIRI9yShz9df2Iu7N6Rr8XHkGIj7V4m1C1BXUEm
         AbBFTisofMhtOAvAHbTcZEMmSXFSLVeN6b3KwNSZ0VQFzAtZcHHkpwnTmQsbD8N6ylnm
         Ec0NhExzQrV8P/awpAP4BmmwbFCWLeF+XrA1YhBy506gYoyx49N3tqQ127WzaO50vUfY
         RRBxDIeYDxG9Em+90HqE9Ogmp2nNkGdX5Q8+G9Ubk9OuHn5xxfdmrYZU6NBB5y1cffJR
         318g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAs6wJhWnVz1RxCJAURWAJoaNIJSPO9Jo8tDofJOop4=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=U+t22pIQ9+P7tTNXrccn499BjnIuVBfJ6lYq4IGlOwAIykkhcTaKGXdQfNH6TBdJ+G
         bhtPZh7OBQMgrQAX4BghXJmtmQ6sGemvY8NeHJG+Fkx9AiMePB7WApsjAE4gsCtjIThe
         DE1zA0xK8jkJmhj6u/b5G/Ysx7WdWnbZPGL6+IL1807EoXeaWV3MKFItQcs3H+RdFaBF
         0L6dCQJJBmpqCRfucsQ0eTgjSTGKOO/6VNqN1QZcyVZxW/5rA9iERHUc76cI6zdFAHkg
         kSGXqJgHBRJ2ysgONwGvb+JmdOKANCCyas7qVTEdXXZtwQO+CAknXTaKleYh5ksaAFLo
         b6Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774454439; x=1775059239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAs6wJhWnVz1RxCJAURWAJoaNIJSPO9Jo8tDofJOop4=;
        b=kPLOLE46I1+tRQ7XrK3vkqEhI+iTpE9168j5ec1I9Dp3IfsXUZxg59bib9u0eLXxd6
         yRC+ji3fqpp5rVSoJumQFZcNdAHcc2pSZXnt5Qk1IHtzsMozJ0TSfMYptHZt3OFSsMr9
         vbsoW/IC0KDzd7SEPnp2y4BQhilVXwNvWNrhji52cd6mJ22/gC1eU8i5c7K7uTXTwpL5
         L9yeVDUDuXpdY0S1e7S2AZTs6jXNQBea2/UpalcR4gi0q6o2lYblKWAQIWh+tkfvEF1N
         5shVm3Yc/Qy3ywQ3FCftYBHj55Xj/hdnromhO8E+k98KDIH9K24PWEEZiT1rHrAX0+cN
         8BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454439; x=1775059239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAs6wJhWnVz1RxCJAURWAJoaNIJSPO9Jo8tDofJOop4=;
        b=X7ZpePvLz6U4IxX1dg/q/tQt7nxhI6SCBaZr/laqpjQPmGJ4hEctkW8iN3gsF0NaZB
         qSPt+d5iPvIxSJXUbmTwbaWRXwQm8WjDRidvAqI4azVGw+bxylc/SaMqYdGpFCKV6Q36
         vTTONV3S6ks+4MCMkZ5J9kwqy85aZu219bH77WpKuV4JJu0ItQxl7Vc2PCqa1pPqwYq5
         N/wbBnKmRmF89IYXTaTb6h4hN/CYhBhzinfDGCLnn4OfHcFLnd+2+gb8YmioLvNaRrb1
         kWbkWN4uTBzShVg9vxpcapd/rh+iDA8M2wtOFzyMY9GoTipQRCbaql9VyEpQZFVdGw0z
         LSfA==
X-Gm-Message-State: AOJu0YzGGM5QqyfynJSlye+BNjrrs6iQ8Ozju4enKEKEk0RL18Kk4E0L
	bGeLPF7yGan8QD8f/nMwSpExTnUtwtuCoGZ8hm5OABB1B4hQjcwd3kaYz13uzKhLwzPO0Z4l2Lt
	bF2TRneWx2mFH6nMAEXMGoVKhP+Q5LW0=
X-Gm-Gg: ATEYQzxh9yTRYdl86HZGT78ogwQgtsNdj5SEqE/Y5J65tv4Z6HpOJOQjTsUuveG5SLc
	fOFx7vda9yDCaZrEFvpcoN3nRfS+o0biPKFq12vmD9Ifc7J8ymGdIXMjRL8DovEMUuKUDUXgtD1
	0uB6RyEmqbZ3ChjYixqiRUP8ajZ00/D/N2Ceei+/wyTwmYObZCOXnwANJ9XDxItGLosvaxEJ4Qf
	EXRVaFxpuxWEJsNqxzb4IK1o4vFMkHekvpLOliB0Uei+R3qXx1ykOBSuYztims8UDUeGoYsWqBc
	xFg2gozI3SrV3jyJM0Qpy3e0KR6u9uDhulZ1EpqX/T5mKGi+cvLnYKImDIlJPM5KUHLXBw==
X-Received: by 2002:a53:a108:0:b0:64e:a1f3:e5c9 with SMTP id
 956f58d0204a3-64ee6157bd2mr3005506d50.57.1774454437830; Wed, 25 Mar 2026
 09:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325151809.235680-1-luiz.dentz@gmail.com> <c986d7b6114540132a9b066dd001275a2c0fd774.camel@iki.fi>
In-Reply-To: <c986d7b6114540132a9b066dd001275a2c0fd774.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Mar 2026 12:00:25 -0400
X-Gm-Features: AaiRm50pPYeE40Bd9YeHLXU2-LE2e6OE1hma3B3UbRBxPvMsjivEa5uGmPcKqNk
Message-ID: <CABBYNZJv=JO_O-nMr772_zsFVY5SM69aB9E4AQ38-FpeXDwK-A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF in le_read_features_complete
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 25, 2026 at 11:56=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2026-03-25 kello 11:18 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following backtrace caused by hci_conn being freed
> > before le_read_features_complete but after
> > hci_le_read_remote_features_sync so hci_conn_del -> hci_cmd_sync_dequeu=
e
> > is not able to prevent it:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include=
/linux/instrumented.h:96 [inline]
> > BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/at=
omic/atomic-instrumented.h:1383 [inline]
> > BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/=
hci_core.h:1688 [inline]
> > BUG: KASAN: slab-use-after-free in le_read_features_complete+0x5b/0x340=
 net/bluetooth/hci_sync.c:7344
> > Write of size 4 at addr ffff8880796b0010 by task kworker/u9:0/52
> >
> > CPU: 0 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted syzkaller #0 PREEM=
PT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xcd/0x630 mm/kasan/report.c:482
> >  kasan_report+0xe0/0x110 mm/kasan/report.c:595
> >  check_region_inline mm/kasan/generic.c:194 [inline]
> >  kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
> >  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> >  atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [i=
nline]
> >  hci_conn_drop include/net/bluetooth/hci_core.h:1688 [inline]
> >  le_read_features_complete+0x5b/0x340 net/bluetooth/hci_sync.c:7344
> >  hci_cmd_sync_work+0x1ff/0x430 net/bluetooth/hci_sync.c:334
> >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> >  kthread+0x3c5/0x780 kernel/kthread.c:463
> >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >  </TASK>
> >
> > Allocated by task 5932:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
> >  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
> >  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
> >  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
> >  kmalloc_noprof include/linux/slab.h:957 [inline]
> >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> >  __hci_conn_add+0xf8/0x1c70 net/bluetooth/hci_conn.c:963
> >  hci_conn_add_unset+0x76/0x100 net/bluetooth/hci_conn.c:1084
> >  le_conn_complete_evt+0x639/0x1f20 net/bluetooth/hci_event.c:5714
> >  hci_le_enh_conn_complete_evt+0x23d/0x380 net/bluetooth/hci_event.c:586=
1
> >  hci_le_meta_evt+0x357/0x5e0 net/bluetooth/hci_event.c:7408
> >  hci_event_func net/bluetooth/hci_event.c:7716 [inline]
> >  hci_event_packet+0x685/0x11c0 net/bluetooth/hci_event.c:7773
> >  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
> >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> >  kthread+0x3c5/0x780 kernel/kthread.c:463
> >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >
> > Freed by task 5932:
> >  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
> >  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
> >  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
> >  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
> >  poison_slab_object mm/kasan/common.c:252 [inline]
> >  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
> >  kasan_slab_free include/linux/kasan.h:234 [inline]
> >  slab_free_hook mm/slub.c:2540 [inline]
> >  slab_free mm/slub.c:6663 [inline]
> >  kfree+0x2f8/0x6e0 mm/slub.c:6871
> >  device_release+0xa4/0x240 drivers/base/core.c:2565
> >  kobject_cleanup lib/kobject.c:689 [inline]
> >  kobject_release lib/kobject.c:720 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  kobject_put+0x1e7/0x590 lib/kobject.c:737
> >  put_device drivers/base/core.c:3797 [inline]
> >  device_unregister+0x2f/0xc0 drivers/base/core.c:3920
> >  hci_conn_del_sysfs+0xb4/0x180 net/bluetooth/hci_sysfs.c:79
> >  hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
> >  hci_conn_del+0x657/0x1180 net/bluetooth/hci_conn.c:1234
> >  hci_disconn_complete_evt+0x410/0xa00 net/bluetooth/hci_event.c:3451
> >  hci_event_func net/bluetooth/hci_event.c:7719 [inline]
> >  hci_event_packet+0xa10/0x11c0 net/bluetooth/hci_event.c:7773
> >  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
> >  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
> >  process_scheduled_works kernel/workqueue.c:3340 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
> >  kthread+0x3c5/0x780 kernel/kthread.c:463
> >  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >
> > The buggy address belongs to the object at ffff8880796b0000
> >  which belongs to the cache kmalloc-8k of size 8192
> > The buggy address is located 16 bytes inside of
> >  freed 8192-byte region [ffff8880796b0000, ffff8880796b2000)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79=
6b0
> > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000040 ffff88813ff27280 0000000000000000 000000000000000=
1
> > raw: 0000000000000000 0000000000020002 00000000f5000000 000000000000000=
0
> > head: 00fff00000000040 ffff88813ff27280 0000000000000000 00000000000000=
01
> > head: 0000000000000000 0000000000020002 00000000f5000000 00000000000000=
00
> > head: 00fff00000000003 ffffea0001e5ac01 00000000ffffffff 00000000ffffff=
ff
> > head: ffffffffffffffff 0000000000000000 00000000ffffffff 00000000000000=
08
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd204=
0(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 565=
7, tgid 5657 (dhcpcd-run-hook), ts 79819636908, free_ts 79814310558
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
> >  prep_new_page mm/page_alloc.c:1853 [inline]
> >  get_page_from_freelist+0xd0b/0x31a0 mm/page_alloc.c:3879
> >  __alloc_frozen_pages_noprof+0x25f/0x2440 mm/page_alloc.c:5183
> >  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
> >  alloc_slab_page mm/slub.c:3075 [inline]
> >  allocate_slab mm/slub.c:3248 [inline]
> >  new_slab+0x2c3/0x430 mm/slub.c:3302
> >  ___slab_alloc+0xe18/0x1c90 mm/slub.c:4651
> >  __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4774
> >  __slab_alloc_node mm/slub.c:4850 [inline]
> >  slab_alloc_node mm/slub.c:5246 [inline]
> >  __kmalloc_cache_noprof+0x477/0x800 mm/slub.c:5766
> >  kmalloc_noprof include/linux/slab.h:957 [inline]
> >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> >  tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
> >  tomoyo_init_log+0xc8a/0x2140 security/tomoyo/audit.c:264
> >  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
> >  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> >  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
> >  tomoyo_environ security/tomoyo/domain.c:672 [inline]
> >  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
> >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
> >  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
> >  security_bprm_check+0x1b9/0x1e0 security/security.c:794
> >  search_binary_handler fs/exec.c:1659 [inline]
> >  exec_binprm fs/exec.c:1701 [inline]
> >  bprm_execve fs/exec.c:1753 [inline]
> >  bprm_execve+0x81e/0x1620 fs/exec.c:1729
> >  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
> > page last free pid 5657 tgid 5657 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1394 [inline]
> >  __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2901
> >  discard_slab mm/slub.c:3346 [inline]
> >  __put_partials+0x130/0x170 mm/slub.c:3886
> >  qlink_free mm/kasan/quarantine.c:163 [inline]
> >  qlist_free_all+0x4c/0xf0 mm/kasan/quarantine.c:179
> >  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
> >  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
> >  kasan_slab_alloc include/linux/kasan.h:252 [inline]
> >  slab_post_alloc_hook mm/slub.c:4948 [inline]
> >  slab_alloc_node mm/slub.c:5258 [inline]
> >  __kmalloc_cache_noprof+0x274/0x800 mm/slub.c:5766
> >  kmalloc_noprof include/linux/slab.h:957 [inline]
> >  tomoyo_print_header security/tomoyo/audit.c:156 [inline]
> >  tomoyo_init_log+0x197/0x2140 security/tomoyo/audit.c:255
> >  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
> >  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> >  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
> >  tomoyo_environ security/tomoyo/domain.c:672 [inline]
> >  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
> >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
> >  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
> >  security_bprm_check+0x1b9/0x1e0 security/security.c:794
> >  search_binary_handler fs/exec.c:1659 [inline]
> >  exec_binprm fs/exec.c:1701 [inline]
> >  bprm_execve fs/exec.c:1753 [inline]
> >  bprm_execve+0x81e/0x1620 fs/exec.c:1729
> >  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
> >  do_execve fs/exec.c:1933 [inline]
> >  __do_sys_execve fs/exec.c:2009 [inline]
> >  __se_sys_execve fs/exec.c:2004 [inline]
> >  __x64_sys_execve+0x8e/0xb0 fs/exec.c:2004
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
> >
> > Memory state around the buggy address:
> >  ffff8880796aff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8880796aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > ffff8880796b0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                          ^
> >  ffff8880796b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880796b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Featu=
re Set")
> > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > Closes: https://syzbot.org/bug?extid=3D87badbb9094e008e0685
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_sync.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 45d16639874a..f67a32c1451e 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -7371,7 +7371,7 @@ static void le_read_features_complete(struct hci_=
dev *hdev, void *data, int err)
> >       if (err =3D=3D -ECANCELED)
> >               return;
> >
> > -     hci_conn_drop(conn);
> > +     hci_conn_put(conn);
> >  }
> >
> >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
> > @@ -7441,7 +7441,7 @@ int hci_le_read_remote_features(struct hci_conn *=
conn)
> >       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATUR=
ES))
> >               err =3D hci_cmd_sync_queue_once(hdev,
> >                                             hci_le_read_remote_features=
_sync,
> > -                                           hci_conn_hold(conn),
> > +                                           hci_conn_get(conn),
> >                                             le_read_features_complete);
> >       else
> >               err =3D -EOPNOTSUPP;
>
> This looks like it leaks conn refcount if it can happen that the item
> is already queued, or on queue error.
>
> The hci_cmd_sync_queue_once() and hci_cmd_sync_run_once() API probably
> should indicate to caller whether an item was queued:
>
> https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9=
880979d.1762100290.git.pav@iki.fi/T/#m66b153015dc461c5dacc9f4c9ec2805b1197d=
149

Interesting. Is there a chance to resend this change? It's a little
intrusive since we need to verify all call sites handle -EEXIST but I
guess there is no better option.

> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
