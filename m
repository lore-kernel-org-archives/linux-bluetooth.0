Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F13B297
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951633; cv=none; b=HnhcWSOuPrNzs7Sy3QM7K0ZJCAmjb7uldOUsHZyO+XQF9eRHa9fHOkJAmSbD9yNcJAyol0dx2UJ9tXCiPJk1slK9Q7Ww6tFygaS/BNeXbavD1PFYPZ3EOCsVelWF5B5m3gALf1ePoM0tuqdPt28FzoF/Z0nV0MgBf1U5yBLUJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951633; c=relaxed/simple;
	bh=bbPoY75MOf3xPZFym/n1iUxGGvHr+CaekZCKK5KUWJ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b8x/gwJc3igpElSplUBeEeRe8ZFVI7u7l06oDCfD7nGSUD6g43qvBjaEQg0K/ZJdpUY9nN7YrJchY+Nt8WcRtF0M9gdlCAufU82Pyv+n/TbCh08VySwbELJ2SRkvTuocxxZ2flNNZZKqJY5YtPbjila+8LxlmrWhJRYk0xY+D7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0ELzIEn; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0ELzIEn"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50de14e7d8cso1784306e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731951630; x=1732556430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhDmmcE3C0Z47W4RNQFzKr+QawTLWDtUrn3AyYzGSRs=;
        b=m0ELzIEnfC1bS0G5pg2ewX412LVtBADPBhEZTzG+jRqnoaIbm4vKiPmLEweu1o5rgj
         ypEpIITel3UhTMcRpJMNGJRitykVsf02S5tKKX/huS3YalJmTZrBYX9p7yykh5YSV2ZP
         notTMMWQDTS3r+4v02aVy8o/z6TJJDAawkYeWjleHBIkLWxrsITfbJcdB9vix0NeySBv
         T6wk/yzJyO3RulArP9H101Z7jrT779If9uRq6rJDX0sF/f5B7v2Yw70DxyiJPRWp/cZN
         KfSiBLquvrVqT1YzhvVjPPL3tHkzmefVynx6FUbhYXjWz+d/M3OAnV7h8qfOzCVhjY5p
         ESOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951630; x=1732556430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhDmmcE3C0Z47W4RNQFzKr+QawTLWDtUrn3AyYzGSRs=;
        b=EjeftajssxVW+KUrtY6uvfhTdpX3V58C8SU/AQDGeQgskS1akD9qo8qpE8+FvaqvrP
         9QOeDhRRRMxOObJeHw8Seirrj3cKPdN1hx1GI6RA5F3Oj4TAeztlsLtxwc8107bHx5FN
         C0ZithqqV2KMHWyJ1AYCyJ9EShpatlSwxD9RF7PBqoxh75dFho3rwcMYuYdsyMsrwKjf
         tvUVMFj0xlPLwSyQ8j0khE0vQZFNdwn9tGWKLFnoUMJRYhAWg/FWQuOuLJh41PPl+KDf
         J5o4SNmnA8AtgmYPMnW5Vq5Bi17EawE53puyLXnj2wcxiEjgK3LQ+5xdH/ZnXKYqUgYW
         dviQ==
X-Gm-Message-State: AOJu0YzI+94x89k/eLJF5rvArMG/f81vEyrOOtRzPu1rHZY81Jgl8/TR
	drQ505en3E/eLCC6Jw02KaC5udbJMf87dEnVGgEKUft6CDpbdAIBhnqXog==
X-Google-Smtp-Source: AGHT+IFvQDY39UPqY8daMKb0km7Qxlcp30BB1FuTqAG+BuX6V4vVKdvpAbKKlxIj0FKpy6bCKUlaIg==
X-Received: by 2002:a05:6122:65aa:b0:50d:56ee:b9d1 with SMTP id 71dfb90a1353d-514781ac345mr10895295e0c.12.1731951630060;
        Mon, 18 Nov 2024 09:40:30 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51479bff5basm846896e0c.36.2024.11.18.09.40.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:40:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
Date: Mon, 18 Nov 2024 12:40:26 -0500
Message-ID: <20241118174026.2627359-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1f6d083682b8..da3a1d6f95fc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1351,7 +1351,13 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
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

