Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] client: Move gatt related commands to a submenu
Date: Thu, 16 Nov 2017 12:59:25 +0200
Message-Id: <20171116105925.2117-6-luiz.dentz@gmail.com>
In-Reply-To: <20171116105925.2117-1-luiz.dentz@gmail.com>
References: <20171116105925.2117-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands related to gatt settings are now under gatt
submenu:

[bluetooth]# menu gatt
Menu gatt:
Available commands:
-------------------
list-attributes [dev]                             List attributes
set-alias <alias>                                 Set device alias
select-attribute <attribute/UUID>                 Select attribute
attribute-info [attribute/UUID]                   Select attribute
read                                              Read attribute value
write <data=[xx xx ...]>                          Write attribute value
acquire-write                                     Acquire Write file descriptor
release-write                                     Release Write file descriptor
acquire-notify                                    Acquire Notify file descriptor
release-notify                                    Release Notify file descriptor
notify <on/off>                                   Notify attribute value
register-application [UUID ...]                   Register profile to connect
unregister-application                            Unregister profile
register-service <UUID>                           Register application service.
unregister-service <UUID/object>                  Unregister application service
register-characteristic <UUID> <Flags=read,write,notify...> Register application characteristic
unregister-characteristic <UUID/object>           Unregister application characteristic
register-descriptor <UUID> <Flags=read,write...>  Register application descriptor
unregister-descriptor <UUID/object>               Unregister application descriptor
back                                              Return to main menu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help                                              Display help about this program
---
 client/main.c | 87 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/client/main.c b/client/main.c
index a60228833..88d11bb29 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2402,6 +2402,52 @@ static const struct bt_shell_menu scan_menu = {
 	{ } },
 };
 
+static const struct bt_shell_menu gatt_menu = {
+	.name = "gatt",
+	.entries = {
+	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
+							dev_generator },
+	{ "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
+	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
+				"Select attribute", attribute_generator },
+	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
+				"Select attribute", attribute_generator },
+	{ "read",         NULL,       cmd_read, "Read attribute value" },
+	{ "write",        "<data=[xx xx ...]>", cmd_write,
+						"Write attribute value" },
+	{ "acquire-write", NULL, cmd_acquire_write,
+					"Acquire Write file descriptor" },
+	{ "release-write", NULL, cmd_release_write,
+					"Release Write file descriptor" },
+	{ "acquire-notify", NULL, cmd_acquire_notify,
+					"Acquire Notify file descriptor" },
+	{ "release-notify", NULL, cmd_release_notify,
+					"Release Notify file descriptor" },
+	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value",
+							mode_generator },
+	{ "register-application", "[UUID ...]", cmd_register_app,
+						"Register profile to connect" },
+	{ "unregister-application", NULL, cmd_unregister_app,
+						"Unregister profile" },
+	{ "register-service", "<UUID>", cmd_register_service,
+					"Register application service."  },
+	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
+					"Unregister application service" },
+	{ "register-characteristic", "<UUID> <Flags=read,write,notify...>",
+					cmd_register_characteristic,
+					"Register application characteristic" },
+	{ "unregister-characteristic", "<UUID/object>",
+				cmd_unregister_characteristic,
+				"Unregister application characteristic" },
+	{ "register-descriptor", "<UUID> <Flags=read,write...>",
+					cmd_register_descriptor,
+					"Register application descriptor" },
+	{ "unregister-descriptor", "<UUID/object>",
+					cmd_unregister_descriptor,
+					"Unregister application descriptor" },
+	{ } },
+};
+
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -2453,46 +2499,6 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
-	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
-							dev_generator },
-	{ "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
-	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
-				"Select attribute", attribute_generator },
-	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
-				"Select attribute", attribute_generator },
-	{ "read",         NULL,       cmd_read, "Read attribute value" },
-	{ "write",        "<data=[xx xx ...]>", cmd_write,
-						"Write attribute value" },
-	{ "acquire-write", NULL, cmd_acquire_write,
-					"Acquire Write file descriptor" },
-	{ "release-write", NULL, cmd_release_write,
-					"Release Write file descriptor" },
-	{ "acquire-notify", NULL, cmd_acquire_notify,
-					"Acquire Notify file descriptor" },
-	{ "release-notify", NULL, cmd_release_notify,
-					"Release Notify file descriptor" },
-	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value",
-							mode_generator },
-	{ "register-application", "[UUID ...]", cmd_register_app,
-						"Register profile to connect" },
-	{ "unregister-application", NULL, cmd_unregister_app,
-						"Unregister profile" },
-	{ "register-service", "<UUID>", cmd_register_service,
-					"Register application service."  },
-	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
-					"Unregister application service" },
-	{ "register-characteristic", "<UUID> <Flags=read,write,notify...>",
-					cmd_register_characteristic,
-					"Register application characteristic" },
-	{ "unregister-characteristic", "<UUID/object>",
-				cmd_unregister_characteristic,
-				"Unregister application characteristic" },
-	{ "register-descriptor", "<UUID> <Flags=read,write...>",
-					cmd_register_descriptor,
-					"Register application descriptor" },
-	{ "unregister-descriptor", "<UUID/object>",
-					cmd_unregister_descriptor,
-					"Unregister application descriptor" },
 	{ } },
 };
 
@@ -2545,6 +2551,7 @@ int main(int argc, char *argv[])
 	bt_shell_set_menu(&main_menu);
 	bt_shell_add_submenu(&advertise_menu);
 	bt_shell_add_submenu(&scan_menu);
+	bt_shell_add_submenu(&gatt_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-- 
2.13.6

