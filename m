Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 6/7] tools/btgatt-client: Add "services" command.
Date: Sat, 30 Aug 2014 09:02:48 -0700
Message-Id: <1409414569-20068-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1409414569-20068-1-git-send-email-armansito@chromium.org>
References: <1409414569-20068-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added the "services" command, which enumerates all discovered services,
characteristics, and descriptors.
---
 tools/btgatt-client.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 6299586..445cfc7 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -37,6 +37,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/l2cap.h>
+#include "lib/uuid.h"
 
 #include "monitor/mainloop.h"
 #include "src/shared/util.h"
@@ -154,15 +155,83 @@ static void client_destroy(struct client *cli)
 	bt_gatt_client_unref(cli->gatt);
 }
 
+static void print_uuid(const uint8_t uuid[16])
+{
+	char uuid_str[MAX_LEN_UUID_STR];
+	bt_uuid_t tmp;
+
+	tmp.type = BT_UUID128;
+	memcpy(tmp.value.u128.data, uuid, 16 * sizeof(uint8_t));
+	bt_uuid_to_string(&tmp, uuid_str, sizeof(uuid_str));
+
+	printf("%s\n", uuid_str);
+}
+
+static void print_services(struct client *cli)
+{
+	struct bt_gatt_service_iter iter;
+	bt_gatt_service_t service;
+	const bt_gatt_characteristic_t *chrc;
+
+	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
+		PRLOG("Failed to initialize service iterator\n");
+		return;
+	}
+
+	printf("\n");
+
+	while (bt_gatt_service_iter_next(&iter, &service)) {
+		size_t i, j;
+
+		printf("service - start: 0x%04x, end: 0x%04x, uuid: ",
+				service.start_handle, service.end_handle);
+		print_uuid(service.uuid);
+
+		for (i = 0; i < service.num_chrcs; i++) {
+			chrc = service.chrcs + i;
+			printf("\t  charac - start: 0x%04x, end: 0x%04x, "
+					"value: 0x%04x, props: 0x%02x, uuid: ",
+					chrc->start_handle,
+					chrc->end_handle,
+					chrc->value_handle,
+					chrc->properties);
+			print_uuid(service.chrcs[i].uuid);
+
+			for (j = 0; j < chrc->num_descs; j++) {
+				printf("\t\t  descr - handle: 0x%04x, uuid: ",
+							chrc->descs[j].handle);
+				print_uuid(chrc->descs[j].uuid);
+			}
+		}
+
+		printf("\n");
+	}
+}
+
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
+	struct client *cli = user_data;
+
 	if (!success) {
-		PRLOG("GATT discovery procedures failed - error code: 0x02%x\n",
+		PRLOG("GATT discovery procedures failed - error code: 0x%02x\n",
 								att_ecode);
 		return;
 	}
 
 	PRLOG("GATT discovery procedures complete\n");
+
+	print_services(cli);
+	print_prompt();
+}
+
+static void cmd_services(struct client *cli)
+{
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	print_services(cli);
 }
 
 static void cmd_help(struct client *cli);
@@ -175,6 +244,7 @@ static struct {
 	char *doc;
 } command[] = {
 	{ "help", cmd_help, "\tDisplay help message" },
+	{ "services", cmd_services, "\tShow discovered services" },
 	{ }
 };
 
@@ -208,8 +278,6 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 			break;
 	}
 
-	print_prompt();
-
 	if (command[i].cmd)
 		command[i].func(cli);
 	else
-- 
2.1.0.rc2.206.gedb03e5

