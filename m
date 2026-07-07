Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D311E492D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449596; cv=none; b=Nxl3Gz9cYlYCNw7G8q9uMIWiIqXe3tGk7tLjtKyUbOQZ6ffNKF+cGqEz4LWOml807V8WExzfAyyOWOoyQ+5UxF45hw9mNesA1teCKj+IuleMBNV10bcr/4xdIcFS5q4DWqnOHyY1lTvZlkFgWqXpFeOTnAISUkpeExiMtOwFXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449596; c=relaxed/simple;
	bh=tzUrxM+g/b4W9HZ+yfGwub8Zg0JZo80NHK5Q/L+65zU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=icTKi/Y8PFhhwJJnzjMKD/r2tFoy6UpVsTQ9LEM2ThBVWd3PKsb4f8bZL+EHtq2/5qSeYVxehxMqATzs2Sr7oxqXHg9UyHBodvu/VTQM2s88gMC7Evaoim6Qro1D/NOMrUSBROiOeNBAbwo4MRKRD7uwNE9nNEHl3r9jtzGkr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQSPPITN; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQSPPITN"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-728f9ecd56aso1059366137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783449593; x=1784054393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sazkPpF5RKwDtIal6qTiCcjUcs+f1FRpEi+K/rLu6wo=;
        b=EQSPPITNw1Xs5ENoGgWS7QDqOz+TRBN8C93mAGo5/vfVHSr090yq0emtvQCz8YkFzu
         XHHRqN6uqbiN3dxsZYxQPC9M+syKsQn8dWBx0OU/yMKsGNTGpvabELTJ5g0qoBTQB3Dp
         AFSCyzOCLroRhZdz5uEDhcdgEcUZgUER8oxmIV4XvTAAB6/zLdz8NIYqiDTd9EMrYDsx
         q4OrRS0WdItwHTycwaMa1pwRWdpWvsndtzjEvyCa5kxXmh+Uvsb119PyEwWvYg7ETmLW
         /P3zsvqHk0JrpdtBiSmB84H3z+/sC9JDx/b54ZomV2MOZVnseqlbv0y3q6OLuAWbDJzm
         +nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449593; x=1784054393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sazkPpF5RKwDtIal6qTiCcjUcs+f1FRpEi+K/rLu6wo=;
        b=ICMxOV4HXOXYTJYVxYVap45DA+6hbhN/INZJzRVCMxUqdcksCzHFbiXl7Bde/UM5lQ
         RH6A8JrpdRBXDTRLOGFCGoC7njCHhIF+hyGMkoPmkBA5J76aFroVyNz4mMEQvz1BQvu/
         leFgBmKe57uXNNvB8lgnNOJ+UXd9T7nZ8O9sP/2MJ/LDtmVIXctiERaepEv4uGONXaGZ
         ccKyGpPPrcQxhNTuJpqkTGwhjZO7bc9oSa/TlHdGYb+NWuJcOuCIZJrYxwZcgSCISAVA
         bRX03+koEKYr+SHke5XYwxuZ1UPnNcTv7/sbYiy0vVs5abE7ah7gvBWYQ2ZtfOayddBZ
         8UBw==
X-Gm-Message-State: AOJu0Yw4ORT3mnOn7XBBWk/YncB7qk3kTscXAjYT5CYm4nz56hfM1ePg
	L9oRsOKns9cqZ5tDT9R3kT3Yb6BVQOPmEBxB4wV2TlLvASj6kK/LtkzQ4TjDEL0OH+WmOg==
X-Gm-Gg: AfdE7cmuzwgDKDzUFgerWfiq9223WR3Q8FnnrbW+tsGNyxQuVHk4BarNdBV+RyVKyKu
	RAcL4RZsBI2M/zveZHmOigRNWHSlhCbUOOiMZtrINRShL0xcs5TCVNOhara85s2mlu/K8peOZ7E
	aoDr2tS076c5ZMHTYn1mqYCSR6MYWTrfXkkiz4fmP2HHfhwFZCFvPgaxVTLm/4rs7RvNZmoaO/m
	NRBbobdyXMe6dPv7duTHJT7fWYufxbgwbmd5xvxpIMYPjnss0P0i9PQtb1jGP6lJHJYKSE/u/Za
	I81m49nLNp8Vg/zTED/S2+miWiYh8lscUNcYmhlW6w+iTcpqbMzsLq/P+LHKMxrz6Iy59SwZQIe
	m9/kmT7epRcSnsCT5l0KJH/uggCfwuy8vWx4mwDUGjPP8HuUWsTow5k4yH1w3NfSvIFAzukztOe
	Jbf2l09bszhPNg7rpRg2Rd0p9QSRw4Rg9P3TZgj2CqD8VGRUTPbcrCiTfaL1D8/9DOFe2Au1+TP
	uo4nqY=
X-Received: by 2002:a05:6102:580d:b0:73a:322d:1bbc with SMTP id ada2fe7eead31-744b7cb7db9mr3788081137.26.1783449593420;
        Tue, 07 Jul 2026 11:39:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed3184b2asm84261241.5.2026.07.07.11.39.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:39:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Use util_ltv_foreach to process metadata
Date: Tue,  7 Jul 2026 14:39:44 -0400
Message-ID: <20260707183944.1215551-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of util_ltv_foreach to process the metadata entries
instead of attempting to iterate over the entries manually which
probably only works with the exact same order as used by PTS.
---
 src/shared/bap.c | 88 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f2be7c07ba5d..db6f4f204787 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3404,35 +3404,69 @@ static uint8_t stream_enable(struct bt_bap_stream *stream, struct iovec *meta,
 	return 0;
 }
 
-static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct iovec *meta,
-							struct iovec *rsp)
+struct bap_metadata_process {
+	struct bt_bap_endpoint *ep;
+	uint16_t context;
+	struct iovec *rsp;
+	uint8_t err;
+};
+
+static void bap_metadata_process(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
 {
-	struct bt_ltv *ltv;
-	uint16_t supported_context = 0;
+	struct bap_metadata_process *data = user_data;
 	uint16_t context;
 
-	if (ep->stream && ep->stream->lpac)
-		supported_context = ep->stream->lpac->qos.supported_context;
-
-	ltv = meta->iov_base;
-	if (meta->iov_len >= sizeof(*ltv) &&
-			(ltv->type < BAP_METADATA_PREF_CONTEXT_LTV_TYPE ||
-			ltv->type > BAP_METADATA_LANGUAGE_LTV_TYPE)) {
-		ascs_ase_rsp_add(rsp, ep->id,
-				BT_ASCS_RSP_METADATA_UNSUPPORTED, ltv->type);
-		return true;
-	}
-
-	if (meta->iov_len >= sizeof(*ltv) + sizeof(context) &&
-			ltv->type == BAP_METADATA_CONTEXT_LTV_TYPE &&
-			ltv->len == sizeof(context) + 1) {
-		context = get_le16(ltv->value);
-		if (!context || (context & ~supported_context)) {
-			ascs_ase_rsp_add(rsp, ep->id,
-					BT_ASCS_RSP_METADATA_INVALID,
-					ltv->type);
-			return true;
+	switch (t) {
+	case BAP_METADATA_PREF_CONTEXT_LTV_TYPE:
+		break;
+	case BAP_METADATA_CONTEXT_LTV_TYPE:
+		if (l != sizeof(context)) {
+			ascs_ase_rsp_add(data->rsp, data->ep->id,
+					BT_ASCS_RSP_METADATA_INVALID, t);
+			data->err = BT_ASCS_RSP_METADATA_INVALID;
+			break;
 		}
+
+		context = get_le16(v);
+		if (!context || (context & ~data->context)) {
+			ascs_ase_rsp_add(data->rsp, data->ep->id,
+					BT_ASCS_RSP_METADATA_INVALID, t);
+			data->err = BT_ASCS_RSP_METADATA_INVALID;
+		}
+
+		break;
+	case BAP_METADATA_PROGRAM_INFO_LTV_TYPE:
+	case BAP_METADATA_LANGUAGE_LTV_TYPE:
+		break;
+	default:
+		ascs_ase_rsp_add(data->rsp, data->ep->id,
+					BT_ASCS_RSP_METADATA_UNSUPPORTED,
+					t);
+		data->err = BT_ASCS_RSP_METADATA_UNSUPPORTED;
+		break;
+	};
+}
+
+static bool ascs_metadata_rsp(struct bt_bap_endpoint *ep, struct bt_bap *bap,
+				struct iovec *meta, struct iovec *rsp)
+{
+	struct bap_metadata_process data = {
+		.ep = ep,
+		.rsp = rsp,
+		.err = 0,
+	};
+
+	if (ep->stream && ep->stream->lpac)
+		data.context = ep->stream->lpac->qos.supported_context;
+
+	util_ltv_foreach(meta->iov_base, meta->iov_len, NULL,
+				bap_metadata_process, &data);
+
+	if (data.err) {
+		DBG(bap, "ep %p id 0x%02x metadata error 0x%02x", ep, ep->id,
+				data.err);
+		return true;
 	}
 
 	return false;
@@ -3469,7 +3503,7 @@ static uint8_t ep_enable(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		return 0;
 	}
 
-	if (ascs_metadata_rsp(ep, &meta, rsp))
+	if (ascs_metadata_rsp(ep, bap, &meta, rsp))
 		return 0;
 
 	if (!ep->stream) {
@@ -3705,7 +3739,7 @@ static uint8_t ep_metadata(struct bt_bap_endpoint *ep,
 	meta.iov_base = util_iov_pull_mem(iov, req->len);
 	meta.iov_len = req->len;
 
-	if (ascs_metadata_rsp(ep, &meta, rsp))
+	if (ascs_metadata_rsp(ep, stream->bap, &meta, rsp))
 		return 0;
 
 	return stream_metadata(ep->stream, &meta, rsp);
-- 
2.54.0

