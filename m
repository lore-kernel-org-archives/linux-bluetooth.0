Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/5] emulator/bthost: Add initial rfcomm handling
Date: Wed,  8 Jan 2014 10:23:49 +0100
Message-Id: <1389173030-27970-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389173030-27970-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389173030-27970-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial rfcomm handling in bthost.
---
 emulator/bthost.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 83bfdee..5e13745 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -36,6 +36,7 @@
 #include "bluetooth/bluetooth.h"
 
 #include "monitor/bt.h"
+#include "monitor/rfcomm.h"
 #include "bthost.h"
 
 /* ACL handle and flags pack/unpack */
@@ -1173,6 +1174,64 @@ static struct cid_hook *find_cid_hook(struct btconn *conn, uint16_t cid)
 	return NULL;
 }
 
+static void rfcomm_sabm_recv(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+}
+
+static void rfcomm_disc_recv(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+}
+
+static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+}
+
+static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+}
+
+static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+}
+
+static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, const void *data,
+				uint16_t len)
+{
+	const struct rfcomm_hdr *hdr = data;
+
+	switch (RFCOMM_GET_TYPE(hdr->control)) {
+	case RFCOMM_SABM:
+		rfcomm_sabm_recv(bthost, conn, l2conn, data, len);
+		break;
+	case RFCOMM_DISC:
+		rfcomm_disc_recv(bthost, conn, l2conn, data, len);
+		break;
+	case RFCOMM_UA:
+		rfcomm_ua_recv(bthost, conn, l2conn, data, len);
+		break;
+	case RFCOMM_DM:
+		rfcomm_dm_recv(bthost, conn, l2conn, data, len);
+		break;
+	case RFCOMM_UIH:
+		rfcomm_uih_recv(bthost, conn, l2conn, data, len);
+		break;
+	default:
+		printf("Unknown frame type\n");
+		break;
+	}
+}
+
 static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 {
 	const struct bt_hci_acl_hdr *acl_hdr = data;
@@ -1180,6 +1239,7 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	uint16_t handle, cid, acl_len, l2_len;
 	struct cid_hook *hook;
 	struct btconn *conn;
+	struct l2conn *l2conn;
 	const void *l2_data;
 
 	if (len < sizeof(*acl_hdr) + sizeof(*l2_hdr))
@@ -1218,7 +1278,12 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 		l2cap_le_sig(bthost, conn, l2_data, l2_len);
 		break;
 	default:
-		printf("Packet for unknown CID 0x%04x (%u)\n", cid, cid);
+		l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
+		if (l2conn && l2conn->psm == 0x0003)
+			process_rfcomm(bthost, conn, l2conn, l2_data, l2_len);
+		else
+			printf("Packet for unknown CID 0x%04x (%u)\n", cid,
+									cid);
 		break;
 	}
 }
-- 
1.8.3.1

