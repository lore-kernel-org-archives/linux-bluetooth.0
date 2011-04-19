Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Add discovering event to the Management interface
Date: Tue, 19 Apr 2011 17:35:26 -0400
Message-Id: <4dae0089.a905ec0a.709a.12f8@mx.google.com>
In-Reply-To: <1303248926-16607-1-git-send-email-y>
References: <1303248926-16607-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a new event to the Management interface to track when
local adapters are discovering remote devices. For now this only tracks
BR/EDR discovery procedures.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    2 +
 net/bluetooth/hci_event.c        |   44 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             |    6 +++++
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4093133..69967e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -790,6 +790,7 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
+int mgmt_discovering(u16 index, u8 discovering);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index be93dd0..7434406 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -285,3 +285,5 @@ struct mgmt_ev_remote_name {
 	bdaddr_t bdaddr;
 	__u8 name[MGMT_MAX_NAME_LENGTH];
 } __packed;
+
+#define MGMT_EV_DISCOVERING		0x0014
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c7eb073..f356ed7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -56,6 +56,10 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+					test_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
+
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
@@ -72,6 +76,10 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+					test_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
+
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_conn_check_pending(hdev);
@@ -841,10 +849,15 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
-
 		hci_conn_check_pending(hdev);
-	} else
-		set_bit(HCI_INQUIRY, &hdev->flags);
+		return;
+	}
+
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+					!test_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 1);
+
+	set_bit(HCI_INQUIRY, &hdev->flags);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
@@ -1208,6 +1221,10 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, status);
 
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+					test_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
+
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
@@ -1228,6 +1245,13 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
+	if (!test_bit(HCI_INQUIRY, &hdev->flags)) {
+		set_bit(HCI_INQUIRY, &hdev->flags);
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	for (; num_rsp; num_rsp--, info++) {
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
@@ -2158,6 +2182,13 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 
 	hci_dev_lock(hdev);
 
+	if (!test_bit(HCI_INQUIRY, &hdev->flags)) {
+		set_bit(HCI_INQUIRY, &hdev->flags);
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
 		info = (void *) (skb->data + 1);
@@ -2320,6 +2351,13 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	if (!num_rsp)
 		return;
 
+	if (!test_bit(HCI_INQUIRY, &hdev->flags)) {
+		set_bit(HCI_INQUIRY, &hdev->flags);
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958544a..f623b8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2150,3 +2150,9 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
 	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_discovering(u16 index, u8 discovering)
+{
+	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
+						sizeof(discovering), NULL);
+}
+
-- 
1.7.1

