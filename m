Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7 v2] Bluetooth: Move mgmt_set_fast_connectable to the right location
Date: Thu, 15 Dec 2011 00:47:36 +0200
Message-Id: <1323902861-15990-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1323902861-15990-1-git-send-email-johan.hedberg@gmail.com>
References: <1323902861-15990-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Fast connectable is logically after the connectable property so that's
where it should show up in the code as well (it's also after connectable
in the settings bitfield).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |    7 ++-----
 net/bluetooth/mgmt.c         |   12 ++++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 85e9c6e..bf217cc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -100,6 +100,8 @@ struct mgmt_cp_set_discoverable {
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
 
+#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
+
 #define MGMT_OP_SET_PAIRABLE		0x0008
 
 #define MGMT_OP_ADD_UUID		0x0009
@@ -255,11 +257,6 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
-struct mgmt_cp_set_fast_connectable {
-	__u8 enable;
-} __packed;
-
 #define MGMT_OP_USER_PASSKEY_REPLY	0x0020
 struct mgmt_cp_user_passkey_reply {
 	bdaddr_t bdaddr;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 629570c..54092c2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2052,7 +2052,7 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 					unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_set_fast_connectable *cp = (void *) data;
+	struct mgmt_mode *cp = (void *) data;
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 	int err;
@@ -2070,7 +2070,7 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 
 	hci_dev_lock(hdev);
 
-	if (cp->enable) {
+	if (cp->val) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
 		acp.interval = 0x0024;	/* 22.5 msec page scan interval */
 	} else {
@@ -2154,6 +2154,10 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_CONNECTABLE:
 		err = set_connectable(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_FAST_CONNECTABLE:
+		err = set_fast_connectable(sk, index, buf + sizeof(*hdr),
+								len);
+		break;
 	case MGMT_OP_SET_PAIRABLE:
 		err = set_pairable(sk, index, buf + sizeof(*hdr), len);
 		break;
@@ -2232,10 +2236,6 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
-	case MGMT_OP_SET_FAST_CONNECTABLE:
-		err = set_fast_connectable(sk, index, buf + sizeof(*hdr),
-								len);
-		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
-- 
1.7.7.3

