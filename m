Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Filter list of supported commands/events for untrusted users
Date: Tue, 24 Mar 2015 17:31:03 -0700
Message-Id: <1427243463-13987-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the user of the management interface is not trusted, then it only
has access to a limited set of commands and events. When providing the
list of supported commands and events take the trusted vs untrusted
status of the user into account and return different lists.

This way the untrusted user knows exactly which commands it can
execute and which events it can receive. So no guesswork needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index eda52397a648..38b03bd14723 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -141,6 +141,27 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADVERTISING_REMOVED,
 };
 
+static const u16 mgmt_untrusted_commands[] = {
+	MGMT_OP_READ_INDEX_LIST,
+	MGMT_OP_READ_INFO,
+	MGMT_OP_READ_UNCONF_INDEX_LIST,
+	MGMT_OP_READ_CONFIG_INFO,
+	MGMT_OP_READ_EXT_INDEX_LIST,
+};
+
+static const u16 mgmt_untrusted_events[] = {
+	MGMT_EV_INDEX_ADDED,
+	MGMT_EV_INDEX_REMOVED,
+	MGMT_EV_NEW_SETTINGS,
+	MGMT_EV_CLASS_OF_DEV_CHANGED,
+	MGMT_EV_LOCAL_NAME_CHANGED,
+	MGMT_EV_UNCONF_INDEX_ADDED,
+	MGMT_EV_UNCONF_INDEX_REMOVED,
+	MGMT_EV_NEW_CONFIG_OPTIONS,
+	MGMT_EV_EXT_INDEX_ADDED,
+	MGMT_EV_EXT_INDEX_REMOVED,
+};
+
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
@@ -265,14 +286,20 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 data_len)
 {
 	struct mgmt_rp_read_commands *rp;
-	const u16 num_commands = ARRAY_SIZE(mgmt_commands);
-	const u16 num_events = ARRAY_SIZE(mgmt_events);
-	__le16 *opcode;
+	u16 num_commands, num_events;
 	size_t rp_size;
 	int i, err;
 
 	BT_DBG("sock %p", sk);
 
+	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
+		num_commands = ARRAY_SIZE(mgmt_commands);
+		num_events = ARRAY_SIZE(mgmt_events);
+	} else {
+		num_commands = ARRAY_SIZE(mgmt_untrusted_commands);
+		num_events = ARRAY_SIZE(mgmt_untrusted_events);
+	}
+
 	rp_size = sizeof(*rp) + ((num_commands + num_events) * sizeof(u16));
 
 	rp = kmalloc(rp_size, GFP_KERNEL);
@@ -282,11 +309,23 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp->num_commands = cpu_to_le16(num_commands);
 	rp->num_events = cpu_to_le16(num_events);
 
-	for (i = 0, opcode = rp->opcodes; i < num_commands; i++, opcode++)
-		put_unaligned_le16(mgmt_commands[i], opcode);
+	if (hci_sock_test_flag(sk, HCI_SOCK_TRUSTED)) {
+		__le16 *opcode = rp->opcodes;
+
+		for (i = 0; i < num_commands; i++, opcode++)
+			put_unaligned_le16(mgmt_commands[i], opcode);
+
+		for (i = 0; i < num_events; i++, opcode++)
+			put_unaligned_le16(mgmt_events[i], opcode);
+	} else {
+		__le16 *opcode = rp->opcodes;
+
+		for (i = 0; i < num_commands; i++, opcode++)
+			put_unaligned_le16(mgmt_untrusted_commands[i], opcode);
 
-	for (i = 0; i < num_events; i++, opcode++)
-		put_unaligned_le16(mgmt_events[i], opcode);
+		for (i = 0; i < num_events; i++, opcode++)
+			put_unaligned_le16(mgmt_untrusted_events[i], opcode);
+	}
 
 	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0,
 				rp, rp_size);
-- 
2.1.0

