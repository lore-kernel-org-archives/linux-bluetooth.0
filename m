Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-client: Fix read long
Date: Mon, 26 Jan 2015 17:45:18 +0200
Message-Id: <1422287118-25319-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1422287118-25319-1-git-send-email-luiz.dentz@gmail.com>
References: <1422287118-25319-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

length is uint16_t so it may actually overflow in the expression
length = op->offset - op->orig_offset causing invalid write:

Invalid write of size 8
   at 0x4C2E323: memcpy@@GLIBC_2.14 (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x42CF5F: queue_foreach (queue.c:251)
   by 0x423E95: complete_read_long_op (gatt-client.c:2014)
   by 0x423E95: read_long_cb (gatt-client.c:2081)
   by 0x41F4FB: handle_rsp (att.c:600)
---
 profiles/gap/gas.c       |  4 ++--
 src/gatt-client.c        | 16 +++++++++++-----
 src/shared/gatt-client.c |  2 +-
 src/shared/gatt-client.h |  2 +-
 tools/btgatt-client.c    | 12 ++++++------
 unit/test-gatt.c         |  4 ++--
 6 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index f737949..7a7f6f4 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -99,7 +99,7 @@ static char *name2utf8(const uint8_t *name, uint16_t len)
 }
 
 static void read_device_name_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct gas *gas = user_data;
@@ -131,7 +131,7 @@ static void handle_device_name(struct gas *gas, uint16_t value_handle)
 }
 
 static void read_appearance_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct gas *gas = user_data;
diff --git a/src/gatt-client.c b/src/gatt-client.c
index cb8ddf6..e9209ca 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -330,12 +330,13 @@ static void read_op_cb(struct gatt_db_attribute *attrib, int err,
 }
 
 static void desc_read_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct async_dbus_op *op = user_data;
 	struct descriptor *desc = op->data;
 	struct service *service = desc->chrc->service;
+	uint16_t mtu;
 
 	if (!success) {
 		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
@@ -356,7 +357,9 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	 * entire value. Perform a long read to obtain the rest, otherwise,
 	 * we're done.
 	 */
-	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
+	mtu =  bt_gatt_client_get_mtu(service->client->gatt) - 1;
+
+	if (length == mtu) {
 		op->offset += length;
 		desc->read_id = bt_gatt_client_read_long_value(
 							service->client->gatt,
@@ -763,11 +766,12 @@ static void write_characteristic_cb(struct gatt_db_attribute *attr, int err,
 }
 
 static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
-					uint16_t length, void *user_data)
+					size_t length, void *user_data)
 {
 	struct async_dbus_op *op = user_data;
 	struct characteristic *chrc = op->data;
 	struct service *service = chrc->service;
+	uint16_t mtu;
 
 	if (!success) {
 		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
@@ -788,7 +792,9 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	 * entire value. Perform a long read to obtain the rest, otherwise,
 	 * we're done.
 	 */
-	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
+	mtu = bt_gatt_client_get_mtu(service->client->gatt) - 1;
+
+	if (length == mtu) {
 		op->offset += length;
 		chrc->read_id = bt_gatt_client_read_long_value(
 							service->client->gatt,
@@ -1261,7 +1267,7 @@ static void export_desc(struct gatt_db_attribute *attr, void *user_data)
 }
 
 static void read_ext_props_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct characteristic *chrc = user_data;
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1acd34f..8439038 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1995,7 +1995,7 @@ static void complete_read_long_op(struct read_long_op *op, bool success,
 							uint8_t att_ecode)
 {
 	uint8_t *value = NULL;
-	uint16_t length = 0;
+	size_t length = 0;
 
 	if (!success)
 		goto done;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 9a00feb..1722a4b 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -41,7 +41,7 @@ typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data);
 typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
 					bool reliable_error, uint8_t att_ecode,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 62c4d3e..c779095 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -420,17 +420,17 @@ static void read_multiple_usage(void)
 }
 
 static void read_multiple_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
-	int i;
+	size_t i;
 
 	if (!success) {
 		PRLOG("\nRead multiple request failed: 0x%02x\n", att_ecode);
 		return;
 	}
 
-	printf("\nRead multiple value (%u bytes):", length);
+	printf("\nRead multiple value (%zu bytes):", length);
 
 	for (i = 0; i < length; i++)
 		printf("%02x ", value[i]);
@@ -484,9 +484,9 @@ static void read_value_usage(void)
 }
 
 static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
-					uint16_t length, void *user_data)
+					size_t length, void *user_data)
 {
-	int i;
+	size_t i;
 
 	if (!success) {
 		PRLOG("\nRead request failed: 0x%02x\n", att_ecode);
@@ -500,7 +500,7 @@ static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 		return;
 	}
 
-	printf(" (%u bytes): ", length);
+	printf(" (%zu bytes): ", length);
 
 	for (i = 0; i < length; i++)
 		printf("%02x ", value[i]);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 299ef04..103c78e 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -604,7 +604,7 @@ static void execute_context(struct context *context)
 }
 
 static void test_read_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct context *context = user_data;
@@ -1320,7 +1320,7 @@ static const struct test_step test_read_by_type_6 = {
 };
 
 static void multiple_read_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
+					const uint8_t *value, size_t length,
 					void *user_data)
 {
 	struct context *context = user_data;
-- 
2.1.0

