Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH] tools/btgatt-client: Fixed register-notify prompt
Date: Thu, 22 Dec 2016 10:25:55 +0100
Message-Id: <1482398755-9235-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using the register-notify command in btgatt-client, the prompt
would be broken :

[GATT client]# register-notify 0x005f
Registering notify handler with id: 2
[GATT client]# [GATT client]# Registered notify handler![GATT client]#

This commit fixes the prompt by using the correct printing function and
adding an extra '\n' :

[GATT client]# register-notify 0x005f
Registering notify handler with id: 2
[GATT client]# Registered notify handler
[GATT client]#
---
 tools/btgatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 4c8c9dd..40a03b1 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1114,7 +1114,7 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	PRLOG("Registered notify handler!");
+	PRLOG("Registered notify handler\n");
 }
 
 static void cmd_register_notify(struct client *cli, char *cmd_str)
@@ -1149,7 +1149,7 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	PRLOG("Registering notify handler with id: %u\n", id);
+	printf("Registering notify handler with id: %u\n", id);
 }
 
 static void unregister_notify_usage(void)
-- 
2.1.4

