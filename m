Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747C3B9943;
	Sat,  6 Jun 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776416; cv=none; b=REVgc6PuDzZs2ElfOeKrNpel+K8Ow0S+P5/ux7BEfo4NhKjmZ4XJr2xMhQf2mdqfiqCpsWRuDKH5q0gIc+X3xOY1553eX+UvZhwgqbqP7kacwsQV9WgAE8DvuGjLcaHLQG420oZ9ZcjfJWlWJW1SYifE1crk8fTljeVEHnvlTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776416; c=relaxed/simple;
	bh=iKjt7lAdFhshpI9TT4ivazz0Y+qohYQCVYV6npG1dMo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jJMF2Oe0Jk5Vl715jsWIu8W/aHlT4vT42RQk2Gbi5P9N3X0eNg6Od04FdDorqAljy50OQtILhAIt+XFao2Ubv3SyWZoEhgNekCba/LqyqgAQqyJXT9BPwItnxGAxroeuqfA1v/6WRfgu2KR0psKXnHo2YKqHHPXaSQCx8UTNWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X8lRIOAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X8lRIOAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA11F00893;
	Sat,  6 Jun 2026 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780776415;
	bh=qa5POJ66Fhb7XWJUEzlpeoKcCg4M+FUsDrfjmTiyXQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X8lRIOAC/5y0jTnBZVDufh+G9szVlK547lyO8h5LcLyFWPzMzbDr8NZnDPF9kiZbb
	 Mnwrg9q6MP1QZJSTC6nSLG7euSQUI3jQiHnMWR9Ldb7T77pgOWlTCR0hVQDHFTk7Dl
	 pWpRmwrCmyTiHzqyPfbScM4kKOMyXPuH5baWctQo=
Date: Sat, 6 Jun 2026 13:06:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+8b331cede7bfea7c674c@syzkaller.appspotmail.com>
Cc: jannh@google.com, liam@infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ljs@kernel.org, pfalcato@suse.de,
 syzkaller-bugs@googlegroups.com, vbabka@kernel.org, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [syzbot] [mm?] upstream test error: WARNING in call_timer_fn
Message-Id: <20260606130654.e4374528274cea6ec83397ea@linux-foundation.org>
In-Reply-To: <6a246fb8.c25708ab.1b19ef.0009.GAE@google.com>
References: <6a246fb8.c25708ab.1b19ef.0009.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 12:06:32 -0700 syzbot <syzbot+8b331cede7bfea7c674c@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ba3e43a9e601 Merge tag 'soc-fixes-7.1-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12180f2e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b4166e8ea5fbf7e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=8b331cede7bfea7c674c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Thanks.

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ba3e43a9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/721f1d5136ec/vmlinux-ba3e43a9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ff33eef1aaee/bzImage-ba3e43a9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8b331cede7bfea7c674c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> workqueue: cannot queue hci_cmd_timeout on wq hci0

Looks like a bluetooth thing.  Cc's added.

> WARNING: kernel/workqueue.c:2298 at __queue_work+0xd3f/0x1040 kernel/workqueue.c:2296, CPU#0: syz-executor/5425
> Modules linked in:
> CPU: 0 UID: 0 PID: 5425 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__queue_work+0xd67/0x1040 kernel/workqueue.c:2296
> Code: a6 0e 49 8d 7d 18 48 89 f8 48 c1 e8 03 42 80 3c 20 00 74 05 e8 7a 7b a5 00 49 8b 75 18 49 81 c7 70 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef
> RSP: 0000:ffffc90000007bd8 EFLAGS: 00010082
> RAX: 1ffff1100259b94e RBX: 0000000000000008 RCX: ffff8880336a2540
> RDX: ffff888041425170 RSI: ffffffff8a9c7e10 RDI: ffffffff90334eb0
> RBP: 0000000000000100 R08: ffffffff90304ff7 R09: 1ffffffff20609fe
> R10: dffffc0000000000 R11: ffffffff818d37e0 R12: dffffc0000000000
> R13: ffff888012cdca58 R14: ffffffff90334eb0 R15: ffff888041425170
> FS:  0000000000000000(0000) GS:ffff88808c891000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2fa63fff CR3: 0000000012c0c000 CR4: 0000000000352ef0
> Call Trace:
>  <IRQ>
>  call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1794 [inline]
>  __run_timers kernel/time/timer.c:2374 [inline]
>  __run_timer_base+0x67e/0x8b0 kernel/time/timer.c:2386
>  run_timer_base kernel/time/timer.c:2395 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>  handle_softirqs+0x22a/0x840 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:97 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:115 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:140 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:172 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:191 [inline]
> RIP: 0010:kasan_check_range+0x90/0x2c0 mm/kasan/generic.c:200
> Code: 03 48 bb 01 00 00 00 00 fc ff df 4d 8d 34 19 4d 89 f4 4d 29 dc 49 83 fc 10 7f 29 4d 85 e4 0f 84 3d 01 00 00 4c 89 cb 48 f7 d3 <4c> 01 fb 41 80 3b 00 0f 85 9e 01 00 00 49 ff c3 48 ff c3 75 ee e9
> RSP: 0000:ffffc9000e2bf240 EFLAGS: 00000202
> RAX: 1ffff92001c57e01 RBX: e00006dffe3a8187 RCX: ffffffff8176f0e3
> RDX: 0000000000000001 RSI: 0000000000000010 RDI: ffffc9000e2bf3b8
> RBP: 0000000000000000 R08: ffffc9000e2bf3c7 R09: 1ffff92001c57e78
> R10: dffffc0000000000 R11: fffff52001c57e77 R12: 0000000000000002
> R13: 1ffff92001c57e6f R14: fffff52001c57e79 R15: 1ffff92001c57e77
>  __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
>  unwind_next_frame+0xf33/0x2550 arch/x86/kernel/unwind_orc.c:621
>  arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
>  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
>  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
>  __call_rcu_common kernel/rcu/tree.c:3131 [inline]
>  call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
>  slab_free_hook mm/slub.c:2653 [inline]
>  slab_free mm/slub.c:6251 [inline]
>  kmem_cache_free+0x462/0x650 mm/slub.c:6378
>  tear_down_vmas+0x312/0x520 mm/mmap.c:1262
>  exit_mmap+0x4b6/0x9e0 mm/mmap.c:1320
>  __mmput+0x118/0x430 kernel/fork.c:1178
>  exit_mm+0x1f6/0x2d0 kernel/exit.c:582
>  do_exit+0x6a2/0x22c0 kernel/exit.c:964
>  do_group_exit+0x21b/0x2d0 kernel/exit.c:1119
>  get_signal+0x1284/0x1330 kernel/signal.c:3037
>  arch_do_signal_or_restart+0xbc/0x840 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
>  exit_to_user_mode_loop+0xa9/0x680 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>  do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f328ef57fd7
> Code: Unable to access opcode bytes at 0x7f328ef57fad.
> RSP: 002b:00007ffd7ad34110 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
> RAX: fffffffffffffe00 RBX: 0000555594d02500 RCX: 00007f328ef57fd7
> RDX: 0000000040000000 RSI: 00007ffd7ad3416c RDI: ffffffffffffffff
> RBP: 00007ffd7ad3416c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd7ad341e8
> R13: 0000000000000002 R14: 00007ffd7ad343c8 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:	49 8d 7d 18          	lea    0x18(%r13),%rdi
>    4:	48 89 f8             	mov    %rdi,%rax
>    7:	48 c1 e8 03          	shr    $0x3,%rax
>    b:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
>   10:	74 05                	je     0x17
>   12:	e8 7a 7b a5 00       	call   0xa57b91
>   17:	49 8b 75 18          	mov    0x18(%r13),%rsi
>   1b:	49 81 c7 70 01 00 00 	add    $0x170,%r15
>   22:	4c 89 f7             	mov    %r14,%rdi
>   25:	4c 89 fa             	mov    %r15,%rdx
> * 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>   2d:	4c 89 e8             	mov    %r13,%rax
>   30:	48 c1 e8 03          	shr    $0x3,%rax
>   34:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
>   39:	74 08                	je     0x43
>   3b:	4c 89 ef             	mov    %r13,%rdi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
