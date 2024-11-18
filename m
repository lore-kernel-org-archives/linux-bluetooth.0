Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE1F5FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943989; cv=none; b=rY2x+0yL1XfmVRX/B4WrrhRkjVD/a6Z2WBSGD+JHZ73dEfEuYlV+RXoRw/reDDUexY39S0ppqng36p2yEXX3qrrJe0/pOD6XW6HQHndGBDWGh/dM6Upz7JNLFZMe86wS/rR7to4LcKNPIbLnsnHBDKPZK573zfSpY+VO0qBWd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943989; c=relaxed/simple;
	bh=WeWEyqPco65zNeCLaWdQnz6H98zOqpCIWHuPK7oz1KM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=scc+fV0DTXOch6oFKiF3C+5eskBu2RvNKlIJAAQGj/8C22GL3vGngoMBnBTrtPE0hk4YwPYyIbNLLmmLdsXqz5EhrH84TOmuQnv7oOQf7gKuBIJh8MMV9N2b22noL0bbpMmgCtgpV5kBWxuLIVBPZzF8K/TP6NYhFf6BONeYAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo/bOivE; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo/bOivE"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85700242ca1so636422241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943986; x=1732548786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKQv6O56HBAF6Jgwvmpw1mpzMKrszcW4k2nMZ00ze+A=;
        b=bo/bOivEeXC8djskhmiucmweXT9jSxS6lAq5Vv91X/cGmLEiVWM7Z+zhc6MGfI4h8S
         Rhvc6QMZvlWpiV6ZGWcqGEzcCziHMWRP+j7BH4h1TUKh0VSG7/WRUCkMktDZFhif4l/7
         d7Yv+g7Oo960vfWE5AjCJTbDircymcOLPE2V4U2U/fQN+6IYtu7eV0o6h/IzFbQuPzNH
         lLhEsVEPz2jZtX96HfDkR+rv3FoM/M+VMTELkZk2hYUiejl5MEs6OtND8j2Sb1PFvwm/
         tS8r57jxfXm+Ig9vMIwYEKuge4WWSc1/mt0mki00cpF7/rZ/MF9Bv6ob6l25UJfAHyWV
         KM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943986; x=1732548786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKQv6O56HBAF6Jgwvmpw1mpzMKrszcW4k2nMZ00ze+A=;
        b=uZmcCpi8vWJ3M/Iz2wobkUGj+qaleCxZsnFaQ3aj9CCO6Jl2vdVhsaxYPoZt7vuE1i
         a4pALphvZD3LQj0W36jl4UoZVFpjJTFZmhu0fmzg5ajha9xpavQlKMkcJNdA+Q08HcE+
         9PgKbZv6Xtc6ey8ODjZkkdJFfX5ubB/elQG+Qijdl2qHL+ExAyFg0KWgqMsInT6Uk3Sv
         oD35y7CRiFRMnvbO9AMnNIsqFs4SVCVQzYMduZ6ogDnKK+xLIF8xzjGC0Olu/Am05CWg
         jIbTYq95FCb9ESVs2uI0vQx0e0ZrjRx+kvJmRy/41Gi6QmIqbFD5sOYpRL7YovEIEknK
         5DDw==
X-Gm-Message-State: AOJu0YzZWjgyFMKubhAfbOsVShYchj7vREseSt2gd5QVhiZCpLJndTcc
	/QSKb6qllu7j6xxoSUEQNSlqReRymME8cQoV9ht5O6eURaFt5ICrYhMklw==
X-Google-Smtp-Source: AGHT+IE3fkDA5avEmLxDuwbSlwlLJQHR606LxJj9hvZIrqYkrQeM63vjCtlia7EQBkz8Zs+s6YhPrw==
X-Received: by 2002:a67:cb03:0:b0:4ad:6367:c7d8 with SMTP id ada2fe7eead31-4ad63680653mr8733766137.20.1731943985622;
        Mon, 18 Nov 2024 07:33:05 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ad648c61a2sm1077069137.25.2024.11.18.07.33.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:33:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
Date: Mon, 18 Nov 2024 10:33:01 -0500
Message-ID: <20241118153301.2603131-1-luiz.dentz@gmail.com>
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
index 1f6d083682b8..1fe72d1f96f8 100644
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
+		return;
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

