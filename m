Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C94C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHKRqi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjHKRqh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 13:46:37 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B68EA
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:46:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686ea67195dso1666730b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691775996; x=1692380796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TS+vNAgrMFxUVsQHGpaJcV4hLhpxD9x8bOpzgJjLapg=;
        b=muF01YgeUc+EX1DM9nSY+V0tAE8/lmnVx6BEY+T6538g0K/l3/4X4+DFq50gkkYtjf
         EGFCAMd54TohyyKZryhxetSCmiOE0WiYcbNET5ZVh8HkUintBtj3zkcGKeEbsE5D6odQ
         ZVDrNTWonC0jg4s0Pol3Gf1tl5hoZFj+aqaQ1riqfGDwwUxrj0HK4GBaSGuSGyt34qfS
         LiVdMqB/Xid7TkcT6ecxcAs+8ff/4Nr/7Xw0RANXzrgdychlRD2/Ai1fdd0AuylibN8q
         vK33knd+QXUV0WFMac+kg0pBp94MDuu3S4d1a/LferUtXMnEf7sF86mdEW0RhSc4jEeP
         H3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775996; x=1692380796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS+vNAgrMFxUVsQHGpaJcV4hLhpxD9x8bOpzgJjLapg=;
        b=HH2wjYtkkeFXo3vgHPAqu8M6410jb/2JL+6FZzjGabpQzn49aWcxtr4VsiBd4CARNB
         JjM/M5TL/A1AMvZ+wKCj3a1Zad42z5qSWz4r7TZdjzaP/Q/bpK3kgFcx+sU6AmRY7Dm4
         hKrMfpgLWFZ9iyKiDP9bAYY03UC9rcBYXtZ3SeDbBMKaHj7HFpP9IUXCY27Sxmc0XIwC
         KWyqcd//v1uWsjAnjzTg6HBgWUC4kmgt7Qq/Gd7ncGN4uV8rzLja1DdQOPsbPtCaHdYj
         OAngsnJFTJtspKRkOV0rJelxYO70+jMjPXQ7QYX166uDyYvLbd+SfD5jY8wAcu8zQupF
         +hYA==
X-Gm-Message-State: AOJu0YwyMVM/bJQXP4XB4756zj5au6WwENgbERnowsGEd5BKBVGJbc5V
        yCOaL0yDLJfe7yuWLzh3y3zw1O3h9W4=
X-Google-Smtp-Source: AGHT+IH1klOsiHzMj082afDmiRd1kCIuU23yvhRJTL85qWEfYGpZGgb/0bVs/RjLDOGzSuk5Zvi4hQ==
X-Received: by 2002:a05:6a21:32a9:b0:138:1c5b:2653 with SMTP id yt41-20020a056a2132a900b001381c5b2653mr2792589pzb.41.1691775995815;
        Fri, 11 Aug 2023 10:46:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id q3-20020a656a83000000b0054fa8539681sm3354253pgu.34.2023.08.11.10.46.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:46:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
Date:   Fri, 11 Aug 2023 10:46:33 -0700
Message-ID: <20230811174633.1818931-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use-after-free can occur in hci_disconnect_all_sync if a connection is
deleted by concurrent processing of a controller event.

To prevent this the code now tries to iterate over the list backwards
to ensure the links are cleanup before its parents, also it no longer
relies on a cursor, instead it always uses the last element since
hci_abort_conn_sync is guaranteed to call hci_conn_del.

UAF crash log:
==================================================================
BUG: KASAN: slab-use-after-free in hci_set_powered_sync
(net/bluetooth/hci_sync.c:5424) [bluetooth]
Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124

CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
6.5.0-rc1+ #10
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x90
 print_report+0xcf/0x670
 ? __virt_addr_valid+0xdd/0x160
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 kasan_report+0xa6/0xe0
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_cmd_sync_work+0x137/0x220 [bluetooth]
 process_one_work+0x526/0x9d0
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 worker_thread+0x92/0x630
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x196/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

Allocated by task 1782:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 __kasan_kmalloc+0x8f/0xa0
 hci_conn_add+0xa5/0xa80 [bluetooth]
 hci_bind_cis+0x881/0x9b0 [bluetooth]
 iso_connect_cis+0x121/0x520 [bluetooth]
 iso_sock_connect+0x3f6/0x790 [bluetooth]
 __sys_connect+0x109/0x130
 __x64_sys_connect+0x40/0x50
 do_syscall_64+0x60/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Freed by task 695:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2b/0x50
 __kasan_slab_free+0x10a/0x180
 __kmem_cache_free+0x14d/0x2e0
 device_release+0x5d/0xf0
 kobject_put+0xdf/0x270
 hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
 hci_event_packet+0x579/0x7e0 [bluetooth]
 hci_rx_work+0x287/0xaa0 [bluetooth]
 process_one_work+0x526/0x9d0
 worker_thread+0x92/0x630
 kthread+0x196/0x1e0
 ret_from_fork+0x2c/0x50
==================================================================

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5eb30ba21370..c2fa6690c84c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5389,7 +5389,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		hci_dev_unlock(hdev);
 		return 0;
 	default:
+		hci_dev_lock(hdev);
 		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+		hci_dev_unlock(hdev);
 		return 0;
 	}
 
@@ -5418,13 +5422,19 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct list_head *head = &hdev->conn_hash.list;
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
-		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
+	/* Use reverse order so links are cleanup before parents */
+	while (!list_empty(&hdev->conn_hash.list)) {
+		struct hci_conn *conn = list_last_entry(head, struct hci_conn,
+							list);
+
+		/* Disregard possible errors since hci_conn_del shall have been
+		 * called even in case of errors had occurred since it would
+		 * then cause hci_conn_failed to be called which calls
+		 * hci_conn_del internally.
+		 */
+		hci_abort_conn_sync(hdev, conn, reason);
 	}
 
 	return 0;
-- 
2.41.0

