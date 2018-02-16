Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 4/7] client: Improve help messages for advertise
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <fda21ee4-48eb-2626-d184-8e95d119e3f1@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:21 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/client/main.c b/client/main.c
index a6adb70d2..8fc76a6de 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2302,19 +2302,19 @@ static const struct bt_shell_menu advertise_menu = {
 	.desc = "Advertise Options Submenu",
 	.entries = {
 	{ "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
-			"Set advertise uuids" },
+			"Set/Get advertise uuids" },
 	{ "service", "[uuid] [data=xx xx ...]", cmd_advertise_service,
-			"Set advertise service data" },
+			"Set/Get advertise service data" },
 	{ "manufacturer", "[id] [data=xx xx ...]",
 			cmd_advertise_manufacturer,
-			"Set advertise manufacturer data" },
+			"Set/Get advertise manufacturer data" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
-			"Enable/disable TX power to be advertised",
+			"Show/Enable/Disable TX power to be advertised",
 							NULL },
 	{ "name", "[on/off/name]", cmd_advertise_name,
-			"Enable/disable local name to be advertised" },
-	{ "appearance", "[value]", cmd_advertise_appearance,
-			"Set custom appearance to be advertised" },
+			"Configure local name to be advertised" },
+	{ "appearance", "[on/off/value]", cmd_advertise_appearance,
+			"Configure custom appearance to be advertised" },
 	{ "duration", "[seconds]", cmd_advertise_duration,
 			"Set/Get advertise duration" },
 	{ "timeout", "[seconds]", cmd_advertise_timeout,
-- 
2.14.1

