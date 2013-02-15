Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo
	<anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: [PATCH BlueZ 03/13] lib: Reuse identical code in sdp_get_{add,}_access_protos()
Date: Fri, 15 Feb 2013 10:56:17 -0400
Message-Id: <1360940187-5202-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org>

sdp_get_access_protos() and sdp_get_add_access_protos() do almost
exactly the same thing, except for an additional statement for the
latter.
---
 lib/sdp.c |   34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 8cfdde1..57abfd8 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1860,18 +1860,22 @@ sdp_data_t *sdp_get_proto_desc(sdp_list_t *list, int proto)
 	return NULL;
 }
 
-int sdp_get_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
+static int sdp_get_proto_descs(uint16_t attr_id, const sdp_record_t *rec,
+							sdp_list_t **pap)
 {
 	sdp_data_t *pdlist, *curr;
 	sdp_list_t *ap = 0;
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
+	pdlist = sdp_data_get(rec, attr_id);
 	if (pdlist == NULL) {
 		errno = ENODATA;
 		return -1;
 	}
 	SDPDBG("AP type : 0%x\n", pdlist->dtd);
 
+	if (attr_id == SDP_ATTR_ADD_PROTO_DESC_LIST)
+		pdlist = pdlist->val.dataseq;
+
 	for (; pdlist; pdlist = pdlist->next) {
 		sdp_list_t *pds = 0;
 		for (curr = pdlist->val.dataseq; curr; curr = curr->next)
@@ -1882,28 +1886,14 @@ int sdp_get_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
 	return 0;
 }
 
-int sdp_get_add_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
+int sdp_get_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
 {
-	sdp_data_t *pdlist, *curr;
-	sdp_list_t *ap = 0;
-
-	pdlist = sdp_data_get(rec, SDP_ATTR_ADD_PROTO_DESC_LIST);
-	if (pdlist == NULL) {
-		errno = ENODATA;
-		return -1;
-	}
-	SDPDBG("AP type : 0%x\n", pdlist->dtd);
-
-	pdlist = pdlist->val.dataseq;
+	return sdp_get_proto_descs(SDP_ATTR_PROTO_DESC_LIST, rec, pap);
+}
 
-	for (; pdlist; pdlist = pdlist->next) {
-		sdp_list_t *pds = 0;
-		for (curr = pdlist->val.dataseq; curr; curr = curr->next)
-			pds = sdp_list_append(pds, curr->val.dataseq);
-		ap = sdp_list_append(ap, pds);
-	}
-	*pap = ap;
-	return 0;
+int sdp_get_add_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
+{
+	return sdp_get_proto_descs(SDP_ATTR_ADD_PROTO_DESC_LIST, rec, pap);
 }
 
 int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
-- 
1.7.9.5

