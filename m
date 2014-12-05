Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Bluetooth: Store parameter length with pending mgmt commands
Date: Fri,  5 Dec 2014 13:36:01 +0200
Message-Id: <1417779369-6428-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation for making generic cmd_complete responses possible we'll
need to track the parameter length in addition to just a pointer to
them. This patch adds the necessary variable to the pending_cmd struct.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98537b07b720..56c7838c0a41 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -135,6 +135,7 @@ struct pending_cmd {
 	u16 opcode;
 	int index;
 	void *param;
+	size_t param_len;
 	struct sock *sk;
 	void *user_data;
 	void (*cmd_complete)(struct pending_cmd *cmd, u8 status);
@@ -1205,14 +1206,13 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	cmd->opcode = opcode;
 	cmd->index = hdev->id;
 
-	cmd->param = kmalloc(len, GFP_KERNEL);
+	cmd->param = kmemdup(data, len, GFP_KERNEL);
 	if (!cmd->param) {
 		kfree(cmd);
 		return NULL;
 	}
 
-	if (data)
-		memcpy(cmd->param, data, len);
+	cmd->param_len = len;
 
 	cmd->sk = sk;
 	sock_hold(sk);
-- 
2.1.0

