Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148971BCA0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944209; cv=none; b=pCDlKOHXxNuSL7cDYFt3UTSHQ/JC4DzzB9n5AJw1XIjc3s0OXnOsS0bErQLtRvxLY/rKBubekjY3v5PnZi8jVWsUqdtiUdtHJiiCv+cifHEThvyqOt+PqNODpomNyhesmP5x4u2awD8G+AEhR8ivyJSClqEJCLmzDXR7SF5SVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944209; c=relaxed/simple;
	bh=KOjcnLAstGvalK0Fobd+UQZ7ScA0oUwIupYUucImEDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HuSSTCIRFeVDMvE7C5ysIMKBNjras0ZQmp6DsAZMtm52C8xH/tNhteWgDfdTSS/oAnjUfJBpLG56qkiVRuizdoBteezFdxWWn/ghievpRFVUe1+US4itapYXMXHysiRy5RNiioTJIEibd0OnSPM/T6Egaz0nSK8VyGR4Smk6zRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxLQBc5I; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxLQBc5I"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e786167712so2044843b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731944206; x=1732549006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/e3eIyMeNape+bRUQa5dhH4WiZpLi13dggxUq1lZwMs=;
        b=KxLQBc5Iyo5sSwTfqOlICtnzCrTe1DHWmkvbmMSdIdt/Rry4BgflrrmTvAEGMDFu3j
         ieRr6SKdqROVz0oKhmEjNN2nGGEEzjsresosuGhJ+MGP5Qx4s3Ga0VB7csBhw+TiXcyG
         a5yIch5YBiy0b4JWGd6fcpntfuw3aHNgsmOI3K2zBnTsLjX/FGMsBGkO0GlCiTp7pHIX
         NfUIvjCzLuiEKrfF/iC7x+9y11NPCtHeX5pOqyq4na6swJkHqVew8Tl3v3JV/u5ipzUl
         Dd+Fc2wZskxGnNgcQHHGVkzkW2vaBMAi6EDCvTq9ofAx8hbka8tJ1W8S29x4F9nKi8Hd
         nv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944206; x=1732549006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e3eIyMeNape+bRUQa5dhH4WiZpLi13dggxUq1lZwMs=;
        b=Y24HB+rNFydPambVZEHRuGc4wGzjRi+uPP8l06lG8CVMNRo44kJI+6VlJJ1pGDtPNg
         xJdYp7FYBpMU4pECnjTZnbcxxh94nCeLFwdYKczd9zJn7KYqGDy6j+6wVEcHjytgdmh9
         /dCXrQndLX9xWWWXe6CqGH8QuJF4heJr3/SoFhKN4OsnBkgDMWdv7V8FbrjVftto1vBn
         aM6o3Jed1WJ4XqD7+dS+APF0a2wZTnqs32yAKvyHfJFYStRSagiFqx3JqW9wgunaChNz
         boln2xqzAV5vI0aAsiRXA47exODKw98PyLABBXm3rx7l+PF8ohIS9KDhAkQHjEs4MPQj
         BIFw==
X-Gm-Message-State: AOJu0YymVxbbMFTKnQ2E3VhphGhZqGlxBiyloItF4KW9TR9g6J7qsHER
	3Tdkf2+I4or6uo7WXOvbbTPy/gEIoP1ZJ6LDbt5tItAUHin0jQzOkb7EFA==
X-Google-Smtp-Source: AGHT+IGBLDmRXsqWDtVqfmIuNbFZMRsqWzOPf/dTUAklhpilMgTnk+jqP3GAHyJgzvSbnGHkygBZOA==
X-Received: by 2002:a05:6808:10d2:b0:3e6:60e9:5f8c with SMTP id 5614622812f47-3e7bc84bb19mr9957223b6e.36.1731944205828;
        Mon, 18 Nov 2024 07:36:45 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-514798259f4sm846880e0c.0.2024.11.18.07.36.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:36:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
Date: Mon, 18 Nov 2024 10:36:42 -0500
Message-ID: <20241118153642.2604036-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1f6d083682b8..3ec79c69b0ee 100644
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
 
@@ -1432,6 +1438,11 @@ static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
 
+	/* dequeue cmd_sync entries using cmd as data as that is about to be
+	 * removed/freed.
+	 */
+	hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
+
 	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
 
 	list_del(&cmd->list);
-- 
2.47.0

