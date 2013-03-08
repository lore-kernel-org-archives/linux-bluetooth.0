Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] Bluetooth: Check req->err in hci_req_add
Date: Fri,  8 Mar 2013 11:20:18 -0300
Message-Id: <1362752418-8688-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
References: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If req->err is set, there is no point in queueing the HCI command
in HCI request command queue since it won't be sent anyway.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f14c41f..a49c445 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2536,6 +2536,12 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
+	/* If an error occured during request building, there is no point in
+	 * queueing the HCI command. We can simply return.
+	 */
+	if (req->err)
+		return;
+
 	skb = hci_prepare_cmd(hdev, opcode, plen, param);
 	if (!skb) {
 		BT_ERR("%s no memory for command (opcode 0x%4.4x)",
-- 
1.8.1.2

