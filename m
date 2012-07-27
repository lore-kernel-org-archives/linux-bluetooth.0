Return-Path: <cyrus@holtmann.org>
From: Eder Ruiz Maria <eder.ruiz@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 2/3] att: Add encode/decode execute write support
Date: Fri, 27 Jul 2012 16:29:35 -0400
Message-Id: <1343420976-19921-2-git-send-email-eder.ruiz@openbossa.org>
In-Reply-To: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add functions for encoding/decoding Execute Write Request and
Response PDUs.
---
 attrib/att.c |   34 ++++++++++++++++++++++++++++++++++
 attrib/att.h |    2 ++
 2 files changed, 36 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index acfb4e0..20a8efa 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -1029,3 +1029,37 @@ uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
 	return len;
 }
 
+uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(flags);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (flags > 1)
+		return 0;
+
+	pdu[0] = ATT_OP_EXEC_WRITE_REQ;
+	pdu[1] = flags;
+
+	return min_len;
+}
+
+uint16_t dec_exec_write_resp(const uint8_t *pdu, int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	if (pdu[0] != ATT_OP_EXEC_WRITE_RESP)
+		return 0;
+
+	return len;
+}
diff --git a/attrib/att.h b/attrib/att.h
index ec03be9..64d22ca 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -261,3 +261,5 @@ uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
 			const uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_prep_write_resp(const uint8_t *pdu, int len, uint16_t *handle,
 				uint16_t *offset, uint8_t *value, int *vlen);
+uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, int len);
+uint16_t dec_exec_write_resp(const uint8_t *pdu, int len);
-- 
1.7.9.5

