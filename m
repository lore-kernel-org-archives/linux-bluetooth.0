Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 8/9] tools/btgatt-client: Set service changed handler.
Date: Tue, 23 Sep 2014 13:47:16 -0700
Message-Id: <1411505237-10932-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btgatt-client now sets a service changed handler by calling
bt_gatt_client_set_service_changed.
---
 tools/btgatt-client.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 41b85ad..d900e08 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -93,6 +93,8 @@ static void gatt_debug_cb(const char *str, void *user_data)
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data);
+static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
+							void *user_data);
 
 static struct client *client_create(int fd, uint16_t mtu)
 {
@@ -143,6 +145,8 @@ static struct client *client_create(int fd, uint16_t mtu)
 	}
 
 	bt_gatt_client_set_ready_handler(cli->gatt, ready_cb, cli, NULL);
+	bt_gatt_client_set_service_changed(cli->gatt, service_changed_cb, cli,
+									NULL);
 
 	/* bt_gatt_client already holds a reference */
 	bt_att_unref(att);
@@ -269,6 +273,36 @@ static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	print_prompt();
 }
 
+static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
+								void *user_data)
+{
+	struct client *cli = user_data;
+	struct bt_gatt_service_iter iter;
+	const bt_gatt_service_t *service;
+
+	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
+		PRLOG("Failed to initialize service iterator\n");
+		return;
+	}
+
+	printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
+						start_handle, end_handle);
+
+	if (!bt_gatt_service_iter_next_by_handle(&iter, start_handle, &service))
+		return;
+
+	print_service(service);
+
+	while (bt_gatt_service_iter_next(&iter, &service)) {
+		if (service->start_handle >= end_handle)
+			break;
+
+		print_service(service);
+	}
+
+	print_prompt();
+}
+
 static void services_usage(void)
 {
 	printf("Usage: services [options]\nOptions:\n"
-- 
2.1.0.rc2.206.gedb03e5

