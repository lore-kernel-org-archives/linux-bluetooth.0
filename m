Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] tools/bluetooth-player: Only enable attach input when connected
Date: Wed, 21 Feb 2018 16:14:50 +0200
Message-Id: <20180221141456.6656-2-luiz.dentz@gmail.com>
In-Reply-To: <20180221141456.6656-1-luiz.dentz@gmail.com>
References: <20180221141456.6656-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/bluetooth-player.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 709ef5633..32ae4f6bb 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -57,11 +57,13 @@ static GList *items = NULL;
 
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
 
@@ -1124,7 +1126,6 @@ int main(int argc, char *argv[])
 	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
-	bt_shell_attach(fileno(stdin));
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
-- 
2.14.3

