Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BF25A2DD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455118; cv=none; b=Mkhu6sBCydgkBr4VCo8rFA9dhTTL24wCb9CAFkkcSECrI2O8Uldas+Gn9jV4/kflGHzeGJLcHiHBh9Ei251OUJeDL7L32r/io8k710RguvclDK2n9vymddRlj45tQh5f8zPb1PVIezLKiiueYGMPSs47GICUU2FnISwWZJRCkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455118; c=relaxed/simple;
	bh=SsLI6k4GIgyThcGdbO4JB4ngVgoC30NGoKoB1vaWiME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=camNJVZQ1Pjw21K26WFleBecRg7ejWnEyvF9HmXxEr96Xp09SpLaFEAdI2jeo3c+C/gvQWoDNERQM7aabxTvHbDCECFdYQnbyeI5sd5XNrcJB/t+NKm/3jqWD8I560VSGRpJAmvF+Ko2BCHhdj2jr3mRI8190TMbZGezUJqrvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2EGC6zF; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2EGC6zF"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8b96673653cso791719241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Sep 2025 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757455115; x=1758059915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzJJxRVCFoEHxfxPSRrZGEDVBAGXZmS2z4SCApQbQDY=;
        b=T2EGC6zFxxwXE+jEf7TVtQpSUAQJ4PzBnOL4ZbK6+VhumhUTod76eXg7oSYMk2zEh8
         MXtoVvqlCSZyth5r7m44DyaUXjSHXAkCkPWOAzl2DauUZCI8/05Z7jK0260ynaANmX6p
         23N3dsHtZ3biwwEQSgMiRVsURplLfeCSoMLkIXmROF7n4b+T0lVVyYT/DwR8KRIjfPTU
         z7z3wF75bALqR8HYT930Rmjwqe/ygUCqY/srAFIKMb5lDzqBW95iNClUoOJgFrjvfQZQ
         AW+DTZaug0PM2WQUyd3FHmrPCAtl9Gu+k80UfOYIsj3ngKe/dA9Jf8EQgSRWkEvYersD
         dxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455115; x=1758059915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzJJxRVCFoEHxfxPSRrZGEDVBAGXZmS2z4SCApQbQDY=;
        b=QG0MoNl2B41a8iGOwgbG4IY9IK81vg6r3MG+JOjZ/UG2ELng4EEXKMDzw8X5/iyR5+
         3+e2ErKFeurJOKQVpRDgtwWwTca7rZxyIb579UjPABawq4v8q7dy4evFora5XJs5Q9s0
         u6sA5TsrpsVA9dGpyc8iFaHHTDXglCPkqfSv16/GSLhTRQDv33hF+cYYDOaD17n+lIVL
         lFcpp2+l5OlHzeudY8liOuDcIA3O/1Mg3Ke1bQzGcRG5Ov2uQJjYiENh/zXn4a3NBYio
         1jxCL/taEfw4oYmfMMRrXpW0rX4lRa3t7o52kAPAekdrZ6f7VeJ5HUwwql0hq9qWYYjS
         cacg==
X-Gm-Message-State: AOJu0Ywq2iOiqD0jI+KA1ja6vPPVkxHZk0CQ7iuuszV47pfruZ6z20B4
	sQOepaMiT2vRtaHxkVlNKbgojhH7K8Hd3hg5tVFchvfl8jtw4d+pRGsq7PzYCLlaFDc=
X-Gm-Gg: ASbGncvC8lDqOmNbmG7AM/lMIFYonjHZQSAewbnqrDeWqvnaI5+QPSu6VSD2XowZ/J5
	IqWdTG4vZAK9Iwm4jLDWJFZCx3znfrmgAqEXF3wHRHDAxfxUZcP2u3K/CWitufJXYr3r7jCGop9
	Z8fydfpf3nc6eI4Hc7BYfku4pqM79wHJccbbyWh5S+5EichinyYXgPSSxwzkaozdauG7QWgfsEr
	NIEno4FZ0gyeQToHfqTUvgwROZrbVGet8vDvA4dCHX0K5Y/jUChmvqsgoBVpKMfNY4uTj+Q2CpW
	MdhVPftAMfcANDZ3dN12vVafrrHdJmS7eyu2qVVsy5a2c8K+8n+YVl6k0JADYAYCyA5sKnlNYEi
	BptZtAF9GSQSYprOTSwekeI6LwboQg6gpVTbyXJjyzknDlJkdqdbyNdgp9Klw+xhg0/zTn5JWiF
	z4hDYw4iYPT0dR3XpZvkmiImtK/kszTw==
X-Google-Smtp-Source: AGHT+IEWPqVvbPc6O1Sv1YcTa47AX2+UWb/oc4WwOOri+fQT1HzXXRqe74KzoJ9ZHG+MpDpxfiJuQQ==
X-Received: by 2002:a05:6102:4421:b0:534:cfe0:f83e with SMTP id ada2fe7eead31-53d0b8fb8c4mr3656579137.3.1757455115201;
        Tue, 09 Sep 2025 14:58:35 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89607330273sm9215212241.18.2025.09.09.14.58.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:58:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: MGMT: Fix possible UAF on mgmt_add_adv_patterns_monitor_sync
Date: Tue,  9 Sep 2025 17:58:22 -0400
Message-ID: <20250909215824.1739006-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 989321b1ea27..165e8d8cff96 100644
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
@@ -5215,6 +5223,10 @@ static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_pending_cmd *cmd = data;
 	struct adv_monitor *monitor = cmd->user_data;
 
+	if (cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR, hdev) &&
+	    cmd != pending_find(MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI, hdev))
+		return -ECANCELED;
+
 	return hci_add_adv_monitor(hdev, monitor);
 }
 
-- 
2.51.0

