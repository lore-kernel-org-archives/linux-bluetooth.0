Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 2/4] Bluetooth: Add hci_do_le_scan() helper function
Date: Tue,  9 Aug 2011 19:52:38 -0300
Message-Id: <1312930360-30860-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
References: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a helper function in hci_core to perform LE scan.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   46 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1bc1c3a..8611e2e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -543,6 +543,8 @@ int hci_get_conn_list(void __user *arg);
 int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
+int hci_do_le_scan(struct hci_dev *hdev, int timeout, u8 type, u16 interval,
+								u16 window);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f9ed8c..dbca996 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2431,3 +2431,49 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+static int set_le_scan_param(struct hci_dev *hdev, u8 type, u16 interval,
+								u16 window)
+{
+	struct hci_cp_le_set_scan_param cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+	cp.interval = cpu_to_le16(interval);
+	cp.window = cpu_to_le16(window);
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+}
+
+static int le_scan(struct hci_dev *hdev, u8 enable)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+int hci_do_le_scan(struct hci_dev *hdev, int timeout, u8 type, u16 interval,
+								u16 window)
+{
+	int err;
+
+	BT_DBG("hdev %s", hdev->name);
+
+	if (test_bit(HCI_LE_SCAN, &hdev->flags))
+		return -EPERM;
+
+	err = set_le_scan_param(hdev, type, interval, window);
+	if (err < 0)
+		return err;
+
+	err = le_scan(hdev, 1);
+	if (err < 0)
+		return err;
+
+	mod_timer(&hdev->le_scan_timer, jiffies + msecs_to_jiffies(timeout));
+
+	return 0;
+}
-- 
1.7.5.2

