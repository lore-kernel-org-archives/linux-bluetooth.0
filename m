Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 13/14] Add att_put_u128
Date: Fri, 18 Feb 2011 20:29:32 -0200
Message-Id: <1298068173-16518-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATT protocol uses little endian byte order, before to add a UUID128
value in the PDU it needs to converted from host order to little endian.
---
 attrib/att.c |    4 ++--
 attrib/att.h |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 78ee254..d5374fc 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -115,7 +115,7 @@ uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	if (uuid->type == SDP_UUID16)
 		att_put_u16(uuid->value.uuid16, &pdu[5]);
 	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
+		att_put_u128(uuid->value.uuid128, &pdu[5]);
 
 	return min_len + length;
 }
@@ -345,7 +345,7 @@ uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, uuid_t *uuid,
 	if (uuid->type == SDP_UUID16)
 		att_put_u16(uuid->value.uuid16, &pdu[5]);
 	else
-		memcpy(&pdu[5], &uuid->value.uuid128, length);
+		att_put_u128(uuid->value.uuid128, &pdu[5]);
 
 	return min_len + length;
 }
diff --git a/attrib/att.h b/attrib/att.h
index 49788eb..c7766c8 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -195,6 +195,13 @@ static inline void att_put_u32(uint32_t src, void *dst)
 	bt_put_unaligned(htobl(src), (uint32_t *) dst);
 }
 
+static inline void att_put_u128(uint128_t src, void *dst)
+{
+	uint128_t *d128 = dst;
+
+	htob128(&src, d128);
+}
+
 void att_data_list_free(struct att_data_list *list);
 
 const char *att_ecode2str(uint8_t status);
-- 
1.7.4.1

