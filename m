Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org, broonie@kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: Add hci_cmd_sync
Date: Tue, 29 Sep 2015 15:05:44 +0200
Message-Id: <1443531945-31344-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send a HCI command and wait for command complete event.
This function serializes the requests by grabbing the req_lock.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v1: v2: no patch 1/2
 v3: Add hci_cmd_sync function, used by regmap-ibt

 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 256e673..61dc786 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1349,6 +1349,9 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
+struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
+			     const void *param, u32 timeout);
+
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7cdd99..7935646 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3580,6 +3580,25 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
 }
 
+/* Send HCI command and wait for command commplete event */
+struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
+			     const void *param, u32 timeout)
+{
+	struct sk_buff *skb;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return ERR_PTR(-ENETDOWN);
+
+	bt_dev_dbg(hdev, "opcode 0x%4.4x plen %d", opcode, plen);
+
+	hci_req_lock(hdev);
+	skb = __hci_cmd_sync(hdev, opcode, plen, param, timeout);
+	hci_req_unlock(hdev);
+
+	return skb;
+}
+EXPORT_SYMBOL(hci_cmd_sync);
+
 /* Send ACL data */
 static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 {
-- 
1.9.1

