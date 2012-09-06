Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: mgmt: Implement support for passkey notification
Date: Thu,  6 Sep 2012 11:09:58 +0300
Message-Id: <1346918998-8642-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
References: <1346832850-25061-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds support for Secure Simple Pairing with devices that have
KeyboardOnly as their IO capability. Such devices will cause a passkey
notification on our side and optionally also keypress notifications.
Without this patch some keyboards cannot be paired using the mgmt
interface.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Make the keypress switch statement consistent with the rest of the code

 include/net/bluetooth/hci.h      |   18 ++++++++++
 include/net/bluetooth/hci_core.h |    5 +++
 include/net/bluetooth/mgmt.h     |    7 ++++
 net/bluetooth/hci_event.c        |   67 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |   16 +++++++++
 5 files changed, 113 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0f28f70..76b2b6b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1249,6 +1249,24 @@ struct hci_ev_simple_pair_complete {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define HCI_EV_USER_PASSKEY_NOTIFY	0x3b
+struct hci_ev_user_passkey_notify {
+	bdaddr_t	bdaddr;
+	__le32		passkey;
+} __packed;
+
+#define HCI_KEYPRESS_STARTED		0
+#define HCI_KEYPRESS_ENTERED		1
+#define HCI_KEYPRESS_ERASED		2
+#define HCI_KEYPRESS_CLEARED		3
+#define HCI_KEYPRESS_COMPLETED		4
+
+#define HCI_EV_KEYPRESS_NOTIFY		0x3c
+struct hci_ev_keypress_notify {
+	bdaddr_t	bdaddr;
+	__u8		type;
+} __packed;
+
 #define HCI_EV_REMOTE_HOST_FEATURES	0x3d
 struct hci_ev_remote_host_features {
 	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa807a3..b998b9c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -303,6 +303,8 @@ struct hci_conn {
 	__u8		pin_length;
 	__u8		enc_key_size;
 	__u8		io_capability;
+	__u32		passkey_notify;
+	__u8		passkey_entered;
 	__u16		disc_timeout;
 	unsigned long	flags;
 
@@ -1016,6 +1018,9 @@ int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 link_type, u8 addr_type, u8 status);
 int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status);
+int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			     u8 link_type, u8 addr_type, u32 passkey,
+			     u8 entered);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, u8 status);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1b48eff..22980a7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -478,3 +478,10 @@ struct mgmt_ev_device_unblocked {
 struct mgmt_ev_device_unpaired {
 	struct mgmt_addr_info addr;
 } __packed;
+
+#define MGMT_EV_PASSKEY_NOTIFY		0x0017
+struct mgmt_ev_passkey_notify {
+	struct mgmt_addr_info addr;
+	__le32	passkey;
+	__u8	entered;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 48d7302..ccca88f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3263,6 +3263,65 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 		mgmt_user_passkey_request(hdev, &ev->bdaddr, ACL_LINK, 0);
 }
 
+static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_ev_user_passkey_notify *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s", hdev->name);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (!conn)
+		return;
+
+	conn->passkey_notify = __le32_to_cpu(ev->passkey);
+	conn->passkey_entered = 0;
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
+					 conn->dst_type, conn->passkey_notify,
+					 conn->passkey_entered);
+}
+
+static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_keypress_notify *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s", hdev->name);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (!conn)
+		return;
+
+	switch (ev->type) {
+	case HCI_KEYPRESS_STARTED:
+		conn->passkey_entered = 0;
+		return;
+
+	case HCI_KEYPRESS_ENTERED:
+		conn->passkey_entered++;
+		break;
+
+	case HCI_KEYPRESS_ERASED:
+		conn->passkey_entered--;
+		break;
+
+	case HCI_KEYPRESS_CLEARED:
+		conn->passkey_entered = 0;
+		break;
+
+	case HCI_KEYPRESS_COMPLETED:
+		return;
+	}
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
+					 conn->dst_type, conn->passkey_notify,
+					 conn->passkey_entered);
+}
+
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -3627,6 +3686,14 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_user_passkey_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_USER_PASSKEY_NOTIFY:
+		hci_user_passkey_notify_evt(hdev, skb);
+		break;
+
+	case HCI_EV_KEYPRESS_NOTIFY:
+		hci_keypress_notify_evt(hdev, skb);
+		break;
+
 	case HCI_EV_SIMPLE_PAIR_COMPLETE:
 		hci_simple_pair_complete_evt(hdev, skb);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05d4b83..4c04c1e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3276,6 +3276,22 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					  MGMT_OP_USER_PASSKEY_NEG_REPLY);
 }
 
+int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			     u8 link_type, u8 addr_type, u32 passkey,
+			     u8 entered)
+{
+	struct mgmt_ev_passkey_notify ev;
+
+	BT_DBG("%s", hdev->name);
+
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
+	ev.passkey = __cpu_to_le32(passkey);
+	ev.entered = entered;
+
+	return mgmt_event(MGMT_EV_PASSKEY_NOTIFY, hdev, &ev, sizeof(ev), NULL);
+}
+
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, u8 status)
 {
-- 
1.7.10.4

