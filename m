Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE71F3B89;
	Thu, 13 Mar 2025 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894264; cv=none; b=ExpOrzTZJSGt+w1EVEYeGxMf+nLFpYlYDhom/gpXXt97c5vnjiQYPu9CFrETDK9WN7OUJ/bxuURc4h/yVGT+XtK1wDTqlf+2NCtZG5Ef3cYUCWhfEGJ7LnCWmUAVSamlvDTLKvqgjAbFxUxoz0BYf592KrHFXSOWVZfnndbKiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894264; c=relaxed/simple;
	bh=atuEPx6iJ0rL6pAp8s4JxhvT/PcR6fvU8+nzY8V+xV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDveFWyK2/XQ0jU4U+d5xVrnkV9+UkxEx4F/v7fdA2JkCpxdGlz+2LqdNG4l1rJi7GgDfJqCmxsj91FhOFu1vPi4Zee5yFVT7yn9hU0vg2eajem/k5gKnDFgfmG5od+hLyvcWeJBmSpNc76YmtZi0EZy3OFU7uqDFXlSCwHuWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSLkm0PE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSLkm0PE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF8C4CEDD;
	Thu, 13 Mar 2025 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741894264;
	bh=atuEPx6iJ0rL6pAp8s4JxhvT/PcR6fvU8+nzY8V+xV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSLkm0PEB/nEkfB+lJaIzvAQ7L1e9w7uj+UMZdHuZQCOB4iQpUXJdZmWmerWocpVx
	 aE7FglW70BbEcvyN5HvQmj04tw4t6ybOZV+OeS1XI2T+tg7Qg1PPB/Mudzr8NIhZ5u
	 /990C02GaqNbfKue+E5EY33t+nj2Y8V6ggKYwSwOyvvSuFIHywGBOOAsKRKJQTpWGg
	 kv0aghyYMYOmbHgHJdZn2RM5K4y2QyNtRebzKQsQ6mFsnxtl1QOzrDFn9p/CZ0sLao
	 beac0BkXH50LyxdJ6H+wPky6qMiQRrXHEXwKxMoyC0dPjk0aDxSgVkEeeaHg/gScZl
	 OZIL2Ms5F0KyQ==
Date: Thu, 13 Mar 2025 19:30:58 +0000
From: Will Deacon <will@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	maz@kernel.org, mark.rutland@arm.com, richard.xnu.clark@gmail.com,
	jiangshanlai@gmail.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [syzbot] [arm?] WARNING in delayed_work_timer_fn
Message-ID: <20250313193057.GA7784@willie-the-truck>
References: <00000000000046efb605fec3def0@google.com>
 <675c28e0.050a0220.17d782.000d.GAE@google.com>
 <20250211111045.GA8885@willie-the-truck>
 <Z6u6MgaJWMpjCn4O@slm.duckdns.org>
 <20250214164556.GA13743@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214164556.GA13743@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Feb 14, 2025 at 04:45:57PM +0000, Will Deacon wrote:
> On Tue, Feb 11, 2025 at 10:59:30AM -1000, Tejun Heo wrote:
> > On Tue, Feb 11, 2025 at 11:10:46AM +0000, Will Deacon wrote:
> > > Given that this seems to explode a few times a month, I wonder if it's
> > > worth adding some instrumentation to e.g. dump the name of the workqueue?
> > 
> > It's usually most useful to print out the work function when identifying the
> > culprit. I'd be happy to take the patch.
> 
> Thanks, Tejun. I sent a patch adding some more diagnostics:
> 
> https://lore.kernel.org/r/20250214164349.13694-1-will@kernel.org

Ok, we have our first crash [1] with the new debug information:

[   77.133818][   T10] Bluetooth: hci3: Opcode 0x0c1a failed: -110
[   77.135329][   T10] Bluetooth: hci3: Error when powering off device on rfkill (-110)
[   77.143656][    C1] ------------[ cut here ]------------
[   77.145336][    C1] workqueue: cannot queue hci_cmd_timeout on wq hci3
[   77.147101][    C1] WARNING: CPU: 1 PID: 7433 at kernel/workqueue.c:2258 __queue_work+0xe94/0x1324
[   77.149301][    C1] Modules linked in:
[   77.150287][    C1] CPU: 1 UID: 0 PID: 7433 Comm: syz.2.193 Not tainted 6.14.0-rc5-syzkaller-g77c95b8c7a16 #0
[   77.152960][    C1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
[   77.155583][    C1] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   77.157546][    C1] pc : __queue_work+0xe94/0x1324
[   77.158811][    C1] lr : __queue_work+0xe94/0x1324
[   77.160114][    C1] sp : ffff800080017b40
[   77.161145][    C1] x29: ffff800080017b90 x28: dfff800000000000 x27: ffff700010002f88
[   77.163285][    C1] x26: ffff80008fbbd600 x25: ffff0000dacac800 x24: 0000000000000008
[   77.165326][    C1] x23: ffff0000dacac9c0 x22: 0000000000000100 x21: 1fffe0001b595938
[   77.167421][    C1] x20: ffff800092f09000 x19: ffff0000ecf20948 x18: 0000000000000008
[   77.169356][    C1] x17: 0000000000000000 x16: ffff80008b72ce6c x15: ffff700011f87b38
[   77.171279][    C1] x14: 1ffff00011f87b38 x13: 0000000000000004 x12: ffffffffffffffff
[   77.173271][    C1] x11: 0000000000000103 x10: 0000000000ff0100 x9 : d5bcdc7e4519df00
[   77.175255][    C1] x8 : d5bcdc7e4519df00 x7 : 0000000000000001 x6 : 0000000000000001
[   77.177277][    C1] x5 : ffff8000800172f8 x4 : ffff80008fcaf7c0 x3 : ffff8000804a7bb4
[   77.179372][    C1] x2 : 0000000000000000 x1 : 0000000100000101 x0 : 0000000000000000
[   77.181374][    C1] Call trace:
[   77.182230][    C1]  __queue_work+0xe94/0x1324 (P)
[   77.183476][    C1]  delayed_work_timer_fn+0x74/0x90
[   77.184755][    C1]  call_timer_fn+0x1b4/0x8b8
[   77.185932][    C1]  __run_timer_base+0x59c/0x7b4
[   77.187119][    C1]  run_timer_softirq+0xcc/0x194
[   77.188360][    C1]  handle_softirqs+0x320/0xd34
[   77.189576][    C1]  __do_softirq+0x14/0x20
[   77.190672][    C1]  ____do_softirq+0x14/0x20
[   77.191884][    C1]  call_on_irq_stack+0x24/0x4c
[   77.193050][    C1]  do_softirq_own_stack+0x20/0x2c
[   77.194311][    C1]  __irq_exit_rcu+0x1d8/0x544
[   77.195550][    C1]  irq_exit_rcu+0x14/0x84
[   77.196669][    C1]  el1_interrupt+0x38/0x68
[   77.197818][    C1]  el1h_64_irq_handler+0x18/0x24
[   77.199152][    C1]  el1h_64_irq+0x6c/0x70
[   77.200245][    C1]  lock_acquire+0x278/0x724 (P)
[   77.201520][    C1]  rcu_lock_acquire+0x44/0x54
[   77.202722][    C1]  page_ext_get+0x2c/0x2e8
[   77.203908][    C1]  page_table_check_set+0xa0/0x408
[   77.205117][    C1]  __page_table_check_ptes_set+0x2d0/0x398
[   77.206601][    C1]  set_pte_range+0x618/0x644
[   77.207792][    C1]  finish_fault+0x968/0xd6c
[   77.208968][    C1]  handle_pte_fault+0x3528/0x57b0
[   77.210314][    C1]  handle_mm_fault+0xfa8/0x188c
[   77.211592][    C1]  __get_user_pages+0x1878/0x3400
[   77.212967][    C1]  populate_vma_page_range+0x220/0x2f0
[   77.214435][    C1]  __mm_populate+0x240/0x3d8
[   77.215600][    C1]  vm_mmap_pgoff+0x304/0x3c4
[   77.216833][    C1]  ksys_mmap_pgoff+0xd0/0x5c8
[   77.218066][    C1]  __arm64_sys_mmap+0xf8/0x110
[   77.219195][    C1]  invoke_syscall+0x98/0x2b8
[   77.220453][    C1]  el0_svc_common+0x130/0x23c
[   77.221747][    C1]  do_el0_svc+0x48/0x58
[   77.222881][    C1]  el0_svc+0x54/0x168
[   77.223946][    C1]  el0t_64_sync_handler+0x84/0x108
[   77.225305][    C1]  el0t_64_sync+0x198/0x19c
[   77.226425][    C1] irq event stamp: 3967
[   77.227573][    C1] hardirqs last  enabled at (3966): [<ffff80008b7ec538>] _raw_spin_unlock_irqrestore+0x38/0x98
[   77.230143][    C1] hardirqs last disabled at (3967): [<ffff80008b7ec3e0>] _raw_spin_lock_irq+0x28/0x70
[   77.232639][    C1] softirqs last  enabled at (2318): [<ffff800080311b48>] handle_softirqs+0xb44/0xd34
[   77.235151][    C1] softirqs last disabled at (3923): [<ffff800080020dbc>] __do_softirq+0x14/0x20
[   77.237528][    C1] ---[ end trace 0000000000000000 ]---


So it looks like I was right about bluetooth (the work function is
"hci_cmd_timeout") but, unfortunately, "hci3" doesn't tell us much about
the client.

Perhaps the failed power-off right before the warning suggests that
we're not tearing down the wq properly on that error path? Let's see...

hci_rfkill_set_block() calls hci_dev_do_close() if the power-off fails.
That in turn cancels the delayed 'cmd_timer' work but only if HCI_UP is
not set in the device flags. But if hci_dev_do_poweroff() failed, HCI_UP
may well still be set. Then somehow the workqueue is destroyed, I guess
via hci_unregister_dev() setting HCI_UNREGISTER which enables
hci_release_dev() but at that point it's hard to know which bluetooth
driver is responsible.

Assuming hci_unregister_dev() is triggered via hci_dev_do_close()
closing the device, then unconditionally cancelling the delayed cmd work
when clearing HCI_UP sounds like a reasonable starter for ten?

Dunno, this is all guesswork in code that I'm not familiar with, so I'm
hoping somebody can tell me why I'm wrong :)

Will

--->8

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec36..d2623f6d0593 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5147,11 +5147,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
        }

        err = hci_dev_shutdown(hdev);
-
-       if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
-               cancel_delayed_work_sync(&hdev->cmd_timer);
+       cancel_delayed_work_sync(&hdev->cmd_timer);
+       if (!test_and_clear_bit(HCI_UP, &hdev->flags))
                return err;
-       }

        hci_leds_update_powered(hdev, false);
 
