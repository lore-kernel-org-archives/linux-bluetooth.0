Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 12/14] tools/btgatt-client: Print found include services
Date: Thu, 16 Oct 2014 12:17:24 +0200
Message-Id: <1413454646-23076-13-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 5c692ff..5465d53 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -174,7 +174,9 @@ static void print_uuid(const uint8_t uuid[16])
 static void print_service(const bt_gatt_service_t *service)
 {
 	struct bt_gatt_characteristic_iter iter;
+	struct bt_gatt_incl_service_iter include_iter;
 	const bt_gatt_characteristic_t *chrc;
+	const bt_gatt_included_service_t *incl;
 	size_t i;
 
 	if (!bt_gatt_characteristic_iter_init(&iter, service)) {
@@ -182,12 +184,24 @@ static void print_service(const bt_gatt_service_t *service)
 		return;
 	}
 
+	if (!bt_gatt_include_service_iter_init(&include_iter, service)) {
+		PRLOG("Failed to initialize include service iterator\n");
+		return;
+	}
 	printf(COLOR_RED "service %s" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, uuid: ",
 				service->primary ? "primary" : "second.",
 				service->start_handle, service->end_handle);
 	print_uuid(service->uuid);
 
+	while (bt_gatt_include_service_iter_next(&include_iter, &incl)) {
+		printf("\t  " COLOR_GREEN "include" COLOR_OFF " - handle: "
+					"0x%04x, - start: 0x%04x, end: 0x%04x,"
+					"uuid: ", incl->handle,
+					incl->start_handle, incl->end_handle);
+			print_uuid(incl->uuid);
+	}
+
 	while (bt_gatt_characteristic_iter_next(&iter, &chrc)) {
 		printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
 				" - start: 0x%04x, end: 0x%04x, "
-- 
1.9.3

