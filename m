Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 11/15] Bluetooth: Temporarily stop background scanning on connection
Date: Wed, 16 Oct 2013 20:18:01 -0300
Message-Id: <1381965485-9159-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some LE controllers don't support scanning and initiating a connection
at the same time. So, for those controllers, we should temporarily
stop the background scanning and start it again once the connection
attempt is finished (successfully or not).

So this patch introduces the hci_check_background_scan() which checks
if the background scanning should be started.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 25 +++++++++++++++++++++++++
 net/bluetooth/hci_core.c         | 18 ++++++++++++++++++
 net/bluetooth/hci_event.c        |  6 ++++++
 4 files changed, 50 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index db39eca..017decc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1201,5 +1201,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 
 int hci_trigger_background_scan(struct hci_dev *hdev);
 int hci_untrigger_background_scan(struct hci_dev *hdev);
+void hci_check_background_scan(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d64000e..6ae42c2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -541,6 +541,18 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 
 done:
 	hci_dev_unlock(hdev);
+
+	/* Check the background scanning since it may have been temporarily
+	 * stopped if the controller doesn't support scanning and initiate
+	 * state combination.
+	 */
+	hci_check_background_scan(hdev);
+}
+
+/* Check if controller supports scanning and initiating states combination */
+static bool is_state_combination_supported(struct hci_dev *hdev)
+{
+        return (hdev->le_states[2] & BIT(6)) ? true : false;
 }
 
 static int hci_create_le_conn(struct hci_conn *conn)
@@ -553,6 +565,19 @@ static int hci_create_le_conn(struct hci_conn *conn)
 
 	hci_req_init(&req, hdev);
 
+	/* If controller is scanning but it doesn't support initiating and
+	 * scanning states combination, we stop scanning.
+	 */
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    !is_state_combination_supported(hdev)) {
+		struct hci_cp_le_set_scan_enable enable_cp;
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_DISABLE;
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 68f3c0a..e1e8f8a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3967,3 +3967,21 @@ done:
 	atomic_dec(&hdev->background_scan_cnt);
 	return 0;
 }
+
+/* This function checks if there is background scan triggers and starts
+ * scanning.
+ */
+void hci_check_background_scan(struct hci_dev *hdev)
+{
+	int err;
+
+	if (atomic_read(&hdev->background_scan_cnt) == 0)
+		return;
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	err = start_background_scan(hdev);
+	if (err)
+		BT_ERR("Failed to start background scanning: err %d", err);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 570f27d..a8c7b47 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3592,6 +3592,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 unlock:
 	hci_dev_unlock(hdev);
+
+	/* Check the background scanning since it may have been temporarily
+	 * stopped if the controller doesn't support scanning and initiate
+	 * state combination.
+	 */
+	hci_check_background_scan(hdev);
 }
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.4

