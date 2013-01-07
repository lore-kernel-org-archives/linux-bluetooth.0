Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 5/5] health: Use SDP_IS_TEXT_STR()/SDP_IS_SEQ() where possible
Date: Mon,  7 Jan 2013 07:56:35 -0400
Message-Id: <1357559795-22090-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/health/hdp_util.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 5799ae5..5f81806 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -767,15 +767,13 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 		return TRUE;
 
 	list = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
-	if (list == NULL || (list->dtd != SDP_SEQ8 && list->dtd != SDP_SEQ16 &&
-							list->dtd != SDP_SEQ32))
+	if (list == NULL || !SDP_IS_SEQ(list->dtd))
 		return FALSE;
 
 	for (feat = list->val.dataseq; feat; feat = feat->next) {
 		sdp_data_t *data_type, *mdepid, *role_t, *desc_t;
 
-		if (feat->dtd != SDP_SEQ8 && feat->dtd != SDP_SEQ16 &&
-						feat->dtd != SDP_SEQ32)
+		if (!SDP_IS_SEQ(feat->dtd))
 			continue;
 
 		mdepid = feat->val.dataseq;
@@ -803,10 +801,8 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 		if (mdep != NULL)
 			*mdep = mdepid->val.uint8;
 
-		if (desc != NULL  && desc_t != NULL  &&
-					(desc_t->dtd == SDP_TEXT_STR8 ||
-					desc_t->dtd == SDP_TEXT_STR16  ||
-					desc_t->dtd == SDP_TEXT_STR32))
+		if (desc != NULL && desc_t != NULL &&
+						SDP_IS_TEXT_STR(desc_t->dtd))
 			*desc = g_strdup(desc_t->val.str);
 
 		return TRUE;
@@ -887,8 +883,7 @@ static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
 	sdp_data_t *iter;
 	int proto;
 
-	if (entry == NULL || (entry->dtd != SDP_SEQ8 &&
-			entry->dtd != SDP_SEQ16 && entry->dtd != SDP_SEQ32))
+	if (entry == NULL || !SDP_IS_SEQ(entry->dtd))
 		return FALSE;
 
 	iter = entry->val.dataseq;
@@ -920,8 +915,7 @@ static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
 		return TRUE;
 
 	pdl = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
-	if (pdl == NULL || (pdl->dtd != SDP_SEQ8 && pdl->dtd != SDP_SEQ16 &&
-							pdl->dtd != SDP_SEQ32))
+	if (pdl == NULL || !SDP_IS_SEQ(pdl->dtd))
 		return FALSE;
 
 	p0 = pdl->val.dataseq;
-- 
1.7.9.5

