Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 2/6] core: Split check_config() function
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <be99c2ae-224d-b7b1-da22-2e5a78ca0e35@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:22:10 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Split to check_config() and check_options() that checks main.conf options.
---
 src/main.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/src/main.c b/src/main.c
index 578b262..7482706 100644
--- a/src/main.c
+++ b/src/main.c
@@ -90,6 +90,7 @@ static const char * const supported_options[] = {
 	"ControllerMode",
 	"MultiProfile",
 	"Privacy",
+	NULL
 };
 
 GKeyFile *btd_get_main_conf(void)
@@ -163,6 +164,34 @@ static bt_gatt_cache_t parse_gatt_cache(const char *cache)
 	}
 }
 
+static void check_options(GKeyFile *config, const char *group,
+						const char * const *options)
+{
+	char **keys;
+	int i;
+
+	keys = g_key_file_get_keys(config, group, NULL, NULL);
+
+	for (i = 0; keys != NULL && keys[i] != NULL; i++) {
+		bool found;
+		unsigned int j;
+
+		found = false;
+		for (j = 0; options != NULL && options[j] != NULL; j++) {
+			if (g_str_equal(keys[i], options[j])) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			warn("Unknown key %s for group %s in main.conf",
+							keys[i], group);
+	}
+
+	g_strfreev(keys);
+}
+
 static void check_config(GKeyFile *config)
 {
 	const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
@@ -191,26 +220,7 @@ static void check_config(GKeyFile *config)
 
 	g_strfreev(keys);
 
-	keys = g_key_file_get_keys(config, "General", NULL, NULL);
-
-	for (i = 0; keys != NULL && keys[i] != NULL; i++) {
-		bool found;
-		unsigned int j;
-
-		found = false;
-		for (j = 0; j < G_N_ELEMENTS(supported_options); j++) {
-			if (g_str_equal(keys[i], supported_options[j])) {
-				found = true;
-				break;
-			}
-		}
-
-		if (!found)
-			warn("Unknown key %s for group %s in main.conf",
-							keys[i], "General");
-	}
-
-	g_strfreev(keys);
+	check_options(config, "General", supported_options);
 }
 
 static int get_mode(const char *str)
-- 
2.7.4


