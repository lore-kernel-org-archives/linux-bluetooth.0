Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E41386C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397726; cv=none; b=Rxy1ZKrpJIbTclnUiK/IVPL0kOuxyFklmT21QBt2GAl6byI/RcCmVPfDyGJGyGMlH15H17KGDgfJuJqr9O8sBGs16GKCx6HkxBBU/zj42wZc96lzJ93Nf0jTCgINyjtDfk0NSXCMOcAV8aQ2IfZRPy+BM7q5C6XBYeELhyOb0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397726; c=relaxed/simple;
	bh=7Uke6JNZxv867SjVS504yheh/YVHJIbzWfdyALrlAHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKvYmKOOBS+rXZ1ETbpA5/5uhcOnMa45U+0oSPAkiFThGtkgvAOWpEMnGZcS/+sC+ayY0XMX18XnoCfvwy9Pi7ws69a78MFn1FOGfM7dVi8CA83B08OI5M/K+xRNAAiJXP7Ooa4Mi28EZNsgbgDu9ZQN5Ll+d/x++9wY2OyQuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWCoGaDD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWCoGaDD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so142973b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783397724; x=1784002524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dkev2r5AqQhmFGOlrab3JuVWaUpQn1cTScuYj9bvndg=;
        b=bWCoGaDD4XdTYAKYO68RInCU8BP3DDCp8Os58Qni16hu6fMz2wzgclExu8OmWCg59+
         Bjnjzc7/mfrvRWyaZIyOpZI3DGOCLpdx2VJBwjP2ONrsIRYaz6Z3qjapj0arm3epXioQ
         68PzlCQX2piKvlgZ7xhE23l4jL1Ib5PKQ/IUpvOS+RGrtMT5b+4+cKkcgUZVCO3Di1Qq
         cg5YYA/8XzmYhiKln1DlWyiCV6YZdbxJcibuQuSgNW+qBg3oYHN8f0bSLhV6LHyJS2gL
         3VQhYLZNjAw9npQVn9DlfmqZkBHheVVE85n9Te5ZIVPhOHzsIgvTcQn+/OJgmKuP7JlN
         8O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783397724; x=1784002524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkev2r5AqQhmFGOlrab3JuVWaUpQn1cTScuYj9bvndg=;
        b=B44Ui9EeJRb/wFUIOcQMu+nUdAlE0f/auRLQkz5HAFUhievlboPIG5n7S09Cpqk+g4
         OS4NLpBOzJhVTUHxDaN0lsdvGDb6WuZpqAhDfdptbN/87ZNuODDtLhsswqnqWNI90Hie
         UVYuzzc3difmsBgn2FPd4mTBWik+gjBJAytfOL2KTmJEU/hZjKNgVX3BIiNfGaaQ++dJ
         K7gZxqv1xqvEtH5uXEJToottogjh7wKUkIbjFT+zDo6BXt0SHfjYYfVZ2Fp4LAe03vjH
         /f1aOJeZAXD4tZr5wFS+9nmRLh8PJ70tR7EonFdJfczEPXgfu35U53jlVLmW376+cSlk
         55yw==
X-Gm-Message-State: AOJu0Yw+r/Rugyg364n9i3xNpgclTtjjtJ9cdF3DOOUfMiRcxfaj3JPg
	G4oUpgcdrGdg411OiFGvfIcwLp9tqKJuNixaz3c4Sm7BFDbwOe2yjOLT7xph6WdoHJY=
X-Gm-Gg: AfdE7cmq66UZskH+2VNxWiuw3lcAnbJIk5yjPIGgGWqlCKcPq+Qpdgy5UHKF+Srbvjl
	z3TVUNMoVTNuhY98lzrWksgNl4KCtrFl549UEZDR3CQHrmo4LpyBaQxYHgkOnfKIs1n/AuXuE7R
	55utbo2Fj87oF+AJ3wwx4tBHCQqLLm+vL1BRCFBBJyvbkd/O8Rhgs2BrX49CiMELmWqocTTFnHx
	2LkBD7pbVquVOZISzflrMXB2qe1FpCDXT5AvePmEqGXuYXmd7gwbSn5ACU3c2YmSlk9FUBVAS10
	qq2XOmKU+NtQWinnhvXdZlOrRYv23SD9Avs4JDZlSEKxw+NJni5nmFVsumXoML8E5Jst0sjVYZd
	aK+teE3ps4xbiOLCxWgt1f1LJBXpDbFKTy/BgZrGquOn4vephNMzBUgHIiJYor9yaduo4k3x8Qs
	W/CqgSrbY=
X-Received: by 2002:a05:6a20:cf85:b0:3bf:e2f1:1b18 with SMTP id adf61e73a8af0-3c08eebe1abmr4527629637.49.1783397723891;
        Mon, 06 Jul 2026 21:15:23 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b25204sm312658a12.28.2026.07.06.21.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 21:15:23 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3] Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update
Date: Tue,  7 Jul 2026 12:15:18 +0800
Message-Id: <20260707041518.2799385-1-zzzccc427@gmail.com>
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
stores a borrowed hci_conn_params entry from hdev->le_conn_params. A later
LOAD_CONN_PARAM request can clear disabled parameters and free that entry
before hci_cmd_sync_work() runs the queued callback.

Do not keep the borrowed hci_conn_params pointer in queued work. Queue the
hci_conn instead and hold a reference until the queued callback completes.
When the work runs, revalidate that the connection is still present, look
up the current hci_conn_params entry, and cancel the update if userspace
removed that entry while the work was pending.

Copy the interval values from the current params entry under hdev->lock,
then drop the lock and keep using hci_le_conn_update_sync() to issue the
update.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in conn_update_sync+0x2a/0xf0 [bluetooth]
Read of size 1 at addr ffff88810c697126 by task kworker/u17:0/377
Workqueue: hci0 hci_cmd_sync_work [bluetooth]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 kasan_report+0xe0/0x110
 conn_update_sync+0x2a/0xf0 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Allocated by task 466:
 hci_conn_params_add+0xa6/0x240 [bluetooth]
 load_conn_param+0x4e1/0x850 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]

Freed by task 474:
 kfree+0x313/0x590
 hci_conn_params_clear_disabled+0x9b/0xc0 [bluetooth]
 load_conn_param+0x4bf/0x850 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]

Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v3:
- Keep using hci_le_conn_update_sync() instead of open-coding the HCI
  command in mgmt.c.
- Queue a referenced hci_conn instead of allocating an address-key wrapper.
- Revalidate the connection and current hci_conn_params under hdev->lock,
  then pass a stack copy of the interval fields to hci_le_conn_update_sync().

v2:
- Re-check hci_conn_params in conn_update_sync() and skip the queued
  update if the entry was removed while the work was pending, as
  suggested by Luiz.
- Queue only the address key and copy the current params and connection
  handle under hdev->lock before issuing the HCI command.

 net/bluetooth/mgmt.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..a0a491e5311e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7937,14 +7937,36 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 
 static int conn_update_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn_params *params = data;
-	struct hci_conn *conn;
+	struct hci_conn *conn = data;
+	struct hci_conn_params *params;
+	struct hci_conn_params local = {};
 
-	conn = hci_conn_hash_lookup_le(hdev, &params->addr, params->addr_type);
-	if (!conn)
-		return -ECANCELED;
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn) || conn->role != HCI_ROLE_MASTER)
+		goto cancel;
+
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (!params)
+		goto cancel;
+
+	local.conn_min_interval = params->conn_min_interval;
+	local.conn_max_interval = params->conn_max_interval;
+	local.conn_latency = params->conn_latency;
+	local.supervision_timeout = params->supervision_timeout;
 
-	return hci_le_conn_update_sync(hdev, conn, params);
+	hci_dev_unlock(hdev);
+
+	return hci_le_conn_update_sync(hdev, conn, &local);
+
+cancel:
+	hci_dev_unlock(hdev);
+	return -ECANCELED;
+}
+
+static void conn_update_sync_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	hci_conn_put(data);
 }
 
 static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -8054,9 +8076,13 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			    (conn->le_conn_min_interval != min ||
 			     conn->le_conn_max_interval != max ||
 			     conn->le_conn_latency != latency ||
-			     conn->le_supv_timeout != timeout))
-				hci_cmd_sync_queue(hdev, conn_update_sync,
-						   hci_param, NULL);
+			     conn->le_supv_timeout != timeout)) {
+				hci_conn_get(conn);
+				if (hci_cmd_sync_queue(hdev, conn_update_sync,
+						       conn,
+						       conn_update_sync_destroy) < 0)
+					hci_conn_put(conn);
+			}
 		}
 	}
 
-- 
2.43.0
