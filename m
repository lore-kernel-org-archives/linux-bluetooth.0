Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set supported settings based on enabled HS and/or LE
Date: Mon, 20 Feb 2012 21:47:49 +0100
Message-Id: <1329770869-21333-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since neither High Speed (HS) nor Low Energy (LE) are fully implemented
yet, only expose them in supported settings when enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |    5 -----
 net/bluetooth/hci_event.c   |    5 -----
 net/bluetooth/mgmt.c        |   18 ++++++++++++++++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 60a4727..ad5e94c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1422,5 +1422,6 @@ struct hci_inquiry_req {
 #define IREQ_CACHE_FLUSH 0x0001
 
 extern bool enable_hs;
+extern bool enable_le;
 
 #endif /* __HCI_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 87ff7ff..cc52e03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -54,8 +54,6 @@
 
 #define AUTO_OFF_TIMEOUT 2000
 
-bool enable_hs;
-
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
@@ -2913,6 +2911,3 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
-
-module_param(enable_hs, bool, 0644);
-MODULE_PARM_DESC(enable_hs, "Enable High Speed");
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f00faf0..5d0f92a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -44,8 +44,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static bool enable_le;
-
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3545,6 +3543,3 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb);
 	hdev->stat.evt_rx++;
 }
-
-module_param(enable_le, bool, 0644);
-MODULE_PARM_DESC(enable_le, "Enable LE support");
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bc71b45..f7c2969 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -34,6 +34,9 @@
 #include <net/bluetooth/mgmt.h>
 #include <net/bluetooth/smp.h>
 
+bool enable_hs;
+bool enable_le;
+
 #define MGMT_VERSION	1
 #define MGMT_REVISION	0
 
@@ -374,8 +377,13 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_LINK_SECURITY;
 	}
 
-	if (hdev->features[4] & LMP_LE)
-		settings |= MGMT_SETTING_LE;
+	if (enable_hs)
+		settings |= MGMT_SETTING_HS;
+
+	if (enable_le) {
+		if (hdev->features[4] & LMP_LE)
+			settings |= MGMT_SETTING_LE;
+	}
 
 	return settings;
 }
@@ -3421,3 +3429,9 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
 							cmd ? cmd->sk : NULL);
 }
+
+module_param(enable_hs, bool, 0644);
+MODULE_PARM_DESC(enable_hs, "Enable High Speed support");
+
+module_param(enable_le, bool, 0644);
+MODULE_PARM_DESC(enable_le, "Enable Low Energy support");
-- 
1.7.7.6

