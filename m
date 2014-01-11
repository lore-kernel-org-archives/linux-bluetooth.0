Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 11/11] attrib: Add extra PDU checks when decoding Read by Type Response
Date: Sat, 11 Jan 2014 00:47:27 -0400
Message-Id: <1389415647-25831-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1389415647-25831-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These checks are needed to avoid invalid memory access on bogus PDUs.
---
 attrib/att.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index 183390b..e28be25 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -454,7 +454,24 @@ struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, size_t len)
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_RESP)
 		return NULL;
 
+	/* PDU must contain at least:
+	 * - Attribute Opcode (1 octet)
+	 * - Length (1 octet)
+	 * - Attribute Data List (at least one entry):
+	 *   - Attribute Handle (2 octets)
+	 *   - Attribute Value (at least 1 octet) */
+	if (len < 5)
+		return NULL;
+
 	elen = pdu[1];
+	/* Minimum Attribute Data List size */
+	if (elen < 3)
+		return NULL;
+
+	/* Reject incomplete Attribute Data List */
+	if ((len - 2) % elen)
+		return NULL;
+
 	num = (len - 2) / elen;
 	list = att_data_list_alloc(num, elen);
 	if (list == NULL)
-- 
1.8.3.2

