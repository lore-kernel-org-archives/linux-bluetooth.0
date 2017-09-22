Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/6] client: Introduce parse_argument()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Message-ID: <718f3799-c500-93b1-7342-848ce39332e2@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:20:34 +0900
MIME-Version: 1.0
In-Reply-To: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/client/main.c b/client/main.c
index 7b24633..1c34269 100644
--- a/client/main.c
+++ b/client/main.c
@@ -845,6 +845,44 @@ static gboolean check_default_ctrl(void)
 	return TRUE;
 }
 
+static gboolean parse_argument(const char *arg, const char * const *arg_table,
+					const char *msg, dbus_bool_t *value,
+					const char **option)
+{
+	const char * const *opt;
+
+	if (!arg || !strlen(arg)) {
+		if (msg)
+			rl_printf("Missing on/off/%s argument\n", msg);
+		else
+			rl_printf("Missing on/off argument\n");
+		return FALSE;
+	}
+
+	if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
+		*value = TRUE;
+		if (option)
+			*option = "";
+		return TRUE;
+	}
+
+	if (!strcmp(arg, "off") || !strcmp(arg, "no")) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	for (opt = arg_table; opt && *opt; opt++) {
+		if (strcmp(arg, *opt) == 0) {
+			*value = TRUE;
+			*option = *opt;
+			return TRUE;
+		}
+	}
+
+	rl_printf("Invalid argument %s\n", arg);
+	return FALSE;
+}
+
 static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
 {
 	if (!arg || !strlen(arg)) {
-- 
2.7.4

