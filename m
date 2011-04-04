Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use GFP_KERNEL in user context
Date: Mon,  4 Apr 2011 19:08:02 -0300
Message-Id: <1301954883-13326-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some of the allocations in the mgmt code are in user context, so it's no
recommended the use of GFP_ATOMIC there.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/mgmt.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9a61320..bab8b58 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -133,7 +133,7 @@ static int read_index_list(struct sock *sk)
 	}
 
 	rp_len = sizeof(*rp) + (2 * count);
-	rp = kmalloc(rp_len, GFP_ATOMIC);
+	rp = kmalloc(rp_len, GFP_KERNEL);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
@@ -226,14 +226,14 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 {
 	struct pending_cmd *cmd;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return NULL;
 
 	cmd->opcode = opcode;
 	cmd->index = index;
 
-	cmd->param = kmalloc(len, GFP_ATOMIC);
+	cmd->param = kmalloc(len, GFP_KERNEL);
 	if (!cmd->param) {
 		kfree(cmd);
 		return NULL;
@@ -741,7 +741,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	hci_dev_lock_bh(hdev);
 
-	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
+	uuid = kmalloc(sizeof(*uuid), GFP_KERNEL);
 	if (!uuid) {
 		err = -ENOMEM;
 		goto failed;
@@ -1081,7 +1081,7 @@ static int get_connections(struct sock *sk, u16 index)
 	}
 
 	rp_len = sizeof(*rp) + (count * sizeof(bdaddr_t));
-	rp = kmalloc(rp_len, GFP_ATOMIC);
+	rp = kmalloc(rp_len, GFP_KERNEL);
 	if (!rp) {
 		err = -ENOMEM;
 		goto unlock;
@@ -1581,7 +1581,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	if (msglen < sizeof(*hdr))
 		return -EINVAL;
 
-	buf = kmalloc(msglen, GFP_ATOMIC);
+	buf = kmalloc(msglen, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-- 
1.7.4.1

