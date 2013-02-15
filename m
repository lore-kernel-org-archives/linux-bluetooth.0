Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/13] lib: Cleanup coding style in sdp_get_proto_descs()
Date: Fri, 15 Feb 2013 11:07:47 -0400
Message-Id: <1360940876-6314-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 57abfd8..3c45ac8 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1864,25 +1864,28 @@ static int sdp_get_proto_descs(uint16_t attr_id, const sdp_record_t *rec,
 							sdp_list_t **pap)
 {
 	sdp_data_t *pdlist, *curr;
-	sdp_list_t *ap = 0;
+	sdp_list_t *ap = NULL;
 
 	pdlist = sdp_data_get(rec, attr_id);
 	if (pdlist == NULL) {
 		errno = ENODATA;
 		return -1;
 	}
-	SDPDBG("AP type : 0%x\n", pdlist->dtd);
+
+	SDPDBG("Attribute value type: 0x%02x\n", pdlist->dtd);
 
 	if (attr_id == SDP_ATTR_ADD_PROTO_DESC_LIST)
 		pdlist = pdlist->val.dataseq;
 
 	for (; pdlist; pdlist = pdlist->next) {
-		sdp_list_t *pds = 0;
+		sdp_list_t *pds = NULL;
 		for (curr = pdlist->val.dataseq; curr; curr = curr->next)
 			pds = sdp_list_append(pds, curr->val.dataseq);
 		ap = sdp_list_append(ap, pds);
 	}
+
 	*pap = ap;
+
 	return 0;
 }
 
-- 
1.7.9.5

