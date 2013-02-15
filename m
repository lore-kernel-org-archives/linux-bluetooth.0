Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 05/13] lib: Fix missing DTD validation while accessing SDP data elements
Date: Fri, 15 Feb 2013 11:07:48 -0400
Message-Id: <1360940876-6314-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is necessary to validate the sdp_data_t "dtd" field before accessing
the "val" union members, specially when handling SDP_SEQ*, SDP_ALT* and
SDP_STR* elements, otherwise remote devices can trigger memory
corruption by passing invalid data elements where others are expected.
---
 lib/sdp.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3c45ac8..9c1eeb5 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1874,19 +1874,41 @@ static int sdp_get_proto_descs(uint16_t attr_id, const sdp_record_t *rec,
 
 	SDPDBG("Attribute value type: 0x%02x\n", pdlist->dtd);
 
-	if (attr_id == SDP_ATTR_ADD_PROTO_DESC_LIST)
+	if (attr_id == SDP_ATTR_ADD_PROTO_DESC_LIST) {
+		if (!SDP_IS_SEQ(pdlist->dtd)) {
+			errno = EINVAL;
+			return -1;
+		}
 		pdlist = pdlist->val.dataseq;
+	}
 
 	for (; pdlist; pdlist = pdlist->next) {
 		sdp_list_t *pds = NULL;
-		for (curr = pdlist->val.dataseq; curr; curr = curr->next)
+
+		if (!SDP_IS_SEQ(pdlist->dtd) && !SDP_IS_ALT(pdlist->dtd))
+			goto failed;
+
+		for (curr = pdlist->val.dataseq; curr; curr = curr->next) {
+			if (!SDP_IS_SEQ(curr->dtd)) {
+				sdp_list_free(pds, NULL);
+				goto failed;
+			}
 			pds = sdp_list_append(pds, curr->val.dataseq);
+		}
+
 		ap = sdp_list_append(ap, pds);
 	}
 
 	*pap = ap;
 
 	return 0;
+
+failed:
+	sdp_list_foreach(ap, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(ap, NULL);
+	errno = EINVAL;
+
+	return -1;
 }
 
 int sdp_get_access_protos(const sdp_record_t *rec, sdp_list_t **pap)
-- 
1.7.9.5

