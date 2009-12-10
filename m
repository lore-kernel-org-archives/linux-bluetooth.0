Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
Date: Thu, 10 Dec 2009 11:50:15 +0100
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200911131343.21326.jcaden@libresoft.es> <200911171208.13972.jcaden@libresoft.es> <1260030350.3041.25.camel@violet>
In-Reply-To: <1260030350.3041.25.camel@violet>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912101150.15707.jcaden@libresoft.es>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

here is the corrected patch, without gpg :)


diff --git a/lib/sdp.c b/lib/sdp.c
index 822ec1a..ddf2d1a 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4621,3 +4621,113 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
 {
 	return session->tid++;
 }
+
+/*
+ * Set the supported features
+ */
+int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
+{
+	const sdp_list_t *p, *r;
+	sdp_data_t *feat, *seq_feat;
+	int seqlen, i, err;
+	void **seqDTDs, **seqVals;
+
+	err = -1;
+	i = 0;
+	seqlen = sdp_list_len(sf);
+	seqDTDs = malloc(seqlen * sizeof(void *));
+	if (!seqDTDs)
+		return err;
+	seqVals = malloc(seqlen * sizeof(void *));
+	if (!seqVals) {
+		free(seqDTDs);
+		return err;
+	}
+
+	for (p = sf; p; p = p->next) {
+		int plen, j;
+		void **dtds, **vals;
+
+		plen = sdp_list_len(p->data);
+		dtds = malloc(plen * sizeof(void *));
+		if (!dtds)
+			goto set_sup_feat_exit;
+		vals = malloc(plen * sizeof(void *));
+		if (!vals) {
+			free(dtds);
+			goto set_sup_feat_exit;
+		}
+		j = 0;
+		for (r = p->data; r; r = r->next) {
+			sdp_data_t *data = (sdp_data_t*)r->data;
+			dtds[j] = &data->dtd;
+			vals[j] = &data->val;
+			j++;
+		}
+		feat = sdp_seq_alloc(dtds, vals, plen);
+		free(dtds);
+		free(vals);
+		if (!feat)
+			goto set_sup_feat_exit;
+		seqDTDs[i] = &feat->dtd;
+		seqVals[i] = feat;
+		i++;
+	}
+	seq_feat = sdp_seq_alloc(seqDTDs, seqVals, seqlen);
+	if (!seq_feat)
+		goto set_sup_feat_exit;
+	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
+
+	err = 0;
+
+set_sup_feat_exit:
+	free(seqVals);
+	free(seqDTDs);
+	return err;
+}
+
+/*
+ * Get the supported features
+ * If an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
+{
+	sdp_data_t * sdpdata, *d;
+	sdp_list_t * next;
+	*seqp = NULL;
+
+	sdpdata = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
+
+	if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
+		return sdp_get_uuidseq_attr(rec,
+				     SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
+
+	for (d = sdpdata->val.dataseq; d; d = d->next) {
+		sdp_data_t *dd;
+		sdp_list_t *subseq;
+		subseq = NULL;
+		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
+			goto fail;
+		for (dd = d->val.dataseq; dd; dd = dd->next) {
+			sdp_data_t *data;
+			if (dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&
+						dd->dtd != SDP_TEXT_STR8)
+				goto fail;
+			data = sdp_data_alloc(dd->dtd, &dd->val);
+			if (data)
+				subseq = sdp_list_append(subseq, data);
+		}
+		*seqp = sdp_list_append(*seqp, subseq);
+	}
+	return 0;
+
+fail:
+	while (*seqp) {
+		next = (*seqp)->next;
+		sdp_list_free(*seqp, free);
+		*seqp = next;
+	}
+	errno = EINVAL;
+	return -1;
+}
+
diff --git a/lib/sdp.h b/lib/sdp.h
index 375261e..b493985 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -244,13 +244,16 @@ extern "C" {
 #define SDP_ATTR_GROUP_ID			0x0200
 #define SDP_ATTR_IP_SUBNET			0x0200
 #define SDP_ATTR_VERSION_NUM_LIST		0x0200
+#define SDP_ATTR_SUPPORTED_FEATURES_LIST	0x0200
 #define SDP_ATTR_SVCDB_STATE			0x0201
 
 #define SDP_ATTR_SERVICE_VERSION		0x0300
 #define SDP_ATTR_EXTERNAL_NETWORK		0x0301
 #define SDP_ATTR_SUPPORTED_DATA_STORES_LIST	0x0301
+#define SDP_ATTR_DATA_EXCHANGE_SPEC		0x0301
 #define SDP_ATTR_FAX_CLASS1_SUPPORT		0x0302
 #define SDP_ATTR_REMOTE_AUDIO_VOLUME_CONTROL	0x0302
+#define SDP_ATTR_MCAP_SUPPORTED_PROCEDURES	0x0302
 #define SDP_ATTR_FAX_CLASS20_SUPPORT		0x0303
 #define SDP_ATTR_SUPPORTED_FORMATS_LIST		0x0303
 #define SDP_ATTR_FAX_CLASS2_SUPPORT		0x0304
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index ee39df8..bebb745 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -585,6 +585,20 @@ static inline int sdp_get_icon_url(const sdp_record_t *rec, char *str, int len)
 	return sdp_get_string_attr(rec, SDP_ATTR_ICON_URL, str, len);
 }
 
+/*
+ * Set the supported features
+ * sf should be a list of list with each feature data
+ * Returns 0 on success -1 on fail
+ */
+int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf);
+
+/*
+ * Get the supported features
+ * seqp is set to a list of list with each feature data
+ * Returns 0 on success, if an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp);
+
 sdp_record_t *sdp_extract_pdu(const uint8_t *pdata, int bufsize, int *scanned);
 sdp_record_t *sdp_copy_record(sdp_record_t *rec);
 
