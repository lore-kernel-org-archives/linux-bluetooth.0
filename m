Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Robert=20Luba=C5=9B?= <robert.lubas@silvair.com>
Subject: [PATCH BlueZ 2/2] Mesh: Fix in Config GATT Proxy Set
Date: Mon,  2 Apr 2018 21:29:20 +0200
Message-Id: <20180402192920.19111-2-robert.lubas@silvair.com>
In-Reply-To: <20180402192920.19111-1-robert.lubas@silvair.com>
References: <20180402192920.19111-1-robert.lubas@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the 4.3.2.10 Config GATT Proxy Set, message should have only 1
byte.
---
 mesh/config-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 4e5e06258..801bbf710 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -787,7 +787,7 @@ static void cmd_ident_get(int argc, char *argv[])
 static void cmd_proxy_set(int argc, char *argv[])
 {
 	uint16_t n;
-	uint8_t msg[2 + 1 + 4];
+	uint8_t msg[2 + 1];
 	int parm_cnt;
 
 	if (!verify_config_target(target))
@@ -802,7 +802,6 @@ static void cmd_proxy_set(int argc, char *argv[])
 	}
 
 	msg[n++] = parms[0];
-	msg[n++] = parms[1];
 
 	if (!config_send(msg, n)) {
 		bt_shell_printf("Failed to send \"SET PROXY\"\n");
-- 
2.11.0

