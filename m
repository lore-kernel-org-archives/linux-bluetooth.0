Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/7] client: Introduce data_clear() calling ->clear()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <ba142fa4-c7ae-aded-93c8-169ac4121d62@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:29 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/client/main.c b/client/main.c
index 8fc76a6de..288ed032f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1405,10 +1405,12 @@ static void filter_clear_duplicate(void)
 	filter.duplicate = false;
 }
 
-static const struct filter_clear {
+struct clear_entry {
 	const char *name;
 	void (*clear) (void);
-} filter_clear[] = {
+};
+
+static const struct clear_entry filter_clear[] = {
 	{ "uuids", filter_clear_uuids },
 	{ "rssi", filter_clear_rssi },
 	{ "pathloss", filter_clear_pathloss },
@@ -1437,29 +1439,44 @@ static char *filter_clear_generator(const char *text, int state)
 	return NULL;
 }
 
-static void cmd_scan_filter_clear(int argc, char *argv[])
+static gboolean data_clear(const struct clear_entry *entry_table,
+							const char *name)
 {
-	const struct filter_clear *fc;
+	const struct clear_entry *entry;
 	bool all = false;
 
-	if (argc < 2 || !strlen(argv[1]))
+	if (!name || !strlen(name) || !strcmp("all", name))
 		all = true;
 
-	for (fc = filter_clear; fc && fc->name; fc++) {
-		if (all || !strcmp(fc->name, argv[1])) {
-			fc->clear();
-			filter.set = false;
+	for (entry = entry_table; entry && entry->name; entry++) {
+		if (all || !strcmp(entry->name, name)) {
+			entry->clear();
 			if (!all)
 				goto done;
 		}
 	}
 
 	if (!all) {
-		bt_shell_printf("Invalid argument %s\n", argv[1]);
-		return;
+		bt_shell_printf("Invalid argument %s\n", name);
+		return FALSE;
 	}
 
 done:
+	return TRUE;
+}
+
+static void cmd_scan_filter_clear(int argc, char *argv[])
+{
+	bool all = false;
+
+	if (argc < 2 || !strlen(argv[1]))
+		all = true;
+
+	if (!data_clear(filter_clear, all ? "all" : argv[1]))
+		return;
+
+	filter.set = false;
+
 	if (check_default_ctrl() == FALSE)
 		return;
 
-- 
2.14.1

