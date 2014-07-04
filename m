Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Allow reading configuration info when unconfigured
Date: Fri,  4 Jul 2014 16:54:40 +0200
Message-Id: <1404485680-1682-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reading the controller configuration information is a valid management
command when the controller is unconfigured. Allow this command, but
return invalid index on all other commands.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c7e5d4651021..766411e11ac7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5455,12 +5455,18 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 
 		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-		    test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
+
+		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
+		    opcode != MGMT_OP_READ_CONFIG_INFO) {
+			err = cmd_status(sk, index, opcode,
+					 MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
 	}
 
 	if (opcode >= ARRAY_SIZE(mgmt_handlers) ||
-- 
1.9.3

