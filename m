Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] client: Add generator for scan:clear
Date: Fri, 15 Dec 2017 14:09:53 -0200
Message-Id: <20171215160954.3527-3-luiz.dentz@gmail.com>
In-Reply-To: <20171215160954.3527-1-luiz.dentz@gmail.com>
References: <20171215160954.3527-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tab generator for scan:clear:

[bluetooth]# clear
duplicate-data  pathloss        rssi            transport       uuids
---
 client/main.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 53e03f56f..9c77a34b9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1432,6 +1432,26 @@ static const struct filter_clear {
 	{}
 };
 
+static char *filter_clear_generator(const char *text, int state)
+{
+	static int index, len;
+	const char *arg;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((arg = filter_clear[index].name)) {
+		index++;
+
+		if (!strncmp(arg, text, len))
+			return strdup(arg);
+	}
+
+	return NULL;
+}
+
 static void cmd_scan_filter_clear(int argc, char *argv[])
 {
 	const struct filter_clear *fc;
@@ -2308,7 +2328,8 @@ static const struct bt_shell_menu scan_menu = {
 				mode_generator },
 	{ "clear", "[uuids/rssi/pathloss/transport/duplicate-data]",
 				cmd_scan_filter_clear,
-				"Clears discovery filter." },
+				"Clears discovery filter.",
+				filter_clear_generator },
 	{ } },
 };
 
-- 
2.13.6

