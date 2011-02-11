Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 3/3] Bluetooth: Send LE Connection Update Command
Date: Fri, 11 Feb 2011 19:28:56 -0200
Message-Id: <1297459736-24514-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the new connection update parameter are accepted, the LE master
host sends the LE Connection Update Command to its controller informing
the new requested parameters.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 include/net/bluetooth/hci.h      |   11 +++++++++++
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |   20 ++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |    7 ++++++-
 4 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 46438f4..12417e1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -701,6 +701,17 @@ struct hci_rp_le_ltk_neg_reply {
 	__le16	handle;
 } __packed;
 
+#define HCI_OP_LE_CONN_UPDATE		0x2013
+struct hci_cp_le_conn_update {
+	__le16   handle;
+	__le16   conn_interval_min;
+	__le16   conn_interval_max;
+	__le16   conn_latency;
+	__le16   supervision_timeout;
+	__le16   min_ce_len;
+	__le16   max_ce_len;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5114122..f6c61d2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -786,5 +786,7 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
 void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
+					u16 latency, u16 to_multiplier);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee7dcdd..d646037 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -231,6 +231,26 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn)
 }
 EXPORT_SYMBOL(hci_le_ltk_neg_reply);
 
+void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
+					u16 latency, u16 to_multiplier)
+{
+	struct hci_cp_le_conn_update cp;
+	struct hci_dev *hdev = conn->hdev;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.handle		= cpu_to_le16(conn->handle);
+	cp.conn_interval_min	= cpu_to_le16(min);
+	cp.conn_interval_max	= cpu_to_le16(max);
+	cp.conn_latency		= cpu_to_le16(latency);
+	cp.supervision_timeout	= cpu_to_le16(to_multiplier);
+	cp.min_ce_len		= cpu_to_le16(0x0001);
+	cp.max_ce_len		= cpu_to_le16(0x0001);
+
+	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_le_conn_update);
+
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8b76a72..66c4d80 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2555,7 +2555,9 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 						min, max, latency, to_multiplier);
 
 	memset(&rsp, 0, sizeof(rsp));
-	if (l2cap_check_conn_param(min, max, latency, to_multiplier))
+
+	err = l2cap_check_conn_param(min, max, latency, to_multiplier);
+	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
@@ -2563,6 +2565,9 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
 							sizeof(rsp), &rsp);
 
+	if (!err)
+		hci_le_conn_update(hcon, min, max, latency, to_multiplier);
+
 	return 0;
 }
 
-- 
1.7.4

