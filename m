Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] client: Fix format of arguments of set-service and set-manufacturer
Date: Sun, 26 Nov 2017 22:21:25 +0200
Message-Id: <20171126202126.27783-3-luiz.dentz@gmail.com>
In-Reply-To: <20171126202126.27783-1-luiz.dentz@gmail.com>
References: <20171126202126.27783-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Optional arguments should contain only one set of '[' ']' otherwise
wordexp won't be able to parse it.
---
 client/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 38028c6c0..7661b33c0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2205,9 +2205,9 @@ static const struct bt_shell_menu advertise_menu = {
 	.entries = {
 	{ "set-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_advertise_uuids, "Set advertise uuids" },
-	{ "set-service", "[uuid][data=[xx xx ...]", cmd_set_advertise_service,
+	{ "set-service", "[uuid] [data=xx xx ...]", cmd_set_advertise_service,
 			"Set advertise service data" },
-	{ "set-manufacturer", "[id][data=[xx xx ...]",
+	{ "set-manufacturer", "[id] [data=xx xx ...]",
 			cmd_set_advertise_manufacturer,
 			"Set advertise manufacturer data" },
 	{ "set-tx-power", "<on/off>", cmd_set_advertise_tx_power,
@@ -2254,7 +2254,7 @@ static const struct bt_shell_menu gatt_menu = {
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
 				"Select attribute", attribute_generator },
 	{ "read",         NULL,       cmd_read, "Read attribute value" },
-	{ "write",        "<data=[xx xx ...]>", cmd_write,
+	{ "write",        "<data=xx xx ...>", cmd_write,
 						"Write attribute value" },
 	{ "acquire-write", NULL, cmd_acquire_write,
 					"Acquire Write file descriptor" },
-- 
2.13.6

