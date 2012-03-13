Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: trivial: Remove sparse warnings
Date: Tue, 13 Mar 2012 10:18:35 +0200
Message-Id: <1331626715-23685-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix sparse warnings related to incorrect type in assignment and static symbol.
Also use const keyword. Warnings are shown below:

...
net/bluetooth/mgmt.c:305:28: warning: incorrect type in assignment
(different base types)
net/bluetooth/mgmt.c:305:28:    expected unsigned short [usertype] *opcode
net/bluetooth/mgmt.c:305:28:    got restricted __le16 *<noident>
...
net/bluetooth/mgmt.c:2609:3: warning: symbol 'mgmt_handlers' was not declared.
Should it be static?
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 06b5df3..23f20ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -287,7 +287,7 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_rp_read_commands *rp;
 	u16 num_commands = ARRAY_SIZE(mgmt_commands);
 	u16 num_events = ARRAY_SIZE(mgmt_events);
-	u16 *opcode;
+	__le16 *opcode;
 	size_t rp_size;
 	int i, err;
 
@@ -2601,7 +2601,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
-struct mgmt_handler {
+static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
 	bool var_len;
@@ -2657,7 +2657,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
 	struct hci_dev *hdev = NULL;
-	struct mgmt_handler *handler;
+	const struct mgmt_handler *handler;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
-- 
1.7.9.1

