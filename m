Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] client: Use the common argument generator
Message-ID: <25fbc871-706b-d435-6c78-120d74ce3505@jp.fujitsu.com>
Date: Fri, 25 Aug 2017 17:28:19 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/client/main.c b/client/main.c
index 75696c2..34fcbd7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2234,7 +2234,8 @@ static char *attribute_generator(const char *text, int state)
 	return gatt_attribute_generator(text, state);
 }
 
-static char *capability_generator(const char *text, int state)
+static char *argument_generator(const char *text, int state,
+					const char * const *args_list)
 {
 	static int index, len;
 	const char *arg;
@@ -2244,7 +2245,7 @@ static char *capability_generator(const char *text, int state)
 		len = strlen(text);
 	}
 
-	while ((arg = agent_arguments[index])) {
+	while ((arg = args_list[index])) {
 		index++;
 
 		if (!strncmp(arg, text, len))
@@ -2254,6 +2255,11 @@ static char *capability_generator(const char *text, int state)
 	return NULL;
 }
 
+static char *capability_generator(const char *text, int state)
+{
+	return argument_generator(text, state, agent_arguments);
+}
+
 static gboolean parse_argument_advertise(const char *arg, dbus_bool_t *value,
 							const char **type)
 {
@@ -2308,22 +2314,7 @@ static void cmd_advertise(const char *arg)
 
 static char *ad_generator(const char *text, int state)
 {
-	static int index, len;
-	const char *arg;
-
-	if (!state) {
-		index = 0;
-		len = strlen(text);
-	}
-
-	while ((arg = ad_arguments[index])) {
-		index++;
-
-		if (!strncmp(arg, text, len))
-			return strdup(arg);
-	}
-
-	return NULL;
+	return argument_generator(text, state, ad_arguments);
 }
 
 static void cmd_set_advertise_uuids(const char *arg)
-- 
2.7.4

