Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860E21CA1B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413821; cv=none; b=SHo9/7A7Q1f61L18DOsWmSg0S0T809ociRwJ481G3KW32AE94l2X55lQMazXVtv+i8ZHa1kgVdtgsLYaqkEhVpAKvLhyIUhR24Hh4b6c8OoxP2KOe/74YISfjTv5UG97ZQr7Q+G/CTkVKpoF1DN/2sk4Tzi85WmCyfNT2BRuINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413821; c=relaxed/simple;
	bh=lg6u9TPTvq3CeOlSx8vcUuS7IhWzcEU4lkI2vTLVnLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8DEcu5pZGGnoTuwXVy+illLZMOsIAr24VZMuYTiOe1oHVIwpG9Ywz4efPwT26mry0q88OMzRMhYtsZuMFolXr9XNBM3Z2t0wfnektJl813a7c2L5dyFQ1X3ZfE8Vl+zMjvqiZwb00bgyVexgImshCI92qbTQiSKwBIP0nfWP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrLpRK+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrLpRK+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D83C4CED1;
	Thu,  5 Dec 2024 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733413819;
	bh=lg6u9TPTvq3CeOlSx8vcUuS7IhWzcEU4lkI2vTLVnLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrLpRK+O5Y3WoemUTA3sXlYX+GxeWQVkFBJ6bmSYziqAFSc7myg6VJwQQGDhjV4Lh
	 lDf5pyEqv+KagFQ8EQG1DXwqkbrBY3GtbNpTxoaNUnnB2YHAyJRhf6UWmSUorGV6mO
	 GioL6anyNwaT/FDyQM/HQH30/zSN2zwErIXl+ab2aDSTTXSRkG5v65NidzHDcxJPem
	 E2arUNdh1tHu4SXIk9zkVORiGYqra/tqUOLrZ3jNqhbAi9tn1j6WVaNZYfXWX8H45T
	 R6YAb1PmYuBqNw+bOqO4Yy9ttrAU5cvU2xbOksfuE3biHAnRLJcPJjYIE8Fzy1fqJs
	 bLbT7+0t6Q3Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB37E380A951;
	Thu,  5 Dec 2024 15:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix sleeping function called from
 invalid context
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173341383349.1962790.14997103267506754471.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 15:50:33 +0000
References: <20241204165849.392564-2-luiz.dentz@gmail.com>
In-Reply-To: <20241204165849.392564-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Dec 2024 11:58:49 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
> like the bellow:
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworker/u9:2
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by kworker/u9:2/5070:
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
>  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:6939
>  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
>  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
>  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_core: Fix sleeping function called from invalid context
    https://git.kernel.org/bluetooth/bluetooth-next/c/20c9afdfb287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


