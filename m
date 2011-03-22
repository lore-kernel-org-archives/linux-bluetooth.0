Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v5 1/5] Bluetooth: Rename cmd to param in pending_cmd
Date: Tue, 22 Mar 2011 13:12:19 +0100
Message-ID: <1300795943-6681-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300795943-6681-1-git-send-email-szymon.janc@tieto.com>
References: <1300795943-6681-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This field holds not whole command but only command specific
parameters.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98988c8..657a02d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -36,7 +36,7 @@ struct pending_cmd {
 	struct list_head list;
 	__u16 opcode;
 	int index;
-	void *cmd;
+	void *param;
 	struct sock *sk;
 	void *user_data;
 };
@@ -217,7 +217,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 static void mgmt_pending_free(struct pending_cmd *cmd)
 {
 	sock_put(cmd->sk);
-	kfree(cmd->cmd);
+	kfree(cmd->param);
 	kfree(cmd);
 }
 
@@ -233,13 +233,13 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	cmd->opcode = opcode;
 	cmd->index = index;
 
-	cmd->cmd = kmalloc(len, GFP_ATOMIC);
-	if (!cmd->cmd) {
+	cmd->param = kmalloc(len, GFP_ATOMIC);
+	if (!cmd->param) {
 		kfree(cmd);
 		return NULL;
 	}
 
-	memcpy(cmd->cmd, data, len);
+	memcpy(cmd->param, data, len);
 
 	cmd->sk = sk;
 	sock_hold(sk);
@@ -1428,7 +1428,7 @@ struct cmd_lookup {
 
 static void mode_rsp(struct pending_cmd *cmd, void *data)
 {
-	struct mgmt_mode *cp = cmd->cmd;
+	struct mgmt_mode *cp = cmd->param;
 	struct cmd_lookup *match = data;
 
 	if (cp->val != match->val)
@@ -1527,7 +1527,7 @@ int mgmt_connected(u16 index, bdaddr_t *bdaddr)
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 {
-	struct mgmt_cp_disconnect *cp = cmd->cmd;
+	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct sock **sk = data;
 	struct mgmt_rp_disconnect rp;
 
-- 
1.7.0.4

