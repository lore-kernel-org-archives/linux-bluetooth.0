Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add S4 configuration parameter set for CVSD
Date: Fri, 19 Sep 2014 13:25:25 +0300
Message-Id: <1411122325-22959-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1411122325-22959-1-git-send-email-johan.hedberg@gmail.com>
References: <1411122325-22959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HFP 1.7 specification recommends a new S4 parameter set for CVSD SCO
connections over BR/EDR Secure Connections based links. This patch adds
this set to the sco_param_cvsd table and ensures that it is skipped for
any link that's not using BR/EDR Secure Connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c3d11bbb4f7..2e955ea0d3ef 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -40,6 +40,7 @@ struct sco_param {
 };
 
 static const struct sco_param sco_param_cvsd[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000c,	0x02 }, /* S4 */
 	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
 	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
@@ -209,6 +210,10 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	case SCO_AIRMODE_CVSD:
 		if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
 			return false;
+		/* Skip S4 for non-SC connections */
+		if (conn->attempt == 1 && !test_bit(HCI_CONN_FIPS,
+						    &conn->link->flags))
+			conn->attempt++;
 		param = &sco_param_cvsd[conn->attempt - 1];
 		break;
 	default:
-- 
1.9.3

