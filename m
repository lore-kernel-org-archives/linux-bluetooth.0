Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7B1BD9E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962025; cv=none; b=A9sBi8ti1udRoHtL00jRA75y5iREfwYUzMU851n0sb7d+yeRRj6BSs/G1q/4uRND9UA+LkOhos9XwgLoR5UGzgJ1sQrL7j8I4yV4aY0lmpec2YY1eyspLFyttx2HVId941D9R0gc6Vc7KANnMiJrBVm+s9+cAKAco4O0wAgEIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962025; c=relaxed/simple;
	bh=Nclxww93sv4xFhg0KpuqYWi9tFKVir3LJJQ46+W+qPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PuPgfsZ25kGJRJb70BOSv8zPq9VlI3czMtNLoMFgFzeo3IU5orGxOY6Rfuf0MEjRGKl6roPBRilfZHBrwii1UuXa94P1KU7jNFc7Mw5C1FISKZQYL3DiKPXVzyzyEgyu6df5wGySycjfJ7OY8QzqDTdFCC6x/dBIaaxIkw5IfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCEnSEtb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCEnSEtb"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d3998923dso1125687e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 12:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731962022; x=1732566822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SucZE0mAFW8qXwArWMtXvCfPN6jLPP+wPIz6maDQKH4=;
        b=HCEnSEtbjPvpqxxy63CZiPJ7o/PQT0i5XqIyfqvtz9BK3TSb8bsT6CI36clI5GieCD
         ksx65E5UbNK0mas73wJdKw3tv8b1+Wfgn18NjkOCXEG30Wf6dC1TYyu7oRVef6k3sI+1
         3arxXqwv3tVNLrfV4a4e/uC6gE57w0/wxVSohOYPE804y6YJCETLnQx2nxcj27oPjISy
         zspZoB+SPRry7zYiFV+yNgRGgBNIMMRNAnMQNwshoYBO78FQMr43wc1GqYo8P1kYgZrk
         qFC9eX1x617uNUSoRgK9mUQWUF1r73r281n25tXE8GcRQs4X9qdCyV3yc5PDkv1tBg8a
         XmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962022; x=1732566822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SucZE0mAFW8qXwArWMtXvCfPN6jLPP+wPIz6maDQKH4=;
        b=FJrjVMoMQzVKIZ1fP/7j9hyYe/SBj1LqyBFPagKgbq5+/Pv5FG6It/VPsHtfSLkYzi
         usoTyO16CKHQfdO26KU4DDRQOMDHDMSNVyV1bJJES/7GQKoIoqvlX01TSAbanNOgFpPb
         bcddodAkXMc5ohuV3oPd2UItGAB5zLmrWAfOxJqkbmOMQ2EebIn3rsiiCRwU5ZNEuGhp
         Ps5boYDAuTUsCClCg1YY9PHUJJXyorWRtBZFj36Ktr8IKj/4/G9YGy20YE4jyZ5nK0++
         AxmirRtO0enwmA3Il7kl5rz1x4cGp3IdGhdvNVO5lLjp7yN3z66QXaq8fNV8qfM+8R24
         EA9A==
X-Gm-Message-State: AOJu0YyyN0iFg/BVrdWvGF5aYg4m+TiWxs5gqweoYV5Z+AjWpFqBWwD4
	j8ukUpDEOfmIlyRyk8LbsCUDQnKRCcKbwhZYsNrxUPffxYs5USvg1MFI9Q==
X-Google-Smtp-Source: AGHT+IEC/Gw1jahNbgMNgLhd7et4UzFiKi4ATcc91W2P56827kWE3krZwm3LRS+cModJb/8Iv3hiOg==
X-Received: by 2002:a05:6122:1d92:b0:50c:99da:4f70 with SMTP id 71dfb90a1353d-51477e7dbb8mr11812450e0c.2.1731962021654;
        Mon, 18 Nov 2024 12:33:41 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51479bff5a3sm901218e0c.34.2024.11.18.12.33.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:33:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
Date: Mon, 18 Nov 2024 15:33:37 -0500
Message-ID: <20241118203337.2648476-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
Read of size 8 at addr ffff888029b4dd18 by task kworker/u9:0/54

CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-01155-gf723224742fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
q kasan_report+0x143/0x180 mm/kasan/report.c:601
 set_powered_sync+0x3a/0xc0 net/bluetooth/mgmt.c:1353
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5247:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 set_powered+0x3cd/0x5e0 net/bluetooth/mgmt.c:1394
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5246:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x149/0x360 mm/slub.c:4598
 settings_rsp+0x2bc/0x390 net/bluetooth/mgmt.c:1443
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x112/0x420 net/bluetooth/mgmt.c:9455
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83gv
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1f6d083682b8..e406eb8e4327 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1318,7 +1318,8 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_mode *cp;
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
 		return;
 
 	cp = cmd->param;
@@ -1351,7 +1352,13 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 static int set_powered_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
+	struct mgmt_mode *cp;
+
+	/* Make sure cmd still outstanding. */
+	if (cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+		return -ECANCELED;
+
+	cp = cmd->param;
 
 	BT_DBG("%s", hdev->name);
 
-- 
2.47.0

