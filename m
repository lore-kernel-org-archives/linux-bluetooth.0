Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 3/6] Implement Find by Type Value Request in the atttribute server
Date: Thu, 18 Nov 2010 16:02:33 -0200
Message-Id: <1290103353-26631-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290017386-23969-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1290017386-23969-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT Discover Primary Service by Service UUID sub-procedure is based
on ATT Find By Type Value Request/Response.

Implement an extra verification for broken requests: "Ending Handle"
different than 0xFFFF. The Group End Handle may be greater than the
"Ending Handle" in the Find By Type Value Request. Forces the "Ending
Handle" in the response to 0xFFFF to avoid another request from the
clients. 0xFFFF means that the sub-procedure is complete.
---
 src/attrib-server.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 375b731..41c0ffc 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -383,6 +383,76 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	return length;
 }
 
+static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
+			const uint8_t *value, int vlen, uint8_t *opdu, int mtu)
+{
+	struct attribute *a;
+	struct att_range *range;
+	GSList *l, *matches;
+	int len;
+
+	if (start > end || start == 0x0000)
+		return enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
+					ATT_ECODE_INVALID_HANDLE, opdu, mtu);
+
+	/* Searching first requested handle number */
+	for (l = database, matches = NULL, range = NULL; l; l = l->next) {
+		a = l->data;
+
+		if (a->handle < start)
+			continue;
+
+		if (a->handle > end)
+			break;
+
+		/* Primary service? Attribute value matches? */
+		if ((sdp_uuid_cmp(&a->uuid, uuid) == 0) && (a->len == vlen) &&
+					(memcmp(a->data, value, vlen) == 0)) {
+
+			range = g_new0(struct att_range, 1);
+			range->start = a->handle;
+
+			matches = g_slist_append(matches, range);
+		} else if (range) {
+			/*
+			 * Update the last found handle or reset the pointer
+			 * to track that a new group started: Primary or
+			 * Secondary service.
+			 */
+			if (sdp_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+					sdp_uuid_cmp(&a->uuid, &snd_uuid) == 0)
+				range = NULL;
+			else
+				range->end = a->handle;
+		}
+	}
+
+	if (range) {
+		if (l == NULL) {
+			/* Avoids another iteration */
+			range->end = 0xFFFF;
+		} else if (range->end == 0) {
+			/*
+			 * Broken requests: requested End Handle is not 0xFFFF.
+			 * Given handle is in the middle of a service definition.
+			 */
+			matches = g_slist_remove(matches, range);
+			g_free(range);
+		}
+	}
+
+	if (matches == NULL)
+		return enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
+				ATT_ECODE_ATTR_NOT_FOUND, opdu, mtu);
+
+	len = enc_find_by_type_resp(matches, opdu, mtu);
+
+	g_slist_foreach(matches, (GFunc) g_free, NULL);
+	g_slist_free(matches);
+
+	return len;
+}
+
 static int handle_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct attribute *attrib = a;
@@ -522,6 +592,16 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 			write_value(start, value, vlen);
 		return;
 	case ATT_OP_FIND_BY_TYPE_REQ:
+		length = dec_find_by_type_req(ipdu, len, &start, &end,
+							&uuid, value, &vlen);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+
+		length = find_by_type(start, end, &uuid, value, vlen,
+							opdu, channel->mtu);
+		break;
 	case ATT_OP_READ_BLOB_REQ:
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
-- 
1.7.3.2

