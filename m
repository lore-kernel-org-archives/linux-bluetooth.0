Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 2/3] Bluetooth: Use GFP_KERNEL in mgmt_pending_add
Date: Thu,  7 Jun 2012 19:05:45 -0300
Message-Id: <1339106746-22886-2-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1339106746-22886-1-git-send-email-aguedespe@gmail.com>
References: <1339106746-22886-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are allowed to sleep in mgmt_pending_add, so we should use
GFP_KERNEL for memory allocations instead of GFP_ATOMIC.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8c7a6f9..9a56b64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -687,14 +687,14 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 {
 	struct pending_cmd *cmd;
 
-	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
 	if (!cmd)
 		return NULL;
 
 	cmd->opcode = opcode;
 	cmd->index = hdev->id;
 
-	cmd->param = kmalloc(len, GFP_ATOMIC);
+	cmd->param = kmalloc(len, GFP_KERNEL);
 	if (!cmd->param) {
 		kfree(cmd);
 		return NULL;
-- 
1.7.10.3

