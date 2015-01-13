Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] shared/gatt-client: Fix callback type in struct write_op
Date: Tue, 13 Jan 2015 12:16:18 +0100
Message-Id: <1421147778-22432-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Callback type in struct write_op should be bt_gatt_client_callback_t as
that type is provided by user in bt_gatt_client_write_value()
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3042a6c..8acc752 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1975,7 +1975,7 @@ bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
 }
 
 struct write_op {
-	bt_gatt_result_callback_t callback;
+	bt_gatt_client_callback_t callback;
 	void *user_data;
 	bt_gatt_destroy_func_t destroy;
 };
-- 
1.8.4

