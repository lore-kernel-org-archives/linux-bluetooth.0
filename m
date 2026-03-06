Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FE36F406
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822406; cv=none; b=m5TK035HLvZoAxisP+/tp7BEmD1QUJUJIslovH+N1RNRosbHUh4i1INHSTUR50ZPPkRSp6bM7vTbMNYKWrRXlEDw76/Ch82OgVs64LWMZbmsWCBYmWs122XlPKgjbpozoePtDZAhkDjQvWewFjw0iy8uJ9vUU8rPBvUZ5l6wh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822406; c=relaxed/simple;
	bh=dBXTi0aGdn2e6IOZ/F0I5mY3OxBFW5ndFjbDTeHFovA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ecd6PVbPe1Dq8j9ZV0JPuRAb8qsi+DsKHftzwsKylMFpowuSQRtrg1UMnEsw6+1YzC4JQzq+DjFqeOCJ65nQ2s/JyBOFmoJiOnP6dOrKFudCvjOD7qtM7HZ2zPNTQJ4/yBgiksKcmNylvtQiWqDJXARWyhCbqCK2LdDBfGLT40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyHeoEeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyHeoEeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E1DC4CEF7;
	Fri,  6 Mar 2026 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822405;
	bh=dBXTi0aGdn2e6IOZ/F0I5mY3OxBFW5ndFjbDTeHFovA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cyHeoEeXTxwyepmawCgHh/7IH10zUhIW6DDVyHJqP2RJ3XmNnDa3UsD7pNBcnBTmj
	 M4R1fJV8cB29EikLBN7EA6hFenV1omdaFjvAA2REGgAxwrdLnQkhzMx0ny0GmKUxLA
	 w5TdwRSp1+Tpv2udjei2kU2KATv50fnj1/TaGOM5VrRwZDPOzA3TMG+jAHYsvgWzWx
	 eQkpE75w9OHSXEGfAHmMMoXe7WTkQv+OPMu4krtobrY7w5wjOS7ZqTR/Og02MhZdHz
	 kOQJ0KZXGB1fT9GOYlUBLm0ANcgBZEdoeVDtH+pprun6D5RkXINBKfFzy3qlKaRutv
	 6lWVahYmbCqiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE8C3808200;
	Fri,  6 Mar 2026 18:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: HIDP: Fix possible UAF
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177282240479.8285.6260187669488887341.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 18:40:04 +0000
References: <20260306023155.554597-1-luiz.dentz@gmail.com>
In-Reply-To: <20260306023155.554597-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Mar 2026 21:31:55 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace caused by not dropping l2cap_conn
> reference when user->remove callback is called:
> 
> [   97.809249] l2cap_conn_free: freeing conn ffff88810a171c00
> [   97.809907] CPU: 1 UID: 0 PID: 1419 Comm: repro_standalon Not tainted 7.0.0-rc1-dirty #14 PREEMPT(lazy)
> [   97.809935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [   97.809947] Call Trace:
> [   97.809954]  <TASK>
> [   97.809961]  dump_stack_lvl (lib/dump_stack.c:122)
> [   97.809990]  l2cap_conn_free (net/bluetooth/l2cap_core.c:1808)
> [   97.810017]  l2cap_conn_del (./include/linux/kref.h:66 net/bluetooth/l2cap_core.c:1821 net/bluetooth/l2cap_core.c:1798)
> [   97.810055]  l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:7347 (discriminator 1) net/bluetooth/l2cap_core.c:7340 (discriminator 1))
> [   97.810086]  ? __pfx_l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:7341)
> [   97.810117]  hci_conn_hash_flush (./include/net/bluetooth/hci_core.h:2152 (discriminator 2) net/bluetooth/hci_conn.c:2644 (discriminator 2))
> [   97.810148]  hci_dev_close_sync (net/bluetooth/hci_sync.c:5360)
> [   97.810180]  ? __pfx_hci_dev_close_sync (net/bluetooth/hci_sync.c:5285)
> [   97.810212]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810242]  ? up_write (./arch/x86/include/asm/atomic64_64.h:87 (discriminator 5) ./include/linux/atomic/atomic-arch-fallback.h:2852 (discriminator 5) ./include/linux/atomic/atomic-long.h:268 (discriminator 5) ./include/linux/atomic/atomic-instrumented.h:3391 (discriminator 5) kernel/locking/rwsem.c:1385 (discriminator 5) kernel/locking/rwsem.c:1643 (discriminator 5))
> [   97.810267]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810290]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tracking.h:128 kernel/rcu/tree.c:752)
> [   97.810320]  hci_unregister_dev (net/bluetooth/hci_core.c:504 net/bluetooth/hci_core.c:2716)
> [   97.810346]  vhci_release (drivers/bluetooth/hci_vhci.c:691)
> [   97.810375]  ? __pfx_vhci_release (drivers/bluetooth/hci_vhci.c:678)
> [   97.810404]  __fput (fs/file_table.c:470)
> [   97.810430]  task_work_run (kernel/task_work.c:235)
> [   97.810451]  ? __pfx_task_work_run (kernel/task_work.c:201)
> [   97.810472]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810495]  ? do_raw_spin_unlock (./include/asm-generic/qspinlock.h:128 (discriminator 5) kernel/locking/spinlock_debug.c:142 (discriminator 5))
> [   97.810527]  do_exit (kernel/exit.c:972)
> [   97.810547]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810574]  ? __pfx_do_exit (kernel/exit.c:897)
> [   97.810594]  ? lock_acquire (kernel/locking/lockdep.c:470 (discriminator 6) kernel/locking/lockdep.c:5870 (discriminator 6) kernel/locking/lockdep.c:5825 (discriminator 6))
> [   97.810616]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810639]  ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:95 (discriminator 4) kernel/locking/spinlock_debug.c:118 (discriminator 4))
> [   97.810664]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810688]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
> [   97.810721]  do_group_exit (kernel/exit.c:1093)
> [   97.810745]  get_signal (kernel/signal.c:3007 (discriminator 1))
> [   97.810772]  ? security_file_permission (./arch/x86/include/asm/jump_label.h:37 security/security.c:2366)
> [   97.810803]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810826]  ? vfs_read (fs/read_write.c:555)
> [   97.810854]  ? __pfx_get_signal (kernel/signal.c:2800)
> [   97.810880]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810905]  ? __pfx_vfs_read (fs/read_write.c:555)
> [   97.810932]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810960]  arch_do_signal_or_restart (arch/x86/kernel/signal.c:337 (discriminator 1))
> [   97.810990]  ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal.c:334)
> [   97.811021]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811055]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811078]  ? ksys_read (fs/read_write.c:707)
> [   97.811106]  ? __pfx_ksys_read (fs/read_write.c:707)
> [   97.811137]  exit_to_user_mode_loop (kernel/entry/common.c:66 kernel/entry/common.c:98)
> [   97.811169]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tracking.h:128 kernel/rcu/tree.c:752)
> [   97.811192]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811215]  ? trace_hardirqs_off (./include/trace/events/preemptirq.h:36 (discriminator 33) kernel/trace/trace_preemptirq.c:95 (discriminator 33) kernel/trace/trace_preemptirq.c:90 (discriminator 33))
> [   97.811240]  do_syscall_64 (./include/linux/irq-entry-common.h:226 ./include/linux/irq-entry-common.h:256 ./include/linux/entry-common.h:325 arch/x86/entry/syscall_64.c:100)
> [   97.811268]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811292]  ? exc_page_fault (arch/x86/mm/fault.c:1480 (discriminator 3) arch/x86/mm/fault.c:1527 (discriminator 3))
> [   97.811318]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   97.811338] RIP: 0033:0x445cfe
> [   97.811352] Code: Unable to access opcode bytes at 0x445cd4.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: HIDP: Fix possible UAF
    https://git.kernel.org/bluetooth/bluetooth-next/c/708efc5f2338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


