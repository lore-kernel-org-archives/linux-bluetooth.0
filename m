Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530B1F8AC0;
	Tue, 11 Feb 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272252; cv=none; b=tEca2Kt0umgO9k68QKiX6KeaEuJeZlrqkfXR0599M8QoQ/5tQAECiRO0vN39PZVp1bxj+X9Ddm8RsMCZo5FqfY/0RP4/E5VAvYc86JW1UmZMSk120CPgK4RMsmB3oPuifNBwY9fKyKqTiq2nLb+3JVX2RPX4IgkhhEj9pa8pH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272252; c=relaxed/simple;
	bh=i5sODxIgvXqnCqYayWXfbHvRXo3GQ98uAjuEhD+ByYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bssnJT/NAEL65LrEOCFigYPYzJ9YloM8lU0uXdx5puUkpvPM9EyjtwAGDGsJueFzTvUcVslQYou+mcIo8QvoYbg9m/DPf44ULV+TOTRHgycJtr6WrbAlaOG8S9o6Y+yDW/dxaMX3kuYjjKbjyiR8XA8SJYwsw2mY5C92ow6UEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm+RNu06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm+RNu06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6E7C4CEDD;
	Tue, 11 Feb 2025 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739272252;
	bh=i5sODxIgvXqnCqYayWXfbHvRXo3GQ98uAjuEhD+ByYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jm+RNu06F4e4vKW1xlr6oSOIR/bIHS0LXBFRre9vVLu/nBIk8TI6crnLtQ9v/vPgf
	 FkP0Ea3/OsTvA/HL2Zlo1KWQWYLhm3u13CfMu2mELW50n0QKC9Csf8YRKOVcinndez
	 E0RdpsDxZ5hmUUK2yK+0vh1Pt3W6WuGIIiK4Fdda4ivnGG6IwfhS0q2TLbJM/XxRL7
	 Uu6eTnXauZpeo4zFrVybYhjJYUhQZDVpEhGsrddVeWKVnz6a4OcxuMQuia9Hx25RaU
	 Vy/BQb3CWrCfdii16hq9xR1JCmAMmsR1apH/8fo8RWWondjzso7FzGNAQSTIlmSfO7
	 CCgtU2WwRrZPQ==
Date: Tue, 11 Feb 2025 11:10:46 +0000
From: Will Deacon <will@kernel.org>
To: syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	maz@kernel.org, mark.rutland@arm.com, richard.xnu.clark@gmail.com,
	jiangshanlai@gmail.com, tj@kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [syzbot] [arm?] WARNING in delayed_work_timer_fn
Message-ID: <20250211111045.GA8885@willie-the-truck>
References: <00000000000046efb605fec3def0@google.com>
 <675c28e0.050a0220.17d782.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675c28e0.050a0220.17d782.000d.GAE@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

[+ some other folks]

On Fri, Dec 13, 2024 at 04:30:24AM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2e7aff49b5da Merge branches 'for-next/core' and 'for-next/..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ed5be8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=696fb014d05da3a3
> dashboard link: https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10192d44580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef408f67fde3/disk-2e7aff49.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/414ac17a20dc/vmlinux-2e7aff49.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a93415d2a7e7/Image-2e7aff49.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com

I spent a bit of time looking at the reports in the "dashboard link"
above. There are quite a few in there and I ended up suspecting the
bluetooth subsystem and drivers using hci_register_dev(). Specifically,
it looks like one of the workqueues is serviced in softirq context after
its corresponding device has been destroyed.

I wasn't able to reproduce it locally (I don't have a setup for running
the 'syz' reproducers), but the program is pretty small (see the "syz repro"
link above).

Given that this seems to explode a few times a month, I wonder if it's
worth adding some instrumentation to e.g. dump the name of the workqueue?

Will

--->8

(mammoth backtrace below)

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 current_wq_worker kernel/workqueue_internal.h:69 [inline]
> WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 is_chained_work kernel/workqueue.c:2199 [inline]
> WARNING: CPU: 1 PID: 6023 at kernel/workqueue.c:2257 __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
> Modules linked in:
> CPU: 1 UID: 0 PID: 6023 Comm: klogd Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __queue_work+0xe50/0x1308 kernel/workqueue_internal.h:69
> lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
> lr : is_chained_work kernel/workqueue.c:2199 [inline]
> lr : __queue_work+0xe50/0x1308 kernel/workqueue.c:2256
> sp : ffff800080017b40
> x29: ffff800080017b90 x28: dfff800000000000 x27: ffff700010002f88
> x26: dfff800000000000 x25: ffff0000d1c63800 x24: 0000000000000008
> x23: 1fffe0001b14d791 x22: ffff0000d1c639c0 x21: 0000000000000100
> x20: ffff0000d8a6bc80 x19: ffff0000da2f0930 x18: 1fffe000366c5e7e
> x17: ffff800123d64000 x16: ffff80008326d65c x15: 0000000000000002
> x14: 1ffff00011f300ca x13: dfff800000000000 x12: 00000000b1aebe1c
> x11: 00000000beaa9035 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d8a6bc80 x7 : ffff8000805819c0 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008df6a320
> x2 : ffff0000da2f0930 x1 : 0000000000000100 x0 : 0000000000000000
> Call trace:
>  current_wq_worker kernel/workqueue_internal.h:69 [inline] (P)
>  is_chained_work kernel/workqueue.c:2199 [inline] (P)
>  __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (P)
>  current_wq_worker kernel/workqueue_internal.h:69 [inline] (L)
>  is_chained_work kernel/workqueue.c:2199 [inline] (L)
>  __queue_work+0xe50/0x1308 kernel/workqueue.c:2256 (L)
>  delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:2485
>  call_timer_fn+0x1b4/0x8b8 kernel/time/timer.c:1793
>  expire_timers kernel/time/timer.c:1839 [inline]
>  __run_timers kernel/time/timer.c:2418 [inline]
>  __run_timer_base+0x59c/0x7b4 kernel/time/timer.c:2430
>  run_timer_base kernel/time/timer.c:2439 [inline]
>  run_timer_softirq+0xcc/0x194 kernel/time/timer.c:2449
>  handle_softirqs+0x320/0xd34 kernel/softirq.c:554
>  __do_softirq+0x14/0x20 kernel/softirq.c:588
>  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
>  call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
>  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:86
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0x1d8/0x544 kernel/softirq.c:655
>  irq_exit_rcu+0x14/0x84 kernel/softirq.c:671
>  __el1_irq arch/arm64/kernel/entry-common.c:561 [inline]
>  el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:575
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
>  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
>  raw_spin_rq_unlock_irq kernel/sched/sched.h:1526 [inline] (P)
>  finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5123 (P)
>  raw_spin_rq_unlock_irq kernel/sched/sched.h:1526 [inline] (L)
>  finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5123 (L)
>  finish_task_switch+0x120/0x608 kernel/sched/core.c:5241
>  context_switch kernel/sched/core.c:5372 [inline]
>  __schedule+0x1748/0x27f0 kernel/sched/core.c:6756
>  preempt_schedule_irq+0x80/0x188 kernel/sched/core.c:7078
>  arm64_preempt_schedule_irq arch/arm64/kernel/entry-common.c:301 [inline]
>  __el1_irq arch/arm64/kernel/entry-common.c:563 [inline]
>  el1_interrupt+0x4c/0x68 arch/arm64/kernel/entry-common.c:575
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
>  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
>  do_notify_resume+0x5c/0x1f4 arch/arm64/kernel/entry-common.c:133 (P)
>  do_notify_resume+0x58/0x1f4 arch/arm64/kernel/entry-common.c:133 (L)
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_interrupt+0xc8/0x248 arch/arm64/kernel/entry-common.c:832
>  __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:837
>  el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:842
>  el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:601
> irq event stamp: 35689
> hardirqs last  enabled at (35688): [<ffff80008b687f2c>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
> hardirqs last  enabled at (35688): [<ffff80008b687f2c>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
> hardirqs last disabled at (35689): [<ffff80008b6a9b44>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
> hardirqs last disabled at (35689): [<ffff80008b6a9b44>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
> softirqs last  enabled at (34558): [<ffff800080129934>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (35685): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
