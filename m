Return-Path: <cyrus@holtmann.org>
From: Marcin <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/4] emulator: Add data handler for l2cap connections
Date: Tue, 17 Dec 2013 15:49:37 +0100
Message-Id: <1387291779-14960-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387291779-14960-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Add possibility to handle data received on specified psm.
---
 emulator/bthost.c | 19 ++++++++++++++++++-
 emulator/bthost.h |  6 ++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 32d46b0..bd8bd00 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -103,6 +103,8 @@ struct bthost {
 	void *new_conn_data;
 	uint16_t server_psm;
 	struct l2cap_pending_req *l2reqs;
+	uint16_t read_data_psm;
+	bthost_l2cap_data_cb l2cap_data_cb;
 };
 
 struct bthost *bthost_create(void)
@@ -1119,6 +1121,7 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	uint16_t handle, cid, acl_len, l2_len;
 	struct cid_hook *hook;
 	struct btconn *conn;
+	struct l2conn *l2conn;
 	const void *l2_data;
 
 	if (len < sizeof(*acl_hdr) + sizeof(*l2_hdr))
@@ -1157,7 +1160,13 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 		l2cap_le_sig(bthost, conn, l2_data, l2_len);
 		break;
 	default:
-		printf("Packet for unknown CID 0x%04x (%u)\n", cid, cid);
+		l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
+		if (l2conn && l2conn->psm &&
+				l2conn->psm == bthost->read_data_psm)
+			bthost->l2cap_data_cb(l2_data, l2_len);
+		else
+			printf("Packet for unknown CID 0x%04x (%u)\n", cid,
+									cid);
 		break;
 	}
 }
@@ -1254,6 +1263,14 @@ void bthost_set_server_psm(struct bthost *bthost, uint16_t psm)
 	bthost->server_psm = psm;
 }
 
+void bthost_l2cap_set_data_handler(struct bthost *bthost,
+					bthost_l2cap_data_cb handler,
+					uint16_t psm)
+{
+	bthost->read_data_psm = psm;
+	bthost->l2cap_data_cb = handler;
+}
+
 void bthost_start(struct bthost *bthost)
 {
 	if (!bthost)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 474ada9..5703262 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -68,6 +68,12 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t req,
 				const void *data, uint16_t len,
 				bthost_l2cap_rsp_cb cb, void *user_data);
 
+typedef void (*bthost_l2cap_data_cb) (const void *data, uint16_t len);
+
+void bthost_l2cap_set_data_handler(struct bthost *bthost,
+					bthost_l2cap_data_cb handler,
+					uint16_t psm);
+
 void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan);
 
 void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
-- 
1.8.3.1

