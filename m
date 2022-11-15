Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A36C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiKOAaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiKOAaq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:46 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2961D0DB
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 136so11776653pga.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Klz1V5+/kIG/8boWajkUG+hO/oaRhLwe6+96Y8lDrmU=;
        b=BFEW+a14CLoCeWm/bKNakhvvLnHYHUlGy48eszsRFqwL4COAHzqlKjqJprwisHLzxz
         Ae/n7RpS/75Vnqoyu3gNARmE1OItuOXVS431kOHU16IeEZ6YVHojGzt9mw6Ye3X8MWYp
         fQZ+S66FV1ieVZ0EFOmoHJ1m1UX+2O9EcWDgMl03ouYrpH2SNE2ZZjHJt1z/bTu/z6Pw
         F1oWL8jHujCOfiHDRdVdIW75FUyaB+ZusT41+7xBwrEvkq7QugJQELDbbrAT/sVGZsjh
         8pcPKw3vr5ZUXxLW9ivW8uUzlWF96QsQtPnYYBon7htUSM8/Oq73ZY4AV2cCQJetBW0C
         yyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Klz1V5+/kIG/8boWajkUG+hO/oaRhLwe6+96Y8lDrmU=;
        b=YUaolrxFGrmsT2ejCsEOlkHfs7pyqJoQenf+K5X3TdgVtf835yy8org1cvUJ/rtLLW
         Fty8aEi0pF2lVG7gYjms15nCy2umwn6ny3by/CnRtRbY11VB9G+y6G4ByI0ctguaqkBl
         Sie75EP8OxhvXRVKbv/OpSuT8MgS50sadsLfvTjmHGRzkJYSS1KXzOhGM1zdRejy8pAR
         r2qVQXYh91IJyMIfTyweMVEMmV1QIYYVDiS/YRKF6W3U9IfbXx1HpDLPmN1wR2xqMeu9
         M2GLW4pjnP/HKhFEsRJSA1bngTScz6LWPqvrkCP51fp/iQExuXH0WitQxo1MpjIfhB2q
         NlXA==
X-Gm-Message-State: ANoB5pmLOmAGPxr+yx+ucBoBbwtrZ+NQWnnkNbSXJYmMpFlAmtSxRCYT
        86sqtlT6MmGd7BMa+DZtkKv8rOASUzw=
X-Google-Smtp-Source: AA0mqf6PTby+CxxvlTAdjgpuN5/M5ABq04cbHgNNbcTe/3qloB778RYPgFnWFDdRwj4bjWOiNwxMoQ==
X-Received: by 2002:a63:5203:0:b0:46e:f23a:e9aa with SMTP id g3-20020a635203000000b0046ef23ae9aamr13392207pgb.428.1668472243532;
        Mon, 14 Nov 2022 16:30:43 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] shared/bap: Make use of util_iov helpers
Date:   Mon, 14 Nov 2022 16:30:35 -0800
Message-Id: <20221115003038.2134340-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of util_iov helpers instead of reimplementing them.
---
 src/shared/bap.c | 183 +++++++++++++----------------------------------
 1 file changed, 51 insertions(+), 132 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c3c0d596fe91..25369e619051 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,76 +262,6 @@ static bool bap_db_match(const void *data, const void *match_data)
 	return (bdb->db == db);
 }
 
-static void *iov_add(struct iovec *iov, size_t len)
-{
-	void *data;
-
-	data = iov->iov_base + iov->iov_len;
-	iov->iov_len += len;
-
-	return data;
-}
-
-static void *iov_add_mem(struct iovec *iov, size_t len, const void *d)
-{
-	void *data;
-
-	data = iov->iov_base + iov->iov_len;
-	iov->iov_len += len;
-
-	memcpy(data, d, len);
-
-	return data;
-}
-
-static void iov_free(void *data)
-{
-	struct iovec *iov = data;
-
-	if (!iov)
-		return;
-
-	free(iov->iov_base);
-	free(iov);
-}
-
-static void iov_memcpy(struct iovec *iov, void *src, size_t len)
-{
-	iov->iov_base = realloc(iov->iov_base, len);
-	iov->iov_len = len;
-	memcpy(iov->iov_base, src, len);
-}
-
-static int iov_memcmp(struct iovec *iov1, struct iovec *iov2)
-{
-	if (!iov1)
-		return 1;
-
-	if (!iov2)
-		return -1;
-
-	if (iov1->iov_len != iov2->iov_len)
-		return iov1->iov_len - iov2->iov_len;
-
-	return memcmp(iov1->iov_base, iov2->iov_base, iov1->iov_len);
-}
-
-static struct iovec *iov_dup(struct iovec *iov, size_t len)
-{
-	struct iovec *dup;
-	size_t i;
-
-	if (!iov)
-		return NULL;
-
-	dup = new0(struct iovec, len);
-
-	for (i = 0; i < len; i++)
-		iov_memcpy(&dup[i], iov[i].iov_base, iov[i].iov_len);
-
-	return dup;
-}
-
 unsigned int bt_bap_pac_register(bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy)
@@ -407,27 +337,27 @@ static void pac_foreach(void *data, void *user_data)
 	struct bt_pac_metadata *meta;
 
 	if (!iov->iov_len) {
-		rsp = iov_add(iov, sizeof(*rsp));
+		rsp = util_iov_push(iov, sizeof(*rsp));
 		rsp->num_pac = 0;
 	} else
 		rsp = iov->iov_base;
 
 	rsp->num_pac++;
 
-	p = iov_add(iov, sizeof(*p));
+	p = util_iov_push(iov, sizeof(*p));
 	p->codec.id = pac->codec.id;
 
 	if (pac->data) {
 		p->cc_len = pac->data->iov_len;
-		iov_add_mem(iov, p->cc_len, pac->data->iov_base);
+		util_iov_push_mem(iov, p->cc_len, pac->data->iov_base);
 	} else
 		p->cc_len = 0;
 
-	meta = iov_add(iov, sizeof(*meta));
+	meta = util_iov_push(iov, sizeof(*meta));
 
 	if (pac->metadata) {
 		meta->len = pac->metadata->iov_len;
-		iov_add_mem(iov, meta->len, pac->metadata->iov_base);
+		util_iov_push_mem(iov, meta->len, pac->metadata->iov_base);
 	} else
 		meta->len = 0;
 }
@@ -814,19 +744,6 @@ static void ase_new(struct bt_ascs *ascs, int i)
 	ascs->ase[i] = ase;
 }
 
-static void *iov_pull_mem(struct iovec *iov, size_t len)
-{
-	void *data = iov->iov_base;
-
-	if (iov->iov_len < len)
-		return NULL;
-
-	iov->iov_base += len;
-	iov->iov_len -= len;
-
-	return data;
-}
-
 static bool bap_codec_equal(const struct bt_bap_codec *c1,
 				const struct bt_bap_codec *c2)
 {
@@ -852,7 +769,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	ep->stream = stream;
 	stream->lpac = lpac;
 	stream->rpac = rpac;
-	stream->cc = iov_dup(data, 1);
+	stream->cc = util_iov_dup(data, 1);
 	stream->client = client;
 
 	queue_push_tail(bap->streams, stream);
@@ -1050,8 +967,8 @@ static void bap_stream_free(void *data)
 	queue_foreach(stream->links, bap_stream_unlink, stream);
 	queue_destroy(stream->links, NULL);
 	stream_io_unref(stream->io);
-	iov_free(stream->cc);
-	iov_free(stream->meta);
+	util_iov_free(stream->cc, 1);
+	util_iov_free(stream->meta, 1);
 	free(stream);
 }
 
@@ -1454,13 +1371,13 @@ static uint8_t stream_config(struct bt_bap_stream *stream, struct iovec *cc,
 	/* TODO: Wait for pac->ops response */
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	if (!iov_memcmp(stream->cc, cc)) {
+	if (!util_iov_memcmp(stream->cc, cc)) {
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 		return 0;
 	}
 
-	iov_free(stream->cc);
-	stream->cc = iov_dup(cc, 1);
+	util_iov_free(stream->cc, 1);
+	stream->cc = util_iov_dup(cc, 1);
 
 	if (pac->ops && pac->ops->config)
 		pac->ops->config(stream, cc, NULL, ep_config_cb,
@@ -1497,7 +1414,7 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	if (iov->iov_len < req->cc_len)
 		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
 
-	cc.iov_base = iov_pull_mem(iov, req->cc_len);
+	cc.iov_base = util_iov_pull_mem(iov, req->cc_len);
 	cc.iov_len = req->cc_len;
 
 	if (!bap_print_cc(cc.iov_base, cc.iov_len, bap->debug_func,
@@ -1548,7 +1465,7 @@ static uint8_t ascs_config(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_config *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	DBG(bap, "codec 0x%02x phy 0x%02x latency %u", req->codec.id, req->phy,
 							req->latency);
@@ -1616,7 +1533,7 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_ascs_qos *req;
 	struct bt_bap_qos qos;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	memset(&qos, 0, sizeof(qos));
 
@@ -1653,8 +1570,8 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	iov_free(stream->meta);
-	stream->meta = iov_dup(meta, 1);
+	util_iov_free(stream->meta, 1);
+	stream->meta = util_iov_dup(meta, 1);
 
 	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
@@ -1677,7 +1594,7 @@ static bool bap_print_ltv(const char *label, void *data, size_t len,
 	util_debug(func, user_data, "Length %zu", iov.iov_len);
 
 	for (i = 0; iov.iov_len > 1; i++) {
-		struct bt_ltv *ltv = iov_pull_mem(&iov, sizeof(*ltv));
+		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
 		uint8_t *data;
 
 		if (!ltv) {
@@ -1689,7 +1606,7 @@ static bool bap_print_ltv(const char *label, void *data, size_t len,
 		util_debug(func, user_data, "%s #%u: len %u type %u",
 					label, i, ltv->len, ltv->type);
 
-		data = iov_pull_mem(&iov, ltv->len - 1);
+		data = util_iov_pull_mem(&iov, ltv->len - 1);
 		if (!data) {
 			util_debug(func, user_data, "Unable to parse %s",
 								label);
@@ -1728,7 +1645,7 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
-	meta.iov_base = iov_pull_mem(iov, req->meta.len);
+	meta.iov_base = util_iov_pull_mem(iov, req->meta.len);
 	meta.iov_len = req->meta.len;
 
 	if (!bap_print_metadata(meta.iov_base, meta.iov_len, bap->debug_func,
@@ -1756,7 +1673,7 @@ static uint8_t ascs_enable(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_enable *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->meta.ase);
 	if (!ep) {
@@ -1820,7 +1737,7 @@ static uint8_t ascs_start(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_start *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
 	if (!ep) {
@@ -1892,7 +1809,7 @@ static uint8_t ascs_disable(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_disable *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
 	if (!ep) {
@@ -1967,7 +1884,7 @@ static uint8_t ascs_stop(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_stop *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
 	if (!ep) {
@@ -1995,8 +1912,8 @@ static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	iov_free(stream->meta);
-	stream->meta = iov_dup(meta, 1);
+	util_iov_free(stream->meta, 1);
+	stream->meta = util_iov_dup(meta, 1);
 
 	return 0;
 }
@@ -2032,7 +1949,7 @@ static uint8_t ascs_metadata(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_metadata *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
 	if (!ep) {
@@ -2076,7 +1993,7 @@ static uint8_t ascs_release(struct bt_ascs *ascs, struct bt_bap *bap,
 	struct bt_bap_endpoint *ep;
 	struct bt_ascs_release *req;
 
-	req = iov_pull_mem(iov, sizeof(*req));
+	req = util_iov_pull_mem(iov, sizeof(*req));
 
 	ep = bap_get_endpoint_id(bap, bap->ldb, req->ase);
 	if (!ep) {
@@ -2177,7 +2094,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	hdr = iov_pull_mem(&iov, sizeof(*hdr));
+	hdr = util_iov_pull_mem(&iov, sizeof(*hdr));
 	rsp = ascs_ase_cp_rsp_new(hdr->op);
 
 	for (handler = handlers; handler && handler->str; handler++) {
@@ -2214,7 +2131,7 @@ respond:
 	gatt_db_attribute_notify(attrib, rsp->iov_base, rsp->iov_len, att);
 	gatt_db_attribute_write_result(attrib, id, ret);
 
-	iov_free(rsp);
+	util_iov_free(rsp, 1);
 }
 
 static struct bt_ascs *ascs_new(struct gatt_db *db)
@@ -2333,8 +2250,8 @@ static struct bt_bap_pac *bap_pac_new(struct bt_bap_db *bdb, const char *name,
 	pac->name = name ? strdup(name) : NULL;
 	pac->type = type;
 	pac->codec = *codec;
-	pac->data = iov_dup(data, 1);
-	pac->metadata = iov_dup(metadata, 1);
+	pac->data = util_iov_dup(data, 1);
+	pac->metadata = util_iov_dup(metadata, 1);
 
 	if (qos)
 		pac->qos = *qos;
@@ -2347,8 +2264,8 @@ static void bap_pac_free(void *data)
 	struct bt_bap_pac *pac = data;
 
 	free(pac->name);
-	iov_free(pac->metadata);
-	iov_free(pac->data);
+	util_iov_free(pac->metadata, 1);
+	util_iov_free(pac->data, 1);
 	free(pac);
 }
 
@@ -2769,7 +2686,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 	};
 	int i;
 
-	rsp = iov_pull_mem(&iov, sizeof(*rsp));
+	rsp = util_iov_pull_mem(&iov, sizeof(*rsp));
 	if (!rsp) {
 		DBG(bap, "Unable to parse PAC");
 		return;
@@ -2784,7 +2701,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		struct bt_pac_metadata *meta;
 		struct iovec data, metadata;
 
-		p = iov_pull_mem(&iov, sizeof(*p));
+		p = util_iov_pull_mem(&iov, sizeof(*p));
 		if (!p) {
 			DBG(bap, "Unable to parse PAC");
 			return;
@@ -2796,13 +2713,13 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 					bap->debug_data))
 			return;
 
-		cc = iov_pull_mem(&iov, p->cc_len);
+		cc = util_iov_pull_mem(&iov, p->cc_len);
 		if (!cc) {
 			DBG(bap, "Unable to parse PAC codec capabilities");
 			return;
 		}
 
-		meta = iov_pull_mem(&iov, sizeof(*meta));
+		meta = util_iov_pull_mem(&iov, sizeof(*meta));
 		if (!meta) {
 			DBG(bap, "Unable to parse PAC metadata");
 			return;
@@ -2814,7 +2731,7 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 		metadata.iov_len = meta->len;
 		metadata.iov_base = meta->data;
 
-		iov_pull_mem(&iov, meta->len);
+		util_iov_pull_mem(&iov, meta->len);
 
 		pac = bap_pac_new(bap->rdb, NULL, type, &p->codec, NULL, &data,
 								&metadata);
@@ -3089,7 +3006,7 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	uint32_t pd_min, pd_max, ppd_min, ppd_max;
 	int i;
 
-	cfg = iov_pull_mem(iov, sizeof(*cfg));
+	cfg = util_iov_pull_mem(iov, sizeof(*cfg));
 	if (!cfg) {
 		DBG(bap, "Unable to parse Config Status");
 		return;
@@ -3113,14 +3030,14 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	}
 
 	for (i = 0; iov->iov_len >= sizeof(*cc); i++) {
-		cc = iov_pull_mem(iov, sizeof(*cc));
+		cc = util_iov_pull_mem(iov, sizeof(*cc));
 		if (!cc)
 			break;
 
 		DBG(bap, "Codec Config #%u: type 0x%02x len %u", i,
 						cc->type, cc->len);
 
-		iov_pull_mem(iov, cc->len - 1);
+		util_iov_pull_mem(iov, cc->len - 1);
 	}
 
 	/* Any previously applied codec configuration may be cached by the
@@ -3160,7 +3077,7 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	if (!ep->stream->cc)
 		ep->stream->cc = new0(struct iovec, 1);
 
-	iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
+	util_iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
 }
 
 static void bap_stream_config_cfm_cb(struct bt_bap_stream *stream, int err)
@@ -3200,7 +3117,7 @@ static void ep_status_qos(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	uint16_t sdu;
 	uint16_t latency;
 
-	qos = iov_pull_mem(iov, sizeof(*qos));
+	qos = util_iov_pull_mem(iov, sizeof(*qos));
 	if (!qos) {
 		DBG(bap, "Unable to parse QoS Status");
 		return;
@@ -3236,7 +3153,7 @@ static void ep_status_metadata(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 {
 	struct bt_ascs_ase_status_metadata *meta;
 
-	meta = iov_pull_mem(iov, sizeof(*meta));
+	meta = util_iov_pull_mem(iov, sizeof(*meta));
 	if (!meta) {
 		DBG(bap, "Unable to parse Metadata Status");
 		return;
@@ -3255,7 +3172,7 @@ static void bap_ep_set_status(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 		.iov_len = length,
 	};
 
-	rsp = iov_pull_mem(&iov, sizeof(*rsp));
+	rsp = util_iov_pull_mem(&iov, sizeof(*rsp));
 	if (!rsp)
 		return;
 
@@ -3391,7 +3308,8 @@ static void append_group(void *data, void *user_data)
 	size_t i;
 
 	for (i = 0; i < req->len; i++)
-		iov_add_mem(iov, req->iov[i].iov_len, req->iov[i].iov_base);
+		util_iov_push_mem(iov, req->iov[i].iov_len,
+					req->iov[i].iov_base);
 }
 
 static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
@@ -3414,10 +3332,11 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	hdr.op = req->op;
 	hdr.num = 1 + queue_length(req->group);
 
-	iov_add_mem(&iov, sizeof(hdr), &hdr);
+	util_iov_push_mem(&iov, sizeof(hdr), &hdr);
 
 	for (i = 0; i < req->len; i++)
-		iov_add_mem(&iov, req->iov[i].iov_len, req->iov[i].iov_base);
+		util_iov_push_mem(&iov, req->iov[i].iov_len,
+					req->iov[i].iov_base);
 
 	/* Append the request group with the same opcode */
 	queue_foreach(req->group, append_group, &iov);
@@ -4011,7 +3930,7 @@ static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
 	req->id = ++id;
 	req->stream = stream;
 	req->op = op;
-	req->iov = iov_dup(iov, len);
+	req->iov = util_iov_dup(iov, len);
 	req->len = len;
 	req->func = func;
 	req->user_data = user_data;
-- 
2.37.3

