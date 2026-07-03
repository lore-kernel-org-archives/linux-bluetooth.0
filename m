Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C42BE05A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099503; cv=none; b=s1RgQKLLefp91tAVHLG3A6iexntwJdEHiFnmzinGySRmK+bxplzxxysdGbYjuWnMUbcK78S/FSN4em86w8/PWOwz5v0FRdH2JivlSizJkNbtdymdnYSjwoksU+bqAJranTc8jQVc3DmtglGm/yzve3xOegvVsgxukR56YqEznLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099503; c=relaxed/simple;
	bh=ith/F1J30Vs5+mXOqi1zPfPjuTgvqdRQgwa9aCkR8OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhN/qvcpnLa3GjuS9LkF10pL7RX8BaY0td7yIVZjslvtjRsYp3HUNb9fcH8YlcXIHvUPuysFAeAS503y2CJYSOQaoYXM/euR9NgFeRwv5Wtj+9MWRoYLGq2SXXI3onwraks1JO+KIu/bbkSwUPY2gtzjt8n+ckIJ7pP7w5jDQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlZn4ndh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlZn4ndh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37e0fb87b75so885928a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099502; x=1783704302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6UnqwpsyU7dFE9HXqfoWj7sSFAmeDWgVE1ykBaFQuA=;
        b=dlZn4ndhQji44LFO6jGL095iScPxev1TTtk2YS+dXq5598GaDFTAmYDk2VeIEkLdVH
         8TRWmTljXgpdrmWqEew8idFuA5xovHAS03xn36L0EA8GBtddwNvzUP4eQnA9jleb5PXU
         qKWwd0G2kBbpMni+YDtjyF8zBDyfkcsngy3KrKZ4QPqtoNTfijL1k1G6vCKzAbhNNieE
         e3i6LO8B2J9ZV2Sbksy8B7BDOeZ8WEXrvudW8D2Go0NLmWQRIl8MJMHffJfH9hMi42EV
         Gcb8JKNwPLI7Xxa1ZuZYMPsV/RY1DPWaFPEgKhZNoxeuqdw8hhRVEkM6GyfAkwLc43m5
         5DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099502; x=1783704302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6UnqwpsyU7dFE9HXqfoWj7sSFAmeDWgVE1ykBaFQuA=;
        b=UeZ+yk95GRwhleJYVgPSgrUDPaaXc/uOSah3gs/4xFa+2RkxAFySN5cPTTcgFzU4ow
         FOg/ICGLY+qLtLNNMj6Ye0kgT3QtlEPsD9bMdAYHLqLjq3fOQbQ/TWSOL14quuiVI6FD
         KaCga9ycnNQ/USMB90PqquQkVrTMaaT7CS9G23F5My4WU+QB8FrU6eWUdt74Bznxw7hE
         zH4WGiN0Pu3CuYtsDJBVnLY47F+NoQZZ+OQfaLo3E4YzgvGRTXDYaxGF5vlGHZPzsVv2
         bj2ufGaM08vu5IDpCKR17T7ycXv7fcUNPbTEn6Nx4WnpHstfuTrQ0gLD9noP/s6yH9GK
         uQuw==
X-Gm-Message-State: AOJu0YzD324lQpBi99a2LtaOzRVqkJ8xui5T6mAyiYO8cTIvwISI8YPl
	0TfdPmP0FeVe0VzfwajyKsTlZhkIhiTBUXpCvsZ4ub94Nd7wYUohV4xu
X-Gm-Gg: AfdE7clb0vt31rB1mR1p0eTb/hKGpKA1vnRYCRxCu7blc9PunkAViGzL058zz0+Mo8N
	YQpYXJTTBRQdPqPaCdiZZjaJuwBasT9OrgIDZI5ryIXSUUnrDHYjoX3s8w7wcDK2LOJK19Q94KD
	ux5oOhrT1vqpEMGIBG0PSSKZn1/9WScU7PW3IqrMnupaKveuSLIcvC/mExOAokHV0gqCpQMs72Y
	GZqkzAuoU6+c+7tcbKiz2gocy6FLamREXqgXfmUb8cMwBf5qlUc46teQH5MYMMDBPdEQBLF/Iw7
	GjnDXKcQAG+Pa7UEYKXN21R5ZocjgiL326UTuxogU0MxQKzgww+fERdgdcr8VcSpnqr5A4BAfi+
	B2hhS5K66swkkw+zmbB91FoORKtZngjmnjZqcE69n3g5L53m4CHiYHiX7bGd4tVw4YO6aTGhz2c
	BEu3kcrLM=
X-Received: by 2002:a17:902:968e:b0:2ca:e0ff:e696 with SMTP id d9443c01a7336-2cbb0b1e34dmr1767965ad.9.1783099501523;
        Fri, 03 Jul 2026 10:25:01 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7870873sm12233865ad.55.2026.07.03.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:25:01 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] Bluetooth: MGMT: validate LOAD_CONN_PARAM entry before update
Date: Sat,  4 Jul 2026 01:24:55 +0800
Message-Id: <20260703172455.2363611-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MGMT_OP_LOAD_CONN_PARAM queues conn_update_sync() when a single parameter
update changes an existing LE central connection. The queued work currently
stores the hci_conn_params object from hdev->le_conn_params. A later
LOAD_CONN_PARAM request can clear disabled parameters and free that object
before hci_cmd_sync_work() runs the queued callback.

Do not keep that borrowed pointer in the queued work. Queue only the
address key. conn_update_sync() can then look up the current params entry
while holding hdev->lock. If userspace removed that entry while the work
was pending, cancel the queued update.

If the entry is still present, copy the current params and connection
handle under the lock. Then issue LE Connection Update after dropping the
lock.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in conn_update_sync+0x2a/0xf0 [bluetooth]
Read of size 1 at addr ffff88810c697126 by task kworker/u17:0/377
Workqueue: hci0 hci_cmd_sync_work [bluetooth]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 ? conn_update_sync+0x2a/0xf0 [bluetooth]
 ? __virt_addr_valid+0x19f/0x330
 ? conn_update_sync+0x2a/0xf0 [bluetooth]
 kasan_report+0xe0/0x110
 ? conn_update_sync+0x2a/0xf0 [bluetooth]
 ? __pfx_conn_update_sync+0x10/0x10 [bluetooth]
 conn_update_sync+0x2a/0xf0 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Allocated by task 466:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 hci_conn_params_add+0xa6/0x240 [bluetooth]
 load_conn_param+0x4e1/0x850 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 sock_write_iter+0x28e/0x2a0
 vfs_write+0x6e4/0x810
 ksys_write+0x147/0x170
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 474:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x313/0x590
 hci_conn_params_clear_disabled+0x9b/0xc0 [bluetooth]
 load_conn_param+0x4bf/0x850 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 sock_write_iter+0x28e/0x2a0
 vfs_write+0x6e4/0x810
 ksys_write+0x147/0x170
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
- Re-check hci_conn_params in conn_update_sync() and skip the queued
  update if the entry was removed while the work was pending, as
  suggested by Luiz.
- Queue only the address key and copy the current params and connection
  handle under hdev->lock before issuing the HCI command.

 net/bluetooth/mgmt.c | 62 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..6fbabf437786 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7935,16 +7935,50 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+struct conn_update_sync_data {
+	bdaddr_t addr;
+	u8 addr_type;
+};
+
 static int conn_update_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn_params *params = data;
+	struct conn_update_sync_data *update = data;
+	struct hci_conn_params *params;
+	struct hci_cp_le_conn_update cp;
 	struct hci_conn *conn;
 
-	conn = hci_conn_hash_lookup_le(hdev, &params->addr, params->addr_type);
-	if (!conn)
-		return -ECANCELED;
+	hci_dev_lock(hdev);
+
+	params = hci_conn_params_lookup(hdev, &update->addr, update->addr_type);
+	if (!params)
+		goto cancel;
+
+	conn = hci_conn_hash_lookup_le(hdev, &update->addr, update->addr_type);
+	if (!conn || conn->role != HCI_ROLE_MASTER)
+		goto cancel;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle		= cpu_to_le16(conn->handle);
+	cp.conn_interval_min	= cpu_to_le16(params->conn_min_interval);
+	cp.conn_interval_max	= cpu_to_le16(params->conn_max_interval);
+	cp.conn_latency		= cpu_to_le16(params->conn_latency);
+	cp.supervision_timeout	= cpu_to_le16(params->supervision_timeout);
+	cp.min_ce_len		= cpu_to_le16(0x0000);
+	cp.max_ce_len		= cpu_to_le16(0x0000);
 
-	return hci_le_conn_update_sync(hdev, conn, params);
+	hci_dev_unlock(hdev);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+
+cancel:
+	hci_dev_unlock(hdev);
+	return -ECANCELED;
+}
+
+static void conn_update_sync_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	kfree(data);
 }
 
 static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -8054,9 +8088,21 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			    (conn->le_conn_min_interval != min ||
 			     conn->le_conn_max_interval != max ||
 			     conn->le_conn_latency != latency ||
-			     conn->le_supv_timeout != timeout))
-				hci_cmd_sync_queue(hdev, conn_update_sync,
-						   hci_param, NULL);
+			     conn->le_supv_timeout != timeout)) {
+				struct conn_update_sync_data *update;
+
+				update = kzalloc_obj(*update);
+				if (!update)
+					continue;
+
+				bacpy(&update->addr, &hci_param->addr);
+				update->addr_type = hci_param->addr_type;
+
+				if (hci_cmd_sync_queue(hdev, conn_update_sync,
+						       update,
+						       conn_update_sync_destroy) < 0)
+					kfree(update);
+			}
 		}
 	}
 
-- 
2.43.0
