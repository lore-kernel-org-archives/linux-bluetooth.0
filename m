Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] emulator/bthost: Add initial rfcomm handling
Date: Mon,  6 Jan 2014 19:42:40 +0100
Message-Id: <1389033760-16764-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389033760-16764-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389033760-16764-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial rfcomm handling in bthost. It also adds
rfcomm.h to monitor directory
---
 emulator/bthost.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 monitor/rfcomm.h  | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 monitor/rfcomm.h

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 83bfdee..e142038 100644
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
+	switch (GET_TYPE(hdr->control)) {
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
+		if (l2conn->psm == 0x0003)
+			process_rfcomm(bthost, conn, l2conn, l2_data, l2_len);
+		else
+			printf("Packet for unknown CID 0x%04x (%u)\n", cid,
+									cid);
 		break;
 	}
 }
diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
new file mode 100644
index 0000000..a8266e7
--- /dev/null
+++ b/monitor/rfcomm.h
@@ -0,0 +1,53 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013 Intel Corporation
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define RFCOMM_SABM    0x2f
+#define RFCOMM_DISC    0x43
+#define RFCOMM_UA      0x63
+#define RFCOMM_DM      0x0f
+#define RFCOMM_UIH     0xef
+
+#define GET_TYPE(control)      ((control & 0xef))
+#define GET_DLCI(address)      ((address & 0xfc) >> 2)
+#define GET_CHANNEL(address)   ((address & 0xf8) >> 3)
+#define GET_DIR(address)       ((address & 0x04) >> 2)
+
+#define TEST_EA(length)      ((length & 0x01))
+
+#define ADDR(cr, dlci) (((dlci & 0x3f) << 2) | (cr << 1) | 0x01)
+#define CTRL(type, pf) (((type & 0xef) | (pf << 4)))
+#define LEN8(len)       (((len) << 1) | 1)
+#define LEN16(len)      ((len) << 1)
+
+struct rfcomm_hdr {
+	uint8_t address_field;
+	uint8_t control;
+	uint8_t length;
+} __attribute__((packed));
+
+struct rfcomm_cmd {
+	uint8_t address_field;
+	uint8_t control;
+	uint8_t length;
+	uint8_t fcs;
+} __attribute__((packed));
-- 
1.8.3.1

