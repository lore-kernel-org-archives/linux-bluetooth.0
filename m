Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 4/6] client: Use existing function for parsing argument
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Message-ID: <7bd8e641-d090-d452-c9cc-cf0b7e6dc5f6@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:20:16 +0900
MIME-Version: 1.0
In-Reply-To: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/client/main.c b/client/main.c
index 2cb449f..7b24633 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2368,22 +2368,12 @@ static void cmd_set_advertise_manufacturer(const char *arg)
 
 static void cmd_set_advertise_tx_power(const char *arg)
 {
-	if (arg == NULL || strlen(arg) == 0) {
-		rl_printf("Missing on/off argument\n");
-		return;
-	}
-
-	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_tx_power(dbus_conn, true);
-		return;
-	}
+	dbus_bool_t powered;
 
-	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_tx_power(dbus_conn, false);
+	if (parse_argument_on_off(arg, &powered) == FALSE)
 		return;
-	}
 
-	rl_printf("Invalid argument\n");
+	ad_advertise_tx_power(dbus_conn, powered);
 }
 
 static void cmd_set_advertise_name(const char *arg)
-- 
2.7.4

