Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 13/14] Bluetooth: Support LE-Only discovery procedure
Date: Mon, 19 Sep 2011 18:35:35 -0300
Message-Id: <1316468136-12472-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for LE-Only discovery procedure through
management interface.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   16 +++++++++++++---
 net/bluetooth/mgmt.c      |   13 ++++++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5bbba54..0408c50 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -889,14 +889,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		return;
-
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
 	if (!cp)
 		return;
 
 	if (cp->enable == 0x01) {
+		if (status) {
+			mgmt_discovery_complete(hdev->id, status);
+			return;
+		}
+
 		set_bit(HCI_LE_SCAN, &hdev->flags);
 
 		mgmt_discovering(hdev->id, 1);
@@ -906,7 +908,15 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
+
+		if (mgmt_has_pending_stop_discov(hdev->id))
+			hci_cancel_le_scan(hdev);
 	} else if (cp->enable == 0x00) {
+		mgmt_discovery_complete(hdev->id, status);
+
+		if (status)
+			return;
+
 		clear_bit(HCI_LE_SCAN, &hdev->flags);
 
 		mgmt_discovering(hdev->id, 0);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1eee5cc..e869422 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,14 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+/*
+ * These LE scan and inquiry parameters were chosen according to LE General
+ * Discovery Procedure specification.
+ */
+#define LE_SCAN_TYPE 0x01
+#define LE_SCAN_WIN 0x12
+#define LE_SCAN_INT 0x12
+#define LE_SCAN_TIMEOUT_LE_ONLY 10240 /* TGAP(gen_disc_scan_min) */
 #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
 
 struct pending_cmd {
@@ -1637,7 +1645,8 @@ static int start_discovery(struct sock *sk, u16 index)
 	if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
 		err = -ENOSYS;
 	else if (lmp_host_le_capable(hdev))
-		err = -ENOSYS;
+		err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
 	else
 		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
 
@@ -1684,6 +1693,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		err = hci_cancel_inquiry(hdev);
+	else if (test_bit(HCI_LE_SCAN, &hdev->flags))
+		err = hci_cancel_le_scan(hdev);
 	else
 		err = 0;
 
-- 
1.7.5.2

