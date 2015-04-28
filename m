Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/att: Rename sec_level to security
Date: Tue, 28 Apr 2015 17:35:31 +0300
Message-Id: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/att.c         | 4 ++--
 src/shared/att.h         | 4 ++--
 src/shared/gatt-client.c | 6 +++---
 src/shared/gatt-server.c | 2 +-
 unit/test-gatt.c         | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index f24da18..c5eaa09 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1341,7 +1341,7 @@ bool bt_att_unregister_all(struct bt_att *att)
 	return true;
 }
 
-int bt_att_get_sec_level(struct bt_att *att)
+int bt_att_get_security(struct bt_att *att)
 {
 	struct bt_security sec;
 	socklen_t len;
@@ -1360,7 +1360,7 @@ int bt_att_get_sec_level(struct bt_att *att)
 	return sec.level;
 }
 
-bool bt_att_set_sec_level(struct bt_att *att, int level)
+bool bt_att_set_security(struct bt_att *att, int level)
 {
 	struct bt_security sec;
 
diff --git a/src/shared/att.h b/src/shared/att.h
index fb6247e..80810a1 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -83,8 +83,8 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
 
 bool bt_att_unregister_all(struct bt_att *att);
 
-int bt_att_get_sec_level(struct bt_att *att);
-bool bt_att_set_sec_level(struct bt_att *att, int level);
+int bt_att_get_security(struct bt_att *att);
+bool bt_att_set_security(struct bt_att *att, int level);
 
 bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7b628fe..56bad60 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2217,7 +2217,7 @@ unsigned int bt_gatt_client_write_without_response(
 
 	/* Only use signed write if unencrypted */
 	if (signed_write) {
-		security = bt_att_get_sec_level(client->att);
+		security = bt_att_get_security(client->att);
 		op = security > BT_SECURITY_LOW ?  BT_ATT_OP_WRITE_CMD :
 						BT_ATT_OP_SIGNED_WRITE_CMD;
 	} else
@@ -3004,7 +3004,7 @@ bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client,
 	if (!client)
 		return false;
 
-	return bt_att_set_sec_level(client->att, level);
+	return bt_att_set_security(client->att, level);
 }
 
 int bt_gatt_client_get_sec_level(struct bt_gatt_client *client)
@@ -3012,5 +3012,5 @@ int bt_gatt_client_get_sec_level(struct bt_gatt_client *client)
 	if (!client)
 		return -1;
 
-	return bt_att_get_sec_level(client->att);
+	return bt_att_get_security(client->att);
 }
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ae77dcc..6167065 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -395,7 +395,7 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 	if (!perm)
 		return 0;
 
-	security = bt_att_get_sec_level(server->att);
+	security = bt_att_get_security(server->att);
 	if (perm & BT_ATT_PERM_AUTHEN && security < BT_ATT_SECURITY_HIGH)
 		return BT_ATT_ERROR_AUTHENTICATION;
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index caaacbd..a7ea7cd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1002,7 +1002,7 @@ static void test_signed_write_seclevel(struct context *context)
 	g_assert(bt_att_set_local_key(context->att, key, local_counter,
 								context));
 
-	g_assert(bt_att_set_sec_level(context->att, BT_ATT_SECURITY_MEDIUM));
+	g_assert(bt_att_set_security(context->att, BT_ATT_SECURITY_MEDIUM));
 
 	g_assert(bt_gatt_client_write_without_response(context->client,
 							step->handle,
-- 
2.1.0

