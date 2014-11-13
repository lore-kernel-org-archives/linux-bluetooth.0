Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] unit/test-gatt: Add debug for bt_att
Date: Thu, 13 Nov 2014 18:21:38 +0200
Message-Id: <1415895699-19124-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gatt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 39cdda3..31e524b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -284,7 +284,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
-static void gatt_debug(const char *str, void *user_data)
+static void print_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
@@ -381,6 +381,10 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	case ATT:
 		context->att = att;
 
+		if (g_test_verbose())
+			bt_att_set_debug(context->att, print_debug, "bt_att:",
+									NULL);
+
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
 	case CLIENT:
@@ -388,8 +392,8 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 		g_assert(context->client);
 
 		if (g_test_verbose())
-			bt_gatt_client_set_debug(context->client, gatt_debug,
-								"gatt:", NULL);
+			bt_gatt_client_set_debug(context->client, print_debug,
+						"bt_gatt_client:", NULL);
 
 		bt_gatt_client_set_ready_handler(context->client,
 						client_ready_cb, context, NULL);
-- 
1.9.3

