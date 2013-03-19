Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 6/6] Bluetooth: Fallback transparent SCO from T2 to T1
Date: Tue, 19 Mar 2013 19:04:15 +0100
Message-Id: <1363716255-21332-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
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
attempt to reconnect twice, but still test conn->fallback as a preventive
measure.
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   12 ++++++++++--
 net/bluetooth/hci_event.c        |    3 ++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 70e0364..ba3fd72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -329,6 +329,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		voice_setting;
+	__u8		fallback;
 	unsigned long	flags;
 
 	__u8		remote_cap;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 95c69a6..83b38e3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,13 +179,21 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 
-	if (conn->voice_setting == 0x0003) {
+	if (conn->fallback == 0 && conn->voice_setting == 0x0003) {
 		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
 							   ~ESCO_2EV3);
 		cp.max_latency    = __constant_cpu_to_le16(0x000d);
 		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
 		cp.retrans_effort = 0x02;
-	} else {
+		conn->fallback = 1;
+	} else if (conn->fallback == 1 && conn->voice_setting == 0x0003) {
+		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK |
+							   ESCO_EV3);
+		cp.max_latency    = __constant_cpu_to_le16(0x0007);
+		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
+		cp.retrans_effort = 0x02;
+		conn->fallback = 2;
+	} else if (conn->voice_setting == 0x0000) {
 		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
 		cp.max_latency    = __constant_cpu_to_le16(0xffff);
 		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2fe3ccd..f3b070e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2953,11 +2953,12 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x0d:	/* No resource available */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
-		if (conn->out && conn->attempt < 2) {
+		if (conn->out && conn->attempt < 2 && conn->fallback != 2) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
 			hci_setup_sync(conn, conn->link->handle);
-- 
1.7.9.5

