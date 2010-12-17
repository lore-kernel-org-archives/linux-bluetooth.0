Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH] Add enc_read_blob_req() as defined in BT Core Spec v4.0
Date: Fri, 17 Dec 2010 11:08:53 -0800
Message-Id: <1292612933-31095-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1292612933-31095-1-git-send-email-bgix@codeaurora.org>
References: <1292612933-31095-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c |   19 +++++++++++++++++++
 attrib/att.h |    2 ++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 445b192..f8dbc02 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -542,6 +542,25 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
 	return min_len;
 }
 
+uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
+									int len)
+{
+	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
+							sizeof(offset);
+
+	if (pdu == NULL)
+		return 0;
+
+	if (len < min_len)
+		return 0;
+
+	pdu[0] = ATT_OP_READ_BLOB_REQ;
+	att_put_u16(handle, &pdu[1]);
+	att_put_u16(offset, &pdu[3]);
+
+	return min_len;
+}
+
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
diff --git a/attrib/att.h b/attrib/att.h
index 2c8c724..0b8612e 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -202,6 +202,8 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
 uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
 						uint8_t *value, int *vlen);
 uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
+uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
+									int len);
 uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
 uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
 uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
-- 
1.7.2.2

