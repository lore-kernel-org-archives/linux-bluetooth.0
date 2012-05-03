Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Enable Low Energy support by default
Date: Thu,  3 May 2012 07:12:31 +0200
Message-Id: <1336021951-19413-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth Low Energy support so far was disabled by default via
a module parameter. With this change the module parameter will be removed
and Low Energy is enabled by default.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    1 -
 net/bluetooth/hci_event.c   |    2 +-
 net/bluetooth/mgmt.c        |   12 +++---------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 346f087..66a7b57 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1438,6 +1438,5 @@ struct hci_inquiry_req {
 #define IREQ_CACHE_FLUSH 0x0001
 
 extern bool enable_hs;
-extern bool enable_le;
 
 #endif /* __HCI_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 507fcec..b739baf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -725,7 +725,7 @@ static void hci_set_le_support(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (enable_le && test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		cp.le = 1;
 		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 79e7770..ea170d2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,7 +35,6 @@
 #include <net/bluetooth/smp.h>
 
 bool enable_hs;
-bool enable_le;
 
 #define MGMT_VERSION	1
 #define MGMT_REVISION	1
@@ -384,10 +383,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (enable_hs)
 		settings |= MGMT_SETTING_HS;
 
-	if (enable_le) {
-		if (hdev->features[4] & LMP_LE)
-			settings |= MGMT_SETTING_LE;
-	}
+	if (hdev->features[4] & LMP_LE)
+		settings |= MGMT_SETTING_LE;
 
 	return settings;
 }
@@ -1199,7 +1196,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (!enable_le || !(hdev->features[4] & LMP_LE)) {
+	if (!(hdev->features[4] & LMP_LE)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				 MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
@@ -3657,6 +3654,3 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 module_param(enable_hs, bool, 0644);
 MODULE_PARM_DESC(enable_hs, "Enable High Speed support");
-
-module_param(enable_le, bool, 0644);
-MODULE_PARM_DESC(enable_le, "Enable Low Energy support");
-- 
1.7.7.6

