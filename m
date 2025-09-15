Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE71B7F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941026; cv=none; b=lOKp6v+NnkFbgwhekV9but8PcjI/jWpjfAWZm0pU/aLnIRvLPgnxcs5xb+yF4AF/NFzjl6pv0wQVL6KZzDkJhsvq1kZ+J6bHSe+jpfhM76sCnv6dshdC3tsp4nQk0m/jfHO8sFl6Y1v8pfq2O4aF1Urq3D9w4KezEi35Kt19+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941026; c=relaxed/simple;
	bh=d2iBpXHQN3Nq8n4VXOm9ctqT+evp9wSnKRq18vTjnRE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOR1nzDN7zvakv5KWF4KKixrCTayVpL2GnJrgdoS6IK0t3/lP3scCN+NNsfce/EjnbHvNFgiepeVLV/CqfmlfAmTi8fVRRkZsMZFPqljlGIeyWjUAoBKQ+8iqB3ZOohAIQtkvkJ9vcezwqznKI3K2ZXjUP/zqu7nIpq+/qXlFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8U5auVf; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8U5auVf"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8972e215df9so726675241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941022; x=1758545822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG88+ZTtjS+6DiXi60aRvuWbjbwPuGXQvhLGSXq2/Mo=;
        b=h8U5auVfuK/S/iS6RKFX69yI0nKNQqXTeKbvKkMj3/Lz7T22cY1N+BuoeD5TeuE3/G
         9LZg1g7YvUutF6RD3Sy5/z7sfg895FV7/RFb1nfkdICavpBFZ9NTlySYkl6PmT8ZypGH
         b4ODj/Bjxs/j1gAdWKtCUTooqKxcdK53HZkQuuj9g5S5XSachd/xcaP99xsjTS3txQA2
         1IiIqZtgGJiYQ3fpN0WNYt2CCZHaGSAPl2u0FQeF69uytGdPCYtYeefChaE4ZcxYIL+i
         yTJUysLuIiJ4+8OH5tPfuMvcH704jrGSwCghdb2ZviLI+5Xsx3OtRNz687AzC6T4Pr9b
         anMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941022; x=1758545822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG88+ZTtjS+6DiXi60aRvuWbjbwPuGXQvhLGSXq2/Mo=;
        b=cuKnDdAG6RYPzdkD1qclUeYUYzKwGkzF3FzEm+ggaeJUJ1Lz1EWBIaKgig1N+CSDDR
         sLqz0LHxuFuWNilQfQ43pjS+lLstNI0KObU5fqGnViZel9M/Zld5s824y92CscDSUZhJ
         6WzIIk/mU5+oTACvunT/yqvkxy0O6R9Xv2WRZah1eS9mJJuJppLSB8CPxFV3pFvZt3EV
         2Rlhn0nC+gmAR6tkyztGv/DH0JxsfNE03skdjQJX+0zqnfQE07SuHM7pll2hE8LMCJyX
         tWkI2bnReCqAiTP1tYuimLc7asdtFGWtPYtcAR6RaWP7CL/CxN/nqUI2LjKaMu2DD1I4
         PcXw==
X-Gm-Message-State: AOJu0YzBEJoa5bvihUEEy4WycnvGh3mQW1K7akFoP9CU68EghrmpH5om
	wpCgIrmxluXT0LpWh1PMEDvT03GlbygCVhG0/SBzI0shhqT91jvQOcSUHAhcSA==
X-Gm-Gg: ASbGncsVggOdWgfqTxNqhCjeF74tyaCQuyuRe+USWkW1ZHeaoNXgcI9fTcZR/p6lIgW
	ksGZFqSM1mJ8MRnaDnMd3P0+/yogRflHT963DvUUb3zijIwaCdXqA8OEKG2x3JxQQZK7lYiBZW6
	qCmRXqMcLDdlPjVFZEjy7+jNi4B20GN6RDLLriHi4tBUT3FRm+H0C+nrz74idHQbTBvBP8e2Jop
	8wVrDha5wTuelcCnZJq3XO1LPTIBm7GQVb0uotlS+997Kg+s/cjbgcmyakCUUw9nN9t6u0FhYrA
	tCIwELpTWpad5QWW89nvpTLYHl4lJ4M3ovu+2bEELNlvW1NTHirhAF6j5NoEZzVdYb7dQZZrBtb
	jCG1MY2kj8os5nEJHGUBy4lkUMQHQhdnACy1NeFCwMDuSIRydPUVBQiQnsr/fqJd5OP8xkooMLK
	fn
X-Google-Smtp-Source: AGHT+IGot4YBimRa3ecOwCoUgaeIKSoIUyPrexIDwexHnhZFpsbdASzwEFtE+gL4JrS9jN2WsYQ/cQ==
X-Received: by 2002:a05:6102:a53:b0:525:42d2:790d with SMTP id ada2fe7eead31-5561010bbbdmr3577149137.25.1757941021843;
        Mon, 15 Sep 2025 05:57:01 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-555bd4fe0a4sm2490260137.8.2025.09.15.05.56.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:56:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/3] Bluetooth: MGMT: Fix possible UAFs
Date: Mon, 15 Sep 2025 08:56:44 -0400
Message-ID: <20250915125644.664438-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915125644.664438-1-luiz.dentz@gmail.com>
References: <20250915125644.664438-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attemps to fix possible UAFs caused by struct mgmt_pending being
freed while still being processed like in the following trace, in order
to fix mgmt_pending_valid is introduce and use to check if the
mgmt_pending hasn't been removed from the pending list, on the complete
callbacks it is used to check and in addtion remove the cmd from the list
while holding mgmt_pending_lock to avoid TOCTOU problems since if the cmd
is left on the list it can still be accessed and freed.

BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55

CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16.4/arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12210:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4364
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x65/0x1e0 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x35/0x140 net/bluetooth/mgmt_util.c:296
 __add_adv_patterns_monitor+0x130/0x200 net/bluetooth/mgmt.c:5247
 add_adv_patterns_monitor+0x214/0x360 net/bluetooth/mgmt.c:5364
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 sock_write_iter+0x258/0x330 net/socket.c:1133
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12221:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4648 [inline]
 kfree+0x18e/0x440 mm/slub.c:4847
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x30d/0x380 net/bluetooth/mgmt_util.c:257
 __mgmt_power_off+0x169/0x350 net/bluetooth/mgmt.c:9444
 hci_dev_close_sync+0x754/0x1330 net/bluetooth/hci_sync.c:5290
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_dev_close+0x108/0x200 net/bluetooth/hci_core.c:526
 sock_do_ioctl+0xd9/0x300 net/socket.c:1192
 sock_ioctl+0x576/0x790 net/socket.c:1313
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Closes: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c      | 138 ++++++++++++++++++++++++--------------
 net/bluetooth/mgmt_util.c |  23 +++++++
 net/bluetooth/mgmt_util.h |   2 +
 3 files changed, 114 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 989321b1ea27..0c1cb1606a35 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1323,8 +1323,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_mode *cp;
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	cp = cmd->param;
@@ -1351,7 +1350,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 				mgmt_status(err));
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_powered_sync(struct hci_dev *hdev, void *data)
@@ -1360,7 +1359,7 @@ static int set_powered_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_mode *cp;
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+	if (!mgmt_pending_valid(hdev, cmd, false))
 		return -ECANCELED;
 
 	cp = cmd->param;
@@ -1516,8 +1515,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1539,12 +1537,15 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 	hci_dev_unlock(hdev);
 }
 
 static int set_discoverable_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_valid(hdev, data, false))
+		return -ECANCELED;
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_discoverable_sync(hdev);
@@ -1691,8 +1692,7 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1707,7 +1707,7 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 }
@@ -1743,6 +1743,9 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 
 static int set_connectable_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_valid(hdev, data, false))
+		return -ECANCELED;
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_connectable_sync(hdev);
@@ -1924,7 +1927,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 	bool changed;
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED || cmd != pending_find(MGMT_OP_SET_SSP, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	if (err) {
@@ -1935,8 +1938,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 			new_settings(hdev, NULL);
 		}
 
-		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true,
-				     cmd_status_rsp, &mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 		return;
 	}
 
@@ -1946,7 +1948,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true, settings_rsp, &match);
+	settings_rsp(cmd, &match);
 
 	if (changed)
 		new_settings(hdev, match.sk);
@@ -1964,6 +1966,9 @@ static int set_ssp_sync(struct hci_dev *hdev, void *data)
 	bool changed = false;
 	int err;
 
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
 	if (cp->val)
 		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
 
@@ -2060,23 +2065,29 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 static void set_le_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct mgmt_pending_cmd *cmd = data;
 	struct cmd_lookup match = { NULL, hdev };
 	u8 status = mgmt_status(err);
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, cmd_status_rsp,
-				     &status);
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, data, true))
 		return;
+
+	if (status) {
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, status);
+		goto done;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, settings_rsp, &match);
+	settings_rsp(cmd, &match);
 
 	new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
+
+done:
+	mgmt_pending_free(cmd);
 }
 
 static int set_le_sync(struct hci_dev *hdev, void *data)
@@ -2086,6 +2097,9 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	u8 val = !!cp->val;
 	int err;
 
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
 	if (!val) {
 		hci_clear_adv_instance_sync(hdev, NULL, 0x00, true);
 
@@ -2129,6 +2143,9 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	u8 status = mgmt_status(err);
 	struct sock *sk = cmd->sk;
 
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
+		return;
+
 	if (status) {
 		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
 				     cmd_status_rsp, &status);
@@ -2145,6 +2162,9 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_set_mesh *cp = cmd->param;
 	size_t len = cmd->param_len;
 
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
 	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
 
 	if (cp->enable)
@@ -3872,8 +3892,7 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	if (status) {
@@ -3887,13 +3906,18 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 			hci_cmd_sync_queue(hdev, name_changed_sync, NULL, NULL);
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_name_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_local_name *cp = cmd->param;
+	struct mgmt_cp_set_local_name *cp;
+
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
+	cp = cmd->param;
 
 	if (lmp_bredr_capable(hdev)) {
 		hci_update_name_sync(hdev, cp->name);
@@ -4051,8 +4075,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	struct sk_buff *skb = cmd->skb;
 	u8 status = mgmt_status(err);
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	if (!status) {
@@ -4080,7 +4103,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	if (skb && !IS_ERR(skb))
 		kfree_skb(skb);
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_default_phy_sync(struct hci_dev *hdev, void *data)
@@ -4090,6 +4113,9 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_le_set_default_phy cp_phy;
 	u32 selected_phys = __le32_to_cpu(cp->selected_phys);
 
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
 	memset(&cp_phy, 0, sizeof(cp_phy));
 
 	if (!(selected_phys & MGMT_PHY_LE_TX_MASK))
@@ -5189,6 +5215,14 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct adv_monitor *monitor = cmd->user_data;
 
+	/* This is likely the result of hdev being closed and mgmt_index_removed
+	 * is attempting to clean up any pending command so
+	 * hci_adv_monitors_clear is about to be called which will take care of
+	 * freeing the adv_monitor instances.
+	 */
+	if (status == -ECANCELED && !mgmt_pending_valid(hdev, cmd, true))
+		return;
+
 	hci_dev_lock(hdev);
 
 	rp.monitor_handle = cpu_to_le16(monitor->handle);
@@ -5213,9 +5247,11 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct adv_monitor *monitor = cmd->user_data;
 
-	return hci_add_adv_monitor(hdev, monitor);
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
+	return hci_add_adv_monitor(hdev, cmd->user_data);
 }
 
 static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
@@ -5482,7 +5518,8 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 			       status);
 }
 
-static void read_local_oob_data_complete(struct hci_dev *hdev, void *data, int err)
+static void read_local_oob_data_complete(struct hci_dev *hdev, void *data,
+					 int err)
 {
 	struct mgmt_rp_read_local_oob_data mgmt_rp;
 	size_t rp_size = sizeof(mgmt_rp);
@@ -5502,7 +5539,8 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, void *data, int e
 	bt_dev_dbg(hdev, "status %d", status);
 
 	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA, status);
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				status);
 		goto remove;
 	}
 
@@ -5784,17 +5822,12 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED)
-		return;
-
-	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
-	    cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&
-	    cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
 				DISCOVERY_FINDING);
@@ -5802,6 +5835,9 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 static int start_discovery_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_valid(hdev, data, false))
+		return -ECANCELED;
+
 	return hci_start_discovery_sync(hdev);
 }
 
@@ -6007,15 +6043,14 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd, true))
 		return;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	if (!err)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -6023,6 +6058,9 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 static int stop_discovery_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_valid(hdev, data, false))
+		return -ECANCELED;
+
 	return hci_stop_discovery_sync(hdev);
 }
 
@@ -6232,14 +6270,18 @@ static void enable_advertising_instance(struct hci_dev *hdev, int err)
 
 static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct mgmt_pending_cmd *cmd = data;
 	struct cmd_lookup match = { NULL, hdev };
 	u8 instance;
 	struct adv_info *adv_instance;
 	u8 status = mgmt_status(err);
 
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, data, true))
+		return;
+
 	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true,
-				     cmd_status_rsp, &status);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, status);
+		mgmt_pending_free(cmd);
 		return;
 	}
 
@@ -6248,8 +6290,7 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
-	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true, settings_rsp,
-			     &match);
+	settings_rsp(cmd, &match);
 
 	new_settings(hdev, match.sk);
 
@@ -6284,6 +6325,9 @@ static int set_adv_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_mode *cp = cmd->param;
 	u8 val = !!cp->val;
 
+	if (!mgmt_pending_valid(hdev, cmd, false))
+		return -ECANCELED;
+
 	if (cp->val == 0x02)
 		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
@@ -8037,10 +8081,6 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 	u8 status = mgmt_status(err);
 	u16 eir_len;
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
-		return;
-
 	if (!status) {
 		if (!skb)
 			status = MGMT_STATUS_FAILED;
@@ -8147,7 +8187,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 		kfree_skb(skb);
 
 	kfree(mgmt_rp);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
@@ -8156,7 +8196,7 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
+	cmd = mgmt_pending_new(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
 			       cp, sizeof(*cp));
 	if (!cmd)
 		return -ENOMEM;
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index a88a07da3947..be6d9b8db51b 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -320,6 +320,29 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
+bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
+			bool remove)
+{
+	struct mgmt_pending_cmd *tmp;
+
+	if (!cmd)
+		return false;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
+		if (cmd == tmp) {
+			if (remove)
+				list_del(&cmd->list);
+			mutex_unlock(&hdev->mgmt_pending_lock);
+			return true;
+		}
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+	return false;
+}
+
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk)
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 024e51dd6937..5aeba4c7b07f 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -65,6 +65,8 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
+bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
+			bool remove);
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk);
-- 
2.51.0

