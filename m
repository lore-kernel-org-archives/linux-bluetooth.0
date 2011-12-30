Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 1/2] Bluetooth: Rename extfeatures
Date: Fri, 30 Dec 2011 10:34:03 -0300
Message-Id: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hdev->extfeatures to hdev->host_features since it
holds the extended features Page 1 (aka host features).

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 include/net/bluetooth/hci_core.h |    4 ++--
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5e2e984..ea9231f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -127,7 +127,7 @@ struct hci_dev {
 	__u8		major_class;
 	__u8		minor_class;
 	__u8		features[8];
-	__u8		extfeatures[8];
+	__u8		host_features[8];
 	__u8		commands[64];
 	__u8		ssp_mode;
 	__u8		hci_ver;
@@ -676,7 +676,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
 /* ----- Extended LMP capabilities ----- */
-#define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & LMP_HOST_LE)
+#define lmp_host_le_capable(dev)   ((dev)->host_features[0] & LMP_HOST_LE)
 
 /* ----- HCI protocols ----- */
 static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 919e3c0..37c31c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -711,7 +711,7 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	memcpy(hdev->extfeatures, rp->features, 8);
+	memcpy(hdev->host_features, rp->features, 8);
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2540944..38ec8ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -291,7 +291,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (!(hdev->features[4] & LMP_NO_BREDR))
 		settings |= MGMT_SETTING_BREDR;
 
-	if (hdev->extfeatures[0] & LMP_HOST_LE)
+	if (hdev->host_features[0] & LMP_HOST_LE)
 		settings |= MGMT_SETTING_LE;
 
 	if (test_bit(HCI_AUTH, &hdev->flags))
-- 
1.7.8.1

