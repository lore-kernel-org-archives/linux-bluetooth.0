Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] client: Add scan.clear discoverable
Date: Mon, 30 Jul 2018 14:14:25 +0300
Message-Id: <20180730111427.29947-4-luiz.dentz@gmail.com>
In-Reply-To: <20180730111427.29947-1-luiz.dentz@gmail.com>
References: <20180730111427.29947-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements scan.clear for discoverable filter.
---
 client/main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 6e6f6d2fb..1a66a3ab4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1416,6 +1416,11 @@ static void filter_clear_duplicate(void)
 	filter.duplicate = false;
 }
 
+static void filter_clear_discoverable(void)
+{
+	filter.discoverable = false;
+}
+
 struct clear_entry {
 	const char *name;
 	void (*clear) (void);
@@ -1427,6 +1432,7 @@ static const struct clear_entry filter_clear[] = {
 	{ "pathloss", filter_clear_pathloss },
 	{ "transport", filter_clear_transport },
 	{ "duplicate-data", filter_clear_duplicate },
+	{ "discoverable", filter_clear_discoverable },
 	{}
 };
 
@@ -2539,7 +2545,8 @@ static const struct bt_shell_menu scan_menu = {
 	{ "discoverable", "[on/off]", cmd_scan_filter_discoverable,
 				"Set/Get discoverable filter",
 				NULL },
-	{ "clear", "[uuids/rssi/pathloss/transport/duplicate-data]",
+	{ "clear",
+		"[uuids/rssi/pathloss/transport/duplicate-data/discoverable]",
 				cmd_scan_filter_clear,
 				"Clears discovery filter.",
 				filter_clear_generator },
-- 
2.17.1

