Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 06/15] Bluetooth: Background scanning
Date: Wed, 16 Oct 2013 20:17:56 -0300
Message-Id: <1381965485-9159-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds helpers to trigger and untrigger the background
scanning. As long as the number of triggers are greater than zero,
we keep the background scanning running. Once the number of triggers
reaches zero, it is stopped.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  7 ++++
 net/bluetooth/hci_core.c         | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1e67da5..cb6458a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -288,6 +288,10 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
+	/* This counter tracks the number of background scanning triggers
+	 */
+	atomic_t		background_scan_cnt;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
@@ -1191,4 +1195,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+int hci_trigger_background_scan(struct hci_dev *hdev);
+int hci_untrigger_background_scan(struct hci_dev *hdev);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c9c3390..c3e47e9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2402,6 +2402,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
+	atomic_set(&hdev->background_scan_cnt, 0);
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
@@ -3786,3 +3788,84 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
+
+static void start_background_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status)
+		BT_DBG("HCI request failed to start background scanning: "
+		       "status 0x%2.2x", status);
+}
+
+int hci_trigger_background_scan(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_request req;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/* If we already have triggers, there is no need to send HCI command
+	 * to start the background scanning.
+	 */
+	if (atomic_read(&hdev->background_scan_cnt) > 0)
+		goto done;
+
+	hci_req_init(&req, hdev);
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.type = LE_SCAN_PASSIVE;
+	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
+	param_cp.window = cpu_to_le16(hdev->le_scan_window);
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+
+	err = hci_req_run(&req, start_background_scan_complete);
+	if (err)
+		return err;
+
+done:
+	atomic_inc(&hdev->background_scan_cnt);
+	return 0;
+}
+
+static void stop_background_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status)
+		BT_DBG("HCI request failed to stop background scanning: "
+		       "status 0x%2.2x", status);
+}
+
+int hci_untrigger_background_scan(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_enable cp;
+	struct hci_request req;
+	int err;
+
+	/* If we have more triggers, we should keep scanning. */
+	if (atomic_read(&hdev->background_scan_cnt) > 1)
+		goto done;
+
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		goto done;
+
+	hci_req_init(&req, hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	err = hci_req_run(&req, stop_background_scan_complete);
+	if (err)
+		return err;
+
+done:
+	atomic_dec(&hdev->background_scan_cnt);
+	return 0;
+}
-- 
1.8.4

