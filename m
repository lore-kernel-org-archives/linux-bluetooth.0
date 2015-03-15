Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Add support for trust verification of management commands
Date: Sat, 14 Mar 2015 18:09:52 -0700
Message-Id: <1426381792-31788-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check the required trust level of each management command with the trust
level of the management socket. If it does not match up, then return the
newly introduced permission denied error.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2534bd4d22b2..f3baad589db0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -44,6 +44,7 @@
 #define MGMT_STATUS_INVALID_INDEX	0x11
 #define MGMT_STATUS_RFKILLED		0x12
 #define MGMT_STATUS_ALREADY_PAIRED	0x13
+#define MGMT_STATUS_PERMISSION_DENIED	0x14
 
 struct mgmt_hdr {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8d67704d6116..fe2dc753787f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6379,6 +6379,13 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 
 	handler = &chan->handlers[opcode];
 
+	if (!hci_sock_test_flag(sk, HCI_SOCK_TRUSTED) &&
+	    !(handler->flags & HCI_MGMT_UNTRUSTED)) {
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_PERMISSION_DENIED);
+		goto done;
+	}
+
 	if (index != MGMT_INDEX_NONE) {
 		hdev = hci_dev_get(index);
 		if (!hdev) {
-- 
2.1.0

