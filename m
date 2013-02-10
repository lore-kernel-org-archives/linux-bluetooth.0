Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 09/13] lib: Validate DTDs when parsing BluetoothProfileDescriptorList
Date: Sun, 10 Feb 2013 17:26:33 -0400
Message-Id: <1360531597-3506-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "seq->val.dataseq != NULL" check is also removed from the for()
statement because it should be done after verifying that the data
element is a sequence (inside the "if (SDP_IS_SEQ(...))" block.)
---
 lib/sdp.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index ba55fc4..c5bc16e 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2078,11 +2078,15 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 
 	*profDescSeq = NULL;
 	sdpdata = sdp_data_get(rec, SDP_ATTR_PFILE_DESC_LIST);
-	if (!sdpdata || !sdpdata->val.dataseq) {
+	if (sdpdata == NULL) {
 		errno = ENODATA;
 		return -1;
 	}
-	for (seq = sdpdata->val.dataseq; seq && seq->val.dataseq; seq = seq->next) {
+
+	if (!SDP_IS_SEQ(sdpdata->dtd) || sdpdata->val.dataseq == NULL)
+		goto invalid;
+
+	for (seq = sdpdata->val.dataseq; seq; seq = seq->next) {
 		uuid_t *uuid = NULL;
 		uint16_t version = 0x100;
 
@@ -2094,13 +2098,21 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 				seq = next;
 			}
 		} else if (SDP_IS_SEQ(seq->dtd)) {
-			sdp_data_t *puuid = seq->val.dataseq;
-			sdp_data_t *pVnum = seq->val.dataseq->next;
-			if (puuid && pVnum) {
-				uuid = &puuid->val.uuid;
-				version = pVnum->val.uint16;
-			}
-		}
+			sdp_data_t *puuid, *pVnum;
+
+			puuid = seq->val.dataseq;
+			if (puuid == NULL || !SDP_IS_UUID(puuid->dtd))
+				goto invalid;
+
+			uuid = &puuid->val.uuid;
+
+			pVnum = puuid->next;
+			if (pVnum == NULL || pVnum->dtd != SDP_UINT16)
+				goto invalid;
+
+			version = pVnum->val.uint16;
+		} else
+			goto invalid;
 
 		if (uuid != NULL) {
 			profDesc = malloc(sizeof(sdp_profile_desc_t));
@@ -2119,6 +2131,13 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 		}
 	}
 	return 0;
+
+invalid:
+	sdp_list_free(*profDescSeq, free);
+	*profDescSeq = NULL;
+	errno = EINVAL;
+
+	return -1;
 }
 
 int sdp_get_server_ver(const sdp_record_t *rec, sdp_list_t **u16)
-- 
1.7.9.5

