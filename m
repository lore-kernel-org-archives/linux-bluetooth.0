Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/2] Add encode/decode for write response
Date: Tue, 15 Feb 2011 10:16:48 -0400
Message-Id: <1297779409-32597-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The encode/decode functions for Write Response operations were created
to keep consistency with the rest of GATT API.
---
 attrib/att.c        |   21 +++++++++++++++++++++
 attrib/att.h        |    2 ++
 src/attrib-server.c |    4 +---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index dff8597..3259fca 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -526,6 +526,27 @@ uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
 	return len;
 }
 
+uint16_t enc_write_resp(uint8_t *pdu, int len)
+{
+	if (pdu == NULL)
+		return 0;
+
+	pdu[0] = ATT_OP_WRITE_RESP;
+
+	return sizeof(pdu[0]);
+}
+
+uint16_t dec_write_resp(const uint8_t *pdu, int len)
+{
+	if (pdu == NULL)
+		return 0;
+
+	if (pdu[0] != ATT_OP_WRITE_RESP)
+		return 0;
+
+	return len;
+}
+
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
diff --git a/attrib/att.h b/attrib/att.h
index 7e81dc4..7d9afeb 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -215,6 +215,8 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
 							uint8_t *pdu, int len);
 uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
+uint16_t enc_write_resp(uint8_t *pdu, int len);
+uint16_t dec_write_resp(const uint8_t *pdu, int len);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
 uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
 								int len);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 72f5b17..85b39a8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -601,9 +601,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	memcpy(&uuid, &a->uuid, sizeof(uuid_t));
 	attrib_db_update(handle, &uuid, value, vlen);
 
-	pdu[0] = ATT_OP_WRITE_RESP;
-
-	return sizeof(pdu[0]);
+	return enc_write_resp(pdu, len);
 }
 
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
-- 
1.7.0.4

