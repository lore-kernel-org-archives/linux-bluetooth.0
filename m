Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16B264A76
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455421; cv=none; b=bUji3V6Ce/tlR/g+XVLMbn0A4llczODu6shfaSg3Uu4D5Pv9aWsDipTvdTWv0tB6z0UKVXf/jYLHezEK+CPphS2TZO5Q5UGLSHoz9DZeF7yNYAgIbu0hrSmEuPhRA9Sq1J7AygbebHAxD29LbNLG8j6c74onSezL3wRvlp2Ka90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455421; c=relaxed/simple;
	bh=j+lWpHl2hpFhbsDK4OP6e6q2nOs/w9X1ZKhW3A3evIc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=renxOEbe8vdav4Z6mCLmZ+3tI5BYslL34WsrEJ4Asm24ZREokyLUl3zwtwWGstQCtRJTsJM9IlF5m2jaI+RLBNSaP/2FCMXStElAmj4p13uXYj/Axgw+n3N45cqfQzOOG2nolUs9GJjZmyRn0oSfksFH02PCDyVB1S0/xsISXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM+VKWxH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM+VKWxH"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-545e265e2d0so4941184e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757455418; x=1758060218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ouwDdbCFiCxJrsk5dYlQPkelGc9F5atNrYeT6tRuX0=;
        b=aM+VKWxH85HCjJ0ZQGenTmLSPlw/QuFhxTJNNixiLf8Lj27Q8j10hSKFRM9Q120FnC
         vWFbMOUADuCeozpMxp0DmabQelAlxVFjGCSYZMuhozf9Xdzz2W3cyTq8kkqsIjp/7sh6
         uh4VICR4O4SaDXNgpIwkCANK5+UmoRrSH9KzjuXXK5DgdChcrjLI2DdEVLbYwDXJ5QQS
         8NCcWlOfTNiSrRmxXKXSyoRaPcgWtWrMETZ7VSzmktce41X+sRHyp9rI6x/hu0Vg/WbC
         v0ziDn+Awr0bgY1DTpPfUfZFj+TDtAAOQEbsCT5dUwVP+yqcdwOjx3E0CdPzT9P1+Bw9
         Qfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455418; x=1758060218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ouwDdbCFiCxJrsk5dYlQPkelGc9F5atNrYeT6tRuX0=;
        b=R47w6znHlU6M2wBCOvQ4fA1E/kKyC4f21RkMOKiQ+D+D4iy5n+kIuWwCsKgxVmwECl
         nTG/Jhd94MneVj58GSKpmrInjKwlMvck1dj5XSHKC+qH55ZqeNOsxe9Qh7/FSwkayFMS
         hsb3alKzhAwolkaNEKczK9l3cizyuQuJ0l0BI5jNS65T3yRQEwic143NlPnBpslvWra0
         xs4S0H7dsTjB7CxtFGSFHQ996W8d26gBd3FmlUMKzdOKhm8ET+Ui2uWZK8pk2NVx0Gj5
         zG+i7TiB69d+paKofGn32uosgqNLpjDxPo6TRC1wFHLEWxPPmvI8Qh3OtQCgMEVZVAIM
         ojwQ==
X-Gm-Message-State: AOJu0YyrBCdquGd1ILjjBAZiR+QW/J445imx3j2x5WbWCSTNoTIY8C7f
	zpao/3Uc994KKGw/TXMtH1oUHDlC2NPIH24aaEeVAC4rPLpylMAXPJ++EO4EstbAmc0=
X-Gm-Gg: ASbGnctvcKAn9XNvavHHLA0kFoqwA9aoEi9/FCKYAnXM2FdSAqGeILnogFUgtbW5NeU
	P+/ko9BksN5ceZxMeYysnZoKdJjeU3pIA300eriBvo8W8CL2RvHHY1yCm6x8Q0h/S5UCD8DPck9
	GFYbM+elyfbqNXXowQeGFwXjZ+Y9SdTymE14h7T6X4H4Jokw+9rWWWMLw4cTuDUJJQi/v0UqD5K
	n3/knFA3gIKdpwSGzcUcTfV0b9xdiZYyVXd1Xt0/tz3HRs+yYiVemUzXmGPRfUmDznZ13gS0l5f
	/QjA1V1uEZEBRc+3tPQmfpOS+P7C0ab5Uliifry2h2/dcTEscVCWUeZkws22uMTpJSOoUJRdZWJ
	9R1WHdlX8dcx4ty5btuaHXdghPX6REa2/a/ie0RLPuEGBdSrQOGQ9Lmp3ePVArcQvGsm0dITdj5
	xTZCTVCRVPVtVbk6ySfPa2Rt93Z+bC5V6X9N5il8mAIhWf7ZGtdI8=
X-Google-Smtp-Source: AGHT+IEJQ1Uw0UkYtcUGx0BqB0/bhUDL7Wo4I7iq3OfvdRkQ9eiDmK7deJi9yeoG6e4mPcZhkg5VvQ==
X-Received: by 2002:a05:6122:31a7:b0:545:da45:dae1 with SMTP id 71dfb90a1353d-5472afe8467mr4443949e0c.8.1757455418044;
        Tue, 09 Sep 2025 15:03:38 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449bc6668esm13505416e0c.0.2025.09.09.15.03.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 15:03:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: MGMT: Fix possible UAF on mgmt_add_adv_patterns_monitor_sync
Date: Tue,  9 Sep 2025 18:03:25 -0400
Message-ID: <20250909220327.1771815-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55

CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
 hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 home/kwqcheii/source/fuzzing/kernel/kasan/linux-6.16.4/arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12210:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4364
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0x65/0x1e0 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x35/0x140 net/bluetooth/mgmt_util.c:296
 __add_adv_patterns_monitor+0x130/0x200 net/bluetooth/mgmt.c:5247
 add_adv_patterns_monitor+0x214/0x360 net/bluetooth/mgmt.c:5364
 hci_mgmt_cmd+0x9c9/0xef0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0x6ca/0xef0 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 sock_write_iter+0x258/0x330 net/socket.c:1133
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12221:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4648 [inline]
 kfree+0x18e/0x440 mm/slub.c:4847
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x30d/0x380 net/bluetooth/mgmt_util.c:257
 __mgmt_power_off+0x169/0x350 net/bluetooth/mgmt.c:9444
 hci_dev_close_sync+0x754/0x1330 net/bluetooth/hci_sync.c:5290
 hci_dev_do_close net/bluetooth/hci_core.c:501 [inline]
 hci_dev_close+0x108/0x200 net/bluetooth/hci_core.c:526
 sock_do_ioctl+0xd9/0x300 net/socket.c:1192
 sock_ioctl+0x576/0x790 net/socket.c:1313
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Closes: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 989321b1ea27..d76aa3eda37f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5189,6 +5189,14 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct adv_monitor *monitor = cmd->user_data;
 
+	/* This is likely the result of hdev being closed and mgmt_index_removed
+	 * is attempting to clean up any pending command so
+	 * hci_adv_monitors_clear is about to be called which will take care of
+	 * freeing the adv_monitor instances.
+	 */
+	if (status == -ECANCELED)
+		return;
+
 	hci_dev_lock(hdev);
 
 	rp.monitor_handle = cpu_to_le16(monitor->handle);
@@ -5213,9 +5221,12 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct adv_monitor *monitor = cmd->user_data;
 
-	return hci_add_adv_monitor(hdev, monitor);
+	if (cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) &&
+	    cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev))
+		return -ECANCELED;
+
+	return hci_add_adv_monitor(hdev, cmd->user_data);
 }
 
 static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
-- 
2.51.0

