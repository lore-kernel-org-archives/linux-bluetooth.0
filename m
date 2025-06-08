Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1F207E1D
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422584; cv=none; b=q+RxANaj0aXLMNzdrCAZnw7ORqZPL3D5Z2ziVCqO1k6wDSLIkojeIyNitBDlzlgbFvMsg3pGHztDlQ4y31b5LyOVNkGmnC9CMznz7qK63pugxsC1XBkz1UB+asxaFvozkx0Jjjpw/CTjjmbjvvw4GbuobhLfaao55uqbXObhEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422584; c=relaxed/simple;
	bh=s2w3p1YvJiJ851QjodOmLGzJlNru+s6s3iuVcF79kuM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dZSSj3BDA4eW/S6yZg4b3+Ym9cs+e7rL6IlOyLjqjF+smUeLqkI2tNO4A1MMEw4zeFHbPSU28RxL+iw2g7qNnqLujmBqZp16io7a3fEC1t+nceMCpvso+wj7aVJRWt9O/5obiR2FC07tZlIBlig8FqcPvjV2QVzZ7Qu855+gmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddc5137992so50686395ab.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Jun 2025 15:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749422582; x=1750027382;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHdraUuPD5VVAsvRzEgsoNhZ21HMosn9o24fwsFDw8Y=;
        b=BZD0aG+astvRNpXzmkXjF6WVWUG8kFXCyRlHYEZNyRcOGYyK2UhKrPAfLSqc3IqfHx
         9Y+JCFMx719hsVtLC9hrh2cCfMyvJY0DL3hvZ+cdk3A6xCFa9Sbz/h+z4SpnjFgqNFKl
         6PLatTBwv3+l2wrq3Cx1P/2fMiOLar7XZhT4MSKsM/wvlQfhx7pWOB84vX7R5fMuul7N
         i7aCwjMJF40f1jDOYqRfUh2I68/3etOmjJPilRYh71iMRlnZ/LjOmGcJMS/AxJ/JlhSl
         Qqvo1Xe2oXHLQZ9jBLJEWFP1fOY5S5udBkCnwHTG9ddqX1zJVi9KCdD86/ll8cc/KtUP
         Q+PA==
X-Forwarded-Encrypted: i=1; AJvYcCVjJdp0r0M54QM03Kfmbn0UQh5e/vMoEiI/waXkvPR2jNF6Oqes/+r0q670c1ftgwPIH4/F9FGBf2QzjOLdRm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7umlTzliuepzckxAfmcIuHbzJsiCKHFeAPX/B/LwrCc0RL5RR
	obxc/zuq5xq7bLO+1tPDyShAsvvh90jaB4VJPmgooxrnTiRjiH7mKPiGNsE9jCRI9IMRguNiGjS
	LAXGNAl+8n+QTaUD/+wF5PD+Npk4PscC4pksItUWFfb92cFJioR9tLIey7k4=
X-Google-Smtp-Source: AGHT+IH4qdEyJVg4qmlJ4ctiptLDNprBi9XdvXzJf1XlEMvrEP5olAL8c+60PdaDddgQARchKMDjevMMBdY5rB3jbKinOpsT5bry
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2782:b0:3dc:7240:94c7 with SMTP id
 e9e14a558f8ab-3ddce41d023mr113559195ab.6.1749422581811; Sun, 08 Jun 2025
 15:43:01 -0700 (PDT)
Date: Sun, 08 Jun 2025 15:43:01 -0700
In-Reply-To: <0c4d3721-db0d-433a-93c5-1d3247ba41b1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684611f5.050a0220.d8705.0014.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

cquire+0xfc/0x350
[  109.325603][ T5869]  _raw_spin_lock+0x2e/0x40
[  109.325629][ T5869]  ? lockref_get+0x15/0x50
[  109.325659][ T5869]  lockref_get+0x15/0x50
[  109.325688][ T5869]  simple_recursive_removal+0x3b/0x690
[  109.325717][ T5869]  ? do_raw_spin_unlock+0x172/0x230
[  109.325747][ T5869]  ? __pfx_remove_one+0x10/0x10
[  109.325771][ T5869]  ? mntput+0x10/0x90
[  109.325796][ T5869]  debugfs_remove+0x5d/0x80
[  109.325821][ T5869]  hci_release_dev+0x8c/0x600
[  109.325852][ T5869]  ? __pfx_hci_release_dev+0x10/0x10
[  109.325882][ T5869]  ? rcu_is_watching+0x12/0xc0
[  109.325903][ T5869]  ? kfree+0x24f/0x4d0
[  109.325931][ T5869]  bt_host_release+0x6a/0xb0
[  109.325952][ T5869]  ? __pfx_bt_host_release+0x10/0x10
[  109.325973][ T5869]  device_release+0xa1/0x240
[  109.325999][ T5869]  kobject_put+0x1e7/0x5a0
[  109.326020][ T5869]  ? __pfx_vhci_release+0x10/0x10
[  109.326052][ T5869]  put_device+0x1f/0x30
[  109.326076][ T5869]  vhci_release+0xb5/0x130
[  109.326108][ T5869]  __fput+0x402/0xb70
[  109.326132][ T5869]  task_work_run+0x150/0x240
[  109.326164][ T5869]  ? __pfx_task_work_run+0x10/0x10
[  109.326199][ T5869]  do_exit+0x864/0x2bd0
[  109.326230][ T5869]  ? __pfx_do_exit+0x10/0x10
[  109.326256][ T5869]  ? do_raw_spin_lock+0x12c/0x2b0
[  109.326286][ T5869]  ? find_held_lock+0x2b/0x80
[  109.326308][ T5869]  do_group_exit+0xd3/0x2a0
[  109.326336][ T5869]  get_signal+0x2673/0x26d0
[  109.326363][ T5869]  ? __pfx_get_signal+0x10/0x10
[  109.326385][ T5869]  ? kmem_cache_free+0x16d/0x4d0
[  109.326413][ T5869]  ? __fput+0x68d/0xb70
[  109.326434][ T5869]  arch_do_signal_or_restart+0x8f/0x790
[  109.326457][ T5869]  ? __fput+0x68d/0xb70
[  109.326476][ T5869]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  109.326503][ T5869]  ? __pfx_fput_close_sync+0x10/0x10
[  109.326524][ T5869]  ? dnotify_flush+0x79/0x4c0
[  109.326566][ T5869]  exit_to_user_mode_loop+0x84/0x110
[  109.326600][ T5869]  do_syscall_64+0x3f6/0x490
[  109.326621][ T5869]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  109.326644][ T5869] RIP: 0033:0x7f6845b8d5ca
[  109.326661][ T5869] Code: Unable to access opcode bytes at 0x7f6845b8d5a=
0.
[  109.326671][ T5869] RSP: 002b:00007ffefac60c40 EFLAGS: 00000293 ORIG_RAX=
: 0000000000000003
[  109.326693][ T5869] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000=
07f6845b8d5ca
[  109.326706][ T5869] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[  109.326719][ T5869] RBP: 00007ffefac60c9c R08: 0000000000000000 R09: 000=
07ffefac609a7
[  109.326732][ T5869] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000001
[  109.326745][ T5869] R13: 00000000000927c0 R14: 000000000001aa36 R15: 000=
07ffefac60cf0
[  109.326765][ T5869]  </TASK>
[  109.326772][ T5869]=20
[  109.662463][ T5869] Allocated by task 5869:
[  109.666812][ T5869]  kasan_save_stack+0x33/0x60
[  109.671613][ T5869]  kasan_save_track+0x14/0x30
[  109.676325][ T5869]  __kasan_slab_alloc+0x89/0x90
[  109.681256][ T5869]  kmem_cache_alloc_lru_noprof+0x1d0/0x3b0
[  109.687349][ T5869]  __d_alloc+0x31/0xaa0
[  109.691619][ T5869]  d_alloc+0x4a/0x1e0
[  109.695718][ T5869]  d_alloc_parallel+0xe3/0x12e0
[  109.700963][ T5869]  __lookup_slow+0x193/0x460
[  109.705774][ T5869]  lookup_noperm+0xe1/0x110
[  109.710312][ T5869]  start_creating.part.0+0x15a/0x3e0
[  109.716005][ T5869]  debugfs_create_dir+0x6c/0x5f0
[  109.721340][ T5869]  hci_register_dev+0x2f2/0xc60
[  109.726328][ T5869]  __vhci_create_device+0x357/0x7f0
[  109.731716][ T5869]  vhci_write+0x2c0/0x480
[  109.736252][ T5869]  vfs_write+0x6c4/0x1150
[  109.740904][ T5869]  ksys_write+0x12a/0x250
[  109.745448][ T5869]  do_syscall_64+0xcd/0x490
[  109.750065][ T5869]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  109.755993][ T5869]=20
[  109.758349][ T5869] Freed by task 15:
[  109.762424][ T5869]  kasan_save_stack+0x33/0x60
[  109.767369][ T5869]  kasan_save_track+0x14/0x30
[  109.772423][ T5869]  kasan_save_free_info+0x3b/0x60
[  109.777663][ T5869]  __kasan_slab_free+0x51/0x70
[  109.782576][ T5869]  kmem_cache_free+0x2d1/0x4d0
[  109.787495][ T5869]  rcu_core+0x79c/0x14e0
[  109.791784][ T5869]  handle_softirqs+0x219/0x8e0
[  109.796774][ T5869]  run_ksoftirqd+0x3a/0x60
[  109.801340][ T5869]  smpboot_thread_fn+0x3f7/0xae0
[  109.806423][ T5869]  kthread+0x3c2/0x780
[  109.810589][ T5869]  ret_from_fork+0x5d4/0x6f0
[  109.815482][ T5869]  ret_from_fork_asm+0x1a/0x30
[  109.820362][ T5869]=20
[  109.823072][ T5869] Last potentially related work creation:
[  109.828904][ T5869]  kasan_save_stack+0x33/0x60
[  109.833815][ T5869]  kasan_record_aux_stack+0xa7/0xc0
[  109.839064][ T5869]  __call_rcu_common.constprop.0+0x9a/0x9f0
[  109.846303][ T5869]  dentry_free+0xc2/0x160
[  109.850666][ T5869]  __dentry_kill+0x498/0x600
[  109.855291][ T5869]  dput.part.0+0x4b1/0x9b0
[  109.859830][ T5869]  dput+0x1f/0x30
[  109.863586][ T5869]  debugfs_remove+0x5d/0x80
[  109.868127][ T5869]  vhci_release+0x9b/0x130
[  109.872572][ T5869]  __fput+0x402/0xb70
[  109.876663][ T5869]  task_work_run+0x150/0x240
[  109.881510][ T5869]  do_exit+0x864/0x2bd0
[  109.885964][ T5869]  do_group_exit+0xd3/0x2a0
[  109.890524][ T5869]  get_signal+0x2673/0x26d0
[  109.895159][ T5869]  arch_do_signal_or_restart+0x8f/0x790
[  109.900906][ T5869]  exit_to_user_mode_loop+0x84/0x110
[  109.906326][ T5869]  do_syscall_64+0x3f6/0x490
[  109.911128][ T5869]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  109.917311][ T5869]=20
[  109.919935][ T5869] The buggy address belongs to the object at ffff88807=
1891a70
[  109.919935][ T5869]  which belongs to the cache dentry of size 312
[  109.934312][ T5869] The buggy address is located 208 bytes inside of
[  109.934312][ T5869]  freed 312-byte region [ffff888071891a70, ffff888071=
891ba8)
[  109.949195][ T5869]=20
[  109.951537][ T5869] The buggy address belongs to the physical page:
[  109.957976][ T5869] page: refcount:0 mapcount:0 mapping:0000000000000000=
 index:0x0 pfn:0x71890
[  109.967572][ T5869] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_=
mapped:0 pincount:0
[  109.976151][ T5869] memcg:ffff88802919ed01
[  109.980496][ T5869] flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastc=
pupid=3D0x7ff)
[  109.988514][ T5869] page_type: f5(slab)
[  109.993050][ T5869] raw: 00fff00000000040 ffff88801ca94780 dead000000000=
122 0000000000000000
[  110.001676][ T5869] raw: 0000000000000000 0000000000150015 00000000f5000=
000 ffff88802919ed01
[  110.010388][ T5869] head: 00fff00000000040 ffff88801ca94780 dead00000000=
0122 0000000000000000
[  110.019449][ T5869] head: 0000000000000000 0000000000150015 00000000f500=
0000 ffff88802919ed01
[  110.028182][ T5869] head: 00fff00000000001 ffffea0001c62401 00000000ffff=
ffff 00000000ffffffff
[  110.037080][ T5869] head: ffffffffffffffff 0000000000000000 00000000ffff=
ffff 0000000000000002
[  110.045949][ T5869] page dumped because: kasan: bad access detected
[  110.052725][ T5869] page_owner tracks the page as allocated
[  110.058670][ T5869] page last allocated via order 1, migratetype Reclaim=
able, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__G=
FP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5864, tgid 5864 (syz-executor)=
, ts 108825522753, free_ts 35108082918
[  110.083404][ T5869]  post_alloc_hook+0x1c0/0x230
[  110.089384][ T5869]  get_page_from_freelist+0x1321/0x3890
[  110.095163][ T5869]  __alloc_frozen_pages_noprof+0x261/0x23f0
[  110.102661][ T5869]  alloc_pages_mpol+0x1fb/0x550
[  110.108098][ T5869]  new_slab+0x23b/0x330
[  110.112837][ T5869]  ___slab_alloc+0xd9c/0x1940
[  110.117802][ T5869]  __slab_alloc.constprop.0+0x56/0xb0
[  110.123659][ T5869]  kmem_cache_alloc_lru_noprof+0xf4/0x3b0
[  110.129789][ T5869]  __d_alloc+0x31/0xaa0
[  110.134352][ T5869]  d_alloc_pseudo+0x1c/0xc0
[  110.139204][ T5869]  alloc_file_pseudo+0xcf/0x230
[  110.144507][ T5869]  sock_alloc_file+0x50/0x210
[  110.149791][ T5869]  __sys_socket+0x1c0/0x260
[  110.154768][ T5869]  __x64_sys_socket+0x72/0xb0
[  110.159903][ T5869]  do_syscall_64+0xcd/0x490
[  110.164705][ T5869]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.171259][ T5869] page last free pid 1 tgid 1 stack trace:
[  110.177345][ T5869]  __free_frozen_pages+0x7fe/0x1180
[  110.182956][ T5869]  free_contig_range+0x183/0x4b0
[  110.188039][ T5869]  destroy_args+0x7f6/0xa60
[  110.192847][ T5869]  debug_vm_pgtable+0x13b8/0x2d00
[  110.198193][ T5869]  do_one_initcall+0x120/0x6e0
[  110.203286][ T5869]  kernel_init_freeable+0x5c2/0x900
[  110.208731][ T5869]  kernel_init+0x1c/0x2b0
[  110.213105][ T5869]  ret_from_fork+0x5d4/0x6f0
[  110.217918][ T5869]  ret_from_fork_asm+0x1a/0x30
[  110.222812][ T5869]=20
[  110.225370][ T5869] Memory state around the buggy address:
[  110.231468][ T5869]  ffff888071891a00: fb fb fb fb fb fb fc fc fc fc fc =
fc fc fc fa fb
[  110.240145][ T5869]  ffff888071891a80: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[  110.248590][ T5869] >ffff888071891b00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[  110.257376][ T5869]                                            ^
[  110.263723][ T5869]  ffff888071891b80: fb fb fb fb fb fc fc fc fc fc fc =
fc fc fa fb fb
[  110.272360][ T5869]  ffff888071891c00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
[  110.280656][ T5869] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  110.290650][ T5869] Kernel panic - not syncing: KASAN: panic_on_warn set=
 ...
[  110.298787][ T5869] CPU: 1 UID: 0 PID: 5869 Comm: syz-executor Not taint=
ed 6.16.0-rc1-syzkaller-g19272b37aa4f-dirty #0 PREEMPT(full)=20
[  110.311806][ T5869] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[  110.321979][ T5869] Call Trace:
[  110.325949][ T5869]  <TASK>
[  110.329265][ T5869]  dump_stack_lvl+0x3d/0x1f0
[  110.334799][ T5869]  panic+0x71c/0x800
[  110.338998][ T5869]  ? __pfx_panic+0x10/0x10
[  110.343613][ T5869]  ? rcu_is_watching+0x12/0xc0
[  110.348630][ T5869]  ? irqentry_exit+0x3b/0x90
[  110.353343][ T5869]  ? lockdep_hardirqs_on+0x7c/0x110
[  110.358844][ T5869]  ? _raw_spin_lock+0x2e/0x40
[  110.363634][ T5869]  ? check_panic_on_warn+0x1f/0xb0
[  110.368878][ T5869]  ? _raw_spin_lock+0x2e/0x40
[  110.373779][ T5869]  check_panic_on_warn+0xab/0xb0
[  110.378848][ T5869]  end_report+0x107/0x170
[  110.383308][ T5869]  kasan_report+0xee/0x110
[  110.387745][ T5869]  ? _raw_spin_lock+0x2e/0x40
[  110.392640][ T5869]  ? _raw_spin_lock+0x2e/0x40
[  110.397603][ T5869]  __kasan_check_byte+0x36/0x50
[  110.402600][ T5869]  lock_acquire+0xfc/0x350
[  110.407153][ T5869]  _raw_spin_lock+0x2e/0x40
[  110.411773][ T5869]  ? lockref_get+0x15/0x50
[  110.416402][ T5869]  lockref_get+0x15/0x50
[  110.420955][ T5869]  simple_recursive_removal+0x3b/0x690
[  110.426702][ T5869]  ? do_raw_spin_unlock+0x172/0x230
[  110.431959][ T5869]  ? __pfx_remove_one+0x10/0x10
[  110.436933][ T5869]  ? mntput+0x10/0x90
[  110.441117][ T5869]  debugfs_remove+0x5d/0x80
[  110.446166][ T5869]  hci_release_dev+0x8c/0x600
[  110.450960][ T5869]  ? __pfx_hci_release_dev+0x10/0x10
[  110.456565][ T5869]  ? rcu_is_watching+0x12/0xc0
[  110.461363][ T5869]  ? kfree+0x24f/0x4d0
[  110.465635][ T5869]  bt_host_release+0x6a/0xb0
[  110.470427][ T5869]  ? __pfx_bt_host_release+0x10/0x10
[  110.475842][ T5869]  device_release+0xa1/0x240
[  110.480576][ T5869]  kobject_put+0x1e7/0x5a0
[  110.485098][ T5869]  ? __pfx_vhci_release+0x10/0x10
[  110.490263][ T5869]  put_device+0x1f/0x30
[  110.494492][ T5869]  vhci_release+0xb5/0x130
[  110.499490][ T5869]  __fput+0x402/0xb70
[  110.503813][ T5869]  task_work_run+0x150/0x240
[  110.508637][ T5869]  ? __pfx_task_work_run+0x10/0x10
[  110.514088][ T5869]  do_exit+0x864/0x2bd0
[  110.518757][ T5869]  ? __pfx_do_exit+0x10/0x10
[  110.523385][ T5869]  ? do_raw_spin_lock+0x12c/0x2b0
[  110.528713][ T5869]  ? find_held_lock+0x2b/0x80
[  110.533506][ T5869]  do_group_exit+0xd3/0x2a0
[  110.538221][ T5869]  get_signal+0x2673/0x26d0
[  110.542932][ T5869]  ? __pfx_get_signal+0x10/0x10
[  110.548742][ T5869]  ? kmem_cache_free+0x16d/0x4d0
[  110.553909][ T5869]  ? __fput+0x68d/0xb70
[  110.558187][ T5869]  arch_do_signal_or_restart+0x8f/0x790
[  110.564061][ T5869]  ? __fput+0x68d/0xb70
[  110.568918][ T5869]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  110.575472][ T5869]  ? __pfx_fput_close_sync+0x10/0x10
[  110.580949][ T5869]  ? dnotify_flush+0x79/0x4c0
[  110.585856][ T5869]  exit_to_user_mode_loop+0x84/0x110
[  110.591259][ T5869]  do_syscall_64+0x3f6/0x490
[  110.595889][ T5869]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  110.602107][ T5869] RIP: 0033:0x7f6845b8d5ca
[  110.606681][ T5869] Code: Unable to access opcode bytes at 0x7f6845b8d5a=
0.
[  110.613977][ T5869] RSP: 002b:00007ffefac60c40 EFLAGS: 00000293 ORIG_RAX=
: 0000000000000003
[  110.622786][ T5869] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000=
07f6845b8d5ca
[  110.630784][ T5869] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000003
[  110.638860][ T5869] RBP: 00007ffefac60c9c R08: 0000000000000000 R09: 000=
07ffefac609a7
[  110.647030][ T5869] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000001
[  110.655018][ T5869] R13: 00000000000927c0 R14: 000000000001aa36 R15: 000=
07ffefac60cf0
[  110.663275][ T5869]  </TASK>
[  110.667034][ T5869] Kernel Offset: disabled
[  110.671574][ T5869] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-=
go1.23.7.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0=
.1-go1.23.7.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.7'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3640950295=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 3d2f584dd
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D3d2f584ddab119da50e8a8d26765aa98d3b33c02 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250528-144826"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"3d2f584ddab119da50e8a8d26765aa98d3=
b33c02\"
/usr/bin/ld: /tmp/ccd8Gt78.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12b67570580000


Tested on:

commit:         19272b37 Linux 6.16-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc4c8362784bb779=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac3c79181f6aecc51=
20c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D130d8a0c5800=
00

