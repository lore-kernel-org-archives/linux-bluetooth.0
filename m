Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add Device Added and Device Removed management events
Date: Sun, 29 Jun 2014 22:28:34 +0200
Message-Id: <1404073714-36369-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When devices are added or removed, then make sure that events are send
out to all other clients so that the list of devices can be easily
tracked. This is especially important when external clients are
adding or removing devices within the auto-connection list.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 11 +++++++++++
 net/bluetooth/mgmt.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bc9b105f2b50..1f95ad4fce02 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -603,3 +603,14 @@ struct mgmt_ev_new_csrk {
 	__u8 store_hint;
 	struct mgmt_csrk_info key;
 } __packed;
+
+#define MGMT_EV_DEVICE_ADDED		0x001a
+struct mgmt_ev_device_added {
+	struct mgmt_addr_info addr;
+	__u8 action;
+} __packed;
+
+#define MGMT_EV_DEVICE_REMOVED		0x001b
+struct mgmt_ev_device_removed {
+	struct mgmt_addr_info addr;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 64b55c7881ee..d83197f9e727 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -114,6 +114,8 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PASSKEY_NOTIFY,
 	MGMT_EV_NEW_IRK,
 	MGMT_EV_NEW_CSRK,
+	MGMT_EV_DEVICE_ADDED,
+	MGMT_EV_DEVICE_REMOVED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -4968,6 +4970,18 @@ unlock:
 	return err;
 }
 
+static void device_added(struct sock *sk, struct hci_dev *hdev,
+			 bdaddr_t *bdaddr, u8 type, u8 action)
+{
+	struct mgmt_ev_device_added ev;
+
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = type;
+	ev.action = action;
+
+	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
+}
+
 static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
@@ -5009,6 +5023,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
+
 	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
 
@@ -5017,6 +5033,17 @@ unlock:
 	return err;
 }
 
+static void device_removed(struct sock *sk, struct hci_dev *hdev,
+			   bdaddr_t *bdaddr, u8 type)
+{
+	struct mgmt_ev_device_removed ev;
+
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = type;
+
+	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
+}
+
 static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			 void *data, u16 len)
 {
@@ -5043,6 +5070,8 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			addr_type = ADDR_LE_DEV_RANDOM;
 
 		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+
+		device_removed(sk, hdev, &cp->addr.bdaddr, cp->addr.type);
 	} else {
 		if (cp->addr.type) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
-- 
1.9.3

