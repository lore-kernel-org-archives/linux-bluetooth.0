Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH v10 10/10] Bluetooth: Add SCO connection fallback
Date: Wed, 14 Aug 2013 19:03:34 +0200
Message-Id: <1376499814-11386-11-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initiating a transparent eSCO connection, make use of T2 settings
at first try. T2 is the recommended settings from HFP 1.6 WideBand
Speech. Upon connection failure, try T1 settings.

When CVSD is requested and eSCO is supported, try to establish eSCO
connection using S3 settings. If it fails, fallback in sequence to S2,
S1, D1, D0 settings.

To know which setting should be used, conn->attempt is used. It
indicates the currently ongoing SCO connection attempt and can be used
as the index for the fallback settings table.

These setting and the fallback order are described in Bluetooth HFP 1.6
specification p. 101.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   41 ++++++++++++++++++++++++++++++--------
 net/bluetooth/hci_event.c        |    6 +++---
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2bfab8..1f95e9b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -570,7 +570,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 }
 
 void hci_disconnect(struct hci_conn *conn, __u8 reason);
-void hci_setup_sync(struct hci_conn *conn, __u16 handle);
+int hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c0e56a5..d3befac 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -31,6 +31,24 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/smp.h>
 
+struct sco_param {
+	u16 pkt_type;
+	u16 max_latency;
+};
+
+static const struct sco_param sco_param_cvsd[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a }, /* S3 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007 }, /* S2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007 }, /* S1 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff }, /* D0 */
+};
+
+static const struct sco_param sco_param_wideband[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
+};
+
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -172,10 +190,11 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
 }
 
-void hci_setup_sync(struct hci_conn *conn, __u16 handle)
+int hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
+	const struct sco_param *param;
 
 	BT_DBG("hcon %p", conn);
 
@@ -192,19 +211,25 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
-		cp.pkt_type = __constant_cpu_to_le16(EDR_ESCO_MASK &
-						     ~ESCO_2EV3);
-		cp.max_latency = __constant_cpu_to_le16(0x000d);
+		if (conn->attempt > ARRAY_SIZE(sco_param_wideband))
+			return -ECONNREFUSED;
 		cp.retrans_effort = 0x02;
+		param = &sco_param_wideband[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
-		cp.max_latency = __constant_cpu_to_le16(0xffff);
-		cp.retrans_effort = 0xff;
+		if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
+			return -ECONNREFUSED;
+		cp.retrans_effort = 0x01;
+		param = &sco_param_cvsd[conn->attempt - 1];
 		break;
+	default:
+		return -EINVAL;
 	}
 
-	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
+	cp.pkt_type = __cpu_to_le16(param->pkt_type);
+	cp.max_latency = __cpu_to_le16(param->max_latency);
+
+	return hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
 
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a8bb7bb..491c5fb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2909,11 +2909,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
-		if (conn->out && conn->attempt < 2) {
+		if (conn->out) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-			hci_setup_sync(conn, conn->link->handle);
-			goto unlock;
+			if (hci_setup_sync(conn, conn->link->handle) == 0)
+				goto unlock;
 		}
 		/* fall through */
 
-- 
1.7.9.5

