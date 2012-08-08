Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 2/2] Bluetooth: mgmt: Add device disconnect reason
Date: Wed,  8 Aug 2012 09:42:33 +0200
Message-Id: <1344411753-10124-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

MGMT_EV_DEVICE_DISCONNECTED will now expose the disconnection reason to
userland, distinguishing four possible values:

	0x00	Reason not known or unspecified
	0x01	ACL connection timeout
	0x02	ACL connection terminated by local host
	0x03	ACL connection terminated by remote host

Note that the local/remote distinction just determines which side
terminated the low-level ACL connection, regardless of the disconnection
of the higher-level profiles.

This can sometimes be misleading and thus must be used with care. For
example, some hardware combinations would report a locally initiated
disconnection even if the user turned Bluetooth off in the remote side.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    8 ++++++++
 net/bluetooth/hci_event.c        |   24 +++++++++++++++++++++---
 net/bluetooth/mgmt.c             |    9 +++++----
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 41d9439..4fb0323 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1004,7 +1004,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			  u8 *dev_class);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type);
+			     u8 link_type, u8 addr_type, u8 reason);
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			   u8 link_type, u8 addr_type, u8 status);
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4348ee8..e8b86e0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -405,7 +405,15 @@ struct mgmt_ev_device_connected {
 	__u8	eir[0];
 } __packed;
 
+#define MGMT_DEV_DISCONN_TIMEOUT	0x01
+#define MGMT_DEV_DISCONN_LOCAL_HOST	0x02
+#define MGMT_DEV_DISCONN_REMOTE		0x03
+
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000C
+struct mgmt_ev_device_disconnected {
+	struct mgmt_addr_info addr;
+	__u8	reason;
+} __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0386e1e..1323341 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -29,6 +29,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
 
 /* Handle HCI Event packets */
 
@@ -1906,12 +1907,29 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
 	    (conn->type == ACL_LINK || conn->type == LE_LINK)) {
-		if (ev->status != 0)
+		if (ev->status != 0) {
 			mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 					       conn->dst_type, ev->status);
-		else
+		} else {
+			u8 reason = 0;
+
+			switch (ev->reason) {
+			case HCI_ERROR_CONNECTION_TIMEOUT:
+				reason = MGMT_DEV_DISCONN_TIMEOUT;
+				break;
+			case HCI_ERROR_REMOTE_USER_TERM:
+			case HCI_ERROR_REMOTE_LOW_RESOURCES:
+			case HCI_ERROR_REMOTE_POWER_OFF:
+				reason = MGMT_DEV_DISCONN_REMOTE;
+				break;
+			case HCI_ERROR_LOCAL_HOST_TERM:
+				reason = MGMT_DEV_DISCONN_LOCAL_HOST;
+				break;
+			}
+
 			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-						 conn->dst_type);
+						 conn->dst_type, reason);
+		}
 	}
 
 	if (ev->status == 0) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3329cb..05d4b83 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3077,16 +3077,17 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 }
 
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			     u8 link_type, u8 addr_type)
+			     u8 link_type, u8 addr_type, u8 reason)
 {
-	struct mgmt_addr_info ev;
+	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 	int err;
 
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
-	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_bdaddr(link_type, addr_type);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
+	ev.reason = reason;
 
 	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
 			 sk);
-- 
1.7.7.6

