Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Require SSP enabling before BR/EDR Secure Connections
Date: Thu, 22 Jan 2015 11:15:22 -0800
Message-Id: <1421954122-15727-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When BR/EDR is supported by a controller, then it is required to enable
Secure Simple Pairing first before enabling the Secure Connections
feature.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e86b8d9105e9..41e30055bae8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4758,6 +4758,11 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	    !test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				  MGMT_STATUS_REJECTED);
+
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_INVALID_PARAMS);
-- 
2.1.0

