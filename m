Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C992652A2
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455426; cv=none; b=aleEJ7kZIbbtKsqrKXhrY2OeMALnHobN3DBuZL9ZO0RZV28nvoqJYlUP9YI+sTcjJKcRv4qdSI6eQqLy9QvDGeWpyuX1gucTr1vIOJoqyrT1M9q1d6KPOuMxoNQ+pwHghd46ykjDuUlrZL0ch7QIudMAJSH66dxXHimiFujUI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455426; c=relaxed/simple;
	bh=qPw9JqY5Pm7eVUuN1AIjjw0mQBk5mclxUzCXHrmFd7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPF6voe2X/PXCC4NYRpD7WKyOFOdXTvLwsoTXMwPB704/VxixXn3I8LV0pOSxIBgq2W1/OIlfox2PRp3VrpiYIKAvo6O/qI5uTsYfc4M25qG8BfHRMyV+su7FqYZChdg96Fv8Kcica6OjJxN6FwnyAni14I/KPg+nttWjUWtqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8lq4UfF; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8lq4UfF"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-544ad727d19so51985e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757455423; x=1758060223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdzJnOK+i0bRwN5EfVKF9NbcwzRkp1zoDIj1YFhTtvE=;
        b=A8lq4UfFNnIgfbZLXXvfJiJ2BO/DRiDfV9XF5IylYt3BkFjCGGmWkCzRzOVfStJquF
         SNtkFzrtpZSuz4F3clocHK8zLit/MYsIYGLFXuLXoYbv+CwbULogu3IeZXfuRnomMsKk
         GY1vO3t7SMurrF3WhEfIYeXXicAVP9MhcOUZ/r82Nv31GAmu7Glo4RThPX7gsnM8dvdb
         FgW3zMhy6ryRB9Q8hwNWq9Uu2LFE64GsCeHV1Lh9UNsbHKOWClIM5fV5X8y+oShLv9+w
         T7EnyB+YbgJ0NyM24Bp6i6vt83vsNKs+b//FulRXjjapJcZXoitfx7/2lN7MvmDEyGlM
         5OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455423; x=1758060223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdzJnOK+i0bRwN5EfVKF9NbcwzRkp1zoDIj1YFhTtvE=;
        b=asGkQZOirFuVO2OWzh15yXAQpVRXKOvsrbfUYwUsFiHJ2mR6yCb93ySXcmG4Pf8UA+
         O7oZuAcXhktuiFmm/GwcJ2or7bHPcmNSHg8Oxu9YCPuH+3oI4y/GwXfkRH1z9TFMzx+P
         ciGuxh3Gh618AkHTaCLqmWnU3f++BkztFvyLPE56JpYmqCLyBJyiA/X9oKnkKYExO4Hv
         TrQSXUS6qrq06FyXb7sPmukmWwgJ7nByAKDVuJU4YLmUX0UVm3NCIVDlMBiK7UJn476V
         JtMz9szqkcJ/eHMwJobpdglG36CwypamxQJTm6RGVr8SKmZWA8MwsbTa38lL2/4MyH7o
         XIZw==
X-Gm-Message-State: AOJu0YwrvoflpSNTad9xf2n/1KRUl4UQPO1Jm9tyH4CoBDd1Ivt3bjMZ
	vrVStcVj1S2M2iOX88tilRO4Rs++SiB0eIh2FtUf8XuF7yqr4MIfzaRdwlVhFp2uibQ=
X-Gm-Gg: ASbGncsBDBlaCHWaR1/lxvFCSW6Q7nSm97rn1MHyKltcGuBouQSzyGoiSitWT/UsXK3
	cXiPSm+tOkcq5SYfylIUcJFfbJ5yfdQ8ZtudIIN1rJMD+SfMX6c8hDbMvQbSCSq0emOwxfn4vch
	sgezVy/d6dmXrQ01jFUsngqU4hFnqJE6tuHlXg/yhStFWXsuc8HWR+mRcbD/CICn0+RmkLtT53g
	xQL2T9KyfhgOWa6TMEHi0tDJSUdV6TpLtYf1mwqKkyFpnCm8QXTOIG+gb4/oLSEjOFrLrv/mDfd
	o9gJEjznh/45StYbzxQBcyaKbAup0K+GzIc9UhVjFfsF8fi1XEDZkA6LUn4QT1PsYiNIffO5KJ7
	MFr40o9qs38qSdD1nQM2Ht7SfHuYjjjE9Gd846k1cX4lpLYddnDvcPrDvEwiPVtfE1lZQ50ot0E
	jHX6/Ik/OEu/711BobOnOFXcUyRv9ekQ==
X-Google-Smtp-Source: AGHT+IHP50Whp8eE4NtcTFuDZ8fg/RuKGmlImQhrFJLqdEaHIwY123ybBecdU70ggbwcI/QPH+c98w==
X-Received: by 2002:a05:6122:2a55:b0:545:af6d:1edf with SMTP id 71dfb90a1353d-547a724360amr4100041e0c.5.1757455422669;
        Tue, 09 Sep 2025 15:03:42 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449bc6668esm13505416e0c.0.2025.09.09.15.03.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 15:03:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
Date: Tue,  9 Sep 2025 18:03:27 -0400
Message-ID: <20250909220327.1771815-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909220327.1771815-1-luiz.dentz@gmail.com>
References: <20250909220327.1771815-1-luiz.dentz@gmail.com>
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

