Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] client: Add description for submenus
Date: Tue, 12 Dec 2017 10:14:18 -0200
Message-Id: <20171212121419.4850-2-luiz.dentz@gmail.com>
In-Reply-To: <20171212121419.4850-1-luiz.dentz@gmail.com>
References: <20171212121419.4850-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper descriptions for each submenu.
---
 client/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/main.c b/client/main.c
index f3369e89a..5af4c97d8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2202,6 +2202,7 @@ static void cmd_set_advertise_timeout(int argc, char *argv[])
 
 static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
+	.desc = "Advertising Management Submenu",
 	.entries = {
 	{ "set-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_advertise_uuids, "Set advertise uuids" },
@@ -2226,6 +2227,7 @@ static const struct bt_shell_menu advertise_menu = {
 
 static const struct bt_shell_menu scan_menu = {
 	.name = "scan",
+	.desc = "Scan Filters Submenu",
 	.entries = {
 	{ "set-filter-uuids", "[uuid1 uuid2 ...]", cmd_set_scan_filter_uuids,
 				"Set scan filter uuids" },
@@ -2246,6 +2248,7 @@ static const struct bt_shell_menu scan_menu = {
 
 static const struct bt_shell_menu gatt_menu = {
 	.name = "gatt",
+	.desc = "Generic Attribute Submenu",
 	.entries = {
 	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
 							dev_generator },
-- 
2.13.6

