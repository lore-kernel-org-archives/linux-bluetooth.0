Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 9/9] Bluetooth: SCO connection fallback
Date: Fri, 12 Jul 2013 18:05:43 +0200
Message-Id: <1373645143-7494-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initiating a transparent eSCO connection, make use of T2 settings at
first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
connection failure, try T1 settings.

When CVSD is requested and eSCO is supported, try to establish eSCO connection
using S3 settings. If it fails, fallback in sequence to S2, S1, D1, D0 settings.

Failure is detected if Synchronous Connection Complete event fails with
error 0x0d. This error code has been found experimentally by sending a T2
request to a T1 only SCO listener. It means "Connection Rejected due to
Limited resource".
To know which setting should be used, conn->fallback is used.  Bluez only
attempt to reconnect twice. Since, more than 2 fallback are required,
conn->fallback is tested as an alternative measure. We want to fallback only if
conn->fallback is positive. Calling hci_setup_sync with conn->fallback == 0
triggers initial connection attempt.

These setting and the fallback order are described in Bluetooth HFP 1.6
specification p. 101.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   37 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c        |    3 ++-
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2bfab8..26560c6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -321,6 +321,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		setting;
+	__u8		fallback;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c4d6163..d6b09fa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -31,6 +31,25 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/smp.h>
 
+struct sco_param {
+	u16 pkt_type;
+	u16 max_latency;
+	u8 next;
+};
+
+static const struct sco_param sco_param_cvsd[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a, 1 }, /* S3 */
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007, 2 }, /* S2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007, 3 }, /* S1 */
+	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff, 4 }, /* D1 */
+	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff, 0 }, /* D0 */
+};
+
+static const struct sco_param sco_param_wideband[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d, 1 }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008, 0 }, /* T1 */
+};
+
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -176,6 +195,7 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
+	const struct sco_param *param;
 
 	BT_DBG("hcon %p", conn);
 
@@ -192,15 +212,20 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
-		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
-							   ~ESCO_2EV3);
-		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		param = &sco_param_wideband[conn->fallback];
+		cp.pkt_type       = __constant_cpu_to_le16(param->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(param->max_latency);
 		cp.retrans_effort = 0x02;
+
+		conn->fallback    = param->next;
 		break;
 	case SCO_AIRMODE_CVSD:
-		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.retrans_effort = 0xff;
+		param = &sco_param_cvsd[conn->fallback];
+		cp.pkt_type       = __constant_cpu_to_le16(param->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(param->max_latency);
+		cp.retrans_effort = 0x01;
+
+		conn->fallback    = param->next;
 		break;
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0437200..6659af8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2904,11 +2904,12 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x0d:	/* No resource available */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
-		if (conn->out && conn->attempt < 2) {
+		if (conn->out && (conn->attempt < 2 || conn->fallback > 0)) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
 			hci_setup_sync(conn, conn->link->handle);
-- 
1.7.9.5

