Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 2/9] Bluetooth: Add MGMT opcodes for Passkey Entry
Date: Tue, 15 Nov 2011 16:32:46 -0800
Message-Id: <1321403573-7143-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321403573-7143-1-git-send-email-bgix@codeaurora.org>
References: <1321403573-7143-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8b07a83..3d58d7c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -233,6 +233,17 @@ struct mgmt_cp_set_fast_connectable {
 	__u8 enable;
 } __packed;
 
+#define MGMT_OP_USER_PASSKEY_REPLY	0x0020
+struct mgmt_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__le32 passkey;
+} __packed;
+
+#define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x0021
+struct mgmt_cp_user_passkey_neg_reply {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -327,3 +338,8 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_USER_PASSKEY_REQUEST	0x0017
+struct mgmt_ev_user_passkey_request {
+	bdaddr_t bdaddr;
+} __packed;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
