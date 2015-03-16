Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for Local OOB Extended Data Update events
Date: Mon, 16 Mar 2015 16:07:58 -0700
Message-Id: <1426547278-2094-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a different user requests a new set of local out-of-band data, then
inform all previous users that the data has been updated. To limit the
scope of users, the updates are limited to previous users. If a user has
never requested out-of-band data, it will also not see the update.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h |  7 +++++++
 net/bluetooth/mgmt.c         | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ce757303dc07..a6ea156dc7e9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -186,6 +186,7 @@ enum {
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
 	HCI_MGMT_GENERIC_EVENTS,
+	HCI_MGMT_OOB_DATA_EVENTS,
 };
 
 /*
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 543c1ba3d892..a1a68671bf88 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -735,3 +735,10 @@ struct mgmt_ev_ext_index {
 #define MGMT_EV_EXT_INDEX_ADDED		0x0020
 
 #define MGMT_EV_EXT_INDEX_REMOVED	0x0021
+
+#define MGMT_EV_LOCAL_OOB_DATA_UPDATED	0x0022
+struct mgmt_ev_local_oob_data_updated {
+	__u8    type;
+	__le16	eir_len;
+	__u8	eir[0];
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7fa3c4b8384b..4cdc72028597 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -262,6 +262,13 @@ static int mgmt_index_event(u16 event, struct hci_dev *hdev, void *data,
 			       flag, NULL);
 }
 
+static int mgmt_limited_event(u16 event, struct hci_dev *hdev, void *data,
+			      u16 len, int flag, struct sock *skip_sk)
+{
+	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
+			       flag, skip_sk);
+}
+
 static int mgmt_generic_event(u16 event, struct hci_dev *hdev, void *data,
 			      u16 len, struct sock *skip_sk)
 {
@@ -6387,8 +6394,16 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 
+	hci_sock_set_flag(sk, HCI_MGMT_OOB_DATA_EVENTS);
+
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
 				MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
+	if (err < 0)
+		goto done;
+
+	err = mgmt_limited_event(MGMT_EV_LOCAL_OOB_DATA_UPDATED, hdev,
+				 rp, sizeof(*rp) + eir_len,
+				 HCI_MGMT_OOB_DATA_EVENTS, sk);
 
 done:
 	kfree(rp);
-- 
2.1.0

