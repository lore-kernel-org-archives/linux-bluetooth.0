Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 4/5] client: Use existing function for parsing
 argument
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Message-ID: <42b4c048-887b-6b7c-1aac-d3a12c9d1911@jp.fujitsu.com>
Date: Mon, 25 Sep 2017 13:33:44 +0900
MIME-Version: 1.0
In-Reply-To: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/client/main.c b/client/main.c
index 91b728a..3dadd5b 100644
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

