Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C586323
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457889; cv=none; b=bxpjaAfAhg6mk4DaLlxPhrH0cxH6gPuESFXrfbi2HcS9JdvVKk2gc3nE0wH9IBPjDdhDUkPDjKeaY4isvWAfzyLPKuIDD6t/qjKljIZoI6tSF1+qlfM0L2BMl9XwNRapeL/UFu8i1jNg7pP1zL2pcVLFNPER/dnYPjkG0a27lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457889; c=relaxed/simple;
	bh=YuBvoS+iv8EZE+9HOe9/btlBGya8guhNHGtWFdKG5vM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u2dccahlCtxPAg0UHdyYw+aoY31LXmpjhrxRy84c0Tt6AXoQdAPyXnelH4W6v+3cIZcdl/dUHMSbbzfTkMCtHwtqdVfVdko9sZWmlZorbwpPa0ZLldN9saus+a7+X1QA661Mt0ejTkUw+Uak6CRCoCiFzq81bD3mC2FIo/Qb0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5aiAP7z; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5aiAP7z"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e5995828d1so59564137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748457886; x=1749062686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5m8TSMbgwmQWVrCkLfyn2sIkahlDZau5VWLPZJSgUw=;
        b=C5aiAP7zKMesgDHjBwJ5++HuZ5btMz1LV3dy/tEriki5WqKJEqO9xM0GlqDz/dIL4/
         ARL0zeiWvd8sEQZTTBa3Qhh+7fFqWhBC7BsAmT7WBeSPJX+FKMyFbRVEEAFR0KtgsYn8
         Dq3YdUZuIlhsrtqX1j/2gDD7bV9J0Ic2OxulGaLrvsFWI9f66MWBaKBAqTq8qWn7X6Zi
         /7JSbouPPx/pjzigoh+7rdRe8sqRs+N8XVDKkaK6I0M1b+8U3g0xgTxJgld6cFsdPuPM
         ClcABLVvj81XiCfG9Pwlj+Fbw/rmtupMgKpRKrGO4+UdpTwvNUTt9Gu3SlTcC2oNa023
         ll/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748457886; x=1749062686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5m8TSMbgwmQWVrCkLfyn2sIkahlDZau5VWLPZJSgUw=;
        b=t6l/5lHtnEYE1rnSt+gvoEQ/d0QS0KDCaCMRf7nmmfs0oDwjrsGBKOWB1fETE6LxyL
         X1xky/XFLaxCnAYHiGMcZDBQj44C4ACr7DOi5Q/7qpQhkz7Mn5axcp2WVVrMP83jCmwf
         jBW1PSFgVthLhOweadrMZv5th5/Lv+hjwlbtb4F6O1n489eAFWqxfeHBNgBB8Pptc0Dp
         ux+2cU2ZAnldTPwwoCDcKPB6Pd4LsxRFkZqfOvWs70kO1cVafnr3pg0myZT4V1MIRbij
         XWTgFCh8LPz9doogA1JkjDj5ZGvq7ezHeMuPtn30hIb7X5BiZL50gIIXsN56iBTUL/4d
         XCMw==
X-Gm-Message-State: AOJu0Ywmmg+IMOSeCns5avoyNryoVpa/xAt+IfFe/Y2NnvbDTgZIQSyJ
	oPRBWLaC6QsKcVWmRsWjuiT06MHXMGFe5JEfKg3855B4jv2cmS2ZXpiwIGr9rQ==
X-Gm-Gg: ASbGncvxgjUwFDAatgpTQDLAzcDkKyQkkTyDDwrT3UIQPiNjbhpZ1SQvjRRm1XnBY29
	7+vIjQcDLiRjcXZUyzGRTQxeuPg9QCGOn6dr4A4fmEP6dmdBm4RX8Y4ZF2lwAMKOaDlrka7lLG2
	MtztG3HavuNCX29DUTuoYoOqzhVliMI8+4APhf7H8PxmbxR+31rwy+Ea8A9Q5HPOrRhl5kLB/K/
	V0i39wUJbIe4QaYmYcqQDY4bXYiiBEH8RM12ijZeTTegd5lnwWlfW6wCTV2sbWF6JrOzaT3k6If
	wF68k02fHMNWC26ouFuuhyzSta3B04gNItLLnRDCC0AYOM0Ds5RerF292Y1YZmDC5MrC+R9bhFj
	2jpDsJoeU5juxvzwQyvRa
X-Google-Smtp-Source: AGHT+IFdPso2wMcqNzYpZFFR8KBEQpyairBFNpwEZd/NvGYV3+E3B29C2BDy7XPR3UmeF/BCzy+glQ==
X-Received: by 2002:a05:6102:3f44:b0:4e2:a29d:ecb9 with SMTP id ada2fe7eead31-4e4240642ebmr15416926137.1.1748457885837;
        Wed, 28 May 2025 11:44:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e1f01b2f4sm1290907241.14.2025.05.28.11.44.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:44:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Use RCU-protected in mgmt_pending list
Date: Wed, 28 May 2025 14:44:41 -0400
Message-ID: <20250528184441.538069-1-luiz.dentz@gmail.com>
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

