Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/9] Bluetooth: Add HCI defines for User Passkey entry
Date: Sat, 12 Nov 2011 22:01:11 -0800
Message-Id: <1321164079-2216-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
References: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 139ce2a..e284dd9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -453,6 +453,14 @@ struct hci_rp_user_confirm_reply {
 
 #define HCI_OP_USER_CONFIRM_NEG_REPLY	0x042d
 
+#define HCI_OP_USER_PASSKEY_REPLY		0x042e
+struct hci_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__le32	passkey;
+} __packed;
+
+#define HCI_OP_USER_PASSKEY_NEG_REPLY	0x042f
+
 #define HCI_OP_REMOTE_OOB_DATA_REPLY	0x0430
 struct hci_cp_remote_oob_data_reply {
 	bdaddr_t bdaddr;
@@ -1076,6 +1084,11 @@ struct hci_ev_user_confirm_req {
 	__le32		passkey;
 } __packed;
 
+#define HCI_EV_USER_PASSKEY_REQUEST	0x34
+struct hci_ev_user_passkey_req {
+	bdaddr_t	bdaddr;
+} __packed;
+
 #define HCI_EV_REMOTE_OOB_DATA_REQUEST	0x35
 struct hci_ev_remote_oob_data_request {
 	bdaddr_t bdaddr;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
