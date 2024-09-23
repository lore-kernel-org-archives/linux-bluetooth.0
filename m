Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCFDF60
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110281; cv=none; b=D0XYPrmhTpQb8GZwftVtlKiBEdlwEp+tjdUCEGPbzLPG4YTX+HiaRqCWuo7vcNpEo04IIO36eWQIdihzw8Gvacu+93xUvXXbafGAKMpggkjn75DGIM1Jy+QS1QWICmr+EK7Wi92LFGxjqY4f4KkmH0PGVZBruizM7ka5NFFiebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110281; c=relaxed/simple;
	bh=/+8ACLxm/zNO6dfAHiBYcuTQOUp9sBKibfpO7GBCkdY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gI4JTyGSy7gSAuVf3dxwTBNtybvztAy/HjK3xAK07AzVcjqOKvS3n6/AHqQkuCreNdjfsJR91BWWqoDEGrSVrTBNJksHl+Cr96WxAzKls9gbDLEQMb15Y1WoOkn4VwPgYF1Su1dHgk8kvrkFp2TV8cb3QC+MfmDqqwfthUulQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVleAvXt; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVleAvXt"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-502b8d7033cso1235610e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727110278; x=1727715078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtxT2s83lenSrm+yto2Zhre5lxb6aEADnyuAGZEeSvw=;
        b=EVleAvXtaYvOVx7j9Vy5oxdgn3t36PsWzQ+4WOZL5nRHdX+Wyc0Z8kw8Dz8pNwSE05
         fVxFezNPU96K2F/86/JdErAyweuiSFGIeWxzonN2g8Nl67wNePQKQlrV8UyQujlRLXAR
         iTUiprjwyzitbdkAVmZXkft4FHrwjVkIS/+aoqfTPimOyTjxAoJVSazqwcSLdZnJOehK
         u/QLgawXNVIMKncBTK+mUVoQX35Dsjhi9wERdJN6CmEbtwwVniDGh6u4t+3qMtle0wCq
         myxOYu0mUGNo8A/CaIhuACtzF5fWlA/Hwem4J9NEPg9AbIn5XpsplXiEFSStyKvvEgAs
         r63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110278; x=1727715078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtxT2s83lenSrm+yto2Zhre5lxb6aEADnyuAGZEeSvw=;
        b=bEL2AU2TAQzwpZklJRnvwUAUllnx2rUYyXBOzg47f6WmnUgDIgKMEauZVvS0YqFFb7
         57oLAKudacbbS+9asZcVCCNDque+mr9yLuuBQhrVIL81M5nHh3TXfaoV7dT0u3VSq9a9
         h6TtkUWlN+ysB17D1l2ad6Mxfsl5OAY2CXxdaOSJXtfxPlAxFupkdPtjsSrXWGF/Z/C4
         yyLvhekL4sOpcJQ4fMfooofZwzXfpXOHmb09UAgHm1S/fcB9dpk/kK6xa29IzGZ3beHy
         EnOfR0jqFUZrbOg9t1jCAm5pWdArS48/OcVf0dGNNkMFBU8mkXPFGjtVFaOyUhBOeMNa
         rygA==
X-Gm-Message-State: AOJu0Yzxkskg1T+V3XB05yQDhrM9OGQhNhfB1+dVqAEu4h2EwIB5B/YJ
	ZhLtWXqm6yBNOGv9lHxBoGbND3PHtZVJN/4XVI0vzPrqxLuSn9xQgQjhrA==
X-Google-Smtp-Source: AGHT+IFMrfOkOyBaoJM7fK/a4Ga6JhVel8+s9cgaMXoNaFE7y6MpspTCgQk15b+VOrNetRpC/4swTQ==
X-Received: by 2002:a05:6122:3197:b0:4fe:bce9:8f4f with SMTP id 71dfb90a1353d-503e41a8025mr6846814e0c.9.1727110278200;
        Mon, 23 Sep 2024 09:51:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035b95a775sm3101409e0c.18.2024.09.23.09.51.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:51:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth/L2CAP: Fix uaf in l2cap_connect
Date: Mon, 23 Sep 2024 12:51:16 -0400
Message-ID: <20240923165116.1540227-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

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

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
Fixes: 7b064edae38d ("Bluetooth: Fix authentication if acl data comes before remote feature evt")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c   | 2 ++
 net/bluetooth/hci_event.c  | 2 +-
 net/bluetooth/l2cap_core.c | 8 --------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..b2f8f9c5b610 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..b87c0f1dab9e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3706,7 +3706,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..6544c1ed7143 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;
 }
-- 
2.46.0

