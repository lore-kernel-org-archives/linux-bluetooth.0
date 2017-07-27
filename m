Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 6/6] core: Make easier to manage checked groups
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <eef350d9-d7dc-019a-7ab6-bc1d8ff7379d@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:24:04 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes easier to manage groups which need to be checked for.
---
 src/main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/main.c b/src/main.c
index 2d00478..f33c64d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -106,6 +106,17 @@ static const char * const gatt_options[] = {
 	NULL
 };
 
+static const struct group_table {
+	const char *name;
+	const char * const *options;
+} valid_groups[] = {
+	{ "General",	supported_options },
+	{ "Policy",	policy_options },
+	{ "GATT",	gatt_options },
+	{ }
+};
+
+
 GKeyFile *btd_get_main_conf(void)
 {
 	return main_conf;
@@ -207,9 +218,9 @@ static void check_options(GKeyFile *config, const char *group,
 
 static void check_config(GKeyFile *config)
 {
-	const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
 	char **keys;
 	int i;
+	const struct group_table *group;
 
 	if (!config)
 		return;
@@ -217,11 +228,10 @@ static void check_config(GKeyFile *config)
 	keys = g_key_file_get_groups(config, NULL);
 
 	for (i = 0; keys != NULL && keys[i] != NULL; i++) {
-		const char **group;
 		bool match = false;
 
-		for (group = valid_groups; *group; group++) {
-			if (g_str_equal(keys[i], *group)) {
+		for (group = valid_groups; group && group->name ; group++) {
+			if (g_str_equal(keys[i], group->name)) {
 				match = true;
 				break;
 			}
@@ -233,9 +243,8 @@ static void check_config(GKeyFile *config)
 
 	g_strfreev(keys);
 
-	check_options(config, "General", supported_options);
-	check_options(config, "Policy", policy_options);
-	check_options(config, "GATT", gatt_options);
+	for (group = valid_groups; group && group->name; group++)
+		check_options(config, group->name, group->options);
 }
 
 static int get_mode(const char *str)
-- 
2.7.4


