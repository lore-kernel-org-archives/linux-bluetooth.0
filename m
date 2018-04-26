Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	bgodavar@codeaurora.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3 1/2] Bluetooth: Add __hci_cmd_send function
Date: Thu, 26 Apr 2018 13:13:26 +0200
Message-Id: <1524741207-19753-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This function allows to send a HCI command without expecting any
controller event/response in return. This is allowed for vendor-
specific commands only.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Only allow vendor-specific command to be unresponded
     Rename function to __hci_cmd_send
 v3: no change

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b619a19..893bbbb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1393,6 +1393,8 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout);
+int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
+		   const void *param);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..b0ee9ed 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3422,6 +3422,37 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 	return 0;
 }
 
+int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
+		   const void *param)
+{
+	struct sk_buff *skb;
+
+	if (hci_opcode_ogf(opcode) != 0x3f) {
+		/* A controller receiving a command shall respond with either
+		 * a Command Status Event or a Command Complete Event.
+		 * Therefore, all standard HCI commands must be sent via the
+		 * standard API, using hci_send_cmd or hci_cmd_sync helpers.
+		 * Some vendors do not comply with this rule for vendor-specific
+		 * commands and do not return any event. We want to support
+		 * unresponded commands for such cases only.
+		 */
+		bt_dev_err(hdev, "unresponded command not supported");
+		return -EINVAL;
+	}
+
+	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	if (!skb) {
+		bt_dev_err(hdev, "no memory for command (opcode 0x%4.4x)",
+			   opcode);
+		return -ENOMEM;
+	}
+
+	hci_send_frame(hdev, skb);
+
+	return 0;
+}
+EXPORT_SYMBOL(__hci_cmd_send);
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
2.7.4
