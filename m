Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] shared/gatt-server: Request authorization for prepare writes.
Date: Wed,  2 May 2018 11:17:56 +0200
Message-Id: <20180502091757.24190-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds gatt-server possibility to request authorization from
application if needed and previously wasn't authorized. Authorization is
requested by sending write request with no data to application.
---
 doc/gatt-api.txt         |  8 ++++++
 src/gatt-database.c      |  6 +++++
 src/shared/gatt-server.c | 64 +++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 0f1cc9029..b9bdc9352 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -251,6 +251,14 @@ Properties	string UUID [read-only]
 				"secure-read" (Server only)
 				"secure-write" (Server only)
 
+		boolean Authorized [read-only, optional] (Server only)
+
+			True, if read/write operation was previously authorized
+			and attribute requires authorization. If no Authorized
+			property is available along with characteristic or this
+			property is set to true, then daemon don't send empty
+			write request for authorization.
+
 Characteristic Descriptors hierarchy
 ====================================
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0ac5b75b0..419db909c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2614,6 +2614,12 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
+	if (offset && g_dbus_proxy_get_property(chrc->proxy, "Authorized",
+								&iter)) {
+		gatt_db_attribute_write_result(attrib, id, 0);
+		return;
+	}
+
 	if (chrc->write_io) {
 		if (pipe_io_send(chrc->write_io, value, len) < 0) {
 			error("Unable to write: %s", strerror(errno));
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4b554f665..cdade76f8 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1208,6 +1208,45 @@ static bool store_prep_data(struct bt_gatt_server *server,
 	return prep_data_new(server, handle, offset, length, value);
 }
 
+struct prep_write_complete_data {
+	void *pdu;
+	uint16_t length;
+	struct bt_gatt_server *server;
+};
+
+static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
+								void *user_data)
+{
+	struct prep_write_complete_data *pwcd = user_data;
+	uint16_t handle = 0;
+	uint16_t offset;
+
+	handle = get_le16(pwcd->pdu);
+
+	if (err) {
+		bt_att_send_error_rsp(pwcd->server->att,
+					BT_ATT_OP_PREP_WRITE_REQ, handle, err);
+		free(pwcd->pdu);
+		free(pwcd);
+
+		return;
+	}
+
+	offset = get_le16(pwcd->pdu + 2);
+
+	if (!store_prep_data(pwcd->server, handle, offset, pwcd->length - 4,
+						&((uint8_t *) pwcd->pdu)[4]))
+		bt_att_send_error_rsp(pwcd->server->att,
+					BT_ATT_OP_PREP_WRITE_RSP, handle,
+					BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
+
+	bt_att_send(pwcd->server->att, BT_ATT_OP_PREP_WRITE_RSP, pwcd->pdu,
+						pwcd->length, NULL, NULL, NULL);
+
+	free(pwcd->pdu);
+	free(pwcd);
+}
+
 static void prep_write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1215,7 +1254,8 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle = 0;
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
-	uint8_t ecode;
+	struct prep_write_complete_data *pwcd;
+	uint8_t ecode, status;
 
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1245,15 +1285,21 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	if (ecode)
 		goto error;
 
-	if (!store_prep_data(server, handle, offset, length - 4,
-						&((uint8_t *) pdu)[4])) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
+	pwcd = new0(struct prep_write_complete_data, 1);
+	pwcd->pdu = malloc(length);
+	memcpy(pwcd->pdu, pdu, length);
+	pwcd->length = length;
+	pwcd->server = server;
 
-	bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, NULL,
-								NULL, NULL);
-	return;
+	status = gatt_db_attribute_write(attr, offset, NULL, 0,
+						BT_ATT_OP_PREP_WRITE_REQ,
+						server->att,
+						prep_write_complete_cb, pwcd);
+
+	if (status)
+		return;
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
 
 error:
 	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
-- 
2.13.6

