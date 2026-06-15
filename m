Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB8400E10
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536197; cv=none; b=LqaLujyJMxEgFQ6NnyudhXa9GArz7HRbCm3LpcaCB/2mqteWDYlF5l2fR1XsQ5bYvM4vtoXuerPleMYZJsAR5UUyS/SAjGNy5C3+OU3DIyh7gOKHyM/BFQatx6VTy36vQgL20jM0TvHMi9M+2UqwoqBXjv1/VoUU2V5dKwFCTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536197; c=relaxed/simple;
	bh=I1aHIggciL+96mvzHXJprXMWMGaZAV5N+Cv9vZJwvJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwG3vhMdczDCFQ07slmOJraknigjbq1MfIVJ1o3VxIhGDw6XJ/BoWQEyLqPf6MAePSgcf1byu/vFsLaOSyUp/PGZ8oeRWXK3W4p4fsRrerioMhFeDR97+YeD9yxGfIbpuuhpgaYgAy6cbq5/ZYYB21rXjveO32AOUOgsAS8C2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=FHWLj8ih; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="FHWLj8ih"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so4409724e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1781536194; x=1782140994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIrF5pxuCjnAJoxb4czrrpSavkn7esm67b6oFTzhZxA=;
        b=FHWLj8ihporR9Czq90CI+DaF/arISq7/jThMw1lorsmMW4m4CYpM5d7rNMZ8msjmmQ
         gdqOJaU2vpU+44ZKGAq6TSEqTddMaV5pnhOjlZjsP/fRn/qa7b9oXX9/nhnI9ZCM98zL
         Lgl7bryR33aArrp6D5NAAM3/MjRFzhK4AA5suPBFnzTAQcYPzPd2cfJ//BCEnyzmnJZs
         Mitun6PJn7IwcIX4CvLaLolWLtGwY65gYWXwR4mgZWXPdeTvN2E6EBqX5uYmM5Rwn9dd
         iprfP/tnqySIxE7Tj4GHrY8640Bq7hcVnHSiSQQQy9qCzNpPOZTJVIO0TPyAlVVIpXRb
         vM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536194; x=1782140994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIrF5pxuCjnAJoxb4czrrpSavkn7esm67b6oFTzhZxA=;
        b=f8Tul5oYOnOY9q6thZ0PyeObD/o0rFzWEcW3H95T7ioEdlaxazoImaac70obspFoKL
         Gcjwiq8hU/DAFUpiWRSM66mXU6JWQy4obPsIOOMbJpM99TifInkfPU9EPYdDD0QtHrJh
         wVXYu7MUoEqiX4sJEWa+zpLAgPQWqQ6aVIHhGUHeGGsvqHZFhvYLYm3LmmRTYJWFAr8n
         EA1NApEKBfESDzvQRHrI01eWU8+5KtOzrEbVl3z/64pzTZquHqmLFpBdR09AWeOAztSW
         4Sk7Wl8KAf0NbcAzc545FO7nd3g2Qy8a33x2cVT1yhbPc+jdibyYG2UO4vUW7wp7vdJj
         WhHg==
X-Gm-Message-State: AOJu0Yw4pOQzRCUTwFHjvPmngxoYaQ8ZAHCvUMqic5cV1w1tp9athScX
	x4/y4BDOAe0u0Mrfd9RhNKJVa7qH3sPWSSWYjhosYgdZAIGTzYLUIY6WdWRX4POvY0bv
X-Gm-Gg: Acq92OEh0mW4mfYmk0HNftLvEdNsgl0TcfdsGbirD2rT2oL3tYWjX5I8vTSptp6OVpI
	Hp7eoX9faO0Cp2B8ytfLNQNMlcVJO1Qgom/CGPhr8BPFDaW2l00ZFxAlByvdAj3bKTLOVwWjGU2
	FFuz9cUofWgXaJBdMlwBfkV08Ut67e4/h9U1tdyJZHLbEelx0mR6G4r4wxlysqsn3CBI3F8Njlw
	ySNYqIv6SGJGpeet49BWzx4T915ZY+MF4BGRFqWtM0cmehqgNqYPjvFxPG7w7vjwtZVqLV1o0IN
	iAaBaD0bVIrLdhlls/ml8rs+QvlK99zwwA8zXMfbB+b4p3qm2Brv23HC5cR4k9D1e7VacdLGb1x
	OzRMPkim3RwUorTzZeEEEe/IX1HE99Bx75ixD6Zp2U4QVpTpPjmcGbS22ErPuI6aXiGdiONmN7G
	MJuZYW7ZH6fMI=
X-Received: by 2002:ac2:5693:0:b0:5aa:656f:d4f0 with SMTP id 2adb3069b0e04-5ad2db83f52mr4145533e87.41.1781536193202;
        Mon, 15 Jun 2026 08:09:53 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e170386sm2869601e87.30.2026.06.15.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:09:52 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Page <sam@bynar.io>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete
Date: Mon, 15 Jun 2026 16:09:22 +0100
Message-ID: <20260615150922.1737274-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_device_complete() runs from the hci_cmd_sync_work kworker, which
holds only hci_req_sync_lock and *not* hci_dev_lock.  It calls
hci_conn_params_lookup() and then dereferences the returned object
(params->flags) without taking hci_dev_lock:

	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
					le_addr_type(cp->addr.type));
	...
	device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
			     cp->addr.type, hdev->conn_flags,
			     params ? params->flags : 0);

hci_conn_params_lookup() walks hdev->le_conn_params and is documented to
require hdev->lock.  A concurrent MGMT_OP_REMOVE_DEVICE
(remove_device()), which does run under hci_dev_lock, can call
hci_conn_params_free() to list_del() and kfree() the very object the
lookup returned, so the subsequent params->flags read touches freed
memory [0].

Hold hci_dev_lock() across the hci_conn_params_lookup() and the read of
params->flags (and the matching event emission) so the lookup result
cannot be freed by a concurrent remove_device() before it is used,
honouring the locking contract of hci_conn_params_lookup().

[0]: (trailing page/memory-state dump trimmed)
BUG: KASAN: slab-use-after-free in add_device_complete+0x358/0x3d8 net/bluetooth/mgmt.c:7671
Read of size 1 at addr ffff000017ab26c1 by task kworker/u9:8/388

CPU: 1 UID: 0 PID: 388 Comm: kworker/u9:8 Not tainted 7.0.11 #20 PREEMPT
Hardware name: linux,dummy-virt (DT)
Workqueue: hci0 hci_cmd_sync_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xb4/0xd4 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x118/0x5d8 mm/kasan/report.c:482
 kasan_report+0xb0/0xf4 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 add_device_complete+0x358/0x3d8 net/bluetooth/mgmt.c:7671
 hci_cmd_sync_work+0x14c/0x240 net/bluetooth/hci_sync.c:334
 process_one_work+0x628/0xd38 kernel/workqueue.c:3289
 process_scheduled_works kernel/workqueue.c:3372 [inline]
 worker_thread+0x7a8/0xac0 kernel/workqueue.c:3453
 kthread+0x39c/0x444 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 3401:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xd4/0xd8 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x1b0/0x458 mm/slub.c:5385
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 hci_conn_params_add+0x10c/0x4b0 net/bluetooth/hci_core.c:2279
 hci_conn_params_set net/bluetooth/mgmt.c:5162 [inline]
 add_device+0x5b4/0xa54 net/bluetooth/mgmt.c:7755
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1721 [inline]
 hci_sock_sendmsg+0x10b4/0x1dd0 net/bluetooth/hci_sock.c:1841
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe0/0x128 net/socket.c:742
 sock_write_iter+0x250/0x390 net/socket.c:1195
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x66c/0xab0 fs/read_write.c:688
 ksys_write+0x1fc/0x24c fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __arm64_sys_write+0x70/0xa4 fs/read_write.c:748
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151
 el0_svc+0x38/0xac arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 3740:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_free_info+0x4c/0x74 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x88/0xb8 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6170 [inline]
 kfree+0x14c/0x458 mm/slub.c:6488
 hci_conn_params_free+0x288/0x484 net/bluetooth/hci_core.c:2312
 remove_device+0x4b0/0x968 net/bluetooth/mgmt.c:7919
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1721 [inline]
 hci_sock_sendmsg+0x10b4/0x1dd0 net/bluetooth/hci_sock.c:1841
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe0/0x128 net/socket.c:742
 sock_write_iter+0x250/0x390 net/socket.c:1195
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x66c/0xab0 fs/read_write.c:688
 ksys_write+0x1fc/0x24c fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __arm64_sys_write+0x70/0xa4 fs/read_write.c:748
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151
 el0_svc+0x38/0xac arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Fixes: 1e2e3044c1bc ("Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd0893..dc55763f9e58 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7658,6 +7658,8 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 	if (!err) {
 		struct hci_conn_params *params;
 
+		hci_dev_lock(hdev);
+
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 
@@ -7666,6 +7668,7 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
 				     cp->addr.type, hdev->conn_flags,
 				     params ? params->flags : 0);
+		hci_dev_unlock(hdev);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,

base-commit: f70f7f2512c6b9113dc78f6a25361166afd1412e
-- 
2.54.0

