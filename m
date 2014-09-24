Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add retransmission effort into SCO parameter table
Date: Wed, 24 Sep 2014 22:41:46 +0300
Message-Id: <1411587706-25498-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It is expected that new parameter combinations will have the
retransmission effort value different between some entries (mainly
because of the new S4 configuration added by HFP 1.7), so it makes sense
to move it into the table instead of having it hard coded based on the
selected SCO_AIRMODE_*.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 445829cd363c..06047142797c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -36,24 +36,25 @@
 struct sco_param {
 	u16 pkt_type;
 	u16 max_latency;
+	u8  retrans_effort;
 };
 
 static const struct sco_param esco_param_cvsd[] = {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a }, /* S3 */
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007 }, /* S2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007 }, /* S1 */
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff }, /* D0 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
 };
 
 static const struct sco_param sco_param_cvsd[] = {
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff }, /* D0 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
 };
 
 static const struct sco_param sco_param_wideband[] = {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d }, /* T2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
 };
 
 static void hci_le_create_connection_cancel(struct hci_conn *conn)
@@ -208,19 +209,16 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	case SCO_AIRMODE_TRANSP:
 		if (conn->attempt > ARRAY_SIZE(sco_param_wideband))
 			return false;
-		cp.retrans_effort = 0x02;
 		param = &sco_param_wideband[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
 		if (lmp_esco_capable(conn->link)) {
 			if (conn->attempt > ARRAY_SIZE(esco_param_cvsd))
 				return false;
-			cp.retrans_effort = 0x01;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
 			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
 				return false;
-			cp.retrans_effort = 0xff;
 			param = &sco_param_cvsd[conn->attempt - 1];
 		}
 		break;
@@ -228,6 +226,7 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 		return false;
 	}
 
+	cp.retrans_effort = param->retrans_effort;
 	cp.pkt_type = __cpu_to_le16(param->pkt_type);
 	cp.max_latency = __cpu_to_le16(param->max_latency);
 
-- 
1.9.3

