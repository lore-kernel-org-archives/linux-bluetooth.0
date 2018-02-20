Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] tools/obexctl: Only enable attach input when connected
Date: Tue, 20 Feb 2018 16:47:31 +0200
Message-Id: <20180220144731.28583-3-luiz.dentz@gmail.com>
In-Reply-To: <20180220144731.28583-1-luiz.dentz@gmail.com>
References: <20180220144731.28583-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/obexctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 2ef1c044e..b6333842e 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -75,11 +75,13 @@ struct transfer_data {
 
 static void connect_handler(DBusConnection *connection, void *user_data)
 {
+	bt_shell_attach(fileno(stdin));
 	bt_shell_set_prompt(PROMPT_ON);
 }
 
 static void disconnect_handler(DBusConnection *connection, void *user_data)
 {
+	bt_shell_detach();
 	bt_shell_set_prompt(PROMPT_OFF);
 }
 
@@ -2111,7 +2113,6 @@ int main(int argc, char *argv[])
 	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
-	bt_shell_attach(fileno(stdin));
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 
-- 
2.14.3

