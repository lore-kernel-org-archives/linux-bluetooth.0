Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 4/6] tools/obexctl: Return exit status for
 non-interactive
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Message-ID: <61e62414-f489-a307-0c41-46dd781fae72@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:31:06 +0900
MIME-Version: 1.0
In-Reply-To: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/obexctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 3360972bd..f839ab0bd 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2145,6 +2145,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
+	int status;
 
 	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
@@ -2161,11 +2162,11 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 							property_changed, NULL);
 
-	bt_shell_run();
+	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
 
 	dbus_connection_unref(dbus_conn);
 
-	return 0;
+	return status;
 }
-- 
2.14.1

