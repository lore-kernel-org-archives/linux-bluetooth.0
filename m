Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BD2F3638
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197179; cv=none; b=GcWqDv5mren5wUwBgC4+ckSKLEAJ6wP0TKuro01HI9+07iXLeBaINJdLCpUt15/1hTMxD6h96Q2NT+s2/VjRwcdOyADtTVTLb+JC5h+DeeOxVYKBN4Nl6GVtxmTLuY+weO75lFkjdM53cKpGT9OULnLjS7v07gEFLFboEC+D1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197179; c=relaxed/simple;
	bh=Uv9kHIVVZxV2ZHWW0y2s0Dc4cRxHB9XUaozdxZyIob0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=t0R1857f+rpIuRoG0Fdqw6acmchSbJz4IszEoAmh5fE/zclyo+mwQn8qFEmnFsrIxUBhTxc3tEoLaMu5kU0OqAIsnYIpVrJ958+CCrgShMneVUWHdVcWqABZebthTOQ/WVK2g4IjTKD2VQh+7oS3gsmDREBI2aOcATvAINV4bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dQ1bV0Bzjz6FyBt;
	Mon, 08 Dec 2025 20:32:54 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5B8CWg5s038942;
	Mon, 8 Dec 2025 20:32:42 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 8 Dec 2025 20:32:45 +0800 (CST)
Date: Mon, 8 Dec 2025 20:32:45 +0800 (CST)
X-Zmail-TransId: 2afa6936c56dc05-748c1
X-Mailer: Zmail v1.0
Message-ID: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
In-Reply-To: <20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn>
References: 20251208203056891J84Xq6wiMu3r7HXa_mRb3@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <chen.junlin@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyAxLzJdIEJsdWV0b290aDogaGNpX2Nvbm46IEFkZCB0cmFjZXBvaW50cyBmb3IgZGVidWdnaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5B8CWg5s038942
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 08 Dec 2025 20:32:54 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6936C576.000/4dQ1bV0Bzjz6FyBt

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Add tracepoints for tracking hci_conn_hold, hci_conn_drop, and hci_conn_del
to facilitate debugging and viewing call stacks.
The existing Bluetooth debugging method, BT_DBG, cannot trace call stacks.

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
---
 include/net/bluetooth/hci_core.h |  3 ++
 include/trace/events/bluetooth.h | 80 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |  4 ++
 3 files changed, 87 insertions(+)
 create mode 100644 include/trace/events/bluetooth.h

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b261e74e2c4..5e01e6c501c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <trace/events/bluetooth.h>

 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_drv.h>
@@ -1620,6 +1621,7 @@ static inline void hci_conn_put(struct hci_conn *conn)

 static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
 {
+	trace_hci_conn_hold(conn);
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));

 	atomic_inc(&conn->refcnt);
@@ -1630,6 +1632,7 @@ static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)

 static inline void hci_conn_drop(struct hci_conn *conn)
 {
+	trace_hci_conn_drop(conn);
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));

 	if (atomic_dec_and_test(&conn->refcnt)) {
diff --git a/include/trace/events/bluetooth.h b/include/trace/events/bluetooth.h
new file mode 100644
index 000000000000..dd6446263e83
--- /dev/null
+++ b/include/trace/events/bluetooth.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bluetooth
+
+#if !defined(_TRACE_BLUETOOTH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BLUETOOTH_H
+
+#include <linux/tracepoint.h>
+#include <net/bluetooth/hci_core.h>
+
+TRACE_EVENT(hci_conn_hold,
+
+	TP_PROTO(void *conn_ptr),
+
+	TP_ARGS(conn_ptr),
+
+	TP_STRUCT__entry(
+		__field(void *, conn_addr)
+		__field(int, refcnt)
+	),
+
+	TP_fast_assign(
+		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
+
+		__entry->conn_addr = conn;
+		__entry->refcnt = atomic_read(&conn->refcnt);
+	),
+
+	TP_printk("conn_addr=%p, orig refcnt=%d",
+			__entry->conn_addr, __entry->refcnt)
+)
+
+TRACE_EVENT(hci_conn_drop,
+
+	TP_PROTO(void *conn_ptr),
+
+	TP_ARGS(conn_ptr),
+
+	TP_STRUCT__entry(
+		__field(void *, conn_addr)
+		__field(int, refcnt)
+	),
+
+	TP_fast_assign(
+		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
+
+		__entry->conn_addr = conn;
+		__entry->refcnt = atomic_read(&conn->refcnt);
+	),
+
+	TP_printk("conn_addr=%p, orig refcnt=%d",
+			__entry->conn_addr, __entry->refcnt)
+)
+
+TRACE_EVENT(hci_conn_del,
+
+	TP_PROTO(void *conn_ptr),
+
+	TP_ARGS(conn_ptr),
+
+	TP_STRUCT__entry(
+		__field(void *, conn_addr)
+		 __field(int, refcnt)
+	),
+
+	TP_fast_assign(
+		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
+
+		__entry->conn_addr = conn;
+		__entry->refcnt = atomic_read(&conn->refcnt);
+	),
+
+	TP_printk("conn_addr=%p, orig refcnt=%d",
+			__entry->conn_addr, __entry->refcnt)
+)
+
+#endif /* _TRACE_BLUETOOTH_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 99efeed6a766..74a02cf7ba14 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,9 @@
 #include <net/bluetooth/iso.h>
 #include <net/bluetooth/mgmt.h>

+#define CREATE_TRACE_POINTS
+#include <trace/events/bluetooth.h>
+
 #include "smp.h"
 #include "eir.h"

@@ -1129,6 +1132,7 @@ static void hci_conn_unlink(struct hci_conn *conn)

 void hci_conn_del(struct hci_conn *conn)
 {
+	trace_hci_conn_del(conn);
 	struct hci_dev *hdev = conn->hdev;

 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
-- 
2.27.0
