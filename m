Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 6/6] Bluetooth: Fallback transparent SCO from T2 to T1
Date: Tue, 16 Apr 2013 17:08:40 +0200
Message-Id: <1366124920-10185-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1366124920-10185-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1366124920-10185-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initiating a transparent eSCO connection, make use of T2 settings at
first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
connection failure, try T1 settings.
T2 failure is detected if Synchronous Connection Complete event fails with
error 0x0d. This error code has been found experimentally by sending a T2
request to a T1 only SCO listener. It means "Connection Rejected due to
Limited resource".
To know which of T2 or T1 should be used, conn->fallback is used.  Bluez only
attempt to reconnect twice. In the future, we will need more than 2 fallback
possibilities. Thus, test conn->fallback as an alternative measure. We want to
fallback only if conn->fallback is positive. Calling hci_setup_sync with
conn->fallback == 0 is an initial connection attempt.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   21 ++++++++++++++++++---
 net/bluetooth/hci_event.c        |    3 ++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 98f8c15..605715e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -329,6 +329,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		setting;
+	__u8		fallback;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cface45..b8d1060 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -31,6 +31,18 @@
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/smp.h>
 
+struct sco_param {
+	u16 pkt_type;
+	u16 max_latency;
+	u8 next;
+};
+
+static const struct sco_param sco_param_wideband [] =
+{
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d, 1 },
+	{ EDR_ESCO_MASK & ESCO_EV3,   0x0007, 0 },
+};
+
 static void hci_le_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -176,6 +188,7 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
+	const struct sco_param *param;
 
 	BT_DBG("hcon %p", conn);
 
@@ -191,11 +204,13 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting) {
 	case BT_VOICE_TRANSPARENT:
-		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
-							   ~ESCO_2EV3);
-		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		param = &sco_param_wideband[conn->fallback];
+		cp.pkt_type       = __constant_cpu_to_le16(param->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(param->max_latency);
 		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
 		cp.retrans_effort = 0x02;
+
+		conn->fallback    = param->next;
 		break;
 	default:
 		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 333646c..610c7a8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2955,11 +2955,12 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
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

