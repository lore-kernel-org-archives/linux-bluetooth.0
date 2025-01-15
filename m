Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F924816D;
	Wed, 15 Jan 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934703; cv=none; b=uc6IX0pIjS7bZ7q8ytt2OFKxBxtpcQEmk2qNn1+KA/8SyGc61dGNWyZHI4T/8bIuVoj7uTcf1J1sgkurVOHX7lncPgd126BMCP9sG+Lo1tbT2RkjVeomrmhuBdylFYCSydMVyILlOdYBcW8YY5hFDrl6jPLt2Cwq7fUFpx7I0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934703; c=relaxed/simple;
	bh=/Kci8b6ccPkR1AvWMWsNyfWW+qKRYOz/iHE84Uz3jqM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cPQEZDPoLIy60iF6hF63nKHHm5A/PduiSIXd43LyzdyqbqY9/Xf7Uu160x9iWHTFC7A0rSr5VJSbzWWvl0+Hv973GUJDmpFMqEjsrFeOWn8yEdVDmjFeoklRGYxGkvm6Sl9mx63nn6DLn9GpsHzAVJJ7snrOyfcpuOrak3Lh+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lvkUZYRA; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lvkUZYRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736934389; bh=kZidF7NJkdW9RkM+9Dowmltq/b18k7aH2CEdIXn8eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lvkUZYRAp+zHkeA/dn7mMsQlykOE5JhtTWNCv4OMlR6/CBPJnFbwIBmRzlQKZoDNA
	 gktQT4MRfnQQm+R48hygz9yuq13o3MqgB0bji5MELBFadRlHKBly5bMDAbad8IPoe7
	 7aDOwZXxSa/2qnBGu2HcXkXWSXxhV4+XBBd4xjYQ=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B9B28009; Wed, 15 Jan 2025 17:46:27 +0800
X-QQ-mid: xmsmtpt1736934387tg4pqrozv
Message-ID: <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aNKiZcSXV2vvny3eUVkxtpBtdSpi+Ofr9WU/qXCr+Na27pqQd1X
	 rR4hVLS6MtQ2zw4HB9nZBaC6YwsNOzm97xMNHKHVAjizyzSalfPXlQL1/O+kyft5P3+COAWMe6aA
	 kYXjUuk4Afo19Oa0ZtxiNVsqh5ZaCZGzCY3Cso6KcA9FRTEmH+nGQjqqYuY38om6TqocADs0DHNY
	 0/iS1josRyQ2HSY0iEzMPI0aYOmMbGPJIakNwuDUoUSl1LspFX0QBZoXmyQKnzNAjt5ZGvnAKFZZ
	 HSgvgqKTj38evf8hznPWB0nApNDjc+8OeUFdC21cx6+fSTafzg42agPF/jnHswpTw8g22inb3eXZ
	 PAP8BiGME7toCjTpejKlARPqyRtcXke1wixMMUM0nlZvIe3sZAKyPwGmE1Ykys6Xyaj0mPh/3Qm8
	 tcI88YUG4reVIctZrpJbKUkoHPGFveX9DertOY0Z7YyrrGuNUllmMqS5KVdg2b2qDncfi6EzbwdJ
	 LwdPu6iZP5Te01pdmASf5JAf+b155CXBy5vYEPBQlwPQ6EfRfUvtUSb41kXqt4ux1kKrwRGSgSRu
	 hpLRJX+jmwylqADZf7vUFAQ+a03aNB7sUPaC/KlDC4jsl3MSmCdys5QIvklptMaPXXoOAAQwJjiH
	 FRaoeIuI2r1oULzmZOqGg1NOtVH7N617RC4lD3mfkHXmqO3K8jtcT8W16KFtWKiQL3ybur+JtMjz
	 rxwD17jQ/OhKqL+Z0CMAvHs8E8jhNe4Qh2tTrUj7iKurqiofNCiax8EE5gguoVJvZE+uYe3AMjOo
	 jQeIzF89fTk6wA1ff8ZfR6Kx1w7/zuR3gWw2NPiNw+KoIL1Q9ptaKmywwfOG3PXnjmtI8E1XRROF
	 P5NEhwRxjOPTCFgNMWjRnN/XAUByMDH50iC537S6RQ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: hci_core: sync hci rx and cmd sync work
Date: Wed, 15 Jan 2025 17:46:27 +0800
X-OQ-MSGID: <20250115094626.3603288-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <677b9c97.050a0220.a40f5.0003.GAE@google.com>
References: <677b9c97.050a0220.a40f5.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a slab-use-after-free Read in l2cap_send_cmd. [1]

After the hci sync command releases l2cap_conn, the hci receive data work
queue references the released l2cap_conn when sending to the upper layer.
Add hci dev lock to the hci receive data work queue to synchronize the two.

[1]
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837

CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
 l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5837:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f9e19f9cb5a3..88c8aa37eb64 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3798,7 +3798,9 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
 		/* Send to upper protocol */
+		hci_dev_lock(hdev);
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_dev_unlock(hdev);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
-- 
2.47.0

