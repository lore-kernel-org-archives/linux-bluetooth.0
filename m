Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix encryption key size for peripheral role
Date: Wed, 31 Jul 2013 16:25:29 -0300
Message-Id: <1375298729-23513-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1375298729-23513-1-git-send-email-andre.guedes@openbossa.org>
References: <1375298729-23513-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the connection encryption key size information when
the host is playing the peripheral role. We should set conn->enc_key_
size in hci_le_ltk_request_evt, otherwise it is left uninitialized.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea993ab..bc56245 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3560,6 +3560,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	else
 		conn->pending_sec_level = BT_SECURITY_MEDIUM;
 
+	conn->enc_key_size = ltk->enc_size;
+
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
 	if (ltk->type & HCI_SMP_STK) {
-- 
1.8.3.4

