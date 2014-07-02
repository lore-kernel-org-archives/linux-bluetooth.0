Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Add support for Unconfigured Index Removed events
Date: Wed,  2 Jul 2014 21:30:55 +0200
Message-Id: <1404329455-32929-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a controller in an unconfigured state gets removed, then send
Unconfigured Index Removed events.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 2 ++
 net/bluetooth/mgmt.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7da29fd748d8..651993213bd9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -642,3 +642,5 @@ struct mgmt_ev_new_conn_param {
 } __packed;
 
 #define MGMT_EV_UNCONF_INDEX_ADDED	0x001d
+
+#define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ab70d5858db9..1a78d26b0049 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -119,6 +119,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_DEVICE_REMOVED,
 	MGMT_EV_NEW_CONN_PARAM,
 	MGMT_EV_UNCONF_INDEX_ADDED,
+	MGMT_EV_UNCONF_INDEX_REMOVED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5395,7 +5396,10 @@ void mgmt_index_removed(struct hci_dev *hdev)
 
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
-	mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		mgmt_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0, NULL);
+	else
+		mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
 /* This function requires the caller holds hdev->lock */
-- 
1.9.3

