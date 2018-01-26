Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] tools/obexctl: Retrieve updated Size property once
Message-ID: <93990bf7-f452-b47f-70c1-9370f2b860cd@jp.fujitsu.com>
Date: Fri, 26 Jan 2018 17:14:43 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since obexd may have updated the Size property, obexctl retrieves it
once so that it can output more proper transfer information.
---
 tools/obexctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 05bbd3e84..777221d2f 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1888,6 +1888,13 @@ static void transfer_property_changed(GDBusProxy *proxy, const char *name,
 	str = proxy_description(proxy, "Transfer", COLORED_CHG);
 
 	if (strcmp(name, "Transferred") == 0) {
+		/*
+		 * Since the Size property may have been updated at the start
+		 * of the transfer, it is retrieved so that the transfer
+		 * information can be output more proper.
+		 */
+		if (data->transferred == 0)
+			g_dbus_proxy_refresh_property(proxy, "Size");
 		print_transferred(data, str, iter);
 		goto done;
 	}
-- 
2.14.1

