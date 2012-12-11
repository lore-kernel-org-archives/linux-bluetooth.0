Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 5/5] Bluetooth: Fallback transparent SCO from T2 to T1
Date: Tue, 11 Dec 2012 17:53:52 +0100
Message-Id: <1355244832-2729-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1355244832-2729-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1355244832-2729-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When initiating an eSCO connection, force use of T2 settings at first try.
T2 is the recommended settings from HFP 1.6 WideBand Speech so we only do that
on an transparent eSCO request. Upon connection failure, try T1 settings.
To know which of T2 or T1 should be used, we use the connection attempt index.
T2 failure is detected if Synchronous Connection Complete Event fails with
error 0x0d. This error code has been found experimentally by sending a T2
request to a T1 only SCO listener. It means "Connection Rejected due to
Limited resource".
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   13 +++++++++++--
 net/bluetooth/hci_event.c        |    1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b9902a..9ef7fe0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -438,7 +438,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
-	HCI_CONN_SCO_T2_SETTINGS,
+	HCI_CONN_SCO_TRANSPARENT,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4bba2fb..87c2fa4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -181,10 +181,19 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
 
-	if (test_and_clear_bit(HCI_CONN_SCO_T2_SETTINGS, &conn->flags)) {
+	if (conn->attempt == 1 &&
+	    test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
+		cp.pkt_type       = cpu_to_le16(EDR_ESCO_MASK & ~ESCO_2EV3);
 		cp.voice_setting |= 3;
 		cp.max_latency    = __constant_cpu_to_le16(0x000d);
 		cp.retrans_effort = 0x02;
+	} else if (conn->attempt == 2 &&
+		   test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
+		cp.pkt_type       = cpu_to_le16(ESCO_EV3 | EDR_ESCO_MASK);
+		cp.voice_setting |= 3;
+		cp.max_latency    = __constant_cpu_to_le16(0x0007);
+		cp.retrans_effort = 0x02;
+		clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags);
 	} else {
 		cp.max_latency    = __constant_cpu_to_le16(0xffff);
 		cp.retrans_effort = 0xff;
@@ -584,7 +593,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 	hci_conn_hold(sco);
 
 	if (codec)
-		set_bit(HCI_CONN_SCO_T2_SETTINGS, &sco->flags);
+		set_bit(HCI_CONN_SCO_TRANSPARENT, &sco->flags);
 
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 175d23d..762ec1d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3319,6 +3319,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		hci_conn_add_sysfs(conn);
 		break;
 
+	case 0x0d:	/* No resource available */
 	case 0x11:	/* Unsupported Feature or Parameter Value */
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
-- 
1.7.9.5

