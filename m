Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B2EEBA;
	Sun,  8 Sep 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725780829; cv=none; b=nnMhAPLx8e+ztne32/kBZCD51v/FCQs5ZKdqmyseiu56vIOd9UghlKCR6iEutSb4Zajn/4Z9UV2IboyFQKon+Ls4Ir9gfneluuAEDW8uYzSQSPIJGde1w9eE/UtCnGutBuh3Q8WBGQv7xRRr4HaJ5hmdEPtHkpieoiwaBu6Ysxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725780829; c=relaxed/simple;
	bh=MdCbPhkHQri7YyqGTEUeldKccHGyJUHHhvbe9ptI37U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mDXde3r12nUiMCgAbOdeosWgQPBYERGXsRoWXrEpgqT8uhQIW0EdzJkvHBGKxQqATFUczagdVe4gwXpnGe2wbLvRG9i2FxjeJy4PGSp1dJIUxpri8cGEs5HS+zRcDGi13eYJlMW5JaLfqBYS352Jqszl5/tiO6QgQI94+DUG5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JX4fFx5O; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JX4fFx5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725780521; bh=s2IsHzadGpUSVyQWE1lsGbPHUEG59JWzy4uq573kJgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JX4fFx5OJ6YV9H7seEy17mpft3Nz4EX0XT0oWi+dH1lV/X52BmAKLz0UEX2rSB/mQ
	 SuTlFqaj8tPpkFh0vj575ndUoAnLwXnXqH0hhYDwlSlztBRlIqEXDqy2pBaWJllXSB
	 BIxx4v5VtAFWIGlsJyW9Mz0vpa6Fk3GbyU/v+XQQ=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 59C2B62B; Sun, 08 Sep 2024 15:22:28 +0800
X-QQ-mid: xmsmtpt1725780148tbozqj8kv
Message-ID: <tencent_7697B4E9DEEC52CEB478626D182DE96CB00A@qq.com>
X-QQ-XMAILINFO: MWL596E7+0fRWqY1j/Y/rWEZfvB79KncHGNLAR9GHZ/93mZ0U4zTzPHz5TGS1m
	 TZKGVPoGBcMMv6DlmH1Y6j7qu+lcbf/lc6WVQI3lSY592oXcCqBxsMCNRHP+JaFzwHl+2ghzmS4G
	 r7LUbrioylACK++682q6BRY2aRTRwgQ8zpt2zVSnG+czQbLT/ksFFjXsepQQITDiEAhBN7z/dPbe
	 3w5I08xO67AXJ0aDpy24xni80S0LxlcnP1bTS5gNvNU+PAtwtyIjC7GCQFZ5udzzX1skELcO7GUx
	 Y+H6kA0r//H8/KBKm7alISdwbcK+jtNqsl/wgID/ttM+DInMCA+j1YxztmcYLqkO1ePQtNMYSUbW
	 441A/ZSH6dO/b61NsgwqHMCd0MwqPmSLT0P9hDfBOBxmdmBbN1FOu3+NSfiCIwqx2fFa0OUcRHIZ
	 PMVQQueVk389Rn53bRU/cA5+Tp1r+EQqdARbgZO/H0/ypFPTMfnjy9i1QnRW/qj02GUZqQa+V/LA
	 s3Oev6Oe6E5XLhiY/jt2d0rhPBvhxN+8a87AoO3jCilXVqWEeZbE42Fz8EblSdInQeOkxFqxAd1A
	 QHaGA9X0+0t4JHBLinp7bzrj1ieBstY4UjWbo16R1lerKErZ15jAt1+HdAVdvCZxV0o8HJHFmuhH
	 c84PguL8e3g2l/z/cc+YNMqTM9gNvKh1w/RSilRgUYTWA9AaVHMGqoYTN2ItU20h2kRLsFeuzQ0w
	 vQ+PRORrrdz+v8bZ5sJbaeqIRLy/4tl4jcL4jvojmVmXMDfypTg6X8Zv9wE83LxJnjsGkiYDnqsJ
	 BACzxZSn59v6ynlbdukZOtnwGYm0BJpc7Z0kSswaIKunlj1a4Qr6GFeRR2Az8rfmqY45n/Fd/6c6
	 XAZIxBxtymp7GPZ8lUoKH1D59fSIwIdjjz2BGVM6ned+mY81uE93I/dZ9OPhaPfw1yfPZC/aM3z/
	 QGmrqQKNw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
Date: Sun,  8 Sep 2024 15:22:28 +0800
X-OQ-MSGID: <20240908072227.1551072-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: <0000000000004a130a0621888811@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
...

Freed by task 5245:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

[Analysis] 
There was a data race when accessing conn in hci_rx_work and hci_cmd_sync_work.
This is because the hci dev lock was prematurely exited when executing
hci_acldata_macket() in hci_rx_work, which resulted in it being released
by hci_cmd_sync_work when accessing conn outside the lock.

Reported-and-tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_core.c   | 3 ++-
 net/bluetooth/l2cap_core.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f25a21f532aa..4f7b45bb863f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3776,18 +3776,19 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
 
 	if (conn) {
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_dev_unlock(hdev);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
 	}
+	hci_dev_unlock(hdev);
 
 	kfree_skb(skb);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..b948b0a3b2f2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4072,10 +4072,8 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;
-- 
2.43.0

