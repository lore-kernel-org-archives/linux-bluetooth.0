Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 08/13] lib: Validate DTDs when parsing LanguageBaseAttributeIDList
Date: Fri, 15 Feb 2013 11:07:51 -0400
Message-Id: <1360940876-6314-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also check if the required number of entries is present.
---
 lib/sdp.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 782d9bd..77dafaa 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2019,19 +2019,30 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
 		errno = ENODATA;
 		return -1;
 	}
+
+	if (!SDP_IS_SEQ(sdpdata->dtd))
+		goto invalid;
 	curr_data = sdpdata->val.dataseq;
+
 	while (curr_data) {
-		sdp_data_t *pCode = curr_data;
-		sdp_data_t *pEncoding;
-		sdp_data_t *pOffset;
+		sdp_data_t *pCode, *pEncoding, *pOffset;
+
+		pCode = curr_data;
+		if (pCode->dtd != SDP_UINT16)
+			goto invalid;
+
+		/* LanguageBaseAttributeIDList entries are always grouped as
+		 * triplets */
+		if (!pCode->next || !pCode->next->next)
+			goto invalid;
 
 		pEncoding = pCode->next;
-		if (!pEncoding)
-			break;
+		if (pEncoding->dtd != SDP_UINT16)
+			goto invalid;
 
 		pOffset = pEncoding->next;
-		if (!pOffset)
-			break;
+		if (pOffset->dtd != SDP_UINT16)
+			goto invalid;
 
 		lang = malloc(sizeof(sdp_lang_attr_t));
 		if (!lang) {
@@ -2051,6 +2062,13 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
 	}
 
 	return 0;
+
+invalid:
+	sdp_list_free(*langSeq, free);
+	*langSeq = NULL;
+	errno = EINVAL;
+
+	return -1;
 }
 
 int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
-- 
1.7.9.5

