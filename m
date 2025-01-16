Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE41DDC12
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041804; cv=none; b=hSt8ToSc6osLrOcQHG/Y1vlRJU8opUHn42k+yqU+/9RKsBlQGcaq1VZ99Ok/s5n2+Ir3dXqdzHy+PTgCwClhru09NEySr+7XnOlHreoHpPWf056/nHTcAvAMkx5IPLOeu+8RgliVZDXDIUJbgw2YnBCZ77qiOSurs1J/kxQ03W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041804; c=relaxed/simple;
	bh=sycmZWuQhvgF3V0f11ScUky9K8uCZNKJ8YqqoUJLySY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ACsm+XnAEMPGT/Twx4WtUPpEQNaC2YgtJAMjXEMjUO5nBbQQY7d0W94H+crojzjcYLg5P96CfEosC9pc4V4sGMYX5PuzBTL2NGPl5ZrSUteMPttNF3c5YShd1FRDksOheyYHD+Wgu5DF0NXAaGmkdVprsF28FNigWQB0kQAzN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbbqhznu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbbqhznu"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be49f6b331so85765685a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737041800; x=1737646600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=720AkD/zgKeEhOjbcT3M7hGdPsm1hsXkqO75utWqaAg=;
        b=PbbqhznuSxTDzTrmmwIHmcgtlBHmZRsACh+HGH9oIzww70OPDunHZsMKCGF+Oc9JMl
         tSzXHtCoOjwK90cNkxKroO3mYg/0j1Rx7MoV1W1KaRR/5rRO0cAAe1iGXLZXfxzGlj7/
         QwDDDrYviDS9mi/lmWHWA9E9yHtkS+ntoRXTHqPqbG+NXYdi+wA4apkv7avWe+wYEFb5
         KZ7bByV3r9OS9oEpbRxRPO3oh9dIUhAw/YPhXXAiVw5xYi8piEneT0KnGaNjA81bvFKA
         3pIffESDzPIueUaqARFgvBOiwAZ3IjYNQcqWa9+dZvNV6AjlhYkp1Ejo4Q7bwjg2wdXP
         rN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041800; x=1737646600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=720AkD/zgKeEhOjbcT3M7hGdPsm1hsXkqO75utWqaAg=;
        b=XpEImh6jWatxbYjms93gvwfi9/L2Ev5lzs1H6AQgSlBQ4e0xpGrOiOo2pt7Wqb4vvO
         BQJUOkQkjU+R1nRr37pyBz42pdU6Fnr9qs/UysKydAGKYSG3j0Q4DhB6P9jmyJu/yLNY
         Wqlsndy//WRis42t+EmZcJG02b/ojweujaRV6Wd6WA7jnPdk6W2gSiSjYMpRDkKynd8C
         vXIIWLNQAp5tMaui3wLzRBNR9gZAy3g6vvXeI0FVMwz1y/ctF3ODr98xhtH99k4ZgueG
         olDZuPco/ol62S8Jc9ScRhAfz93Cevfzfl2ORYqb4Rd9cIPLkJ/9pi15XFuUIu5d9sia
         j0MQ==
X-Gm-Message-State: AOJu0YzS49QRrfIS6empjQ32vfZiqT19Nc75GzJN7Arxmxnq6rwLeNdv
	bDhryjgKhaeQGjVKALIdL5lCqAJrHLwv2vCMSxfVUvOkOYUSWr4W9SJgKw==
X-Gm-Gg: ASbGncvYeDAdwHJeX1hpEZl2vxin9rSLtDpZJgO99OGPbWaEPJ1I4eaYvv+DYTyI14R
	enrU4vz8jvYcaihGrGwYEgye1VqgoiMrvF2w8cqUwozXyfie1Bqm8hCRFJ0NKuKGp0hzjdCnoBg
	Kc0H9d2L+mJbS+OdS8VnvwH6fGl3Ypg1PbkRoM1gVpIMwnF7E2AvN8Lh4Zm0b3AqRCFkP7MSXll
	Ngix7FSaMy/b/tJI1gZFK2CwDpYfQGwG18A7eUvV52mmAMfmwO2ZfrVwSyHxIAphciikR8Fn8IV
	jnGan2VRmBGcP7jYd1/6gFHoyZGu
X-Google-Smtp-Source: AGHT+IHY65kPSkQ5/F3a8gzKNF5SXEJA63wOrDKD31vC7RouNQe+/0059ms4aehr7hHLhXPDLjxgDw==
X-Received: by 2002:a05:620a:3906:b0:7b1:3f88:48ef with SMTP id af79cd13be357-7bcd97b1a95mr4864470385a.46.1737041800034;
        Thu, 16 Jan 2025 07:36:40 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b68a21dae2sm69466137.13.2025.01.16.07.36.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:36:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
Date: Thu, 16 Jan 2025 10:36:35 -0500
Message-ID: <20250116153635.3689890-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..00ef61609d49 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7466,14 +7466,33 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
 	conn->rx_len = 0;
 }
 
+static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
+{
+	BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
+
+	if (!kref_get_unless_zero(&c->ref))
+		return NULL;
+
+	return c;
+}
+
 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_conn *conn;
 	int len;
 
+	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
+	hci_dev_lock(hcon->hdev);
+
+	conn = hcon->l2cap_data;
+
 	if (!conn)
 		conn = l2cap_conn_add(hcon);
 
+	conn = l2cap_conn_hold_unless_zero(conn);
+
+	hci_dev_unlock(hcon->hdev);
+
 	if (!conn)
 		goto drop;
 
@@ -7565,6 +7584,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
+	l2cap_conn_put(conn);
+
 drop:
 	kfree_skb(skb);
 }
-- 
2.47.1

