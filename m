Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Add new error code for invalid index
Date: Thu,  1 Mar 2012 17:15:00 -0800
Message-Id: <1330650900-11420-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
References: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The index is part of the command header and not its parameters so it
makes sense to distinguish this from the invalid parameters error.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    1 +
 net/bluetooth/mgmt.c         |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d33457d..0ca3519 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -41,6 +41,7 @@
 #define MGMT_STATUS_DISCONNECTED	0x0e
 #define MGMT_STATUS_NOT_POWERED		0x0f
 #define MGMT_STATUS_CANCELLED		0x10
+#define MGMT_STATUS_INVALID_INDEX	0x11
 
 struct mgmt_hdr {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd01e4a..fa9a589 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2682,7 +2682,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		hdev = hci_dev_get(index);
 		if (!hdev) {
 			err = cmd_status(sk, index, opcode,
-					MGMT_STATUS_INVALID_PARAMS);
+					MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 	}
@@ -2698,7 +2698,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	if ((hdev && opcode < MGMT_OP_READ_INFO) ||
 			(!hdev && opcode >= MGMT_OP_READ_INFO)) {
 		err = cmd_status(sk, index, opcode,
-						MGMT_STATUS_INVALID_PARAMS);
+						MGMT_STATUS_INVALID_INDEX);
 		goto done;
 	}
 
@@ -2745,7 +2745,7 @@ int mgmt_index_added(struct hci_dev *hdev)
 
 int mgmt_index_removed(struct hci_dev *hdev)
 {
-	u8 status = MGMT_STATUS_INVALID_PARAMS;
+	u8 status = MGMT_STATUS_INVALID_INDEX;
 
 	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
-- 
1.7.9.1

