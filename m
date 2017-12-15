Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] client: Make scan:clear clear individual fields
Date: Fri, 15 Dec 2017 09:53:59 -0200
Message-Id: <20171215115400.21161-2-luiz.dentz@gmail.com>
In-Reply-To: <20171215115400.21161-1-luiz.dentz@gmail.com>
References: <20171215115400.21161-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reintroduces the option to clear individual fields which was
removed when redesining the commands which now read the fields when
no arguments are provided.
---
 client/main.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/client/main.c b/client/main.c
index 5f7ec0103..53e03f56f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1392,18 +1392,68 @@ static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void cmd_scan_filter_clear(int argc, char *argv[])
+static void filter_clear_uuids(void)
 {
-	/* set default values for all options */
-	filter.rssi = DISTANCE_VAL_INVALID;
-	filter.pathloss = DISTANCE_VAL_INVALID;
 	g_strfreev(filter.uuids);
 	filter.uuids = NULL;
 	filter.uuids_len = 0;
+}
+
+static void filter_clear_rssi(void)
+{
+	filter.rssi = DISTANCE_VAL_INVALID;
+}
+
+static void filter_clear_pathloss(void)
+{
+	filter.pathloss = DISTANCE_VAL_INVALID;
+}
+
+static void filter_clear_transport(void)
+{
 	g_free(filter.transport);
 	filter.transport = NULL;
+}
+
+static void filter_clear_duplicate(void)
+{
 	filter.duplicate = false;
+}
+
+static const struct filter_clear {
+	const char *name;
+	void (*clear) (void);
+} filter_clear[] = {
+	{ "uuids", filter_clear_uuids },
+	{ "rssi", filter_clear_rssi },
+	{ "pathloss", filter_clear_pathloss },
+	{ "transport", filter_clear_transport },
+	{ "duplicate-data", filter_clear_duplicate },
+	{}
+};
+
+static void cmd_scan_filter_clear(int argc, char *argv[])
+{
+	const struct filter_clear *fc;
+	bool all = false;
+
+	if (argc < 2 || !strlen(argv[1]))
+		all = true;
 
+	for (fc = filter_clear; fc && fc->name; fc++) {
+		if (all || !strcmp(fc->name, argv[1])) {
+			fc->clear();
+			if (!all)
+				goto done;
+		}
+	}
+
+	if (!all) {
+		bt_shell_printf("Invalid argument %s\n", argv[1]);
+		return;
+	}
+
+done:
 	if (check_default_ctrl() == FALSE)
 		return;
 
@@ -2256,7 +2306,8 @@ static const struct bt_shell_menu scan_menu = {
 	{ "duplicate-data", "[on/off]", cmd_scan_filter_duplicate_data,
 				"Set/Get duplicate data filter",
 				mode_generator },
-	{ "clear", NULL, cmd_scan_filter_clear,
+	{ "clear", "[uuids/rssi/pathloss/transport/duplicate-data]",
+				cmd_scan_filter_clear,
 				"Clears discovery filter." },
 	{ } },
 };
-- 
2.13.6

