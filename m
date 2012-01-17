Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange messages
Date: Mon, 16 Jan 2012 21:14:54 -0300
Message-Id: <1326759294-1934-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <20120113204027.GA13470@samus>
References: <20120113204027.GA13470@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This defines two new messages, one event that will inform
userspace that a new Long Term Key was exchanged and one that
will allow userspace to load LTKs into the kernel.

Besides the information necessary for the restablishement of
the secure link, we added some extra information: "authenticated"
that informs if the key can be used to establish an authenticated
link, and "master" that informs the role in that the key should
be used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index be65d34..c0bff97 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -288,6 +288,22 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct mgmt_ltk_info {
+	struct mgmt_addr_info addr;
+	__u8 authenticated;
+	__u8 master;
+	__u8 enc_size;
+	__le16 ediv;
+	__u8 rand[8];
+	__u8 val[16];
+} __packed;
+
+#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0026
+struct mgmt_cp_load_long_term_keys {
+	__le16 key_count;
+	struct mgmt_ltk_info keys[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -388,3 +404,9 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_NEW_LONG_TERM_KEY	0x0016
+struct mgmt_ev_new_long_term_key {
+	__u8 store_hint;
+	struct mgmt_ltk_info key;
+} __packed;
-- 
1.7.8.1

