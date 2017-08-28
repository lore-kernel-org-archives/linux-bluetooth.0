Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] mesh: Use DuplicateData filter
Date: Mon, 28 Aug 2017 16:42:40 +0300
Message-Id: <20170828134240.18840-3-luiz.dentz@gmail.com>
In-Reply-To: <20170828134240.18840-1-luiz.dentz@gmail.com>
References: <20170828134240.18840-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Also use the term duplicate instead of reset to make it more clear
the intent of the filter.
---
 mesh/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index b06f4352a..96ac78544 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1575,7 +1575,7 @@ struct set_discovery_filter_args {
 	dbus_int16_t pathloss;
 	char **uuids;
 	size_t uuids_len;
-	dbus_bool_t reset;
+	dbus_bool_t duplicate;
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -1602,9 +1602,9 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 	if (args->transport != NULL)
 		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
 						&args->transport);
-	if (args->reset)
-		dict_append_entry(&dict, "ResetData", DBUS_TYPE_BOOLEAN,
-						&args->reset);
+	if (args->duplicate)
+		dict_append_entry(&dict, "DuplicateData", DBUS_TYPE_BOOLEAN,
+						&args->duplicate);
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1639,7 +1639,7 @@ static void set_scan_filter_commit(void)
 	args.transport = filtered_scan_transport;
 	args.uuids = filtered_scan_uuids;
 	args.uuids_len = filtered_scan_uuids_len;
-	args.reset = TRUE;
+	args.duplicate = TRUE;
 
 	if (check_default_ctrl() == FALSE)
 		return;
-- 
2.13.5

