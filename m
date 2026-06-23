Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47930D3EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231188; cv=none; b=bp5GIbMgQJDd1UeIXlfAMCjZqPp+zs7anJDyLIZhzJ0uKq48Rpv/9lIIHPrn165ecxV47qlyBIhy3EPgL4vicXZy3yOjugFnn8Lyjjr0mZhcbh8Jg5A/E9Joby/6cWepzRhPU+Q6N36NnB3q4DYkYOZ/Gc6/iZYFPK2UkS+yGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231188; c=relaxed/simple;
	bh=E08fANLfySLUmtQZyk8z4JRKtfupJ7HNlGdHwLVWTAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TRxItk99HNxgVuQR2GioQrXyItE/2QaoT3nyZqiAN8T6/wzcfjnAE033cTHum6nfan1olHramV9SvxdXUpQT04sZ3Um01Io+6dHZgT4/uWzxLrIZYL1iJqQoSJ0bq7WTcXlxCSgQJpFKVNuqmQC8VqZukTmlT/9gPh4T1VSS95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCVv3WJU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCVv3WJU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b900f350fso115542a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231186; x=1782835986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+v2T4WdGgthusYqJLajsBQCPaCAsq8PVQQDhe0OAc4Q=;
        b=qCVv3WJUFCWIIFYNXDMlyrfasS6OczY3e4RLRNdUcfKWJB+yl/bVrznyTGV81K/lPx
         TrVgrAuVDL+zzGjgueNW3v+oO4j1OGnCEKnBIefcpG4Fh4YfRYpe1b9gpSNzoc+oyV61
         lIt5Um6t4CgGZMCCeNQEjT8sHccK6jkrOSiPirFaDHu0r90hwgWmEnCJ3J2kHCmdYUh/
         oDUPS7OkPXagjAkRHj57sOjtLzewBPmx2TIU/wK0U/Ah6nvAwIy9UxA/PZU2dYCqfwaa
         +1dN+ko7VRLGfcW9eDnSeHQUGtRsRMWU2Vw+wNox2n//Qd2meNGRA2ROF6/F9jl33gmg
         cVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231186; x=1782835986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v2T4WdGgthusYqJLajsBQCPaCAsq8PVQQDhe0OAc4Q=;
        b=M1mqE9U3KTRsm2a131u8evohC5hHTYjOzdzd3c3LQ4cCTGKMDz4CZ8zFD4MsgN14Yj
         WZiZepHjh3g6MUBSGZ4fsmEngRjWRmuZpTbicykypP91VGnoRMehZwPEhtdSvaVLufLv
         2TRvtvJBfKDV/sNRUXpXppFJYY/wa7UDHOe5qsIpjrwhd+N8ho/NfX1k4+fktSOmPITG
         dD2PL29/sjQ6IOSP38gPoRjJ0ngktOx5VepztQyG6uDcMos0jlXsk5n62P/ENKCoha93
         WS5H55moV9mqmv53ohxVgMHEaXGuXsljfxnmiCgkgGWJYRAnSPG/L+ctad3TdNX+sEjf
         vVhw==
X-Gm-Message-State: AOJu0YzE0U8yQaHcZX5njZghKSGPzJKHj0yn7Vmm3i70uxkMsSfK+skW
	zbYynl78TPGGKD+WUyTyta+XR//qljecMNOcj9sLnKXRi5Jr4WnpvQi4
X-Gm-Gg: AfdE7clNDSvOnBHJFanGcZ45MrtHVUY9l/MIwXdsx9vP1xtOfuczarmvS7xOUsPUOfY
	6GV7wA+J/IN9OvdZ29ePdPZMr9VK4/dXJKe13CF2OtEMALmymYrPJtN9u7OIxKKdSFisRlDtsJC
	K85+5rJK/nJAylfoZsJ5CpBnoyzZgle95VNRF9PJ5CXxQFwFpAz6B6c8XViMGlO6AqaZCr1zC2E
	0pNXo83ACBmIdVUcJ6HXwNiiGJVYKT3P86Tojqp5qwmNy/14xUAMEyADsjbCKmZZC532qKYUkiw
	GiH4VT5apgVoq81WmIu+z2zqdUg/jvZ1btOkHgJ+cBiKqkmgZJzfcJqX0/sDM41GkGjH+Baa/Wh
	qhDi+nHMD6pbORIVYRboAU5vdLmGYmGRAywLY134dWs3W+OaKQxIcGbxpdvF9wmbi35T6WJ6MB3
	2Hsw6eHU0=
X-Received: by 2002:a17:90b:4f8a:b0:37c:ad9b:680b with SMTP id 98e67ed59e1d1-37dd17872c5mr3562183a91.20.1782231185957;
        Tue, 23 Jun 2026 09:13:05 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f2d2702sm10677994a91.12.2026.06.23.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:13:05 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
Date: Wed, 24 Jun 2026 00:12:59 +0800
Message-Id: <20260623161259.2175870-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_l2cap_conn() looks up an LE hci_conn under hdev protection, but
then drops that protection before reading hcon->l2cap_data and before
lowpan_control_write() later dereferences conn->hcon.  A disconnect or
device close can tear down the same L2CAP connection in that window.

The buggy scenario involves two paths, with each column showing the order
within that path:

6LoWPAN control write:              HCI disconnect/device close:
  1. get_l2cap_conn() finds hcon      1. hci_disconn_cfm() dispatches
     and hcon->l2cap_data.               the L2CAP disconnect callback.
  2. get_l2cap_conn() drops hdev      2. l2cap_conn_del() clears
     protection and returns conn.        hcon->l2cap_data and drops the
                                         L2CAP connection reference.
  3. lowpan_control_write() reads     3. hci_conn_del() removes and drops
     conn->hcon.                         the HCI connection.

Take a reference to the L2CAP connection with
l2cap_conn_hold_unless_zero() while hdev is still locked, and drop that
reference after the debugfs command's last use of conn.  This mirrors the
existing L2CAP ACL receive-side handoff and keeps the connection
dereferenceable after leaving hdev protection.  Export the existing helper
so the bluetooth_6lowpan module can use the same lifetime primitive.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in lowpan_control_write+0x374/0x520
The buggy address belongs to the object at ffff888111b9d000 which belongs
to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of freed 1024-byte region
[ffff888111b9d000, ffff888111b9d400)
Read of size 8
Call trace:
  dump_stack_lvl+0x66/0xa0
  print_report+0xce/0x5f0
  lowpan_control_write+0x374/0x520 (net/bluetooth/6lowpan.c:1131)
  srso_alias_return_thunk+0x5/0xfbef5
  __virt_addr_valid+0x19f/0x330
  kasan_report+0xe0/0x110
  __debugfs_file_get+0xf7/0x400
  full_proxy_write+0x9e/0xd0
  vfs_write+0x1b0/0x810
  ksys_write+0xd2/0x170
  dnotify_flush+0x32/0x220
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
Allocated by task stack:
  kasan_save_stack+0x33/0x60
  kasan_save_track+0x17/0x60
  __kasan_kmalloc+0xaa/0xb0
  l2cap_conn_add+0x45/0x520
  l2cap_chan_connect+0xac6/0xd90
  l2cap_sock_connect+0x216/0x350
  __sys_connect+0x101/0x130
  __x64_sys_connect+0x40/0x50
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
Freed by task stack:
  kasan_save_stack+0x33/0x60
  kasan_save_track+0x17/0x60
  kasan_save_free_info+0x3b/0x60
  __kasan_slab_free+0x5f/0x80
  kfree+0x313/0x590
  hci_conn_hash_flush+0xc0/0x140
  hci_dev_close_sync+0x41a/0xb00
  hci_dev_close+0x12f/0x160
  hci_sock_ioctl+0x157/0x570
  sock_do_ioctl+0xf7/0x210
  sock_ioctl+0x32f/0x490
  __x64_sys_ioctl+0xc7/0x110
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  kasan_record_aux_stack+0xa7/0xc0
  insert_work+0x32/0x100
  __queue_work+0x262/0xa60
  queue_work_on+0xad/0xb0
  l2cap_connect_cfm+0x4ef/0x670
  hci_le_remote_feat_complete_evt+0x247/0x430
  hci_event_packet+0x360/0x6f0
  hci_rx_work+0x2ae/0x7a0
  process_one_work+0x4fd/0xbc0
  worker_thread+0x2d8/0x570
  kthread+0x1ad/0x1f0
  ret_from_fork+0x3c9/0x540
  ret_from_fork_asm+0x1a/0x30

Fixes: 6b8d4a6a0314 ("Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed one")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/6lowpan.c    | 21 +++++++++++++++------
 net/bluetooth/l2cap_core.c |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..2fa1cc3de796 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1029,16 +1029,19 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 
 	hci_dev_lock(hdev);
 	hcon = hci_conn_hash_lookup_le(hdev, addr, le_addr_type);
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
-	if (!hcon)
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		hci_dev_put(hdev);
 		return -ENOENT;
+	}
 
-	*conn = (struct l2cap_conn *)hcon->l2cap_data;
+	*conn = l2cap_conn_hold_unless_zero(hcon->l2cap_data);
 
 	BT_DBG("conn %p dst %pMR type %u", *conn, &hcon->dst, hcon->dst_type);
 
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
 	return 0;
 }
 
@@ -1185,18 +1188,22 @@ static ssize_t lowpan_control_write(struct file *fp,
 		if (conn) {
 			struct lowpan_peer *peer;
 
-			if (!is_bt_6lowpan(conn->hcon))
+			if (!is_bt_6lowpan(conn->hcon)) {
+				l2cap_conn_put(conn);
 				return -EINVAL;
+			}
 
 			peer = lookup_peer(conn);
 			if (peer) {
 				BT_DBG("6LoWPAN connection already exists");
+				l2cap_conn_put(conn);
 				return -EALREADY;
 			}
 
 			BT_DBG("conn %p dst %pMR type %d user %u", conn,
 			       &conn->hcon->dst, conn->hcon->dst_type,
 			       addr_type);
+			l2cap_conn_put(conn);
 		}
 
 		ret = bt_6lowpan_connect(&addr, addr_type);
@@ -1212,6 +1219,8 @@ static ssize_t lowpan_control_write(struct file *fp,
 			return ret;
 
 		ret = bt_6lowpan_disconnect(conn, addr_type);
+		if (conn)
+			l2cap_conn_put(conn);
 		if (ret < 0)
 			return ret;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 62133eef9d2f..ed668a782d3d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7702,6 +7702,7 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 
 	return c;
 }
+EXPORT_SYMBOL(l2cap_conn_hold_unless_zero);
 
 int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 		       struct sk_buff *skb, u16 flags)
-- 
2.43.0

