Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] client: Ask user the characteristic value
Date: Wed, 28 Jun 2017 15:54:21 +0300
Message-Id: <20170628125423.26208-8-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

During register-characteristic ask user to input the initial value it
should assume:

register-characteristic 00002a06-0000-1000-8000-00805f9b34fb write-without-response
[NEW] Characteristic
	/org/bluez/app/service0x1da7150/chrc0x1dc0bb0
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
[/org/bluez/app/service0x1da7150/chrc0x1dc0bb0] Enter value: 00 00
---
 client/gatt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 342b60f..674795a 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1157,6 +1157,40 @@ static const GDBusMethodTable chrc_methods[] = {
 	{ }
 };
 
+static void chrc_set_value(const char *input, void *user_data)
+{
+	struct chrc *chrc = user_data;
+	uint8_t value[512];
+	char *entry;
+	unsigned int i;
+
+	g_free(chrc->value);
+
+	for (i = 0; (entry = strsep((char **)&input, " \t")) != NULL; i++) {
+		long int val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= G_N_ELEMENTS(value)) {
+			rl_printf("Too much data\n");
+			return;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			rl_printf("Invalid value at index %d\n", i);
+			return;
+		}
+
+		value[i] = val;
+	}
+
+	chrc->value_len = i;
+	chrc->value = g_memdup(value, i);
+}
+
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 {
 	struct service *service;
@@ -1186,6 +1220,8 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
 	service->chrcs = g_list_append(service->chrcs, chrc);
 
 	print_chrc(chrc, COLORED_NEW);
+
+	rl_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
 }
 
 static struct chrc *chrc_find(const char *pattern)
-- 
2.9.4

