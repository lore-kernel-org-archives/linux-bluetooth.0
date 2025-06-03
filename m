Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2321FF35
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982567; cv=none; b=kmR4qOIMGGFfNrv1uurX9k/V+f9j6PdbmgyajaoEsax2jKHVaIdxqwbNMZvN0LvjLZsKhPIYXDL86R7QIBp/dzO1vyY4WSifI4w7klMSYjQLBCsUAXA75lIH+9UaxNYetYb7R0USvvgg+FvpfuZ1WR7P5DL3ApUk0I7SruMPpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982567; c=relaxed/simple;
	bh=ukNADY/eB/oKbipEib98icQs9ZBvGyz9cISnKQ1hKb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h4CfR1MhidvlwAQsLGVFtjbF5hlU2RHODc7itZeBwzR4j9eix5fD3iJX06/INFncrG2O4A0Lc7p5Mmzr2AHhv0k6cMsOEDm7X+Pa4IH2VTOTpSYAaIUZ8C5jOnz8ejZmQWbbZTZ4CMLeMb1FT0Cp51HIiMWkSjHK7w1ogw3GK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+dZofnl; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+dZofnl"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-530807a856fso168960e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748982564; x=1749587364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=95RB5vhMORoij9KVancSjqUJhs6tyLX8Sj/K4T3Hv1U=;
        b=P+dZofnlCdqveYtWS46QuQGTXPTD9B6XP/iTJraswN/TtL9Y2DVur2tBlvhmKkIcMM
         KBxIgH1yqlgAl2yHd68tMj1c4OmvjVhgNWE9WKc1ghyzMtOVlGUAwVZq9RSf3298dGV4
         xmipOTTuc7izwLBUuFfg4ftsMtwUJa/1SVS7erCMAJACXp0siGMRIv4fZQdDWQEx0InP
         HMTodoJDM1eUj0l/cjoSQuYUBG9E77hkhz2KhLsUpDUxxSdHjskUNaYL8Qa1bA05ew86
         p0jEtDzcp1xlbrtf3AjB3Myb8NebIZJVdGBWNl8B7N6MMHwh+VVqV6MbWeEbwAmtKICR
         YnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982564; x=1749587364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95RB5vhMORoij9KVancSjqUJhs6tyLX8Sj/K4T3Hv1U=;
        b=MJ1RmZU1Gn+dxYAFy7dZ1Ue56B+PsTiMhfG1SEeOOGwBMPFIAfsuc8jUFiFdK1EhAb
         FQsdykayuXWxatMZEGfHs6w6/9OQw9rny2Uth4+nV/bltIVUkg90KhghaJJC7nRkgD8x
         XMnpjMPfpVH8/R1FBSo7wCaahwJsjkMpVpp9hfApZ7uprqIqHuuyRCVTBGRy8fPXhg5s
         Si84vPXQ/Rf0B50qaDK7uTp5F5sIgAkXYuJ3d70xLnsMqnbHvWSx94cQXyoqqikJgktr
         DlJ/HY7xBobdtSlAM/ZOvLC3X/MwLKU7r7p3H+O0O9+OegCWD96YsCxpmbK3PaR7HV/0
         6cZw==
X-Gm-Message-State: AOJu0Yzlf6lXmd7IaWFaE36KyVFIo3jGEPz9REg5/GsPzGwsWb08glCL
	ajSKJbB3+uWYPxY+66bQ+ePq439ouzv+E0ytMRsBKIO9BJX8OFA/mOo/paHHwFl+qPI=
X-Gm-Gg: ASbGnctLFwXTJi5l29+x/b3d18RZlfaxdbpbDMLdNu/enw0T/khQHGdfkzvCy7qBrcN
	VE1yzJvwkKOSKp81EmtW8Y3S9MtQCxmrs4dS0gl53fJ7uN4pWvl6zRUyIG79pC8fuDNBMLpU5MV
	ZtgU81onckZNxSa8Ca9GGEI4m3RwZudr4UR2xPRv11javeZdVoID3F3NYMzqf6P9ixQDspY25vj
	dOc6PB2YFRbsfKKWpsRjD3LY1o25hNRdVNNfttDgqxelDj1CVH+M+QYPF6yoDJcScYASO9SrA1h
	utQIUa2YrUSXqQbcAJci7th/y8jwb6uLJ2M8H6q2VtVSBWbTfgKA8mvDyWRswVf5gx6s3Rjul50
	rApvmhFq/kZ3J3tESaQ9r
X-Google-Smtp-Source: AGHT+IE2Sikyfc3wD+lGTwKNuBVM21fcagNBqDfHUhj8Pm0yuTo+q8sIsqRCwLw617RWIkomzAcdWw==
X-Received: by 2002:a05:6122:470f:b0:52d:beeb:c6a3 with SMTP id 71dfb90a1353d-530ba1d932emr3888023e0c.1.1748982563592;
        Tue, 03 Jun 2025 13:29:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a38f77dsm8169298241.22.2025.06.03.13.29.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:29:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
Date: Tue,  3 Jun 2025 16:29:20 -0400
Message-ID: <20250603202921.267083-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks MGMT_OP_REMOVE_ADV_MONITOR to not use mgmt_pending_add to
avoid crashes like bellow:

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5406
Read of size 8 at addr ffff88801c53f318 by task kworker/u5:5/5341

CPU: 0 UID: 0 PID: 5341 Comm: kworker/u5:5 Not tainted 6.15.0-syzkaller-10402-g4cb6c8af8591 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 mgmt_remove_adv_monitor_complete+0xe5/0x540 net/bluetooth/mgmt.c:5406
 hci_cmd_sync_work+0x261/0x3a0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5987:
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
 remove_adv_monitor+0x103/0x1b0 net/bluetooth/mgmt.c:5454
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5989:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x18e/0x440 mm/slub.c:4841
 mgmt_pending_foreach+0xc9/0x120 net/bluetooth/mgmt_util.c:242
 mgmt_index_removed+0x10d/0x2f0 net/bluetooth/mgmt.c:9366
 hci_sock_bind+0xbe9/0x1000 net/bluetooth/hci_sock.c:1314
 __sys_bind_socket net/socket.c:1810 [inline]
 __sys_bind+0x2c3/0x3e0 net/socket.c:1841
 __do_sys_bind net/socket.c:1846 [inline]
 __se_sys_bind net/socket.c:1844 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1844
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 66bd095ab5d4 ("Bluetooth: advmon offload MSFT remove monitor")
Closes: https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190
Reported-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Tested-by: syzbot+feb0dc579bbe30a13190@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  4 +---
 net/bluetooth/mgmt.c             | 37 ++++++++++----------------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b261e74e2c4..93fcb659f0d4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2400,7 +2400,6 @@ void mgmt_advertising_added(struct sock *sk, struct hci_dev *hdev,
 			    u8 instance);
 void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 04845ff3ad57..aeda2e4557d5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1877,10 +1877,8 @@ void hci_free_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	if (monitor->handle)
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 
-	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED) {
+	if (monitor->state != ADV_MONITOR_STATE_NOT_REGISTERED)
 		hdev->adv_monitors_cnt--;
-		mgmt_adv_monitor_removed(hdev, monitor->handle);
-	}
 
 	kfree(monitor);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 14a9462fced5..feaeec2423ae 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5108,24 +5108,14 @@ static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle)
+static void mgmt_adv_monitor_removed(struct sock *sk, struct hci_dev *hdev,
+				     u16 handle)
 {
 	struct mgmt_ev_adv_monitor_removed ev;
-	struct mgmt_pending_cmd *cmd;
-	struct sock *sk_skip = NULL;
-	struct mgmt_cp_remove_adv_monitor *cp;
-
-	cmd = pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev);
-	if (cmd) {
-		cp = cmd->param;
-
-		if (cp->monitor_handle)
-			sk_skip = cmd->sk;
-	}
 
 	ev.monitor_handle = cpu_to_le16(handle);
 
-	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk_skip);
+	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
 static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
@@ -5227,8 +5217,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
-	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev)) {
+	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
@@ -5398,8 +5387,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+	if (status == -ECANCELED)
 		return;
 
 	hci_dev_lock(hdev);
@@ -5408,12 +5396,14 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 
 	rp.monitor_handle = cp->monitor_handle;
 
-	if (!status)
+	if (!status) {
+		mgmt_adv_monitor_removed(cmd->sk, hdev, cp->monitor_handle);
 		hci_update_passive_scan(hdev);
+	}
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
@@ -5423,10 +5413,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-
-	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
-		return -ECANCELED;
-
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
@@ -5445,14 +5431,13 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (pending_find(MGMT_OP_SET_LE, hdev) ||
-	    pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) ||
 	    pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev)) {
 		status = MGMT_STATUS_BUSY;
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_REMOVE_ADV_MONITOR, hdev, data, len);
 	if (!cmd) {
 		status = MGMT_STATUS_NO_RESOURCES;
 		goto unlock;
@@ -5462,7 +5447,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 				  mgmt_remove_adv_monitor_complete);
 
 	if (err) {
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 		if (err == -ENOMEM)
 			status = MGMT_STATUS_NO_RESOURCES;
-- 
2.49.0

