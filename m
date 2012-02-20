Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: mgmt: Add address type parameter to Discovering event
Date: Tue, 21 Feb 2012 00:24:34 +0200
Message-Id: <1329776676-22800-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds an address type parameter to the Discovering event. The
value matches that given to Start/Stop Discovery.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    4 ++++
 net/bluetooth/hci_core.c     |    3 +--
 net/bluetooth/mgmt.c         |    8 ++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 870a3de..1dbadbe 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -402,6 +402,10 @@ struct mgmt_ev_device_found {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0013
+struct mgmt_ev_discovering {
+	__u8 type;
+	__u8 discovering;
+} __packed;
 
 #define MGMT_EV_DEVICE_BLOCKED		0x0014
 struct mgmt_ev_device_blocked {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cc52e03..a7439ae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -363,10 +363,9 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		hdev->discovery.type = 0;
-
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
+		hdev->discovery.type = 0;
 		break;
 	case DISCOVERY_STARTING:
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3db8525..86148b1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3392,6 +3392,7 @@ int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
+	struct mgmt_ev_discovering ev;
 	struct pending_cmd *cmd;
 
 	BT_DBG("%s discovering %u", hdev->name, discovering);
@@ -3409,8 +3410,11 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 		mgmt_pending_remove(cmd);
 	}
 
-	return mgmt_event(MGMT_EV_DISCOVERING, hdev, &discovering,
-						sizeof(discovering), NULL);
+	memset(&ev, 0, sizeof(ev));
+	ev.type = hdev->discovery.type;
+	ev.discovering = discovering;
+
+	return mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-- 
1.7.9

