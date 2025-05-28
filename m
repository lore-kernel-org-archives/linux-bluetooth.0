Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B06AD3
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466445; cv=none; b=q0PCcMcQAVkuGAvLSIpZsiPUJbRQ4ZkI5zyQOQ/PGydLBeYLAMhiewUMT8A+OGiAU13hCzAFZLuhtc+cvDTTVAa1/K590PzaH7wTTLDNGILuTzl0jLyDO5YlO9x7oBVfO0lfuISxKUVwwU8574nu530yvry1474YnqG4/kYO7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466445; c=relaxed/simple;
	bh=OOXqX1cgtTRUjyFxxmIMpT5jsuNst696cnK0c3d+jXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=funBfNsDRk4nNFYPCIIFSbSAYiUisEaLjgRJMLYoCYVMMITMbisOBKh7DG0XxKrbFGmUECdkWIKLbCzFz2gfAHgCx0nSgeZHutS7TGmoEK9zqtQy/OrPVW8KY/9cKHiGAnoRga28cHwzeN4SFV42NNUNhcrHIAg2/D9l5Ajqq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrxliAwP; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrxliAwP"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e5a73028d2so79174137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748466441; x=1749071241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+rk6tHK4nduggm5wYCkM4uHHtGWPJqc/WC8TAHA0II=;
        b=RrxliAwPNE962KiR6zcg95OxOYNWAlI884d6j7X0r//ztr3FThOQ6Uag/9Fc5cHsga
         hEqay8YB2eHQJD921k0rbFKd8DMwaTsOktZezB3QxrjxOJypYrno4bfqKMDJdCPH4Uxh
         BiD9KzwX92mQyg1thzwoMQoKueXwvbkp1Epse6swTyoxz+hboq05Rq16lSqU0fUXC8og
         ehwbfA5F9eciej9hj+eJ11fLHNQYmZrw8AR7hYFd2mPSuatxXZDN9f1HhRbPI+vZCEq+
         UY6Y8BwyHsUxogG1141m57tBVCD64EK/03LoA4m14ErxOw0y2C8JPwADA1lVMsYBvMlY
         LbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748466441; x=1749071241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+rk6tHK4nduggm5wYCkM4uHHtGWPJqc/WC8TAHA0II=;
        b=PLTtjt5x5HegDbBm/FqkkvSEmyF5MQzPa51jBE2cd//J4PckKm+Mir2f8akgtAV2bu
         rW4vJ7o6l1T9uJIv5BJLAL4SskyPctQxnrmk78WuVVvNme1NUZgNWd14FBMRhhw+ERSN
         UXCiJvUjZw67/GBk1EEb9IZL327Q6mCi+nvpSN3+Acmq13GNQbdoQnF/Fm4laKEwmjqX
         B1uo3zD02djyxtFJNPHn9K55/s+q5pUW5z63zeR8KXN0MMC76BmO7Tix1StnaPNOzQ5F
         63LELozEwhXmBPnoauuSJYkBnEW6ZpzCiJ7YuV54r3y6JVrSJu+eCfWBBwo4hkqGe4I2
         mmSw==
X-Gm-Message-State: AOJu0YwR1DAJ8q47MTkd4eBEY4xlr+Dhgntldj0/WsJ+qflRMScNu6zw
	cey8s5uCwkhIz5+EuUYudTTJ+4CYb12mbHtIDhaJldbQYVN5ejjAC7IrrMBjS9mA
X-Gm-Gg: ASbGncslAf6oynSsuLOCKIrt8OEQUFguqU7RjW7Z/PL3/j5x0Jn0+ON0fJbevmuw+VS
	llxqMgjALsd2lAbFpm+PjIBjwu8WUpofbeyjDbLDsooX3q4ySBzqIAo+nmUkhEcAFnkOqd2GXwa
	Ev4jiqS7d/n5lwIG3eZtb/UJgV/PbnL6E8f1dCsHBrKUARjiwMEuzWjilD0608kLHCfPpq2S8nv
	M08TH5bI90J9vgqF7g10I1Jtk0mgqgwpG4mTMJh9JDsDKVu/0Hc0rIvwndENmXXVrA+aAIVGzCL
	eg7NO+/6FEkplHK1n8YaXNXTt5ONtheCGRJ+o55ay1FD6ZN+IPYwm+Xrpd53r4Fcbe7ZTfKTEVn
	rBQ9/TXQn6LF9hX2We7Hn
X-Google-Smtp-Source: AGHT+IHfhehiz1G8fqJshUsHO/Rt1RHeVPrSsvJMbQumyEG7QHkGYNbL7GHIvubjRKhBigYV0VoJTQ==
X-Received: by 2002:a05:6122:17a9:b0:530:6c3e:4db1 with SMTP id 71dfb90a1353d-5306c3e5012mr3455764e0c.6.1748466441295;
        Wed, 28 May 2025 14:07:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad8c77sm13620e0c.15.2025.05.28.14.07.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:07:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Use RCU-protected in mgmt_pending list
Date: Wed, 28 May 2025 17:07:18 -0400
Message-ID: <20250528210718.100679-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses RCU procedures to protect from concurrent access of
mgmt_pending list which can cause crashes like:

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
Read of size 8 at addr ffff888048891a18 by task kworker/u5:8/5333

CPU: 0 UID: 0 PID: 5333 Comm: kworker/u5:8 Not tainted 6.15.0-rc5-syzkaller-00197-gea34704d6ad7 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5405
 hci_cmd_sync_work+0x25e/0x3a0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5702:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x65/0x240 net/bluetooth/mgmt_util.c:252
 mgmt_pending_add+0x34/0x120 net/bluetooth/mgmt_util.c:279
 remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5453
 hci_mgmt_cmd+0x9c6/0xef0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x6ca/0xee0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5700:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x193/0x440 mm/slub.c:4841
 mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
 mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9362
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1810 [inline]
 __sys_bind+0x2c3/0x3e0 net/socket.c:1841
 __do_sys_bind net/socket.c:1846 [inline]
 __se_sys_bind net/socket.c:1844 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1844
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: a380b6cff1a2 ("Bluetooth: Add generic mgmt helper API")
Closes: https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190
Closes: https://syzkaller.appspot.com/bug?extid=0a7039d5d9986ff4ececi
Closes: https://syzkaller.appspot.com/bug?extid=cc0cc52e7f43dc9e6df1
Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Tested-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Tested-by: syzbot+0a7039d5d9986ff4ecec@syzkaller.appspotmail.com
Tested-by: syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt_util.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 3713ff490c65..c2dc8ddf5f78 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -219,13 +219,20 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 {
 	struct mgmt_pending_cmd *cmd;
 
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
 		if (hci_sock_get_channel(cmd->sk) != channel)
 			continue;
-		if (cmd->opcode == opcode)
+
+		if (cmd->opcode == opcode) {
+			rcu_read_unlock();
 			return cmd;
+		}
 	}
 
+	rcu_read_unlock();
+
 	return NULL;
 }
 
@@ -233,14 +240,11 @@ void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
 {
-	struct mgmt_pending_cmd *cmd, *tmp;
-
-	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
-		if (opcode > 0 && cmd->opcode != opcode)
-			continue;
+	struct mgmt_pending_cmd *cmd;
 
+	cmd = mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
+	if (cmd)
 		cb(cmd, data);
-	}
 }
 
 struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
@@ -280,7 +284,7 @@ struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	if (!cmd)
 		return NULL;
 
-	list_add_tail(&cmd->list, &hdev->mgmt_pending);
+	list_add_tail_rcu(&cmd->list, &hdev->mgmt_pending);
 
 	return cmd;
 }
@@ -294,7 +298,8 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 {
-	list_del(&cmd->list);
+	list_del_rcu(&cmd->list);
+	synchronize_rcu();
 	mgmt_pending_free(cmd);
 }
 
-- 
2.49.0

