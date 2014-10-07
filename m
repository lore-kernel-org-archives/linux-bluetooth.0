Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] shared/gatt: Add gatt-client include service iterator
Date: Tue,  7 Oct 2014 09:19:24 +0200
Message-Id: <1412666365-9562-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c | 30 ++++++++++++++++++++++++++++++
 src/shared/gatt-client.h | 10 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 54e6fec..b823c28 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1635,6 +1635,36 @@ bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
 	return true;
 }
 
+bool bt_gatt_include_service_iter_init(struct bt_gatt_include_service_iter *i,
+					const bt_gatt_service_t *service)
+{
+	if (!i || !service)
+		return false;
+
+	memset(i, 0, sizeof(*i));
+	i->service = (struct service_list *) service;
+
+	return true;
+}
+
+bool bt_gatt_include_service_iter_next(struct bt_gatt_include_service_iter *i,
+					const bt_gatt_included_service_t **incl)
+{
+	struct service_list *service;
+
+	if (!i || !incl)
+		return false;
+
+	service = i->service;
+
+	if (i->pos >= service->num_includes)
+		return false;
+
+	*incl = &service->includes[i->pos++];
+
+	return true;
+}
+
 struct read_op {
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 05b4838..df6515e 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -113,6 +113,11 @@ struct bt_gatt_characteristic_iter {
 	size_t pos;
 };
 
+struct bt_gatt_include_service_iter {
+	void *service;
+	size_t pos;
+};
+
 bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 						struct bt_gatt_client *client);
 bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
@@ -129,6 +134,11 @@ bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
 bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
 					const bt_gatt_characteristic_t **chrc);
 
+bool bt_gatt_include_service_iter_init(struct bt_gatt_include_service_iter *i,
+					const bt_gatt_service_t *service);
+bool bt_gatt_include_service_iter_next(struct bt_gatt_include_service_iter *i,
+					const bt_gatt_included_service_t **inc);
+
 typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data);
-- 
1.9.3

