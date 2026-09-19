Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068847C11F
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789817120; cv=none; b=LhsQ021l3PFxWVP6Luk0pZPcgNJugYQ5wsw0g7CEyETxgVcY+GC8XKdzDDxgHNOGv0FMzWY/Ge4G7GEnAmBuNaAauwRfvPE3bYE5xrzUyeUam6vs6/CI9JdregsCtmNl2niW8OSmDifvKfGluAB9i0v00CrptOjsQLgJfxhufVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789817120; c=relaxed/simple;
	bh=SQivD/ji4K2R5qTspKfekb7FmiWTNsMmyU8BWBAt8e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJd3bqUkgqfd1+ypMstoGO3HZelk20LgWbeTqmBuruWD25TAGRDsigUWwYAucIhcTZXtvsfRO7ILlaM+MXOgEnOnQAYPXEdNb3SwpQdDAUJMffnpp35zJXn54fi3DfysehAgjzgVZQfA8dmPsAhPcQis8GyrSqsGjFjjE2ANFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpevQ1/P; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpevQ1/P"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1442704a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789817118; x=1790421918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5aC3Kgohlow4wcl0VhHJG+JEyeeGtfUQaYksvod4tg=;
        b=dpevQ1/PAqDm+Y8tRZNs2EAo5cx5zfs6nIrWbtU7RRJJlcSX1KZwf9JKS32hLIhZ4y
         lRpEhpmUXr1G/3m4UlYE0BCOciTOxVhHmqRFSGHq8HwHLciwkmxxA97j5kv2uNaPy701
         mNLWSYaFo/qRo1asfHOPM3u5zDecurZymB0lQKz8ZOXeoFuwNpuRxzsfgBclP067/CXC
         W6w5Eak0nkeOtq0Tbsapps8kvercwvWAS6PwHh0ouiaBay9d0FsNE+BdBsf9uGUYT4zq
         C/1i0imiQT5wJvTcLmWPnlHzp3gLNdbpjw41p5E5zfeuQIZvXsq3ln5cjH/8oi+X8Kzb
         lP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789817118; x=1790421918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5aC3Kgohlow4wcl0VhHJG+JEyeeGtfUQaYksvod4tg=;
        b=scl+2UA4sIXVgCdsW1WLrumQdfeJLRN9S5AaeyuVvTYvAHR1P8aVzEIwNW0Vvj3dff
         sp35L0SVhv5bH4iViqrRLChl8GCrzI/lrtJ3IOYUUTdEzkSa/8nVJUKeceZBXjvW10L7
         vkTyZ9yvd9xEcfXuxs4/bR7x+8dHl4gAK7gqc01FEVVE8L9eZDNcYGiz3sfHRXUYPEhc
         INO3873McH5BHsr4Syx+SDxj+pD8Sxci3qXSQrA7AmdC+aZZALAHaynWBimMka998xYg
         NNpmO/Ok8hGkL6ChKovnr4ISbw2+LvWHZV5xUim08VNoiWsOGWkE2o//HG80/JK2bvKn
         RHrA==
X-Gm-Message-State: AFuF++ly45GIbpB0hrGZKw2dcfUUYlEKhIfcF6Li00eMUCCuuXkUYCFT
	bJbd0rM4nSo4nkwgLp1q2VaZSU4lHWVz1rmOZPKILyY5dc+LRfaEb6nvBdYb1gVJ
X-Gm-Gg: AYBFou05U03o/qsquEPE1xv3+4kmg+KDgTY/V4P7srAfNw0Q0SDn0GuLD3im/qiOaSi
	tgOcVY7EbHyuKAa2/BR1VnkvtyDWK1f1Yg7A8aGKTB2D2fOhKtbMU3tCoHUWKUZnyVXBL6y/ytH
	JH8tUNShk+2mBmnjVOKk2U/E2PLoByfoL/cDJEy6wqAd+M0ZQTmlbhdPfOa0BEG7KuqHFYg21am
	R19Gt81/mvy6jD+iNA4nJjt1CU2NKhvsCS6kfe9E9pFIBZ1bh3Wi11gblJ5BqGE0JloipmsBEeM
	vzhf3ajtxs6OeEX8k7wpxv3NGstniOeumivTBNqEzwzOpaOH9xBe5sVDPkpisVo8bRo+Qi1e0Vo
	Fk3NPYDuGRJnEA1NinBhd787KVyQPJ5ZzGOL3Mwq8P5ZJqVTVEEd2FbZK3CsRKBRqpHVRRTnssH
	HWNsQbZhiW6HAd8wT3SfNawPPOvZGVU/SPYwXsI5AXffHLP7de5CuVeTgZiOvwpqO4m+5Tj3E7b
	UJMnNz6RrkBuMZzM0JfA3S+1aV959DbmMp7/tG1a87w4joTH6MyW3qnzflGenxZNLwrGI/CSWku
	aXbAplgnbg==
X-Received: by 2002:a17:90b:2f85:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-39e54e7657fmr10074872a91.18.1789817117952;
        Sat, 19 Sep 2026 04:25:17 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5647c151sm3087498a91.4.2026.09.19.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:25:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: MGMT: Fix mesh_tx Use-After-Free and leak in mesh_send()
Date: Sat, 19 Sep 2026 11:25:17 +0000
Message-ID: <20260919112517.3871992-1-benquike@gmail.com>
In-Reply-To: <20260919080846.3005471-1-benquike@gmail.com>
References: <20260919080846.3005471-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mesh_send(), a struct mgmt_mesh_tx entry is allocated and added to
hdev->mesh_pending via mgmt_mesh_add(sk, hdev, send, len) before queuing
mesh_send_sync() and mesh_send_start_complete() onto hdev->req_workqueue
with mesh_tx as the callback data pointer.

Before or while the workqueue executes mesh_send_sync() and
mesh_send_start_complete(), mesh_tx can be removed from
hdev->mesh_pending and freed via mgmt_mesh_remove():
1. If an earlier MGMT_OP_MESH_SEND_CANCEL (send_cancel()) item runs on
   hdev->req_workqueue, send_cancel() calls mesh_send_complete(), which
   removes and frees mesh_tx.
2. If the management socket is closed, mgmt_cleanup() removes and frees
   all mesh_tx entries matching sk under hci_dev_lock(hdev).

When mesh_send_sync() and mesh_send_start_complete() subsequently run,
they dereference the dangling mesh_tx pointer (mesh_tx->param,
mesh_tx->handle, mesh_tx->instance), and mesh_send_start_complete()
frees mesh_tx a second time via mesh_send_complete() on error.

Furthermore, if hci_cmd_sync_queue() fails in mesh_send() (which can
only happen in the !sending branch), mesh_send() only called
mgmt_mesh_remove(mesh_tx) when if (sending) was true (an inverted
condition), leaking mesh_tx on hdev->mesh_pending.

Fix this by holding hci_dev_lock(hdev) and verifying
mesh_tx == mgmt_mesh_next(hdev, NULL) across all mesh_tx and send
dereferences in mesh_send_sync() and mesh_send_start_complete(), and
unconditionally calling mgmt_mesh_remove(mesh_tx) on
hci_cmd_sync_queue() error in mesh_send().

Kernel stack trace (Linux 7.3.0-rc3):
 ==================================================================
 BUG: KASAN: slab-use-after-free in mesh_send_sync+0x39a/0x410
 Read of size 1 at addr ffff8880132fe53b by task kworker/u9:1/143

 CPU: 1 UID: 0 PID: 143 Comm: kworker/u9:1 Not tainted 7.3.0-rc3-g5dd1818b15d9 #1 PREEMPT(lazy)
 Workqueue: hci0 hci_cmd_sync_work
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  mesh_send_sync+0x39a/0x410
  hci_cmd_sync_work+0x14e/0x2a0
  process_one_work+0x6ff/0x1110
  worker_thread+0x4a8/0xb70
  kthread+0x307/0x3e0
  ret_from_fork+0x3ed/0x680
  ret_from_fork_asm+0x1a/0x30
  </TASK>

 Allocated by task 1:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  __kasan_kmalloc+0x7f/0x90
  __kmalloc_cache_noprof+0x16a/0x380
  mgmt_mesh_add+0x5b/0x340
  mesh_send+0x22b/0x690
  hci_sock_sendmsg+0x1155/0x2040
  sock_write_iter+0x492/0x520
  vfs_write+0x671/0xd20
  ksys_write+0x1bb/0x210
  do_syscall_64+0xda/0x4b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

 Freed by task 143:
  kasan_save_stack+0x30/0x50
  kasan_save_track+0x14/0x30
  kasan_save_free_info+0x3b/0x70
  __kasan_slab_free+0x47/0x70
  kfree+0x159/0x420
  send_cancel+0x14e/0x360
  hci_cmd_sync_work+0x14e/0x2a0
  process_one_work+0x6ff/0x1110
  worker_thread+0x4a8/0xb70
  kthread+0x307/0x3e0
  ret_from_fork+0x3ed/0x680
  ret_from_fork_asm+0x1a/0x30

 The buggy address belongs to the object at 0xffff8880132fe500
  which belongs to the cache kmalloc-96 of size 96
 The buggy address is located 59 bytes inside of
  freed 96-byte region [ffff8880132fe500, ffff8880132fe560)
 ==================================================================

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
v3: Add a Fixes: tag. The allocator (mgmt_mesh_add() in mesh_send()),
the freeing path (mesh_send_complete() from send_cancel()), the racing
dereference (mesh_send_sync()), the unlocked hci_add_adv_instance()
call and the missing mgmt_mesh_remove() on the !sending path all came
in together with b338d91703fa ("Bluetooth: Implement support for
Mesh"), first released in v6.1. No later commit touched any of the
lines this patch changes.

This patch fixes two things that share that one origin: the
UAF/locking race, and the leak when the send is not queued. Happy to
split it into two patches if you prefer - both halves would carry the
same tag.

Backporting: the hunks apply back to v6.1, but mesh_send() picked up
extra validation in bda93eec78cd, so older stable branches may need a
trivial context fixup.

v2: Resend via git send-email with intact tab formatting and Assisted-by: LLM tag.
Reproducer (triggers KASAN slab-use-after-free in mesh_send_sync() on
Linux 7.3.0-rc3 via /dev/vhci and MGMT_OP_MESH_SEND_CANCEL +
MGMT_OP_MESH_SEND):

  /* 1. Enable Mesh experimental feature (UUID 766ef3e8-245f-05bf-8d4d-037ad763e42c)
   *    and LE on hci0 via MGMT_OP_SET_EXP_FEATURE (0x004a) and MGMT_OP_SET_LE (0x000d).
   * 2. Hold hdev->req_workqueue briefly in set_name_sync (MGMT_OP_SET_LOCAL_NAME 0x000f).
   * 3. Queue MGMT_OP_MESH_SEND_CANCEL (0x005a, handle = 0) followed immediately by
   *    MGMT_OP_MESH_SEND (0x0059) on a second MGMT control socket.
   * 4. MGMT_OP_MESH_SEND synchronously adds mesh_tx to hdev->mesh_pending (assigning
   *    handle = 1, or matching handle = 0 cancel) and queues mesh_send_sync(mesh_tx).
   *    When send_cancel() runs first on hdev->req_workqueue, it frees mesh_tx, and
   *    mesh_send_sync() immediately dereferences the freed mesh_tx. */

 net/bluetooth/mgmt.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac4864e56..fbf85e791 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2306,36 +2306,53 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_mesh_tx *mesh_tx = data;
-	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	struct mgmt_cp_mesh_send *send;
 	unsigned long mesh_send_interval;
 	u8 mgmt_err = mgmt_status(err);
 
-	/* Report any errors here, but don't report completion */
+	hci_dev_lock(hdev);
+	if (mesh_tx != mgmt_mesh_next(hdev, NULL)) {
+		hci_dev_unlock(hdev);
+		return;
+	}
 
+	/* Report any errors here, but don't report completion */
 	if (mgmt_err) {
 		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
 		/* Send Complete Error Code for handle */
 		mesh_send_complete(hdev, mesh_tx, false);
+		hci_dev_unlock(hdev);
 		return;
 	}
 
+	send = (void *)mesh_tx->param;
 	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
 	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
 			   mesh_send_interval);
+	hci_dev_unlock(hdev);
 }
 
 static int mesh_send_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_mesh_tx *mesh_tx = data;
-	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	struct mgmt_cp_mesh_send *send;
 	struct adv_info *adv, *next_instance;
 	u8 instance = hdev->le_num_of_adv_sets + 1;
 	u16 timeout, duration;
 	int err = 0;
 
-	if (hdev->le_num_of_adv_sets <= hdev->adv_instance_cnt)
+	hci_dev_lock(hdev);
+	if (mesh_tx != mgmt_mesh_next(hdev, NULL)) {
+		hci_dev_unlock(hdev);
+		return MGMT_STATUS_FAILED;
+	}
+
+	if (hdev->le_num_of_adv_sets <= hdev->adv_instance_cnt) {
+		hci_dev_unlock(hdev);
 		return MGMT_STATUS_BUSY;
+	}
 
+	send = (void *)mesh_tx->param;
 	timeout = 1000;
 	duration = send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval);
 	adv = hci_add_adv_instance(hdev, instance, 0,
@@ -2372,6 +2389,8 @@ static int mesh_send_sync(struct hci_dev *hdev, void *data)
 		instance = 0;
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (instance)
 		return hci_schedule_adv_instance_sync(hdev, instance, true);
 
@@ -2534,10 +2553,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				      MGMT_STATUS_FAILED);
 
-		if (mesh_tx) {
-			if (sending)
-				mgmt_mesh_remove(mesh_tx);
-		}
+		if (mesh_tx)
+			mgmt_mesh_remove(mesh_tx);
 	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
 
-- 
2.43.0
