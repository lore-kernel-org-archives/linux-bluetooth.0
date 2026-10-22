Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671323;
	b=cGVF2dEaa0LQjHT6R0tTnyzejOTTBXtKP+FlUVwqTy8pxwixAIFqugO6jg4oU5XPXggp
	 u374oFc6soxu9AFfoHg2eiu/ysrNU5M7hNj68VWzDIvL8rMXa4YHB3bPCLf3Z22uBkPZ5
	 PZfotphvtW3Q2wji1BgI3BZ6b94Gq45rrPa2AC3khPflLI51KHr9omODANESq8yt7t980
	 T7sTbU52Ub+3J3oXctTaMrHrchAJNqE6ZiUx/yAuMwwpZxo/iZRzpcHAiU11KLtWRek7n
	 gqNwINKy7kUt5W1EVZ2iRdsYKcBvjSt88lqJI8zgrrDtGQv1dfKrfvY23tvsP8gCdBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=liXoAECJvGKDAVp+mXVo2aameKZCDOraoLb79YpUHfc=;
	b=YP/bgwGksILNBXXmLZTJ8GlLvGdRqydkECnekvde6UGDbjrFa9qGi1ZwYLrENHNEyFMk
	 RISihcYuM0Tz5EiP/6g3vglcX6tV2MC0GwqO26eLES5fkC2tBJmf+0g9mwMlN5/Y9Ah8l
	 yOQzTPfDI2tG0gBJtypD8Cpj9l+ehVds5qddPRcjVbQu1L+8JQ+LeCkAjh4TYoEWi4cWQ
	 AejeTLobhaRRWgK6aPZZFhPecR9RC59Wh4JSLrvxuwyvYpHXvtXgsi04oQujWt6Mdzhci
	 AGr9z3ooe7o8eRgLRvGq5zwLWJe/tAFEBxC/RDbGw6lVORFE7JML+yVJ0p0lpTjsvug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cd+z8of7;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21372606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21372606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cd+z8of7
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1174625a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792671322; x=1793276122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liXoAECJvGKDAVp+mXVo2aameKZCDOraoLb79YpUHfc=;
        b=Cd+z8of7rwPCwWQ2vQXVXeTp50yv76LgMCApDqmuLv0/0WmmK2MUDPB8rYf8IHF7jo
         Vys6rXj2O7SD6s2CIrHj1feFtlRFQEuKrPd+TvtOHCuGDWMyKCDjw0Op04sXQkamxw5b
         fsy8fS7qvL+8tZA73nB+OeklB0D4HSlIXQbOBkL0cCzpctQFAyVB4COpomsc/SaUfslA
         smUjlAQtJfXJN8nar+9tqfB/wVboZ99s6uOeFqiClOd6DDcjTORZKKD2KkS9dS+wNjbe
         3bEq1DztRvBaFBpkUWilcEcAIYD6PZ0+WEhwm9XbvMn1tpL/1FZrND2ojma5ZmxbdBId
         zcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671322; x=1793276122;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=liXoAECJvGKDAVp+mXVo2aameKZCDOraoLb79YpUHfc=;
        b=BMF/hpwZnCViP01HgH8R7iQrdOjaoJhcdlTJ3A3v93kml+U9jW5a3SUD4qrmwKYO/f
         AYtnU68aO8umEtt8pqZKJGZFw5crkwva2biyGnAPWB5Gsg9JyDyH8xn5cNQHBJPeBYJf
         oLHhzmuOhqRPO1qTNi+a68dWK1ffg+Zxfzbzjp/rOXwen8Hws8MrrGmEVNlsv2u7XDLE
         1Y1ALj8/o47W2ALbGTUX2qJy5qJPpUZuZxwOvgBKQmBiZgkFg5LM2h/N7Ak2K5VILaSd
         UnZgzW0o0Mbz5b9sMwNHqkz6RXId/M9v9cw1k8xmpUucGWjGuD5qzCezn36RRn2gM0vw
         kIOQ==
X-Gm-Message-State: AFq9FYL8g9C2t+qRWj2ZaksN/cfp+MRHwYiRHQ49A82ayDGV01F8vLDV
	MXAL+mBVQe8ZawBaOP/U4zepo7cpbsXrsYM3f/DU7OLHQ/aZJM6YSaSL
X-Gm-Gg: AYBFou29lYWVW38zVg0F6ZVL2PbIg9XfK02/ceSjARgNxPJmjVvjvMuOMGqlVYWrF7K
	m6NN7zfFv4WyeAVY7KOvqXPoVOVJy7bdT3F8/LFYHZ1Ac6aA5CJRvPam9S6VhDKVHbRo0H8y8vh
	jFI5iXhIWqot7a3+YipI3psR7KRy8JeN+lCTIhHFdy13Qpfzv3OCPHBAMd4pcTocBFFo6A8cXO7
	VoPLuEeAx35hx5oQv2LQzXO2F61+9xKigCyccac1mlrquGn8gO4NdWmZob0ubKSulbhgUMgllaJ
	696DWREY/rRAUNjpNhHBbb3iIGdwiSqF62xgHFcDoSc1VIRSaczPjV1uH24DOSnE+bddj7L2kLs
	LK29TUlhzs15RsJFSXyYCMTaldsghiNNsIfikAItJtzBZk/sRW8FTJhm4TLiOcE71rCSCmOHcB9
	uB/yfc8VjVsuFTVzCCvOq7v7aXfFnD7Z7q5hN62c9y2HV9kWoKC4yvp5PQWhLLXAJ2+VW8Jh+ki
	BXDVuLx0TC3lNQsa/1Ks1aWTP/Dpaaxqwlr39CRwVTwobr8HA8=
X-Received: by 2002:a17:90b:1646:b0:3ac:9669:8464 with SMTP id 98e67ed59e1d1-3ad86cf2be4mr3988163a91.24.1792671322156;
        Thu, 22 Oct 2026 05:15:22 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490d4bfsm4777062a91.10.2026.10.22.05.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:15:21 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3] Bluetooth: MGMT: Serialize power-on with power-off completion
Date: Thu, 22 Oct 2026 20:15:15 +0800
Message-Id: <pm-bluetooth-objects-candidate-0063-v15-e728a3f8014489975c69@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mgmt_set_powered_complete() must consume only its own SET_POWERED
command. __mgmt_power_off() frees that command before its destroy callback
runs, and mgmt_pending_valid() recognizes pending commands only by address.

The power-on handler can reuse the address, but it is not the only
allocator. A concurrent set_mesh() can also publish another pending command
at that address after close drops hdev->lock:

  Close request worker              Management socket
  --------------------              -----------------
  __mgmt_power_off(): free cmd
  hci_dev_close_sync(): unlock
                                    set_mesh(): allocate replacement
  completion: claim old address
                                    submission fails: remove/free cmd
  completion: access replacement

Serialize power-on publication with req_lock, which the request worker
holds through its destroy callback. Keep power-off cancellation outside
that mutex and keep the req_lock -> hdev->lock ordering.

Also hold hdev->lock while finding the pending SET_POWERED command,
checking its identity, and consuming it. An unrelated command at the old
address then fails the opcode-specific lookup without being unlinked.
Power-on cannot reuse a SET_POWERED address until the old callback drops
req_lock, and power-off allocates no command once the device is down.

Dequeue pending power requests before settings_rsp() frees their command
data. Their cancellation callback already returns without touching cmd.
An already-dequeued request can still be waiting for req_lock. Check its
opcode under mgmt_pending_lock before copying parameters as well, so it
cannot interpret an unrelated replacement command as power settings.

KASAN report as below:

        BUG: KASAN: slab-use-after-free in
    mgmt_set_powered_complete+0x450/0x4d0
    Read of size 2 at addr ffff88810921ab10 by task kworker/u17:0/500

    Workqueue: hci0 hci_cmd_sync_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? mgmt_set_powered_complete+0x450/0x4d0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? mgmt_set_powered_complete+0x450/0x4d0
     kasan_report+0xe0/0x110
     ? mgmt_set_powered_complete+0x450/0x4d0
     mgmt_set_powered_complete+0x450/0x4d0
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
     hci_cmd_sync_work+0x207/0x450
     ? __pfx_mgmt_set_powered_complete+0x10/0x10
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_pending_new+0x60/0x230
     mgmt_pending_add+0x3b/0x180
     set_powered+0x2a8/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 531:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     set_powered+0x336/0x7e0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    ==================================================================

Fixes: eec8d2bcc841 ("Bluetooth: Add support for set_powered management command")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v3:
- Address cross-opcode pending-command reuse reported by Sashiko:
  https://sashiko.dev/#/patchset/88964
- Validate SET_POWERED identity before claiming it.
- Cancel queued power requests before freeing their command data.
- Check the opcode of an already-dequeued request before reading its
  parameters.
- Retain the balanced power-on request locking introduced in v2.

Changes in v2:
- Move the common set_powered command path into a helper and acquire
  req_lock in the explicit power-on branch, fixing Clang context-analysis
  errors.
- Preserve req_lock -> hdev->lock ordering and keep power-off cancellation
  outside req_lock.
- Rebase onto current bluetooth-next.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0063-v7-35a6680c94a332fea155@gmail.com
Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0063-v11-a70581b6877e5fe118a3@gmail.com

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1342,9 +1342,15 @@
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_mode *cp;
 
-	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
+	if (err == -ECANCELED)
 		return;
+
+	hci_dev_lock(hdev);
+
+	/* Other management commands may reuse the old command address. */
+	if (pending_find(MGMT_OP_SET_POWERED, hdev) != cmd ||
+	    !mgmt_pending_valid(hdev, cmd))
+		goto unlock;
 
 	cp = cmd->param;
 
@@ -1352,10 +1358,8 @@
 
 	if (!err) {
 		if (cp->val) {
-			hci_dev_lock(hdev);
 			restart_le_actions(hdev);
 			hci_update_passive_scan(hdev);
-			hci_dev_unlock(hdev);
 		}
 
 		send_settings_rsp(cmd->sk, cmd->opcode, hdev);
@@ -1371,6 +1375,9 @@
 	}
 
 	mgmt_pending_free(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static int set_powered_sync(struct hci_dev *hdev, void *data)
@@ -1380,8 +1387,9 @@
 
 	mutex_lock(&hdev->mgmt_pending_lock);
 
-	/* Make sure cmd still outstanding. */
-	if (!__mgmt_pending_listed(hdev, cmd)) {
+	/* A dequeued request may have waited across a controller reset. */
+	if (!__mgmt_pending_listed(hdev, cmd) ||
+	    cmd->opcode != MGMT_OP_SET_POWERED) {
 		mutex_unlock(&hdev->mgmt_pending_lock);
 		return -ECANCELED;
 	}
@@ -1395,18 +1403,12 @@
 	return hci_set_powered_sync(hdev, cp.val);
 }
 
-static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
-		       u16 len)
+static int __set_powered(struct sock *sk, struct hci_dev *hdev,
+			 void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct mgmt_pending_cmd *cmd;
 	int err;
-
-	bt_dev_dbg(hdev, "sock %p", sk);
-
-	if (cp->val != 0x00 && cp->val != 0x01)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -1454,6 +1456,32 @@
 	return err;
 }
 
+static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
+		       u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	if (!cp->val)
+		return __set_powered(sk, hdev, data, len);
+
+	/*
+	 * Wait for the previous power-off completion before publishing a
+	 * new command that could reuse its freed pending-command address.
+	 */
+	hci_req_sync_lock(hdev);
+	err = __set_powered(sk, hdev, data, len);
+	hci_req_sync_unlock(hdev);
+
+	return err;
+}
+
 int mgmt_new_settings(struct hci_dev *hdev)
 {
 	return new_settings(hdev, NULL);
@@ -1468,6 +1496,11 @@
 static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
+
+	/* A queued power request must not retain the freed command. */
+	if (cmd->opcode == MGMT_OP_SET_POWERED)
+		hci_cmd_sync_dequeue(match->hdev, set_powered_sync, cmd,
+				     mgmt_set_powered_complete);
 
 	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
 
