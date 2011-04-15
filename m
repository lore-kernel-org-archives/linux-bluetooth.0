Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC] Proposal to distinguish address device types
Date: Fri, 15 Apr 2011 15:33:42 -0300
Message-Id: <1302892422-32206-1-git-send-email-claudio.takahasi@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Device type is input to decide how to establish the L2CAP connection.
For LE devices fixed channel ID 4 is set, otherwise PSM should be set
for basic rate connections. LE public and random constants are misused
for discovery, however I don't see advantage of defining basic rate and
LE values only.

Based on jhe/master:
git://git.kernel.org/pub/scm/linux/kernel/git/jh/linux-2.6.git

Opinions?
---
 include/net/bluetooth/bluetooth.h |    6 ++++++
 include/net/bluetooth/hci_core.h  |    4 ++--
 include/net/bluetooth/mgmt.h      |    1 +
 net/bluetooth/hci_event.c         |   16 ++++++++--------
 net/bluetooth/mgmt.c              |    5 +++--
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4375043..b91eec9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -94,6 +94,12 @@ typedef struct {
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
 
+enum {
+	BDADDR_TYPE_BR = 0,
+	BDADDR_TYPE_LE_PUBLIC,
+	BRADDR_TYPE_LE_RANDOM
+};
+
 /* Copy, swap, convert BD Address */
 static inline int bacmp(bdaddr_t *ba1, bdaddr_t *ba2)
 {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8200704..b357346 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -808,8 +808,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir);
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 bdaddr_type,
+					u8 *dev_class, s8 rssi, u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_periodic_inq_complete(u16 index, u8 status);
 int mgmt_exit_periodic_inq_complete(u16 index, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2a70541..c299f6a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -281,6 +281,7 @@ struct mgmt_ev_local_name_changed {
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
 	bdaddr_t bdaddr;
+	__u8 bdaddr_type;
 	__u8 dev_class[3];
 	__s8 rssi;
 	__u8 eir[HCI_MAX_EIR_LENGTH];
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ded8e0c..997d8f6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1285,8 +1285,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		if (!test_bit(HCI_MGMT, &hdev->flags))
 			continue;
 
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class, 0,
-									NULL);
+		mgmt_device_found(hdev->id, &info->bdaddr, BDADDR_TYPE_BR,
+						info->dev_class, 0, NULL);
 
 		if (test_bit(HCI_DISCOVERY, &hdev->flags))
 			hci_add_found_device(hdev, &info->bdaddr, 0x00);
@@ -2257,8 +2257,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 				continue;
 
 			mgmt_device_found(hdev->id, &info->bdaddr,
-						info->dev_class, info->rssi,
-						NULL);
+					BDADDR_TYPE_BR, info->dev_class,
+					info->rssi, NULL);
 
 			if (!test_bit(HCI_DISCOVERY, &hdev->flags))
 				continue;
@@ -2283,8 +2283,8 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 				continue;
 
 			mgmt_device_found(hdev->id, &info->bdaddr,
-						info->dev_class, info->rssi,
-						NULL);
+					BDADDR_TYPE_BR, info->dev_class,
+					info->rssi, NULL);
 
 			if (!test_bit(HCI_DISCOVERY, &hdev->flags))
 				continue;
@@ -2465,8 +2465,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		if (!test_bit(HCI_MGMT, &hdev->flags))
 			continue;
 
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class,
-						info->rssi, info->data);
+		mgmt_device_found(hdev->id, &info->bdaddr, BDADDR_TYPE_BR,
+				info->dev_class, info->rssi, info->data);
 
 		if (!test_bit(HCI_DISCOVERY, &hdev->flags))
 			continue;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2b20ee9..ad673f2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2157,14 +2157,15 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 	return err;
 }
 
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir)
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 bdaddr_type,
+					u8 *dev_class, s8 rssi, u8 *eir)
 {
 	struct mgmt_ev_device_found ev;
 
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.bdaddr, bdaddr);
+	ev.bdaddr_type = bdaddr_type;
 	memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
 	ev.rssi = rssi;
 
-- 
1.7.4.1
