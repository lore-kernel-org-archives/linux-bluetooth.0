Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 05/18] unit: Add test for gatt_discover_primary()
Date: Tue,  2 Apr 2013 12:50:52 -0400
Message-Id: <1364921465-31182-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index babc30a..02afc69 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -135,6 +135,58 @@ static gboolean handle_not_supported(int fd)
 	return TRUE;
 }
 
+static gboolean handle_read_by_group(int fd)
+{
+	uint8_t pdu[sizeof(uint16_t) * 3 + 2], ipdu[ATT_DEFAULT_LE_MTU];
+	uint16_t pdu_len, start, end;
+	struct att_data_list *adl;
+	bt_uuid_t uuid, prim;
+	uint8_t *value;
+	ssize_t len;
+
+	len = recv(fd, ipdu, sizeof(ipdu), 0);
+	g_assert(len > 0);
+
+	pdu_len = dec_read_by_grp_req(ipdu, len, &start, &end, &uuid);
+	g_assert(pdu_len == len);
+
+	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
+	g_assert(bt_uuid_cmp(&uuid, &prim) == 0);
+
+	adl = att_data_list_alloc(1, sizeof(uint16_t) * 3);
+	g_assert(adl != NULL);
+
+	value = adl->data[0];
+
+	if (start == 0x0001 && end == 0xffff) {
+		att_put_u16(0x0001, &value[0]);
+		att_put_u16(0x000f, &value[2]);
+		att_put_u16(0xaaaa, &value[4]);
+	} else if (start == 0x0010 && end == 0xffff) {
+		att_put_u16(0x0010, &value[0]);
+		att_put_u16(0x001f, &value[2]);
+		att_put_u16(0xbbbb, &value[4]);
+	} else {
+		/* Signal end of attribute group (primary service) */
+		pdu_len = enc_error_resp(ipdu[0], start,
+						ATT_ECODE_ATTR_NOT_FOUND,
+						pdu, sizeof(pdu));
+		g_assert(pdu_len == 5);
+		goto done;
+	}
+
+	pdu_len = enc_read_by_grp_resp(adl, pdu, sizeof(pdu));
+	g_assert(pdu_len == sizeof(pdu));
+
+done:
+	att_data_list_free(adl);
+
+	len = write(fd, pdu, pdu_len);
+	g_assert(len == pdu_len);
+
+	return TRUE;
+}
+
 static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -155,6 +207,8 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 	switch (opcode) {
 	case ATT_OP_MTU_REQ:
 		return handle_mtu_exchange(fd);
+	case ATT_OP_READ_BY_GROUP_REQ:
+		return handle_read_by_group(fd);
 	}
 
 	return handle_not_supported(fd);
@@ -228,11 +282,47 @@ static void test_gatt_exchange_mtu(void)
 	execute_context(context);
 }
 
+static bool discover_primary_cb(GSList *services, uint8_t status,
+								void *user_data)
+{
+	struct context *context = user_data;
+	struct gatt_primary *prim;
+
+	g_assert_cmpuint(status, ==, 0);
+	g_assert_cmpuint(g_slist_length(services), ==, 2);
+
+	prim = g_slist_nth_data(services, 0);
+	g_assert(prim->range.start == 0x0001 && prim->range.end == 0x000f);
+	g_assert(bt_uuid_strcmp(&prim->uuid,
+				"0000aaaa-0000-1000-8000-00805f9b34fb") == 0);
+
+	prim = g_slist_nth_data(services, 1);
+	g_assert(prim->range.start == 0x0010 && prim->range.end == 0x001f);
+	g_assert(bt_uuid_strcmp(&prim->uuid,
+				"0000bbbb-0000-1000-8000-00805f9b34fb") == 0);
+
+	g_main_loop_quit(context->main_loop);
+
+	return false;
+}
+
+static void test_gatt_discover_primary(void)
+{
+	struct context *context = create_context();
+
+	gatt_discover_primary(context->attrib, NULL, discover_primary_cb,
+								context);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
 	g_test_add_func("/gatt/gatt_exchange_mtu", test_gatt_exchange_mtu);
+	g_test_add_func("/gatt/gatt_discover_primary",
+						test_gatt_discover_primary);
 
 	return g_test_run();
 }
-- 
1.7.9.5

