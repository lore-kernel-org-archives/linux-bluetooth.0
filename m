Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/gatt: Fix typo in request_create check
Date: Tue, 13 Jan 2015 11:32:08 +0200
Message-Id: <1421141528-32053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes typo, check for req instead of client.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2c14c3a..42dc504 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1895,7 +1895,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 		return 0;
 
 	req = request_create(client);
-	if (!client) {
+	if (!req) {
 		free(op);
 		return 0;
 	}
-- 
2.1.0

