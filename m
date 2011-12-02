Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/5] hdp_util: Fix potential NULL pointer dereference
Date: Fri,  2 Dec 2011 11:56:34 +0100
Message-Id: <1322823396-5941-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1322823396-5941-3-git-send-email-sancane@gmail.com>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
 <1322823396-5941-2-git-send-email-sancane@gmail.com>
 <1322823396-5941-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sdp_data_get can return NULL, we have to check the provided return
value before using it.
---
 health/hdp_util.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/health/hdp_util.c b/health/hdp_util.c
index 7a234c1..4d546ad 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -758,9 +758,8 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 		return TRUE;
 
 	list = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
-
-	if (list->dtd != SDP_SEQ8 && list->dtd != SDP_SEQ16 &&
-							list->dtd != SDP_SEQ32)
+	if (list == NULL || (list->dtd != SDP_SEQ8 && list->dtd != SDP_SEQ16 &&
+							list->dtd != SDP_SEQ32))
 		return FALSE;
 
 	for (feat = list->val.dataseq; feat; feat = feat->next) {
@@ -911,8 +910,8 @@ static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
 		return TRUE;
 
 	pdl = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
-	if (pdl->dtd != SDP_SEQ8 && pdl->dtd != SDP_SEQ16 &&
-							pdl->dtd != SDP_SEQ32)
+	if (pdl == NULL || (pdl->dtd != SDP_SEQ8 && pdl->dtd != SDP_SEQ16 &&
+							pdl->dtd != SDP_SEQ32))
 		return FALSE;
 
 	p0 = pdl->val.dataseq;
@@ -935,7 +934,7 @@ static gboolean hdp_get_add_prot_desc_list(const sdp_record_t *rec,
 		return TRUE;
 
 	pdl = sdp_data_get(rec, SDP_ATTR_ADD_PROTO_DESC_LIST);
-	if (pdl->dtd != SDP_SEQ8)
+	if (pdl == NULL || pdl->dtd != SDP_SEQ8)
 		return FALSE;
 	pdl = pdl->val.dataseq;
 	if (pdl->dtd != SDP_SEQ8)
-- 
1.7.7.4

