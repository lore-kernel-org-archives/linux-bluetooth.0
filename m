Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH v2 2/2] Bluetooth: Add discovering event to the Management interface
Date: Wed, 27 Apr 2011 10:29:57 -0400
Message-Id: <4db82875.624dec0a.70bd.226a@mx.google.com>
In-Reply-To: <y>
References: <y>
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
 net/bluetooth/hci_event.c        |   40 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/mgmt.c             |    6 +++++
 4 files changed, 43 insertions(+), 6 deletions(-)

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
index cb25628..e64a3de 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -56,7 +56,9 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	clear_bit(HCI_INQUIRY, &hdev->flags);
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
@@ -72,7 +74,9 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	clear_bit(HCI_INQUIRY, &hdev->flags);
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
 
 	hci_conn_check_pending(hdev);
 }
@@ -841,10 +845,14 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
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
+					!test_and_set_bit(HCI_INQUIRY,
+							&hdev->flags))
+		mgmt_discovering(hdev->id, 1);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
@@ -1208,7 +1216,9 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, status);
 
-	clear_bit(HCI_INQUIRY, &hdev->flags);
+	if (test_bit(HCI_MGMT, &hdev->flags) &&
+				test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+		mgmt_discovering(hdev->id, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
@@ -1228,6 +1238,12 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
+	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	for (; num_rsp; num_rsp--, info++) {
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
@@ -2158,6 +2174,12 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 
 	hci_dev_lock(hdev);
 
+	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
 		info = (void *) (skb->data + 1);
@@ -2320,6 +2342,12 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	if (!num_rsp)
 		return;
 
+	if (!test_and_set_bit(HCI_INQUIRY, &hdev->flags)) {
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 1);
+	}
+
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dbc248f..4542396 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2149,3 +2149,9 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
 
 	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
 }
+
+int mgmt_discovering(u16 index, u8 discovering)
+{
+	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
+						sizeof(discovering), NULL);
+}
-- 
1.7.1

