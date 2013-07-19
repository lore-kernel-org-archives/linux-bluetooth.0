Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ 09/11] attrib: Add encode/decode execute write support
Date: Fri, 19 Jul 2013 13:34:15 -0400
Message-Id: <1374255257-8753-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

Add functions for encoding/decoding Execute Write Request PDUs.
---
 attrib/att.c |   31 +++++++++++++++++++++++++++++++
 attrib/att.h |    2 ++
 2 files changed, 33 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 8fd5ab5..d5f4f68 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -1126,6 +1126,37 @@ uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, size_t len)
 	return min_len;
 }
 
+uint16_t dec_exec_write_req(const uint8_t *pdu, size_t len, uint8_t *flags)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*flags);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (flags == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_EXEC_WRITE_REQ)
+		return 0;
+
+	*flags = pdu[1];
+
+	return min_len;
+}
+
+uint16_t enc_exec_write_resp(uint8_t *pdu)
+{
+	if (pdu == NULL)
+		return 0;
+
+	pdu[0] = ATT_OP_EXEC_WRITE_RESP;
+
+	return sizeof(pdu[0]);
+}
+
 uint16_t dec_exec_write_resp(const uint8_t *pdu, size_t len)
 {
 	const uint16_t min_len = sizeof(pdu[0]);
diff --git a/attrib/att.h b/attrib/att.h
index cd102f9..28bc944 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -281,4 +281,6 @@ uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
 						uint16_t *offset, uint8_t *value,
 						size_t *vlen);
 uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, size_t len);
+uint16_t dec_exec_write_req(const uint8_t *pdu, size_t len, uint8_t *flags);
+uint16_t enc_exec_write_resp(uint8_t *pdu);
 uint16_t dec_exec_write_resp(const uint8_t *pdu, size_t len);
-- 
1.7.9.5

