Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4E3E3156
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454176; cv=pass; b=oMQH2YM7ga1U449lF3kqW9FcY+NqC6gQ0JGbhXeeQ1QeuvrSPLVhmcfYzxSQ9mMao+dpzb3FNoTR2NqL90luGyNhlz7JIDFEoS6P4/uc/H+lz4L0XG8BFFnp4hXsv9Xuc6tcQN01/dm+fGH60eKAW4Jubp72+2RcaV5+EAg0Drw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454176; c=relaxed/simple;
	bh=7v94VoYJtEzfARXYPDCTmF5NjkZY+DXXFrqrCFBMU8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWL5pMmCpAcKQrFBYQB934cmeIHP7UtNpImu6xVPUxEPk/Dz87kPikM/hJawykOLks6loUCv3cZ+8CLRTONi9OVMjUgnHybjxxubzNcxUOr8YhrOHIkDlA7c4wmUCiCOxuzzHDDJKOh72y9OuV0ykzq8L4Yys2hQVKXgRxyxecA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nV/5UgPo; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nV/5UgPo"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fgs2Z14VKz49Pvg;
	Wed, 25 Mar 2026 17:56:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774454166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fssq5BeusbPO4TSSaOcWbXtx3kJZPrliKtAuHyD5CbM=;
	b=nV/5UgPodSf66oxUMSJcnU9mTdykY09dq5a7Srdg3OS7y+sSfY7Zi44qJ0ZseN9gfvp7JG
	0eggmuxMx65Pr9CLeqTNd6r82gRAWxhW8YHTB7xXTcB6AsPtHjxcX9FsuOuuN7oOFD+xQa
	YbrLsbwRLCN8OREsHhsagP/EWwzLB4N7dXYHm7smg5JdMkQrVeA5QgjmhEkNaV5orD2rny
	PomlKCcdnbQC67p9Qs52m6jQXJ1OI2Gj5Zfw2tukeeOXORIQrlAQ1WI1sISsm8Ndpyp1rf
	L73JBK4anmc13ZiQ6qFzj2h3sv8xcL62QxN6EvZakVmJfP9csKM1ha1DZkaAhA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774454166;
	b=Jv0j66oH+/Or+NNjjwrNmvzFydjWZ8ft3W4mobW2ZKoZ+JX2bXTHU/73OpEb6AtS7Hm32U
	CkDWjyclUgdVlncoU4l7eI3q4pvfkpRepThEGLYW2H3/gmZnU3fZu2TCL0KoMZ9v+c76f5
	BwoXoOT57KRrSWcWlQ6iS4lkcIjX8ZcQOs8DZBJlHKJUz1s5TKvHtT1nFU601Z+gQv10wg
	jcw1txnmGgBz9O/HCeG448AKLLCjmN84QrJALHTrZ/AfrUMdc1YOavEJS1r1soNoJNfWbL
	CMj60jmHkh5OpGTQstTCwJpOgqnhMoLU5D0FSxpn4r0o+oVHt8RinYpuFvfKgA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774454166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fssq5BeusbPO4TSSaOcWbXtx3kJZPrliKtAuHyD5CbM=;
	b=i1oyGqowA3bkTAg9YI1MrnRpDy6vLYiu1ZE1QVrO1A67WNXWqWbHGF+8WntKr5pgS9dasw
	A8ATY6Nz1FuPMBZ+tybzHsFR7TylMHs/DqZmwHR1Z75JrXdZyiGT0VJzdGT7QARxsyU3gd
	JRNtbKJwSSl5Q2CzSs9tIS3clB2M70PdktfPQ68QI+hczttUjsG1ORmzKtvZpR+iL8376j
	ccPfZFqwNRZHb1/ckkOqe2o3Xl8Ss39bs5SkfwMB4jBMRzGFrg6H0IMuO0f+meSxyg8kI6
	Z7K9S7T1bhQKEewmmOh1DfKPG8vvkhZvAyoPO7JA9ZHR8WEDFn15zuBJAfOgtg==
Message-ID: <c986d7b6114540132a9b066dd001275a2c0fd774.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF in
 le_read_features_complete
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Mar 2026 17:56:04 +0200
In-Reply-To: <20260325151809.235680-1-luiz.dentz@gmail.com>
References: <20260325151809.235680-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ke, 2026-03-25 kello 11:18 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This fixes the following backtrace caused by hci_conn being freed
> before le_read_features_complete but after
> hci_le_read_remote_features_sync so hci_conn_del -> hci_cmd_sync_dequeue
> is not able to prevent it:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/l=
inux/instrumented.h:96 [inline]
> BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atom=
ic/atomic-instrumented.h:1383 [inline]
> BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hc=
i_core.h:1688 [inline]
> BUG: KASAN: slab-use-after-free in le_read_features_complete+0x5b/0x340 n=
et/bluetooth/hci_sync.c:7344
> Write of size 4 at addr ffff8880796b0010 by task kworker/u9:0/52
>=20
> CPU: 0 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted syzkaller #0 PREEMPT=
(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  check_region_inline mm/kasan/generic.c:194 [inline]
>  kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:200
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1383 [inl=
ine]
>  hci_conn_drop include/net/bluetooth/hci_core.h:1688 [inline]
>  le_read_features_complete+0x5b/0x340 net/bluetooth/hci_sync.c:7344
>  hci_cmd_sync_work+0x1ff/0x430 net/bluetooth/hci_sync.c:334
>  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
>  process_scheduled_works kernel/workqueue.c:3340 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
>=20
> Allocated by task 5932:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  __hci_conn_add+0xf8/0x1c70 net/bluetooth/hci_conn.c:963
>  hci_conn_add_unset+0x76/0x100 net/bluetooth/hci_conn.c:1084
>  le_conn_complete_evt+0x639/0x1f20 net/bluetooth/hci_event.c:5714
>  hci_le_enh_conn_complete_evt+0x23d/0x380 net/bluetooth/hci_event.c:5861
>  hci_le_meta_evt+0x357/0x5e0 net/bluetooth/hci_event.c:7408
>  hci_event_func net/bluetooth/hci_event.c:7716 [inline]
>  hci_event_packet+0x685/0x11c0 net/bluetooth/hci_event.c:7773
>  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
>  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
>  process_scheduled_works kernel/workqueue.c:3340 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>=20
> Freed by task 5932:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
>  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2540 [inline]
>  slab_free mm/slub.c:6663 [inline]
>  kfree+0x2f8/0x6e0 mm/slub.c:6871
>  device_release+0xa4/0x240 drivers/base/core.c:2565
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1e7/0x590 lib/kobject.c:737
>  put_device drivers/base/core.c:3797 [inline]
>  device_unregister+0x2f/0xc0 drivers/base/core.c:3920
>  hci_conn_del_sysfs+0xb4/0x180 net/bluetooth/hci_sysfs.c:79
>  hci_conn_cleanup net/bluetooth/hci_conn.c:173 [inline]
>  hci_conn_del+0x657/0x1180 net/bluetooth/hci_conn.c:1234
>  hci_disconn_complete_evt+0x410/0xa00 net/bluetooth/hci_event.c:3451
>  hci_event_func net/bluetooth/hci_event.c:7719 [inline]
>  hci_event_packet+0xa10/0x11c0 net/bluetooth/hci_event.c:7773
>  hci_rx_work+0x2c9/0xeb0 net/bluetooth/hci_core.c:4076
>  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
>  process_scheduled_works kernel/workqueue.c:3340 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>=20
> The buggy address belongs to the object at ffff8880796b0000
>  which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 16 bytes inside of
>  freed 8192-byte region [ffff8880796b0000, ffff8880796b2000)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x796b=
0
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88813ff27280 0000000000000000 0000000000000001
> raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88813ff27280 0000000000000000 0000000000000001
> head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
> head: 00fff00000000003 ffffea0001e5ac01 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(=
__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5657,=
 tgid 5657 (dhcpcd-run-hook), ts 79819636908, free_ts 79814310558
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
>  prep_new_page mm/page_alloc.c:1853 [inline]
>  get_page_from_freelist+0xd0b/0x31a0 mm/page_alloc.c:3879
>  __alloc_frozen_pages_noprof+0x25f/0x2440 mm/page_alloc.c:5183
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
>  alloc_slab_page mm/slub.c:3075 [inline]
>  allocate_slab mm/slub.c:3248 [inline]
>  new_slab+0x2c3/0x430 mm/slub.c:3302
>  ___slab_alloc+0xe18/0x1c90 mm/slub.c:4651
>  __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4774
>  __slab_alloc_node mm/slub.c:4850 [inline]
>  slab_alloc_node mm/slub.c:5246 [inline]
>  __kmalloc_cache_noprof+0x477/0x800 mm/slub.c:5766
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
>  tomoyo_init_log+0xc8a/0x2140 security/tomoyo/audit.c:264
>  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
>  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
>  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
>  tomoyo_environ security/tomoyo/domain.c:672 [inline]
>  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
>  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
>  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
>  security_bprm_check+0x1b9/0x1e0 security/security.c:794
>  search_binary_handler fs/exec.c:1659 [inline]
>  exec_binprm fs/exec.c:1701 [inline]
>  bprm_execve fs/exec.c:1753 [inline]
>  bprm_execve+0x81e/0x1620 fs/exec.c:1729
>  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
> page last free pid 5657 tgid 5657 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1394 [inline]
>  __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2901
>  discard_slab mm/slub.c:3346 [inline]
>  __put_partials+0x130/0x170 mm/slub.c:3886
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4c/0xf0 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
>  kasan_slab_alloc include/linux/kasan.h:252 [inline]
>  slab_post_alloc_hook mm/slub.c:4948 [inline]
>  slab_alloc_node mm/slub.c:5258 [inline]
>  __kmalloc_cache_noprof+0x274/0x800 mm/slub.c:5766
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  tomoyo_print_header security/tomoyo/audit.c:156 [inline]
>  tomoyo_init_log+0x197/0x2140 security/tomoyo/audit.c:255
>  tomoyo_supervisor+0x302/0x13b0 security/tomoyo/common.c:2198
>  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
>  tomoyo_env_perm+0x191/0x200 security/tomoyo/environ.c:63
>  tomoyo_environ security/tomoyo/domain.c:672 [inline]
>  tomoyo_find_next_domain+0xec1/0x20b0 security/tomoyo/domain.c:888
>  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
>  tomoyo_bprm_check_security+0x12d/0x1d0 security/tomoyo/tomoyo.c:92
>  security_bprm_check+0x1b9/0x1e0 security/security.c:794
>  search_binary_handler fs/exec.c:1659 [inline]
>  exec_binprm fs/exec.c:1701 [inline]
>  bprm_execve fs/exec.c:1753 [inline]
>  bprm_execve+0x81e/0x1620 fs/exec.c:1729
>  do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
>  do_execve fs/exec.c:1933 [inline]
>  __do_sys_execve fs/exec.c:2009 [inline]
>  __se_sys_execve fs/exec.c:2004 [inline]
>  __x64_sys_execve+0x8e/0xb0 fs/exec.c:2004
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>=20
> Memory state around the buggy address:
>  ffff8880796aff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880796aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8880796b0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8880796b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880796b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature=
 Set")
> Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D87badbb9094e008e0685
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 45d16639874a..f67a32c1451e 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7371,7 +7371,7 @@ static void le_read_features_complete(struct hci_de=
v *hdev, void *data, int err)
>  	if (err =3D=3D -ECANCELED)
>  		return;
> =20
> -	hci_conn_drop(conn);
> +	hci_conn_put(conn);
>  }
> =20
>  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
> @@ -7441,7 +7441,7 @@ int hci_le_read_remote_features(struct hci_conn *co=
nn)
>  	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
>  		err =3D hci_cmd_sync_queue_once(hdev,
>  					      hci_le_read_remote_features_sync,
> -					      hci_conn_hold(conn),
> +					      hci_conn_get(conn),
>  					      le_read_features_complete);
>  	else
>  		err =3D -EOPNOTSUPP;

This looks like it leaks conn refcount if it can happen that the item
is already queued, or on queue error.

The hci_cmd_sync_queue_once() and hci_cmd_sync_run_once() API probably
should indicate to caller whether an item was queued:

https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d988=
0979d.1762100290.git.pav@iki.fi/T/#m66b153015dc461c5dacc9f4c9ec2805b1197d14=
9

--=20
Pauli Virtanen
