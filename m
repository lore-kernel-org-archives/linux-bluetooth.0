Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 5/5] client: Use new parse_argument() instead of
 parse_argument_XX()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Message-ID: <2df9c1f7-2851-4d6c-79e0-5bb136f619ce@jp.fujitsu.com>
Date: Mon, 25 Sep 2017 13:34:04 +0900
MIME-Version: 1.0
In-Reply-To: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 93 +++++++++++++++--------------------------------------------
 1 file changed, 23 insertions(+), 70 deletions(-)

diff --git a/client/main.c b/client/main.c
index 3dadd5b..2584408 100644
--- a/client/main.c
+++ b/client/main.c
@@ -845,15 +845,24 @@ static gboolean check_default_ctrl(void)
 	return TRUE;
 }
 
-static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
+static gboolean parse_argument(const char *arg, const char * const *arg_table,
+					const char *msg, dbus_bool_t *value,
+					const char **option)
 {
+	const char * const *opt;
+
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing on/off argument\n");
+		if (msg)
+			rl_printf("Missing on/off/%s argument\n", msg);
+		else
+			rl_printf("Missing on/off argument\n");
 		return FALSE;
 	}
 
 	if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
 		*value = TRUE;
+		if (option)
+			*option = "";
 		return TRUE;
 	}
 
@@ -862,35 +871,10 @@ static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
 		return TRUE;
 	}
 
-	rl_printf("Invalid argument %s\n", arg);
-	return FALSE;
-}
-
-static gboolean parse_argument_agent(const char *arg, dbus_bool_t *value,
-							const char **capability)
-{
-	const char * const *opt;
-
-	if (arg == NULL || strlen(arg) == 0) {
-		rl_printf("Missing on/off/capability argument\n");
-		return FALSE;
-	}
-
-	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		*value = TRUE;
-		*capability = "";
-		return TRUE;
-	}
-
-	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		*value = FALSE;
-		return TRUE;
-	}
-
-	for (opt = agent_arguments; *opt; opt++) {
+	for (opt = arg_table; opt && *opt; opt++) {
 		if (strcmp(arg, *opt) == 0) {
 			*value = TRUE;
-			*capability = *opt;
+			*option = *opt;
 			return TRUE;
 		}
 	}
@@ -1061,7 +1045,7 @@ static void cmd_power(const char *arg)
 	dbus_bool_t powered;
 	char *str;
 
-	if (parse_argument_on_off(arg, &powered) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &powered, NULL) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -1082,7 +1066,7 @@ static void cmd_pairable(const char *arg)
 	dbus_bool_t pairable;
 	char *str;
 
-	if (parse_argument_on_off(arg, &pairable) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &pairable, NULL) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -1103,7 +1087,7 @@ static void cmd_discoverable(const char *arg)
 	dbus_bool_t discoverable;
 	char *str;
 
-	if (parse_argument_on_off(arg, &discoverable) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &discoverable, NULL) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -1125,7 +1109,8 @@ static void cmd_agent(const char *arg)
 	dbus_bool_t enable;
 	const char *capability;
 
-	if (parse_argument_agent(arg, &enable, &capability) == FALSE)
+	if (parse_argument(arg, agent_arguments, "capability",
+					&enable, &capability) == FALSE)
 		return;
 
 	if (enable == TRUE) {
@@ -1175,7 +1160,7 @@ static void cmd_scan(const char *arg)
 	dbus_bool_t enable;
 	const char *method;
 
-	if (parse_argument_on_off(arg, &enable) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &enable, NULL) == FALSE)
 		return;
 
 	if (check_default_ctrl() == FALSE)
@@ -2003,7 +1988,7 @@ static void cmd_notify(const char *arg)
 {
 	dbus_bool_t enable;
 
-	if (parse_argument_on_off(arg, &enable) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &enable, NULL) == FALSE)
 		return;
 
 	if (!default_attr) {
@@ -2294,45 +2279,13 @@ static char *capability_generator(const char *text, int state)
 	return argument_generator(text, state, agent_arguments);
 }
 
-static gboolean parse_argument_advertise(const char *arg, dbus_bool_t *value,
-							const char **type)
-{
-	const char * const *opt;
-
-	if (arg == NULL || strlen(arg) == 0) {
-		rl_printf("Missing on/off/type argument\n");
-		return FALSE;
-	}
-
-	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		*value = TRUE;
-		*type = "";
-		return TRUE;
-	}
-
-	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		*value = FALSE;
-		return TRUE;
-	}
-
-	for (opt = ad_arguments; *opt; opt++) {
-		if (strcmp(arg, *opt) == 0) {
-			*value = TRUE;
-			*type = *opt;
-			return TRUE;
-		}
-	}
-
-	rl_printf("Invalid argument %s\n", arg);
-	return FALSE;
-}
-
 static void cmd_advertise(const char *arg)
 {
 	dbus_bool_t enable;
 	const char *type;
 
-	if (parse_argument_advertise(arg, &enable, &type) == FALSE)
+	if (parse_argument(arg, ad_arguments, "type",
+					&enable, &type) == FALSE)
 		return;
 
 	if (!default_ctrl || !default_ctrl->ad_proxy) {
@@ -2370,7 +2323,7 @@ static void cmd_set_advertise_tx_power(const char *arg)
 {
 	dbus_bool_t powered;
 
-	if (parse_argument_on_off(arg, &powered) == FALSE)
+	if (parse_argument(arg, NULL, NULL, &powered, NULL) == FALSE)
 		return;
 
 	ad_advertise_tx_power(dbus_conn, powered);
-- 
2.7.4


