Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 4/4] client: Print Address type in show and info commands
Date: Wed, 13 Dec 2017 14:36:38 +0100
Message-Id: <20171213133638.25852-4-szymon.janc@codecoup.pl>
In-Reply-To: <20171213133638.25852-1-szymon.janc@codecoup.pl>
References: <20171213133638.25852-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index f3369e89a..c435ee677 100644
--- a/client/main.c
+++ b/client/main.c
@@ -864,7 +864,16 @@ static void cmd_show(int argc, char *argv[])
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	bt_shell_printf("Controller %s\n", address);
+
+	if (g_dbus_proxy_get_property(proxy, "AddressType", &iter) == TRUE) {
+		const char *type;
+
+		dbus_message_iter_get_basic(&iter, &type);
+
+		bt_shell_printf("Controller %s (%s)\n", address, type);
+	} else {
+		bt_shell_printf("Controller %s\n", address);
+	}
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
@@ -1435,7 +1444,16 @@ static void cmd_info(int argc, char *argv[])
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	bt_shell_printf("Device %s\n", address);
+
+	if (g_dbus_proxy_get_property(proxy, "AddressType", &iter) == TRUE) {
+		const char *type;
+
+		dbus_message_iter_get_basic(&iter, &type);
+
+		bt_shell_printf("Device %s (%s)\n", address, type);
+	} else {
+		bt_shell_printf("Device %s\n", address);
+	}
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
-- 
2.14.3

