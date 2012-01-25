Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH v3 2/6] Bluetooth: Add helper functions to send LE scan commands
Date: Wed, 25 Jan 2012 19:52:25 -0300
Message-Id: <1327531949-29463-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates two helper functions to send LE Set Scan
Parameters and LE Set Scan Enable commands.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fd22035..4830995 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -89,6 +89,29 @@ static void hci_notify(struct hci_dev *hdev, int event)
 	atomic_notifier_call_chain(&hci_notifier, event, hdev);
 }
 
+static int send_le_scan_param_cmd(struct hci_dev *hdev, u8 type, u16 interval,
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
+static int send_le_scan_enable_cmd(struct hci_dev *hdev, u8 enable)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
 /* ---- HCI requests ---- */
 
 void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
-- 
1.7.8.4
