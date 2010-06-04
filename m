Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 09/32] Adds functions to get remote suported features from its SDP record
Date: Fri,  4 Jun 2010 10:30:02 +0200
Message-Id: <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp_util.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/health/hdp_util.c b/health/hdp_util.c
index 731154b..0b39151 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -781,11 +781,6 @@ static gboolean register_data_exchange_spec(struct hdp_config *config,
 	return TRUE;
 }
 
-GSList *hdp_get_end_points(const sdp_record_t *rec)
-{
-	return NULL;
-}
-
 static gboolean register_mcap_features(sdp_record_t *sdp_record)
 {
 	sdp_data_t *mcap_proc;
@@ -887,3 +882,72 @@ gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val)
 	*val = exspec->val.uint8;
 	return TRUE;
 }
+
+static gint cmp_feat_mdep(gconstpointer a, gconstpointer b)
+{
+	const struct hdp_supp_fts *fts = a;
+	const guint8 *mdep = b;
+
+	if (fts->mdepid == *mdep)
+		return 0;
+	return -1;
+}
+
+static GSList *get_feature(GSList *epl, sdp_data_t *feat_seq)
+{
+	struct hdp_supp_fts *fts;
+	struct hdp_feature *feat;
+	GSList *l;
+	sdp_data_t *mdepid, *dtype, *role, *desc;
+
+	mdepid = feat_seq;
+	if (!mdepid || mdepid->dtd != SDP_UINT8)
+		return epl;
+	dtype = mdepid->next;
+	if (!dtype || dtype->dtd != SDP_UINT16)
+		return epl;
+	role = dtype->next;
+	if (!role || role->dtd != SDP_UINT8)
+		return epl;
+	desc = role->next;
+
+	l = g_slist_find_custom(epl, &mdepid->val.uint8, cmp_feat_mdep);
+	if (l) {
+		fts = l->data;
+		if (fts->role != role->val.uint8)
+			return epl;
+	} else {
+		fts = g_new0(struct hdp_supp_fts, 1);
+		fts->mdepid = mdepid->val.uint8;
+		fts->role = role->val.uint8;
+		epl = g_slist_prepend(epl, fts);
+	}
+
+	feat = g_new0(struct hdp_feature, 1);
+	feat->dtype = dtype->val.uint16;
+	if (desc && desc->dtd == SDP_TEXT_STR8)
+		feat->dscr = g_strdup(desc->val.str);
+	fts->features = g_slist_prepend(fts->features, feat);
+	return epl;
+}
+
+GSList *hdp_get_end_points(const sdp_record_t *rec)
+{
+	GSList *epl = NULL;
+	sdp_data_t *end_points, *l;
+
+	end_points = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
+
+	if (end_points->dtd != SDP_SEQ8)
+		return NULL;
+
+	for (l = end_points->val.dataseq; l; l = l->next) {
+		if (l->dtd != SDP_SEQ8)
+			continue;
+		epl = get_feature(epl, l->val.dataseq);
+	}
+
+	g_slist_foreach(epl, print_features, NULL);
+
+	return epl;
+}
-- 
1.6.3.3

