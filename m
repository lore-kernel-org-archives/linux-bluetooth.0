Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix two minor style issues in management code
Date: Wed, 22 Feb 2012 11:59:01 +0100
Message-Id: <1329908341-30603-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

WARNING: Statements terminations use 1 semicolon
+	return err;;

WARNING: space prohibited between function name and open parenthesis '('
+		err = cmd_status (sk, index, MGMT_OP_CONFIRM_NAME,

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e8f890d..bf074d8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -264,7 +264,7 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 	if (err < 0)
 		kfree_skb(skb);
 
-	return err;;
+	return err;
 }
 
 static int read_version(struct sock *sk)
@@ -2507,7 +2507,7 @@ static int confirm_name(struct sock *sk, u16 index, void *data, u16 len)
 
 	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->addr.bdaddr);
 	if (!e) {
-		err = cmd_status (sk, index, MGMT_OP_CONFIRM_NAME,
+		err = cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
 				MGMT_STATUS_INVALID_PARAMS);
 		goto failed;
 	}
-- 
1.7.7.6

