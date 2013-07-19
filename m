Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ 07/11] attrib: Remove unused parameter from enc_write_resp()
Date: Fri, 19 Jul 2013 13:34:13 -0400
Message-Id: <1374255257-8753-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

---
 attrib/att.c        |    2 +-
 attrib/att.h        |    2 +-
 src/attrib-server.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 675deb6..20a299a 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -559,7 +559,7 @@ uint16_t dec_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
 	return len;
 }
 
-uint16_t enc_write_resp(uint8_t *pdu, size_t len)
+uint16_t enc_write_resp(uint8_t *pdu)
 {
 	if (pdu == NULL)
 		return 0;
diff --git a/attrib/att.h b/attrib/att.h
index ebdb98e..7b585e3 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -233,7 +233,7 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
 						uint8_t *pdu, size_t len);
 uint16_t dec_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
 						uint8_t *value, size_t *vlen);
-uint16_t enc_write_resp(uint8_t *pdu, size_t len);
+uint16_t enc_write_resp(uint8_t *pdu);
 uint16_t dec_write_resp(const uint8_t *pdu, size_t len);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len);
 uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 93f03b3..3f629b0 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -927,7 +927,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		g_key_file_free(key_file);
 	}
 
-	return enc_write_resp(pdu, len);
+	return enc_write_resp(pdu);
 }
 
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
-- 
1.7.9.5

