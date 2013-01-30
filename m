Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 4/4] Bluetooth: Fallback transparent SCO from T2 to T1
Date: Wed, 30 Jan 2013 17:03:20 +0100
Message-Id: <1359561800-12870-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359561800-12870-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359561800-12870-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initiating a transparent eSCO connection, make use of T2 settings at
first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
connection failure, try T1 settings.
To know which of T2 or T1 should be used, the connection attempt index is used.
T2 failure is detected if Synchronous Connection Complete Event fails with
error 0x0d. This error code has been found experimentally by sending a T2
request to a T1 only SCO listener. It means "Connection Rejected due to
Limited resource".

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/hci_conn.c  |   11 ++++++++++-
 net/bluetooth/hci_event.c |    1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7f290ad..2172d42 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,12 +179,21 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 
-	if (test_and_clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
+	if (conn->attempt == 1 &&
+	    test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
 		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
 							   ~ESCO_2EV3);
 		cp.max_latency    = __constant_cpu_to_le16(0x000d);
 		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
 		cp.retrans_effort = 0x02;
+	} else if (conn->attempt == 2 &&
+		   test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
+		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK |
+							   ESCO_EV3);
+		cp.max_latency    = __constant_cpu_to_le16(0x0007);
+		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
+		cp.retrans_effort = 0x02;
+		clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags);
 	} else {
 		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
 		cp.max_latency    = __constant_cpu_to_le16(0xffff);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 188bb83..86ce811 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3379,6 +3379,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x0d:	/* No resource available */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
-- 
1.7.9.5

