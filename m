Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C59265CA6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455481; cv=none; b=kUzWsxFxiQF6TY+N07R/b1rGQo7fYow4SvazpBPIqkMT7Jnp3XEhWbSQnsX4dNHyg/s3gsJXYaSB0xo9FHmSm5E9BPQzdFSishmyadjW6k9UqvlIFbGLSvFuEg5EZZ/P9YV279gW9J8aWPmqKemI4EavowvrjFS7xMgZbYXB0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455481; c=relaxed/simple;
	bh=JICXmk5A8at7q6BluXXKs3o4ttxjuLSsIDZd3g8d7e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tHK8d1GOktwEoqbI7lJDy6m1p2NdzZtJDfdYfOcyQ/4y7AcDxpZFT0VJfET+0BVgSo2kHhHwIhhwiiiN19X4AJW7FFSvs6t3ClQQHQYt+Rnwcgl26+O4VZliW+MRgvAZD9UWY+1+k3AaZ9Sh3JHquIA3c0mD7lxDbo2ouDk3aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p5dc55aad.dip0.t-ipconnect.de [93.197.90.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D4C960213CAD;
	Wed, 10 Sep 2025 00:04:26 +0200 (CEST)
Message-ID: <b0dbb92a-6202-4f84-b559-01fb7ea97c06@molgen.mpg.de>
Date: Wed, 10 Sep 2025 00:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Bluetooth: MGMT: Fix possible UAF on
 mgmt_add_adv_patterns_monitor_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250909215824.1739006-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250909215824.1739006-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for the patch.

Am 09.09.25 um 23:58 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I’d love to see a paragraph in the commit message explaining the problem 
next to the trace below.

> BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
> Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55
> 
> CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xca/0x240 mm/kasan/report.c:482
>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>   mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
>   hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
>   process_one_work kernel/workqueue.c:3238 [inline]
>   process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>   kthread+0x711/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16.4/arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> Allocated by task 12210:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>   __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4364
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1039 [inline]
>   mgmt_pending_new+0x65/0x1e0 net/bluetooth/mgmt_util.c:269
>   mgmt_pending_add+0x35/0x140 net/bluetooth/mgmt_util.c:296
>   __add_adv_patterns_monitor+0x130/0x200 net/bluetooth/mgmt.c:5247
>   add_adv_patterns_monitor+0x214/0x360 net/bluetooth/mgmt.c:5364
>   hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
>   hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   __sock_sendmsg+0x219/0x270 net/socket.c:729
>   sock_write_iter+0x258/0x330 net/socket.c:1133
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0x5c9/0xb30 fs/read_write.c:686
>   ksys_write+0x145/0x250 fs/read_write.c:738
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 12221:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2381 [inline]
>   slab_free mm/slub.c:4648 [inline]
>   kfree+0x18e/0x440 mm/slub.c:4847
>   mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
>   mgmt_pending_foreach+0x30d/0x380 net/bluetooth/mgmt_util.c:257
>   __mgmt_power_off+0x169/0x350 net/bluetooth/mgmt.c:9444
>   hci_dev_close_sync+0x754/0x1330 net/bluetooth/hci_sync.c:5290
>   hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
>   hci_dev_close+0x108/0x200 net/bluetooth/hci_core.c:526
>   sock_do_ioctl+0xd9/0x300 net/socket.c:1192
>   sock_ioctl+0x576/0x790 net/socket.c:1313
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
> Closes: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
> Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/mgmt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 989321b1ea27..165e8d8cff96 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5189,6 +5189,14 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
>   	struct mgmt_pending_cmd *cmd = data;
>   	struct adv_monitor *monitor = cmd->user_data;
>   
> +	/* This is likely the result of hdev being closed and mgmt_index_removed

I’d write what *This* means. Maybe: Status of ECANCELED is …

> +	 * is attempting to clean up any pending command so
> +	 * hci_adv_monitors_clear is about to be called which will take care of
> +	 * freeing the adv_monitor instances.
> +	 */
> +	if (status == -ECANCELED)
> +		return;
> +
>   	hci_dev_lock(hdev);
>   
>   	rp.monitor_handle = cpu_to_le16(monitor->handle);
> @@ -5215,6 +5223,10 @@ static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
>   	struct mgmt_pending_cmd *cmd = data;
>   	struct adv_monitor *monitor = cmd->user_data;
>   
> +	if (cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) &&
> +	    cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev))
> +		return -ECANCELED;
> +
>   	return hci_add_adv_monitor(hdev, monitor);
>   }
>   


Kind regards,

Paul
