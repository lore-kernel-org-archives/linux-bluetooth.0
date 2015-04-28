Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-client: Rename sec_level to security
Date: Tue, 28 Apr 2015 17:35:32 +0300
Message-Id: <1430231734-26699-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
References: <1430231734-26699-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-client.c | 5 ++---
 src/shared/gatt-client.h | 4 ++--
 tools/btgatt-client.c    | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 56bad60..7bc3b71 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2998,8 +2998,7 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	return true;
 }
 
-bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client,
-								int level)
+bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level)
 {
 	if (!client)
 		return false;
@@ -3007,7 +3006,7 @@ bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client,
 	return bt_att_set_security(client->att, level);
 }
 
-int bt_gatt_client_get_sec_level(struct bt_gatt_client *client)
+int bt_gatt_client_get_security(struct bt_gatt_client *client)
 {
 	if (!client)
 		return -1;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 980222c..befa43f 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -131,5 +131,5 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
 
-bool bt_gatt_client_set_sec_level(struct bt_gatt_client *client, int level);
-int bt_gatt_client_get_sec_level(struct bt_gatt_client *client);
+bool bt_gatt_client_set_security(struct bt_gatt_client *client, int level);
+int bt_gatt_client_get_security(struct bt_gatt_client *client);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index ee5315d..a49e16a 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1233,7 +1233,7 @@ static void cmd_set_sec_level(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	if (!bt_gatt_client_set_sec_level(cli->gatt, level))
+	if (!bt_gatt_client_set_security(cli->gatt, level))
 		printf("Could not set sec level\n");
 	else
 		printf("Setting security level %d success\n", level);
@@ -1248,7 +1248,7 @@ static void cmd_get_sec_level(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	level = bt_gatt_client_get_sec_level(cli->gatt);
+	level = bt_gatt_client_get_security(cli->gatt);
 	if (level < 0)
 		printf("Could not set sec level\n");
 	else
-- 
2.1.0

