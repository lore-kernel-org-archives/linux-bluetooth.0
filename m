Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AD370AD5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058424; cv=none; b=icFIhcPKFnPK7lq+IqovaIr2Wg5gl4+NC+Mukqd8IuUX8GIwIlGcopbXtP6bm58dEn6IVFAVNLKw6D+sxh/MOa94u7pCbYygm7ARijSolTBbxTQNOx82yhUk/XLiP899k9Z+5v7FuSp7n9x2PvJbpLv2KVBHyv/ocY4g9JzeodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058424; c=relaxed/simple;
	bh=qM8gJr6e1FztKJ5fEZnJEdHCSDLGCa2BIagLWbz8cc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V0doLpLPjiMcxjPMHku+s2atJA1mIfzi/4TY0pCR/hERCShhOBmzwfiTwSjG0dJiI2x0F6G1RUctkA5C4ZUOYHoXe+V0uv3WjxvjZS7xijmm4aWBU+a+JIIcTdDaNpklPsUww8HFEm89RHLibK9Oc3SvHBmf9R6cSM3UwsZ1mqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSdS74Lf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSdS74Lf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8454160043aso196116b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783058423; x=1783663223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B260b9qoHGqClGVfti9HsbtC6gB03MI5FFUYTqkrSnc=;
        b=gSdS74Lf0eGeR682uvUoND8Kbm1WmUdci+x6mjvm7PyYAKz/7Jou0+Q+Qn9PeaFKl7
         YvW+pm7C0T0uCUl/gfMnffPtfqmWsgx7L5N/iRCVJ8CVzW0yQ2v32jqXwwp+BecvM841
         NLX8kYx3r0xVHO4tlU7qWZdC+4uJE9KGG3/mEsg1d79hTrKSCQIt2L2WXiXlwAOgNYRU
         dMgBIaHrMJudZ+JIrgxL7GGJykwGO3ZoZKP+T7c2WgwqJ4NFx/0hL8xOp86Nb/QqrIY/
         GZCz1MF5ZDuUtQNmjOlgaBADkmCSEn1gO+HvUJRA1zITMLn/sIT3sy70tyLWS+ZN666q
         flhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783058423; x=1783663223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B260b9qoHGqClGVfti9HsbtC6gB03MI5FFUYTqkrSnc=;
        b=PhIL8XykE52aAxFQXB32p/h8OZBMmjKIJ8OtxAYgoH3JZv1/75vY1X4lvZk/nMi6i4
         PDXyS/+wIR9SkZHoCZOTa05GmI6cE5YnbLwFV+LEa6jqgkNOeRVO6gW3M2o7uZRM78yu
         jZw08hg6q0Q4ntiHppPoxcobJmGJSbutLr7xsgxGWs3sjrRx5sg5ywe8sjVBpxsEIV/C
         T4CTM61asqXwNYXfp1IXjpVHqeII2mfTZGw202b0KNUfFTAzTOCMCt6PCyT5td6rYnbx
         d1MtxW4/DXkZFHyQl7XRI28cOzUzY/pRs/6M3TTzkToUbVfD0tMoYhAiZB0iikEUu5Gu
         D7XA==
X-Gm-Message-State: AOJu0YyH+8lKVCUZwtrfA46h9XxPdfxlDeaIu2Gl4cwuxJlVC3py2A+p
	x9S2Z2hDadJ0Lfi0Z/vAb0FrE5oeVeuIf7PDojjOMJEFsO6ijCaZV683
X-Gm-Gg: AfdE7cmiQKnE+N5fYDXSNRpemOTdg17jb55KRO779UtAk/7PfhNYrkl5cXPQ1fjdHSn
	lCZqKhu+hvszvHfm4QWpccSgAdKA06Xu7X9atJ3kIS/iOcQ4ngi4R2+ng0JtC48ey9w8ygjU4tt
	UAHQ0HN6qiuS0ekVX5W6Im5P5SMwSIJCkBOcLmY2jix1wCng2ciediy1eyTiMegvBB+xHBR3kUi
	RZSN3jQSP6/BCVGI0G5B3D0gXSQ18ssQfbKXj5pI8ajxPI+2QdJjBtqgu80QW+YK4tSxiBLv3oZ
	sx+Dx1Aa8E8fOTZquzfgHdCVVrLdY5jYYgjvBzNJXRURmaugNDywFlLTCsra0E3lcLqknXKiH7V
	1pXwtitVr9ZO6FzvRsLndE0vRUibBT++OiAlaZJSEZgNuTR2cVKLL4IZW/IfUqdIoisTbg96ZLL
	aPH/5RkI8=
X-Received: by 2002:a05:6a00:1c93:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-847c0744b00mr8589552b3a.9.1783058422365;
        Thu, 02 Jul 2026 23:00:22 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb983871sm2336431b3a.41.2026.07.02.23.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:00:21 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: snapshot LOAD_CONN_PARAM data before queueing update
Date: Fri,  3 Jul 2026 14:00:16 +0800
Message-Id: <20260703060016.570188-1-zzzccc427@gmail.com>
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

The buggy scenario involves two paths, with each column showing the order
within that path:

  LOAD_CONN_PARAM update path:        LOAD_CONN_PARAM clear path:
  1. update the existing params       1. process a later multi-param load
  2. queue conn_update_sync(params)   2. clear disabled parameters
  3. return while the callback        3. free the queued params object
     is still pending
  4. callback dereferences params

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

Queue a private copy of the address and connection parameter values
instead, and free that copy from the sync-work destroy callback. The live
hdev->le_conn_params entry can then be cleared without invalidating queued
work.

Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/mgmt.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..4a38f7663445 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7947,6 +7947,11 @@ static int conn_update_sync(struct hci_dev *hdev, void *data)
 	return hci_le_conn_update_sync(hdev, conn, params);
 }
 
+static void conn_update_sync_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	kfree(data);
+}
+
 static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
@@ -8054,9 +8059,28 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			    (conn->le_conn_min_interval != min ||
 			     conn->le_conn_max_interval != max ||
 			     conn->le_conn_latency != latency ||
-			     conn->le_supv_timeout != timeout))
-				hci_cmd_sync_queue(hdev, conn_update_sync,
-						   hci_param, NULL);
+			     conn->le_supv_timeout != timeout)) {
+				struct hci_conn_params *update;
+
+				/* Queue a private snapshot so the live params
+				 * entry can be freed later.
+				 */
+				update = kzalloc_obj(*update);
+				if (!update)
+					continue;
+
+				update->addr = hci_param->addr;
+				update->addr_type = hci_param->addr_type;
+				update->conn_min_interval = min;
+				update->conn_max_interval = max;
+				update->conn_latency = latency;
+				update->supervision_timeout = timeout;
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

