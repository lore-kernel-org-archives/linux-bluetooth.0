Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Check req->error flag in hci_req_add
Date: Wed,  6 Mar 2013 20:45:17 -0300
Message-Id: <1362613517-1761-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
References: <1362613517-1761-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If req->error is set, there is no point in queueing the HCI command
in HCI request command queue since it won't be sent anyway.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 64fa390..e2fdc59 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2540,6 +2540,13 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param)
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
+	/*
+	 * If HCI request error flag is set, there is no point in queueing the
+	 * HCI command. We can simply return.
+	 */
+	if (req->error)
+		return;
+
 	skb = hci_prepare_cmd(hdev, opcode, plen, param);
 	if (!skb) {
 		BT_ERR("%s no memory for command", hdev->name);
-- 
1.8.1.2

