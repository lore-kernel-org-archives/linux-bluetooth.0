Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/5] lib: Use SDP_IS_TEXT_STR()/SDP_IS_SEQ() where possible
Date: Mon,  7 Jan 2013 07:56:34 -0400
Message-Id: <1357559795-22090-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 2dac6c7..ca474cd 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -570,7 +570,7 @@ static void extract_svclass_uuid(sdp_data_t *data, uuid_t *uuid)
 {
 	sdp_data_t *d;
 
-	if (!data || data->dtd < SDP_SEQ8 || data->dtd > SDP_SEQ32)
+	if (!data || !SDP_IS_SEQ(data->dtd))
 		return;
 
 	d = data->val.dataseq;
@@ -1912,7 +1912,7 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
 	sdp_data_t *sdpdata = sdp_data_get(rec, attr);
 
 	*seqp = NULL;
-	if (sdpdata && sdpdata->dtd >= SDP_SEQ8 && sdpdata->dtd <= SDP_SEQ32) {
+	if (sdpdata && SDP_IS_SEQ(sdpdata->dtd)) {
 		sdp_data_t *d;
 		for (d = sdpdata->val.dataseq; d; d = d->next) {
 			uuid_t *u;
@@ -2128,9 +2128,7 @@ int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attrid, char *value,
 	sdp_data_t *sdpdata = sdp_data_get(rec, attrid);
 	if (sdpdata)
 		/* Verify that it is what the caller expects */
-		if (sdpdata->dtd == SDP_TEXT_STR8 ||
-				sdpdata->dtd == SDP_TEXT_STR16 ||
-				sdpdata->dtd == SDP_TEXT_STR32)
+		if (SDP_IS_TEXT_STR(sdpdata->dtd))
 			if ((int) strlen(sdpdata->val.str) < valuelen) {
 				strcpy(value, sdpdata->val.str);
 				return 0;
@@ -4744,7 +4742,7 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 
 	sdpdata = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
 
-	if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
+	if (!sdpdata || !SDP_IS_SEQ(sdpdata->dtd))
 		return sdp_get_uuidseq_attr(rec,
 					SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
 
@@ -4752,7 +4750,7 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 		sdp_data_t *dd;
 		sdp_list_t *subseq;
 
-		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
+		if (!SDP_IS_SEQ(d->dtd))
 			goto fail;
 
 		subseq = NULL;
-- 
1.7.9.5

