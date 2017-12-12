Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client: Add description for submenus
Date: Tue, 12 Dec 2017 10:14:19 -0200
Message-Id: <20171212121419.4850-3-luiz.dentz@gmail.com>
In-Reply-To: <20171212121419.4850-1-luiz.dentz@gmail.com>
References: <20171212121419.4850-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper descriptions for each submenu.
---
 mesh/config-client.c | 1 +
 mesh/onoff-model.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 3d618b6a6..aad6525c2 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -613,6 +613,7 @@ static void cmd_get_ttl(int argc, char *argv[])
 
 static const struct bt_shell_menu cfg_menu = {
 	.name = "config",
+	.desc = "Configuration Model Submenu",
 	.entries = {
 	{"target",		"<unicast>",			cmd_set_node,
 						"Set target node to configure"},
diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
index fc0d64617..dbbe69706 100644
--- a/mesh/onoff-model.c
+++ b/mesh/onoff-model.c
@@ -259,6 +259,7 @@ static void cmd_set(int argc, char *argv[])
 
 static const struct bt_shell_menu onoff_menu = {
 	.name = "onoff",
+	.desc = "On/Off Model Submenu",
 	.entries = {
 	{"target",		"<unicast>",			cmd_set_node,
 						"Set node to configure"},
-- 
2.13.6

