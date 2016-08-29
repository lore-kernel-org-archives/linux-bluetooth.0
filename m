Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix wrong Get Clock Information return parameters
Date: Mon, 29 Aug 2016 06:19:47 +0200
Message-Id: <1472444387-129975-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address information of the Get Clock Information return parameters
is copying from a different memory location. It uses &cmd->param while
it actually needs to be cmd->param.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d84924b38262..7a7a8be3f2e4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4869,7 +4869,7 @@ static int clock_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
 	int err;
 
 	memset(&rp, 0, sizeof(rp));
-	memcpy(&rp.addr, &cmd->param, sizeof(rp.addr));
+	memcpy(&rp.addr, cmd->param, sizeof(rp.addr));
 
 	if (status)
 		goto complete;
-- 
2.7.4

