Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 7/7] client: Add clear command for advertise
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <6556ea7a-9717-3148-309c-e72824ae281a@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:48 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the clear command to advertise-related commands to clear individual
fields or whole of advertise configuration.
---
 client/main.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/client/main.c b/client/main.c
index 288ed032f..38df75828 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2314,6 +2314,74 @@ static void cmd_advertise_timeout(int argc, char *argv[])
 	ad_advertise_timeout(dbus_conn, &value);
 }
 
+static void ad_clear_uuids(void)
+{
+	ad_disable_uuids(dbus_conn);
+}
+
+static void ad_clear_service(void)
+{
+	ad_disable_service(dbus_conn);
+}
+
+static void ad_clear_manufacturer(void)
+{
+	ad_disable_manufacturer(dbus_conn);
+}
+
+static void ad_clear_tx_power(void)
+{
+	dbus_bool_t powered = false;
+
+	ad_advertise_tx_power(dbus_conn, &powered);
+}
+
+static void ad_clear_name(void)
+{
+	ad_advertise_name(dbus_conn, false);
+}
+
+static void ad_clear_appearance(void)
+{
+	ad_advertise_appearance(dbus_conn, false);
+}
+
+static void ad_clear_duration(void)
+{
+	long int value = 0;
+
+	ad_advertise_duration(dbus_conn, &value);
+}
+
+static void ad_clear_timeout(void)
+{
+	long int value = 0;
+
+	ad_advertise_timeout(dbus_conn, &value);
+}
+
+static const struct clear_entry ad_clear[] = {
+	{ "uuids",		ad_clear_uuids },
+	{ "service",		ad_clear_service },
+	{ "manufacturer",	ad_clear_manufacturer },
+	{ "tx-power",		ad_clear_tx_power },
+	{ "name",		ad_clear_name },
+	{ "appearance",		ad_clear_appearance },
+	{ "duration",		ad_clear_duration },
+	{ "timeout",		ad_clear_timeout },
+	{}
+};
+
+static void cmd_ad_clear(int argc, char *argv[])
+{
+	bool all = false;
+
+	if (argc < 2 || !strlen(argv[1]))
+		all = true;
+
+	data_clear(ad_clear, all ? "all" : argv[1]);
+}
+
 static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
 	.desc = "Advertise Options Submenu",
@@ -2336,6 +2404,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise duration" },
 	{ "timeout", "[seconds]", cmd_advertise_timeout,
 			"Set/Get advertise timeout" },
+	{ "clear", "[uuids/service/manufacturer/config-name...]", cmd_ad_clear,
+			"Clear advertise config" },
 	{ } },
 };
 
-- 
2.14.1

