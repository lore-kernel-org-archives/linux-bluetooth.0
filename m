Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 1/2] Bluetooth: Add __hci_cmd_sync_noev function
Date: Mon, 23 Apr 2018 19:59:39 +0200
Message-Id: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This function allows to send a HCI command without expecting any
controller event/response in return.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b619a19..d48a7df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1393,6 +1393,8 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout);
+int __hci_cmd_sync_noev(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..2831c4e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3459,6 +3459,23 @@ struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 EXPORT_SYMBOL(hci_cmd_sync);
 
+int __hci_cmd_sync_noev(struct hci_dev *hdev, u16 opcode, u32 plen,
+			const void *param)
+{
+	struct sk_buff *skb = hci_prepare_cmd(hdev, opcode, plen, param);
+
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
+EXPORT_SYMBOL(__hci_cmd_sync_noev);
+
 /* Send ACL data */
 static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 {
-- 
2.7.4
