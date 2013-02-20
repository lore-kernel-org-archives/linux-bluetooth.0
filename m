Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [PATCH] tools: btmgmt: Fix return value to return request id
Date: Wed, 20 Feb 2013 17:26:34 +0100
Message-Id: <d8a09e5d342194afb476c780f800943bc2e2f210.1361377269.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

Commit 947a7477d2a2ab6a61e5a7de44fd5b7cd2ab8d9c introduced the method
send_cmd which returned the index of the adapter instead of the
request id. As a result no mgmt command could be sent to hci0, as 0
marks an invalid request id.
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 4650876..4c6665e 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -833,7 +833,7 @@ static unsigned int send_cmd(struct mgmt *mgmt, uint16_t op, uint16_t id,
 	if (send_id == 0)
 		g_free(data);
 
-	return id;
+	return send_id;
 }
 
 static void setting_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
-- 
1.7.11.7

