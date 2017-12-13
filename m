Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] client: Rename set-filter-clear to clear
Date: Wed, 13 Dec 2017 10:36:54 -0200
Message-Id: <20171213123655.24277-8-luiz.dentz@gmail.com>
In-Reply-To: <20171213123655.24277-1-luiz.dentz@gmail.com>
References: <20171213123655.24277-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters.
---
 client/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 849033870..1617b7cb3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1404,7 +1404,7 @@ static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void cmd_set_scan_filter_clear(int argc, char *argv[])
+static void cmd_scan_filter_clear(int argc, char *argv[])
 {
 	/* set default values for all options */
 	filtered_scan_rssi = DISTANCE_VAL_INVALID;
@@ -2267,7 +2267,7 @@ static const struct bt_shell_menu scan_menu = {
 	{ "duplicate-data", "[on/off]", cmd_scan_filter_duplicate_data,
 				"Set/Get duplicate data filter",
 				mode_generator },
-	{ "set-filter-clear", NULL, cmd_set_scan_filter_clear,
+	{ "clear", NULL, cmd_scan_filter_clear,
 				"Clears discovery filter." },
 	{ } },
 };
-- 
2.13.6

