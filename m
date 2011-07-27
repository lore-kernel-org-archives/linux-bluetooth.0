Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hcidump: decode extended flow spec option
Date: Wed, 27 Jul 2011 12:23:38 +0300
Message-Id: <1311758618-23826-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode EFS option in l2cap configuration packets
---
 parser/l2cap.c |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index f7f0c3e..6345f8d 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -277,14 +277,18 @@ static char *status2str(uint16_t status)
 static char *confresult2str(uint16_t result)
 {
 	switch (result) {
-	case 0x0000:
+	case L2CAP_CONF_SUCCESS:
 		return "Success";
-	case 0x0001:
+	case L2CAP_CONF_UNACCEPT:
 		return "Failure - unacceptable parameters";
-	case 0x0002:
+	case L2CAP_CONF_REJECT:
 		return "Failure - rejected (no reason provided)";
-	case 0x0003:
+	case L2CAP_CONF_UNKNOWN:
 		return "Failure - unknown options";
+	case L2CAP_CONF_PENDING:
+		return "Pending";
+	case L2CAP_CONF_EFS_REJECT:
+		return "Failure - flowspec reject";
 	default:
 		return "Reserved";
 	}
@@ -304,11 +308,11 @@ static char *inforesult2str(uint16_t result)
 static char *type2str(uint8_t type)
 {
 	switch (type) {
-	case 0x00:
+	case L2CAP_SERVTYPE_NOTRAFFIC:
 		return "No traffic";
-	case 0x01:
-		return "Best effort";
-	case 0x02:
+	case L2CAP_SERVTYPE_BESTEFFORT:
+		return "Best Effort";
+	case L2CAP_SERVTYPE_GUARANTEED:
 		return "Guaranteed";
 	default:
 		return "Reserved";
@@ -477,6 +481,25 @@ static void conf_rfc(void *ptr, int len, int in, uint16_t cid)
 	printf(")");
 }
 
+static void conf_efs(void *ptr)
+{
+	uint8_t id, ser_type;
+	uint16_t max_sdu;
+	uint32_t sdu_itime, access_lat, flush_to;
+
+	id = get_val(ptr, sizeof(id));
+	ser_type = get_val(ptr + 1, sizeof(ser_type));
+	max_sdu = get_val(ptr + 2, sizeof(max_sdu));
+	sdu_itime = get_val(ptr + 4, sizeof(sdu_itime));
+	access_lat = get_val(ptr + 8, sizeof(access_lat));
+	flush_to = get_val(ptr + 12, sizeof(flush_to));
+
+	printf("EFS (Id 0x%02x, SerType %s, MaxSDU 0x%04x, SDUitime 0x%08x, "
+			"AccLat 0x%08x, FlushTO 0x%08x)",
+			id, type2str(ser_type), max_sdu, sdu_itime,
+			access_lat, flush_to);
+}
+
 static void conf_fcs(void *ptr, int len)
 {
 	uint8_t fcs;
@@ -489,6 +512,7 @@ static void conf_fcs(void *ptr, int len)
 
 static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 {
+	int indent = 0;
 	p_indent(level, 0);
 	while (len > 0) {
 		l2cap_conf_opt *h = ptr;
@@ -499,6 +523,11 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 		if (h->type & 0x80)
 			printf("[");
 
+		if (indent++) {
+			printf("\n");
+			p_indent(level, 0);
+		}
+
 		switch (h->type & 0x7f) {
 		case L2CAP_CONF_MTU:
 			set_mode(in, cid, 0x00);
@@ -527,6 +556,10 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 			conf_fcs(h->val, h->len);
 			break;
 
+		case L2CAP_CONF_EFS:
+			conf_efs(h->val);
+			break;
+
 		default:
 			printf("Unknown (type %2.2x, len %d)", h->type & 0x7f, h->len);
 			break;
@@ -562,6 +595,9 @@ static void conf_list(int level, uint8_t *list, int len)
 		case L2CAP_CONF_FCS:
 			printf("FCS ");
 			break;
+		case L2CAP_CONF_EFS:
+			printf("EFS ");
+			break;
 		default:
 			printf("%2.2x ", list[i] & 0x7f);
 			break;
-- 
1.7.4.1

