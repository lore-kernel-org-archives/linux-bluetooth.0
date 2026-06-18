Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00053EB810
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778106; cv=none; b=la3LdMD5VkTDsWs4In9PVnO8zGfGGDEeTaEq812g/uy64Unzs5BuYGfKjeXsSUWBH5cW4GvOLxYZz1aoAJOxDfOzVQd0xLKNce4nPZmGdWnPk00HOUVAlZ8jDiUDYMGkLg1guJBEvx7flkAmG3iS0ifStKN546iVBAI3Vnp9TMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778106; c=relaxed/simple;
	bh=6+8eoWxJcpT/sebUE2GsFY0qTTSnnEafCi3GZ3MyjcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCWlqAUCxG386Rbt7bYQnFj3YIrfnGIZ8O1tb7EI6UW+bvGLt3g3ljntoPxRg0nC87xoeQrC7tCUGvYuolsJHd3NBqn1EHP2zW5+6egqT/0+D/DTuewejQoobeGgQYxwBuKg6NL45udjNvewA8HHgGG/N89qAOAoKJ3czp8QiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efxIIFUK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efxIIFUK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d8b644473so562566a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778101; x=1782382901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GMwLptCg7U1JVw3ATsMoR2HLFJPGiUmWXGkyS4wkDM=;
        b=efxIIFUKiQByyX7pSbvBLArF/BDaC6lj39AXq1qBHQgFKO1OahLVGWOMuilboRANDt
         0UxGTUlAYDZON0IK/AaFpeD9o6gDC+rDzZYPFpEImJbngHtvDqYYz3cddFK0vXJPYnn1
         f3H6R1rD7YBJ830wo3L6Klk07k4fARuFbmkGMFgz5lVq98nY6wQZBZVBMfvVedcJDsij
         BcxNFycSBkk8dvFYxmJiigQMcATStkagkxG+yj11vW91xntgXUq8QNJRYMg/9CODywIT
         bUOW4XiCrhOol/y3MuF/9KijOdQw7vTcMxN4ur6ouhC4NbW71JecPu0zQJXE/7T83hqb
         /t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778101; x=1782382901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GMwLptCg7U1JVw3ATsMoR2HLFJPGiUmWXGkyS4wkDM=;
        b=BiL3/EhjkS3XmNoupvrrctivkmyusV2+AIrZTXHeM64oRLxfEjrZburM5x2U2OWACY
         aTuhDflXhhSDV1yiuAj0dU/jElDNScFBmHongXmRd1J1mJgfisouMzAqZ0rivsDYqKlQ
         iQy1Y1rTogcdsDhEQqjg3+ZXD6w7PxxRAqmd19wwg4t1s4mmE/wi/F8oeITZWIyBcTjb
         QkL/shEBqaea8iVu/9ekI3yx8g4v5WUiDZVUN80TfL9X68l5E4svVFDr+/6i/HEJGJGZ
         l8zcNq+fOkAGFlgLY0i0HGgFNGN3zm9fvdV/xnSGdlUlQ4ucd7UfoOO4TYGNrANTOFJU
         owkg==
X-Gm-Message-State: AOJu0Yx9qIL2ZY1aYvhiKtgZz5U+MSPhskR4bso9Bnes76VlQ7KjrBEc
	4cwbu/Jm5XTWIkB2SpHXWCSEPYdeU2ErLgJSe1yveBUfDNMtYXy3Wm5n
X-Gm-Gg: AfdE7ckBnRUTomhxRxWz/u81WQWaxfhhiT52f1nflHPHVWSFVirsVrREwelkpDSIqVL
	FmTxsERFzMkbsuWEMSde2GpZxqsscivhQ3i/82dgmDskew14IrpP2E2YNydYx6neLnyCwvIXsJ7
	O5Q46JayZMuGKQiSS94GCIl9TQmZJYxST9RFF7hhKTuCGIAEeMEMnW6Q8eZTtsGARrn75xWQYIB
	snYSvfMQZPFp1KUfLupBjNU885/fK49dnQcTP0BYmNJmUbdF9jrTvzTdKNWo2Yrr32wQY+wWs5r
	Ek5EgxzLS0ap+eA5sPcMVD+cd1WpFySETIdgVYYS3CfFrkYvHVfrAV/nMve2QrBVmGHMhqd3qGv
	X+f7Utua+NQku+kLRMQnvD9kV7HvxI45/C6J7S9VyeB8JBxVnsVD8hpb/e8uDXkx/F/7HJ/CbNo
	2qg0MCt88=
X-Received: by 2002:a17:90b:1fcf:b0:377:4a58:fe0b with SMTP id 98e67ed59e1d1-37c93703da8mr6535042a91.7.1781778100407;
        Thu, 18 Jun 2026 03:21:40 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm9305116a91.0.2026.06.18.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:21:39 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: mgmt: copy pending command data under the list lock
Date: Thu, 18 Jun 2026 18:21:34 +0800
Message-Id: <20260618102134.3339999-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mgmt_pending_find() only protects the pending list lookup. Once it
returns, a caller that dereferences the returned command has no lifetime
guarantee unless another lock or ownership transfer keeps the command from
being removed and freed.

mgmt_powering_down() only needs the requested SET_POWERED mode, but it
currently keeps the raw pending command pointer after the list lock has
been dropped and then reads cmd->param and cp->val.

The buggy scenario involves two paths, with each column showing the order
within that path:

hci_suspend_dev()/hci_resume_dev():     SET_POWERED completion:
  1. mgmt_powering_down() calls           1. mgmt_set_powered_complete()
     pending_find()
  2. pending_find() drops                 2. mgmt_pending_valid() delists
     mgmt_pending_lock                       the command
                                          3. mgmt_pending_free() frees the
                                             command and parameter buffer
  3. mgmt_powering_down() reads
     cmd->param
  4. mgmt_powering_down() reads
     cp->val

Add a helper that copies a requested pending-command parameter slice while
mgmt_pending_lock is still held. Use it for the mgmt_mode readers in
mgmt.c so they take a snapshot of the pending request instead of keeping an
unlocked raw command pointer just to inspect the requested mode.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in mgmt_powering_down+0xa0/0xf0

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 ? mgmt_powering_down+0xa0/0xf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x19f/0x330
 ? mgmt_powering_down+0xa0/0xf0
 kasan_report+0xe0/0x110
 ? mgmt_powering_down+0xa0/0xf0
 mgmt_powering_down+0xa0/0xf0
 hci_suspend_dev+0xc0/0x2d0
 ? vhci_suspend_work+0x31/0x50
 process_one_work+0x4fd/0xbc0
 ? __pfx_process_one_work+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __list_add_valid_or_report+0x37/0xf0
 ? __pfx_vhci_suspend_work+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 worker_thread+0x2d8/0x570
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x1ad/0x1f0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c9/0x540
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x2e9/0x730
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 336 on cpu 2 at 98.764916s:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 mgmt_pending_new+0x44/0x130
 mgmt_pending_add+0x22/0x110
 set_powered+0x1ad/0x310
 hci_sock_sendmsg+0x96b/0xf80
 sock_write_iter+0x28e/0x2a0
 do_iter_readv_writev+0x211/0x390
 vfs_writev+0x266/0x7b0
 do_writev+0x191/0x1d0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 314 on cpu 0 at 101.816391s:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x313/0x590
 mgmt_pending_foreach+0x144/0x190
 __mgmt_power_off+0xca/0x250
 hci_dev_close_sync+0x8ba/0xb00
 hci_set_powered_sync+0x384/0x480
 hci_cmd_sync_work+0x187/0x210
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/mgmt.c      | 37 ++++++++++++++++++-------------------
 net/bluetooth/mgmt_util.c | 27 +++++++++++++++++++++++++++
 net/bluetooth/mgmt_util.h |  2 ++
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd0893..91272640864a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -960,19 +960,25 @@ static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
 	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
 }
 
+static bool pending_find_copy(u16 opcode, struct hci_dev *hdev, void *data,
+			      size_t len)
+{
+	return mgmt_pending_find_copy(HCI_CHANNEL_CONTROL, opcode, hdev,
+				      data, len);
+}
+
 u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_mode cp;
 
 	/* If there's a pending mgmt command the flags will not yet have
 	 * their final values, so check for this first.
 	 */
-	cmd = pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
-	if (cmd) {
-		struct mgmt_mode *cp = cmd->param;
-		if (cp->val == 0x01)
+	if (pending_find_copy(MGMT_OP_SET_DISCOVERABLE, hdev, &cp,
+			      sizeof(cp))) {
+		if (cp.val == 0x01)
 			return LE_AD_GENERAL;
-		else if (cp->val == 0x02)
+		else if (cp.val == 0x02)
 			return LE_AD_LIMITED;
 	} else {
 		if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
@@ -986,17 +992,13 @@ u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
 
 bool mgmt_get_connectable(struct hci_dev *hdev)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_mode cp;
 
 	/* If there's a pending mgmt command the flag will not yet have
 	 * it's final value, so check for this first.
 	 */
-	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
-	if (cmd) {
-		struct mgmt_mode *cp = cmd->param;
-
-		return cp->val;
-	}
+	if (pending_find_copy(MGMT_OP_SET_CONNECTABLE, hdev, &cp, sizeof(cp)))
+		return cp.val;
 
 	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
 }
@@ -9826,18 +9828,15 @@ static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 bool mgmt_powering_down(struct hci_dev *hdev)
 {
-	struct mgmt_pending_cmd *cmd;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
 
 	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
 		return true;
 
-	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (!cmd)
+	if (!pending_find_copy(MGMT_OP_SET_POWERED, hdev, &cp, sizeof(cp)))
 		return false;
 
-	cp = cmd->param;
-	if (!cp->val)
+	if (!cp.val)
 		return true;
 
 	return false;
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 6ea107c0e054..5d6d13ccadd2 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -233,6 +233,33 @@ struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 	return NULL;
 }
 
+bool mgmt_pending_find_copy(unsigned short channel, u16 opcode,
+			    struct hci_dev *hdev, void *data, size_t len)
+{
+	struct mgmt_pending_cmd *cmd, *tmp;
+	bool found = false;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != channel)
+			continue;
+
+		if (cmd->opcode != opcode)
+			continue;
+
+		if (cmd->param_len >= len) {
+			memcpy(data, cmd->param, len);
+			found = true;
+		}
+		break;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return found;
+}
+
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 20810cf06e81..4cccb71c8a1f 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -51,6 +51,8 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev);
+bool mgmt_pending_find_copy(unsigned short channel, u16 opcode,
+			    struct hci_dev *hdev, void *data, size_t len);
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev, bool remove,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data);
-- 
2.43.0

