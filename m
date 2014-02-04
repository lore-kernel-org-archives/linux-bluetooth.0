Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v6 11/18] gatt: Add Discover All Primary Services
Date: Tue,  4 Feb 2014 14:53:42 -0300
Message-Id: <1391536429-8345-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
 <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch adds ATT Read By Group request handling to the attribute
server. It is the primitive to implement Discover All Primary Services
procedure.
---
 src/gatt.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/src/gatt.c b/src/gatt.c
index ec8f381..f00f52a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -114,6 +114,130 @@ static void send_error(int sk, uint8_t opcode, uint16_t handle, uint8_t ecode)
 	write_pdu(sk, pdu, plen);
 }
 
+static void read_by_group_resp(int sk, uint16_t start,
+					uint16_t end, bt_uuid_t *pattern)
+{
+	uint8_t opdu[ATT_DEFAULT_LE_MTU];
+	GList *list;
+	struct btd_attribute *last = NULL;
+	uint8_t *group_start, *group_end = NULL, *group_uuid;
+	unsigned int uuid_type = BT_UUID_UNSPEC;
+	size_t group_len = 0, plen = 0;
+
+	/*
+	 * Read By Group Type Response format:
+	 *    Attribute Opcode: 1 byte
+	 *    Length: 1 byte (size of each group)
+	 *    Group: start | end | <<UUID>>
+	 */
+
+	opdu[0] = ATT_OP_READ_BY_GROUP_RESP;
+	group_start = &opdu[2];
+	group_uuid = &opdu[6];
+
+	for (list = local_attribute_db; list;
+			last = list->data, list = g_list_next(list)) {
+		struct btd_attribute *attr = list->data;
+
+		if (attr->handle < start)
+			continue;
+
+		if (attr->handle > end)
+			break;
+
+		if (bt_uuid_cmp(&attr->type, pattern) != 0)
+			continue;
+
+		if (uuid_type != BT_UUID_UNSPEC &&
+						uuid_type != attr->type.type) {
+			/*
+			 * Groups should contain the same length: UUID16 and
+			 * UUID128 should be sent on different ATT PDUs
+			 */
+			break;
+		}
+
+		/*
+		 * MTU checking should not be shifted up, otherwise the
+		 * handle of last end group will not be set properly.
+		 */
+		if ((plen + group_len) >= ATT_DEFAULT_LE_MTU)
+			break;
+
+		/* Start Grouping handle */
+		att_put_u16(attr->handle, group_start);
+
+		/* Grouping <<UUID>>: Value is little endian */
+		memcpy(group_uuid, attr->value, attr->value_len);
+
+		if (last && group_end) {
+			att_put_u16(last->handle, group_end);
+			group_end += group_len;
+			plen += group_len;
+		}
+
+		/* Grouping initial settings: First grouping */
+		if (uuid_type == BT_UUID_UNSPEC) {
+			uuid_type = attr->type.type;
+
+			/* start(0xXXXX) | end(0xXXXX) | <<UUID>> */
+			group_len = 2 + 2 + bt_uuid_len(&attr->type);
+
+			/* 2: ATT Opcode and Length */
+			plen = 2 + group_len;
+
+			/* Size of each Attribute Data */
+			opdu[1] = group_len;
+
+			group_end = &opdu[4];
+		}
+
+		group_start += group_len;
+		group_uuid += group_len;
+	}
+
+	if (plen == 0) {
+		send_error(sk, ATT_OP_READ_BY_GROUP_REQ, start,
+						ATT_ECODE_ATTR_NOT_FOUND);
+		return;
+	}
+
+	if (group_end)
+		att_put_u16(last->handle, group_end);
+
+	write_pdu(sk, opdu, plen);
+}
+
+static void read_by_group(int sk, const uint8_t *ipdu, ssize_t ilen)
+{
+	uint16_t decoded, start, end;
+	bt_uuid_t pattern;
+
+	decoded = dec_read_by_grp_req(ipdu, ilen, &start, &end, &pattern);
+	if (decoded == 0) {
+		send_error(sk, ipdu[0], 0x0000, ATT_ECODE_INVALID_PDU);
+		return;
+	}
+
+	if (start > end || start == 0x0000) {
+		send_error(sk, ipdu[0], start, ATT_ECODE_INVALID_HANDLE);
+		return;
+	}
+
+	 /*
+	  * Restricting Read By Group Type to <<Primary>>.
+	  * Removing the checking below requires changes to support
+	  * dynamic values(defined in the upper layer) and additional
+	  * security verification.
+	  */
+	if (bt_uuid_cmp(&pattern, &primary_uuid) != 0) {
+		send_error(sk, ipdu[0], start, ATT_ECODE_UNSUPP_GRP_TYPE);
+		return;
+	}
+
+	read_by_group_resp(sk, start, end, &pattern);
+}
+
 static bool channel_handler_cb(struct io *io, void *user_data)
 {
 	uint8_t ipdu[ATT_DEFAULT_LE_MTU];
@@ -143,11 +267,14 @@ static bool channel_handler_cb(struct io *io, void *user_data)
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
-	case ATT_OP_READ_BY_GROUP_REQ:
 	case ATT_OP_SIGNED_WRITE_CMD:
 		send_error(sk, ipdu[0], 0x0000, ATT_ECODE_REQ_NOT_SUPP);
 		break;
 
+	case ATT_OP_READ_BY_GROUP_REQ:
+		read_by_group(sk, ipdu, ilen);
+		break;
+
 	/* Responses */
 	case ATT_OP_MTU_RESP:
 	case ATT_OP_FIND_INFO_RESP:
-- 
1.8.3.1

