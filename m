Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, brn@deako.com,
        Don Zickus <dzickus@redhat.com>
Subject: [RFC 1/3] bluetooth: Add managment ability to disable duplicate device fitlering
Date: Tue,  6 Dec 2016 16:39:58 -0500
Message-Id: <1481060400-7088-2-git-send-email-dzickus@redhat.com>
In-Reply-To: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are use cases where userspace wants to disable duplicate device
filtering for LE scans on the adapater.  One example is real time update
of RSSI data.

This patch adds hooks into the management interface to allow that.

Currently only used on 'active_scan'.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/hci_request.c      | 2 +-
 net/bluetooth/mgmt.c             | 5 +++++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 554671c..fd34707 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -79,6 +79,7 @@ struct discovery_state {
 	bool			report_invalid_rssi;
 	bool			result_filtering;
 	bool			limited;
+	bool			filter_dups;
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 72a456b..6ffd2d8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -503,6 +503,7 @@ struct mgmt_cp_start_service_discovery {
 	__s8 rssi;
 	__le16 uuid_count;
 	__u8 uuids[0][16];
+	__u8 le_duplicates;
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1015d9c..8b5ee64 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2038,7 +2038,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 
 	memset(&enable_cp, 0, sizeof(enable_cp));
 	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	enable_cp.filter_dup = hdev->discovery.filter_dups;
 
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 		    &enable_cp);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a0..b07aa7f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3578,6 +3578,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
 	u16 uuid_count, expected_len;
+	bool filter_dups = LE_SCAN_FILTER_DUP_ENABLE;
 	u8 status;
 	int err;
 
@@ -3631,6 +3632,9 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (cp->le_duplicates)
+		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
@@ -3649,6 +3653,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hdev->discovery.type = cp->type;
 	hdev->discovery.rssi = cp->rssi;
 	hdev->discovery.uuid_count = uuid_count;
+	hdev->discovery.filter_dups = filter_dups;
 
 	if (uuid_count > 0) {
 		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
-- 
1.8.4

