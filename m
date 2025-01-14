Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A431B2193
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876740; cv=none; b=gwnogINCLZdddzD9PyxBKyoarNOjoJdw59LWGeiW8ByqpmSBqwWkl1Y2EN21yhhbdWzWIWABrJIMwTqdGZjne2TUBz+r0liXICw0zAzWTFYw8VrI5irBqrBRk3zH0OX3W8UYX7XPN9qVLZ2wquOVIxDBfSMeZBdElNHSR01E4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876740; c=relaxed/simple;
	bh=8bxrxWUO3MZuBKqlc2ZvvbU60+k0yTCbDYE3Bcqm4HI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b6cTKclwdxvB1blS9CgduFvlg6CwWmXNJoQ7SpL43cGQeVWHnrzz0u4tn7OTeJoE+1nxZ1UJZE4rHCTY5DRrFLMYDLqdgbrN+Qa7MBp3Q0MLoA4C8WPGQJaLbzle54rpVObwZh24QnFqvnfyd/yqWfPGoiha5hT9J/CRnDJ1tMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AelvRnYl; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AelvRnYl"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso2878886241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 09:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736876737; x=1737481537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yBV3ETJzEzNarOvwpAkWAuXwisDfidU/UqhN4ucdkc=;
        b=AelvRnYllSacgmIUkMSjXVKsh89zq58ZFJC1rqI0r5TsclyskvRP157z0pyBUozbMX
         xeVw4JBQijLj0RH0/uFZEthZRSAQJC8UmVgXwlFpvq8OtbQOAQdbEoS4u/FQeJz3a+y+
         eTEPbPb2N0I4DkDCdPxzEJJDyxfzYbik8BTNGphigGoOk8zUm6KFuCACx/mBzcLSPk1s
         V3o03JGK+g3c0Qc/RfL+KGg62+K+tk/bR/vUfBrZL1m80XdOC2eETaznL7O2T36bSHsl
         HScYVIyaROgrz/ese2uPERZb4jG9P9rKM2223JQafKEAXRAQMB58xTwnrmk19YpUUXPE
         AnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736876737; x=1737481537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yBV3ETJzEzNarOvwpAkWAuXwisDfidU/UqhN4ucdkc=;
        b=gv4EhLhRbbQGoAPpozSQtF/Arg8eWZg1ppWbQAdBRS8SsARJ05YByRbjTwerwVLVKI
         dd9HAVpkj6nHTUGHOWn8kTD70DP6t3qeDSbvOBFuNgupPIW+Ir/iGEnS2tDeM1I8kJjk
         /hIU/x15pdYEXB//t+rhtqAoU5XdMej3glDqQFO2kkj1PXI1k27hpWxEYrg+ZmXI0dPQ
         UmhRVJ0B19lL3J1+annhPr+8+cB+9mndUEpoGSeoi+l3QUdCJsYAqo4rjJTXO+QzXHe2
         wW0OUxLFQ3aVmsJWa7v5E8MifBBXYpOzOLoVvrxw4oTnNJtO0V+liZkReoWIqZ5eMzys
         RMng==
X-Gm-Message-State: AOJu0Yxvsr0yzYKvw1m2i/P9xABjACsvcFkuH4Vkvo1aLUXa7m/xkCcp
	r2g6mwGnQIPSpyXRGEIV8izEdNz+E97qGksYThHMU47b8N/WJrKS+IVl1Q==
X-Gm-Gg: ASbGncvHJ/75kNPRYxVIUnj+XIKyILk+wZxNPyKAFv7SHauaq3+kDRzo+McNvQlhwvT
	MVanu4PdLMMeaPJzbCP5KOY6xMkONoU+dEO4d3pi52w0RFnt0lIOZrV0+Rf1H6MQARz0Ehqij3A
	h4Ojue2wNy/o1YTWk1nPb0HC/tOBxelA65B06CbvoOQbVOuhRsVYd1ecygtZ3dFvR9fnrTJOGct
	lkWrTzcfQ/qPv3t/IE14v3MizypLq/5wk/ujepP/253DEaQdazPo/uAsSN2SU6IM3lt/ISVNTX0
	vVHRssVtov5wa6eCGKKARl9a3bLx
X-Google-Smtp-Source: AGHT+IF+ItEjjwtqdhIyv9nE6ddirrFwUklIG98s9RGq1TGqzkc+D3IBpgQSMwMiIPfeWZzBiagXMA==
X-Received: by 2002:a05:6102:3582:b0:4b6:20a5:8a13 with SMTP id ada2fe7eead31-4b620a58cbdmr12987607137.13.1736876736949;
        Tue, 14 Jan 2025 09:45:36 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f44f53sm4819707137.8.2025.01.14.09.45.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:45:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync
Date: Tue, 14 Jan 2025 12:45:32 -0500
Message-ID: <20250114174532.3263274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mazin Al Haddad <mazin@getstate.dev>

This fixes the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
Read of size 8 at addr ffff88814128f898 by task kworker/u9:4/5961

CPU: 1 UID: 0 PID: 5961 Comm: kworker/u9:4 Not tainted 6.12.0-syzkaller-10684-gf1cd565ce577 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5543
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 16026:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5568
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16022:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9550
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
Tested-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazin@getstate.dev>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e46f3764440..09bac3c9c2d5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5388,10 +5388,16 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_remove_adv_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (status == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return;
 
 	hci_dev_lock(hdev);
 
+	cp = cmd->param;
+
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
@@ -5409,6 +5415,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
 	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
 	u16 handle = __le16_to_cpu(cp->monitor_handle);
 
-- 
2.47.1

