Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727C30BF5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941024; cv=none; b=pBmJ/KHEU0qIbmDgsNHd2ZI1hlBlKCY9PTPV8qTrm6n6r+ESNtbENydYqvqrVpz6HufWkP5CRyw92Y56IdOvDAVfO0QoRWO91jvNWpCQfMsymu+CE0WcojzjAp0eCrImT7baLRmNXHBBWakIzXxSIGQmvSv/iFtk2/Jc/BKcBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941024; c=relaxed/simple;
	bh=qPw9JqY5Pm7eVUuN1AIjjw0mQBk5mclxUzCXHrmFd7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNay4G2TdNtrbb1giG15VOyPR8/RxrDqg7TnsNx9KCQykjh/j8VZ82lYkSKSzb0+o+0z2Nx6Cxbq4LMGkClGXmXvhUPKVMX2qlpd0bWZwpARLpJ9cK+r+q6gsF5QS2zX69V25lyn5hgM02tG5yz2Bmx/FCt7guDIgYExr5PHiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAyn4Ant; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAyn4Ant"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-53042807be7so2892587137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941019; x=1758545819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdzJnOK+i0bRwN5EfVKF9NbcwzRkp1zoDIj1YFhTtvE=;
        b=FAyn4AntZaiplsO82pWYIeL/CK1MmObRj50Lh1mnCrOrQJOk68C2zeMO0eKgLUnkyK
         x0D61po8KudnyHMef6aOOQ7ZuD1mjbNzkf5pJnpqtGKIjG6fCX1QjnWziXAZ32v2b5V5
         z9ceavMUHN7BrBqfVEqibcuSWuKhY7MKtRIrTWZu37tPCo72vcDa8mJPzMmTABdrveKc
         WuCO8f13NgzjbwyK2gNTfoeS/sRa5GyTtZuR78Cy83KCk1j4jbwhaKpuHRRQ4ZOPvGuT
         0eEPjZWCzaHhxB0tkyYFbaXSz3PLFHAwgVPjhe0Kn7jfaQD58BpsssBJZ9UFsBld4c1y
         CfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941019; x=1758545819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdzJnOK+i0bRwN5EfVKF9NbcwzRkp1zoDIj1YFhTtvE=;
        b=mhbEdEi923BMmXi8WOUFZyzrEugThYEUhADrvNsfmOcJATn02ZGCLUgQfN08yj/DA0
         CkIH7cy5AjpqEoJNNhKmX+GQbdM5FOpKC9UaQVXOCk0W/QFyr4+5oVNh9Oy2xEIImAe7
         hnkRIsQuZvrwcZTKuOTHrhMFt9yLk6aGwqibRgK14JHZgCHofyNzajJEYctGn8Mpx0vq
         vPfnK86MonYHeAi5SdnHoO9Wa2rd9EsRK9QdcjF4oS76t4aFt3p3+n6Z23cK+eAEcjW7
         1Myn/dmCsrRbg9Nb69Pht+SsnKocZ0YEexJXPudiWJ3eGHGyOE0x+iDAt0WAO9/COWml
         873A==
X-Gm-Message-State: AOJu0YyWxnmiQsiuztmuWFiukSVHhdl4IlFdJGo+pi7TwiYSP8wiNGCZ
	38G349jaoiMqQtUhyKdGwq1YFX1jXPVRbjV1nYm6roLSXSEg3QnGEErnwBOL6w==
X-Gm-Gg: ASbGnctMMgvfUGzGLoLX/xwHmAT49RfMPXNyllWW0+qKoXha2pMNt+uG0StVYn3GR5L
	UgrHsQzxCWtDDfss1BMav1tB+2eUM4DPnUyclZ+Nwbadexqc4FVwVRyab+yEyc6Qf6Y1ShaRt8B
	QrPvnytSkxpumb2ss3x0h5UvwwwWZ1hDxSzDGL8KZ7DykEm012YTo7zu/z6ArJHgRLbCNQbQ0Gm
	nGWV1g0xJq81u9GP5nMURE8JzxeK8xAP64WglFx+ma79OEjKnQgcZUR9NKKoivXS90/cGjHSQ/o
	Ja0ior68ifZNm13VRoFLigE/W3oEsmb89Ceyo//arUVZEMPCBjfB7+Vcf8zkwO1T5cGIrI9cxVc
	msTMAev5vK9sHXTa9eEIG37HRewHozWPyDUPv2HJv39wtZzhcD9DFc98kaeQeas5iNtGaxLEJ42
	uRBgBUGUDKbkk=
X-Google-Smtp-Source: AGHT+IH8lAK3j7e6DG1IzSr/WtJNvRczlstQ4FPj5zvgYDjMSDBfMNW1SKTGGcUV/lce6HHLKWhuZQ==
X-Received: by 2002:a05:6102:800a:b0:534:1aae:2d7b with SMTP id ada2fe7eead31-5561129857fmr3951367137.24.1757941019268;
        Mon, 15 Sep 2025 05:56:59 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-555bd4fe0a4sm2490260137.8.2025.09.15.05.56.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:56:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/3] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
Date: Mon, 15 Sep 2025 08:56:43 -0400
Message-ID: <20250915125644.664438-2-luiz.dentz@gmail.com>
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

This fixes the following UFA in hci_acl_create_conn_sync where a
connection still pending is command submission (conn->state == BT_OPEN)
maybe freed, also since this also can happen with the likes of
hci_le_create_conn_sync fix it as well:

BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x5ef/0x790 net/bluetooth/hci_sync.c:6861
Write of size 2 at addr ffff88805ffcc038 by task kworker/u11:2/9541

CPU: 1 UID: 0 PID: 9541 Comm: kworker/u11:2 Not tainted 6.16.0-rc7 #3 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: hci3 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 hci_acl_create_conn_sync+0x5ef/0x790 net/bluetooth/hci_sync.c:6861
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 123736:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __hci_conn_add+0x233/0x1b30 net/bluetooth/hci_conn.c:939
 hci_conn_add_unset net/bluetooth/hci_conn.c:1051 [inline]
 hci_connect_acl+0x16c/0x4e0 net/bluetooth/hci_conn.c:1634
 pair_device+0x418/0xa70 net/bluetooth/mgmt.c:3556
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 sock_write_iter+0x258/0x330 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 103680:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 device_release+0x9c/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x8ff/0xcb0 net/bluetooth/hci_conn.c:1173
 hci_conn_complete_evt+0x3c7/0x1040 net/bluetooth/hci_event.c:3199
 hci_event_func net/bluetooth/hci_event.c:7477 [inline]
 hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xbd9/0xfe0 kernel/workqueue.c:2345
 queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2561
 pairing_complete+0x1e7/0x2b0 net/bluetooth/mgmt.c:3451
 pairing_complete_cb+0x1ac/0x230 net/bluetooth/mgmt.c:3487
 hci_connect_cfm include/net/bluetooth/hci_core.h:2064 [inline]
 hci_conn_failed+0x24d/0x310 net/bluetooth/hci_conn.c:1275
 hci_conn_complete_evt+0x3c7/0x1040 net/bluetooth/hci_event.c:3199
 hci_event_func net/bluetooth/hci_event.c:7477 [inline]
 hci_event_packet+0x7e0/0x1200 net/bluetooth/hci_event.c:7531
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4070
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16-rc7/arch/x86/entry/entry_64.S:245

Fixes: aef2aa4fa98e ("Bluetooth: hci_event: Fix creating hci_conn object on error status")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 21 +++++++++++++++++++++
 net/bluetooth/hci_event.c        | 26 +++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 66523b74f828..2924c2bf2a98 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1246,6 +1246,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
+							 __u8 type, __u8 role,
+							 bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->role == role && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 						       bdaddr_t *ba,
 						       __u8 ba_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abb17dadf03c..d790b0d4eb9a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3087,8 +3087,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then it must be receiver/slave role.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn) {
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
@@ -5628,8 +5638,18 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-	if (!conn) {
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then use the role to create a new object.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
+	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
-- 
2.51.0

