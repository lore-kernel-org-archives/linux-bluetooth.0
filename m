Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CA1C283
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258921; cv=none; b=MwCleXU+YMQr1KrsDyz90dn04VCwQ4latK+Ma0ca0NcFZbYJuD62DDymHEs630wWv59KNftUcf1Cyb9c/EpaKiWbcUCwDyma7duejKEd+74WxXNAmeiUo+5seKn/B4SAEgdUGYyy4aVf52CJlRdroq8asRSk7vXzeduOkr5eucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258921; c=relaxed/simple;
	bh=czP0H1rr1XJEZjzMCql9AK4jmS6p60JCVVE4MlnDNdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rBA0JuSvrmVtwWdM8JlVeMKd95m0udksu7eOODYXr61dEU1KlYruzHUpapqLP8EylaS0Lv8goBvwoLDJsSgGWby1VUpOAjOHKhFTmGM/1bCSgMe6E0othdNjgggpidCDIF9VDxD6pAnaosW72UCDXTpWd2lizhMoU+UzDROswn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2DKOPPZ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2DKOPPZ"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-46d1ff63d2fso1037966137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 14:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707258915; x=1707863715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKxYw5K4WVSzQDjbcx5N+Yo1/iyc1u8qC2FEvRS6ap0=;
        b=h2DKOPPZfhoD6wdnvqs8RkrCe0GuqLMjdbF1ohl2pz7QXvy7d8PwxU2TS9fLNZttO3
         gt8lnU5wIwVMyxLuYHVTMw5BjbVXjHbXTO2Zdf/Fb3km1WmHn8vndS//HstUQy7BsoLs
         Ukzmx4m/kVT6L5rH866ekWw8IK4uBACzPZCV8mayC99XEp1xxP6nSiwzfTHjNAWRmbCl
         LTC7/c7Ua4elnU8z5eiM57OILv0kHYo4J4EO1n4t9lud0FmibzWc6per87E4BrxbjGPv
         ObaJ+mOF9PFgmM8t30HUWuTPpRn198ABUMR8CLLGA4u186e+9XBBy1SgGA2Ssv7KjOAI
         8/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258915; x=1707863715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKxYw5K4WVSzQDjbcx5N+Yo1/iyc1u8qC2FEvRS6ap0=;
        b=BA/wNWOBL0bF1gdpubTgCU8ZYPiXsBYKyh7nG5sESsJ/R/wi8gXbT21XTEaM9F/2jb
         My4ReCZZvGyDMWsnGFGh3QwjtEus/Q1Xfxed2wu8DnAgdl6QUDKIaKqmoVsSQ3lZds23
         wl25Q3lcKNRlkjez4w94G3I3pf/MLbAh6ODpQWmW9c9FkTBJ/KSNg0S577JckylLwVCm
         yLVT5usc01HksbTCEahnSG2xW+c444rooxRSnjOMJd7qT2IAQi0+GHZoQQbKcO9R+WPn
         bHfo9yCAZkRFf0jeQ+mImNLRUJ8Gvsvw90VSDmRFyPn8dqm8Iumm9gC5hcU5Mn+Flarz
         /Y2w==
X-Gm-Message-State: AOJu0YyNlnddNLSaMUgcqmQUA4rYYwZ0O2AyULaavZBa9EKJjJrHLi7t
	hMb1DmxRG8074JW//VnSc4MIs/3x7Gl45aNn3srbO7O2NgDspcfrPM5U2ryv
X-Google-Smtp-Source: AGHT+IGJdRZa2lfv5wkk37L/fL/y4TOkvtk/3FI5RWPzNe67TafxuLsL9eUI2P8ss1C2jPK+hYTNZg==
X-Received: by 2002:a67:eb07:0:b0:46d:2c4b:7ef8 with SMTP id a7-20020a67eb07000000b0046d2c4b7ef8mr901052vso.9.1707258914770;
        Tue, 06 Feb 2024 14:35:14 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l7-20020a056102316700b0046d35339f2bsm322432vsm.3.2024.02.06.14.35.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:35:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] shared/bap: Rework stream procedures
Date: Tue,  6 Feb 2024 17:35:11 -0500
Message-ID: <20240206223513.2783330-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework stream procedures to avoid having to check stream types
everytime the procedure is invoked, instead this creates a operation
abstraction which is assign at stream creation.
---
 src/shared/bap.c | 1793 ++++++++++++++++++++++++++--------------------
 1 file changed, 1014 insertions(+), 779 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 00d211c15ddf..7c714628c437 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -214,6 +214,31 @@ struct bt_bap_stream_io {
 	bool connecting;
 };
 
+struct bt_bap_stream_ops {
+	uint8_t type;
+	unsigned int (*config)(struct bt_bap_stream *stream,
+				struct bt_bap_qos *qos, struct iovec *data,
+				bt_bap_stream_func_t func, void *user_data);
+	unsigned int (*qos)(struct bt_bap_stream *stream,
+				struct bt_bap_qos *qos,
+				bt_bap_stream_func_t func, void *user_data);
+	unsigned int (*enable)(struct bt_bap_stream *stream, bool enable_links,
+				struct iovec *metadata,
+				bt_bap_stream_func_t func, void *user_data);
+	unsigned int (*start)(struct bt_bap_stream *stream,
+				bt_bap_stream_func_t func, void *user_data);
+	unsigned int (*disable)(struct bt_bap_stream *stream,
+				bool disable_links, bt_bap_stream_func_t func,
+				void *user_data);
+	unsigned int (*stop)(struct bt_bap_stream *stream,
+				bt_bap_stream_func_t func, void *user_data);
+	unsigned int (*metadata)(struct bt_bap_stream *stream,
+				struct iovec *data, bt_bap_stream_func_t func,
+				void *user_data);
+	unsigned int (*release)(struct bt_bap_stream *stream,
+				bt_bap_stream_func_t func, void *user_data);
+};
+
 struct bt_bap_stream {
 	struct bt_bap *bap;
 	struct bt_bap_endpoint *ep;
@@ -224,6 +249,7 @@ struct bt_bap_stream {
 	struct bt_bap_qos qos;
 	struct bt_bap_stream *link;
 	struct bt_bap_stream_io *io;
+	const struct bt_bap_stream_ops *ops;
 	bool client;
 	void *user_data;
 };
@@ -829,27 +855,46 @@ static bool bap_codec_equal(const struct bt_bap_codec *c1,
 	return c1->id == c2->id;
 }
 
-static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
-						struct bt_bap_endpoint *ep,
-						struct bt_bap_pac *lpac,
-						struct bt_bap_pac *rpac,
-						struct iovec *data,
-						bool client)
+static void ascs_ase_rsp_add(struct iovec *iov, uint8_t id,
+					uint8_t code, uint8_t reason)
 {
-	struct bt_bap_stream *stream;
+	struct bt_ascs_cp_rsp *cp;
+	struct bt_ascs_ase_rsp *rsp;
 
-	stream = new0(struct bt_bap_stream, 1);
-	stream->bap = bap;
-	stream->ep = ep;
-	ep->stream = stream;
-	stream->lpac = lpac;
-	stream->rpac = rpac;
-	stream->cc = util_iov_dup(data, 1);
-	stream->client = client;
+	if (!iov)
+		return;
 
-	queue_push_tail(bap->streams, stream);
+	cp = iov->iov_base;
 
-	return stream;
+	if (cp->num_ase == 0xff)
+		return;
+
+	switch (code) {
+	/* If the Response_Code value is 0x01 or 0x02, Number_of_ASEs shall be
+	 * set to 0xFF.
+	 */
+	case BT_ASCS_RSP_NOT_SUPPORTED:
+	case BT_ASCS_RSP_TRUNCATED:
+		cp->num_ase = 0xff;
+		break;
+	default:
+		cp->num_ase++;
+		break;
+	}
+
+	iov->iov_len += sizeof(*rsp);
+	iov->iov_base = realloc(iov->iov_base, iov->iov_len);
+
+	rsp = iov->iov_base + (iov->iov_len - sizeof(*rsp));
+	rsp->ase = id;
+	rsp->code = code;
+	rsp->reason = reason;
+}
+
+static void ascs_ase_rsp_success(struct iovec *iov, uint8_t id)
+{
+	return ascs_ase_rsp_add(iov, id, BT_ASCS_RSP_SUCCESS,
+					BT_ASCS_REASON_NONE);
 }
 
 static void stream_notify_config(struct bt_bap_stream *stream)
@@ -985,6 +1030,14 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	free(status);
 }
 
+static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
+{
+	if (!bap || !bap->ref_count)
+		return NULL;
+
+	return bt_bap_ref(bap);
+}
+
 static void bap_stream_clear_cfm(struct bt_bap_stream *stream)
 {
 	if (!stream->lpac->ops || !stream->lpac->ops->clear)
@@ -1080,83 +1133,6 @@ static void bap_stream_update_io_links(struct bt_bap_stream *stream)
 	queue_find(bap->streams, bap_stream_io_link, stream);
 }
 
-static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io)
-{
-	if (!io)
-		return NULL;
-
-	__sync_fetch_and_add(&io->ref_count, 1);
-
-	return io;
-}
-
-static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
-{
-	struct io *io;
-	struct bt_bap_stream_io *sio;
-
-	io = io_new(fd);
-	if (!io)
-		return NULL;
-
-	DBG(bap, "fd %d", fd);
-
-	sio = new0(struct bt_bap_stream_io, 1);
-	sio->bap = bap;
-	sio->io = io;
-
-	return stream_io_ref(sio);
-}
-
-static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
-{
-	if (!stream)
-		return NULL;
-
-	if (stream->io)
-		return stream->io;
-
-	if (stream->link)
-		return stream->link->io;
-
-	return NULL;
-}
-
-static bool stream_io_disconnected(struct io *io, void *user_data);
-
-static bool bap_stream_io_attach(struct bt_bap_stream *stream, int fd,
-							bool connecting)
-{
-	struct bt_bap_stream_io *io;
-
-	io = stream_get_io(stream);
-	if (io) {
-		if (fd == stream_io_get_fd(io)) {
-			if (!stream->io)
-				stream->io = stream_io_ref(io);
-
-			io->connecting = connecting;
-			return true;
-		}
-
-		DBG(stream->bap, "stream %p io already set", stream);
-		return false;
-	}
-
-	DBG(stream->bap, "stream %p connecting %s", stream,
-				connecting ? "true" : "false");
-
-	io = stream_io_new(stream->bap, fd);
-	if (!io)
-		return false;
-
-	io->connecting = connecting;
-	stream->io = io;
-	io_set_disconnect_handler(io->io, stream_io_disconnected, stream, NULL);
-
-	return true;
-}
-
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1182,51 +1158,6 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	return true;
 }
 
-static void bap_stream_set_io(void *data, void *user_data)
-{
-	struct bt_bap_stream *stream = data;
-	int fd = PTR_TO_INT(user_data);
-	bool ret;
-
-	if (fd >= 0)
-		ret = bap_stream_io_attach(stream, fd, false);
-	else
-		ret = bap_stream_io_detach(stream);
-
-	if (!ret)
-		return;
-
-	switch (stream->ep->state) {
-	case BT_BAP_STREAM_STATE_ENABLING:
-		if (fd < 0)
-			bt_bap_stream_disable(stream, false, NULL, NULL);
-		else
-			bt_bap_stream_start(stream, NULL, NULL);
-		break;
-	case BT_BAP_STREAM_STATE_DISABLING:
-		if (fd < 0)
-			bt_bap_stream_stop(stream, NULL, NULL);
-		break;
-	}
-}
-
-static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
-{
-	if (!bap || !bap->ref_count)
-		return NULL;
-
-	return bt_bap_ref(bap);
-}
-
-static void stream_stop_complete(struct bt_bap_stream *stream, uint8_t code,
-					uint8_t reason,	void *user_data)
-{
-	DBG(stream->bap, "stream %p stop 0x%02x 0x%02x", stream, code, reason);
-
-	if (stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
-		bap_stream_io_detach(stream);
-}
-
 static void bap_req_free(void *data)
 {
 	struct bt_bap_req *req = data;
@@ -1268,6 +1199,15 @@ done:
 	bap_req_free(req);
 }
 
+static void stream_stop_complete(struct bt_bap_stream *stream, uint8_t code,
+					uint8_t reason,	void *user_data)
+{
+	DBG(stream->bap, "stream %p stop 0x%02x 0x%02x", stream, code, reason);
+
+	if (stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
+		bap_stream_io_detach(stream);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1344,6 +1284,39 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	bt_bap_unref(bap);
 }
 
+static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+
+	ep->old_state = ep->state;
+	ep->state = state;
+
+	if (stream->lpac->type == BT_BAP_BCAST_SINK)
+		goto done;
+
+	if (stream->client)
+		goto done;
+
+	switch (ep->state) {
+	case BT_ASCS_ASE_STATE_IDLE:
+		break;
+	case BT_ASCS_ASE_STATE_CONFIG:
+		stream_notify_config(stream);
+		break;
+	case BT_ASCS_ASE_STATE_QOS:
+		stream_notify_qos(stream);
+		break;
+	case BT_ASCS_ASE_STATE_ENABLING:
+	case BT_ASCS_ASE_STATE_STREAMING:
+	case BT_ASCS_ASE_STATE_DISABLING:
+		stream_notify_metadata(stream);
+		break;
+	}
+
+done:
+	bap_stream_state_changed(stream);
+}
+
 static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 					uint8_t state)
 {
@@ -1390,73 +1363,851 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	bt_bap_unref(bap);
 }
 
-static void stream_set_state(struct bt_bap_stream *stream, uint8_t state)
+static void ep_config_cb(struct bt_bap_stream *stream, int err)
 {
-	struct bt_bap_endpoint *ep = stream->ep;
+	if (err)
+		return;
 
-	ep->old_state = ep->state;
-	ep->state = state;
-
-	if (stream->lpac->type == BT_BAP_BCAST_SINK)
-		goto done;
-
-	if (stream->client)
-		goto done;
-
-	switch (ep->state) {
-	case BT_ASCS_ASE_STATE_IDLE:
-		break;
-	case BT_ASCS_ASE_STATE_CONFIG:
-		stream_notify_config(stream);
-		break;
-	case BT_ASCS_ASE_STATE_QOS:
-		stream_notify_qos(stream);
-		break;
-	case BT_ASCS_ASE_STATE_ENABLING:
-	case BT_ASCS_ASE_STATE_STREAMING:
-	case BT_ASCS_ASE_STATE_DISABLING:
-		stream_notify_metadata(stream);
-		break;
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
+		if (!bt_bap_stream_io_dir(stream))
+			stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_QOS);
+		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_CONFIG);
+		return;
 	}
 
-done:
-	bap_stream_state_changed(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 }
 
-static void ascs_ase_rsp_add(struct iovec *iov, uint8_t id,
-					uint8_t code, uint8_t reason)
+static uint8_t stream_config(struct bt_bap_stream *stream, struct iovec *cc,
+							struct iovec *rsp)
 {
-	struct bt_ascs_cp_rsp *cp;
-	struct bt_ascs_ase_rsp *rsp;
+	struct bt_bap_pac *pac = stream->lpac;
 
-	if (!iov)
-		return;
+	DBG(stream->bap, "stream %p", stream);
 
-	cp = iov->iov_base;
+	/* TODO: Wait for pac->ops response */
+	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	if (cp->num_ase == 0xff)
-		return;
-
-	switch (code) {
-	/* If the Response_Code value is 0x01 or 0x02, Number_of_ASEs shall be
-	 * set to 0xFF.
-	 */
-	case BT_ASCS_RSP_NOT_SUPPORTED:
-	case BT_ASCS_RSP_TRUNCATED:
-		cp->num_ase = 0xff;
-		break;
-	default:
-		cp->num_ase++;
-		break;
+	if (!util_iov_memcmp(stream->cc, cc)) {
+		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		return 0;
 	}
 
-	iov->iov_len += sizeof(*rsp);
-	iov->iov_base = realloc(iov->iov_base, iov->iov_len);
+	util_iov_free(stream->cc, 1);
+	stream->cc = util_iov_dup(cc, 1);
 
-	rsp = iov->iov_base + (iov->iov_len - sizeof(*rsp));
-	rsp->ase = id;
-	rsp->code = code;
-	rsp->reason = reason;
+	if (pac->ops && pac->ops->config)
+		pac->ops->config(stream, cc, NULL, ep_config_cb,
+						pac->user_data);
+
+	return 0;
+}
+
+static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
+					uint8_t op, struct iovec *iov,
+					size_t len,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct bt_bap_req *req;
+	static unsigned int id;
+
+	req = new0(struct bt_bap_req, 1);
+	req->id = ++id ? id : ++id;
+	req->stream = stream;
+	req->op = op;
+	req->iov = util_iov_dup(iov, len);
+	req->len = len;
+	req->func = func;
+	req->user_data = user_data;
+
+	return req;
+}
+
+static uint16_t bap_req_len(struct bt_bap_req *req)
+{
+	uint16_t len = 0;
+	size_t i;
+	const struct queue_entry *e;
+
+	for (i = 0; i < req->len; i++)
+		len += req->iov[i].iov_len;
+
+	e = queue_get_entries(req->group);
+	for (; e; e = e->next)
+		len += bap_req_len(e->data);
+
+	return len;
+}
+
+static bool match_req(const void *data, const void *match_data)
+{
+	const struct bt_bap_req *pend = data;
+	const struct bt_bap_req *req = match_data;
+
+	return pend->op == req->op;
+}
+
+static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
+{
+	if (!bap)
+		return NULL;
+
+	if (bap->rdb->ascs)
+		return bap->rdb->ascs;
+
+	bap->rdb->ascs = new0(struct bt_ascs, 1);
+	bap->rdb->ascs->bdb = bap->rdb;
+
+	return bap->rdb->ascs;
+}
+
+static void append_group(void *data, void *user_data)
+{
+	struct bt_bap_req *req = data;
+	struct iovec *iov = user_data;
+	size_t i;
+
+	for (i = 0; i < req->len; i++)
+		util_iov_push_mem(iov, req->iov[i].iov_len,
+					req->iov[i].iov_base);
+}
+
+static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
+{
+	struct bt_ascs *ascs = bap_get_ascs(bap);
+	int ret;
+	uint16_t handle;
+	struct bt_ascs_ase_hdr hdr;
+	struct iovec iov;
+	size_t i;
+
+	iov.iov_len = sizeof(hdr) + bap_req_len(req);
+
+	DBG(bap, "req %p len %u", req, iov.iov_len);
+
+	if (req->stream && !queue_find(bap->streams, NULL, req->stream)) {
+		DBG(bap, "stream %p detached, aborting op 0x%02x", req->op);
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(ascs->ase_cp, NULL, &handle,
+						NULL, NULL, NULL)) {
+		DBG(bap, "Unable to find Control Point");
+		return false;
+	}
+
+	iov.iov_base = alloca(iov.iov_len);
+	iov.iov_len = 0;
+
+	hdr.op = req->op;
+	hdr.num = 1 + queue_length(req->group);
+
+	util_iov_push_mem(&iov, sizeof(hdr), &hdr);
+
+	for (i = 0; i < req->len; i++)
+		util_iov_push_mem(&iov, req->iov[i].iov_len,
+					req->iov[i].iov_base);
+
+	/* Append the request group with the same opcode */
+	queue_foreach(req->group, append_group, &iov);
+
+	ret = bt_gatt_client_write_without_response(bap->client, handle,
+							false, iov.iov_base,
+							iov.iov_len);
+	if (!ret) {
+		DBG(bap, "Unable to Write to Control Point");
+		return false;
+	}
+
+	bap->req = req;
+
+	return true;
+}
+
+static bool bap_process_queue(void *data)
+{
+	struct bt_bap *bap = data;
+	struct bt_bap_req *req;
+
+	DBG(bap, "");
+
+	if (bap->process_id) {
+		timeout_remove(bap->process_id);
+		bap->process_id = 0;
+	}
+
+	while ((req = queue_pop_head(bap->reqs))) {
+		if (bap_send(bap, req))
+			break;
+		bap_req_complete(req, NULL);
+	}
+
+	return false;
+}
+
+static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
+{
+	struct bt_bap_req *pend;
+	struct queue *queue;
+	struct bt_att *att = bt_bap_get_att(bap);
+	uint16_t mtu = bt_att_get_mtu(att);
+	uint16_t len = 2 + bap_req_len(req);
+
+	if (len > mtu) {
+		DBG(bap, "Unable to queue request: req len %u > %u mtu", len,
+									mtu);
+		return false;
+	}
+
+	pend = queue_find(bap->reqs, match_req, req);
+	/* Check if req can be grouped together and it fits in the MTU */
+	if (pend && (bap_req_len(pend) + len < mtu)) {
+		if (!pend->group)
+			pend->group = queue_new();
+		/* Group requests with the same opcode */
+		queue = pend->group;
+	} else {
+		queue = bap->reqs;
+	}
+
+	DBG(bap, "req %p (op 0x%2.2x) queue %p", req, req->op, queue);
+
+	if (!queue_push_tail(queue, req)) {
+		DBG(bap, "Unable to queue request");
+		return false;
+	}
+
+	/* Only attempot to process queue if there is no outstanding request
+	 * and it has not been scheduled.
+	 */
+	if (!bap->req && !bap->process_id)
+		bap->process_id = timeout_add(BAP_PROCESS_TIMEOUT,
+						bap_process_queue, bap, NULL);
+
+	return true;
+}
+
+static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
+					struct bt_bap_qos *qos,
+					struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov[2];
+	struct bt_ascs_config config;
+	uint8_t iovlen = 1;
+	struct bt_bap_req *req;
+
+	if (!stream->client) {
+		stream_config(stream, data, NULL);
+		return -EINVAL;
+	}
+
+	memset(&config, 0, sizeof(config));
+
+	config.ase = stream->ep->id;
+	config.latency = qos->ucast.target_latency;
+	config.phy = qos->ucast.io_qos.phy;
+	config.codec = stream->rpac->codec;
+
+	if (config.codec.id == 0xff) {
+		config.codec.cid = cpu_to_le16(config.codec.cid);
+		config.codec.vid = cpu_to_le16(config.codec.vid);
+	}
+
+	iov[0].iov_base = &config;
+		iov[0].iov_len = sizeof(config);
+
+	if (data) {
+		if (!bt_bap_debug_config(data->iov_base, data->iov_len,
+					stream->bap->debug_func,
+					stream->bap->debug_data))
+			return 0;
+
+		config.cc_len = data->iov_len;
+		iov[1] = *data;
+		iovlen++;
+	}
+
+	req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, user_data);
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	stream->qos = *qos;
+
+	return req->id;
+}
+
+static unsigned int bap_ucast_qos(struct bt_bap_stream *stream,
+					struct bt_bap_qos *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov;
+	struct bt_ascs_qos qos;
+	struct bt_bap_req *req;
+
+	/* Table 3.2: ASE state machine transition
+	 * Initiating device - client Only
+	 */
+	if (!stream->client)
+		return 0;
+
+	memset(&qos, 0, sizeof(qos));
+
+	/* TODO: Figure out how to pass these values around */
+	qos.ase = stream->ep->id;
+	qos.cig = data->ucast.cig_id;
+	qos.cis = data->ucast.cis_id;
+	put_le24(data->ucast.io_qos.interval, qos.interval);
+	qos.framing = data->ucast.framing;
+	qos.phy = data->ucast.io_qos.phy;
+	qos.sdu = cpu_to_le16(data->ucast.io_qos.sdu);
+	qos.rtn = data->ucast.io_qos.rtn;
+	qos.latency = cpu_to_le16(data->ucast.io_qos.latency);
+	put_le24(data->ucast.delay, qos.pd);
+
+	iov.iov_base = &qos;
+	iov.iov_len = sizeof(qos);
+
+	req = bap_req_new(stream, BT_ASCS_QOS, &iov, 1, func, user_data);
+
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	stream->qos = *data;
+
+	return req->id;
+}
+
+static unsigned int bap_stream_metadata(struct bt_bap_stream *stream,
+					uint8_t op, struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov[2];
+	struct bt_ascs_metadata meta;
+	struct bt_bap_req *req;
+	struct metadata {
+		uint8_t len;
+		uint8_t type;
+		uint8_t data[2];
+	} ctx = LTV(0x02, 0x01, 0x00); /* Context = Unspecified */
+
+	memset(&meta, 0, sizeof(meta));
+
+	meta.ase = stream->ep->id;
+
+	iov[0].iov_base = &meta;
+	iov[0].iov_len = sizeof(meta);
+
+	if (data)
+		iov[1] = *data;
+	else {
+		iov[1].iov_base = &ctx;
+		iov[1].iov_len = sizeof(ctx);
+	}
+
+	meta.len = iov[1].iov_len;
+
+	req = bap_req_new(stream, op, iov, 2, func, user_data);
+
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
+static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
+				     struct bt_bap_qos *qos, struct iovec *data,
+				     bt_bap_stream_func_t func, void *user_data)
+{
+	stream->qos = *qos;
+	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
+		if (data)
+			stream_config(stream, data, NULL);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	}
+
+	return 1;
+}
+
+static unsigned int bap_ucast_enable(struct bt_bap_stream *stream,
+					bool enable_links, struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	int ret;
+
+	/* Table 3.2: ASE state machine transition
+	 * Initiating device - client Only
+	 */
+	if (!stream->client)
+		return 0;
+
+	ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, data, func,
+					user_data);
+	if (!ret || !enable_links)
+		return ret;
+
+	if (stream->link)
+		bap_stream_metadata(stream->link, BT_ASCS_ENABLE, data,
+					NULL, NULL);
+
+	return ret;
+}
+
+static uint8_t stream_start(struct bt_bap_stream *stream, struct iovec *rsp)
+{
+	DBG(stream->bap, "stream %p", stream);
+
+	ascs_ase_rsp_success(rsp, stream->ep->id);
+
+	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
+
+	return 0;
+}
+
+static unsigned int bap_ucast_start(struct bt_bap_stream *stream,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov;
+	struct bt_ascs_start start;
+	struct bt_bap_req *req;
+
+	if (!stream->client) {
+		if (stream->ep->dir == BT_BAP_SINK)
+			stream_start(stream, NULL);
+		return 0;
+	}
+
+	if (stream->ep->dir == BT_BAP_SINK)
+		return 0;
+
+	memset(&start, 0, sizeof(start));
+
+	start.ase = stream->ep->id;
+
+	iov.iov_base = &start;
+	iov.iov_len = sizeof(start);
+
+	req = bap_req_new(stream, BT_ASCS_START, &iov, 1, func, user_data);
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
+static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
+					bool disable_links,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov;
+	struct bt_ascs_disable disable;
+	struct bt_bap_req *req;
+
+	memset(&disable, 0, sizeof(disable));
+
+	disable.ase = stream->ep->id;
+
+	iov.iov_base = &disable;
+	iov.iov_len = sizeof(disable);
+
+	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func, user_data);
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	if (disable_links)
+		bt_bap_stream_disable(stream->link, false, NULL, NULL);
+
+	return req->id;
+}
+
+static uint8_t stream_stop(struct bt_bap_stream *stream, struct iovec *rsp)
+{
+	DBG(stream->bap, "stream %p", stream);
+
+	if (!stream)
+		return 0;
+
+	ascs_ase_rsp_success(rsp, stream->ep->id);
+
+	stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+
+	return 0;
+}
+
+static unsigned int bap_ucast_stop(struct bt_bap_stream *stream,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov;
+	struct bt_ascs_stop stop;
+	struct bt_bap_req *req;
+
+	if (!stream->client) {
+		if (stream->ep->dir == BT_BAP_SINK)
+			stream_stop(stream, NULL);
+		return 0;
+	}
+
+	if (stream->ep->dir == BT_BAP_SINK)
+		return 0;
+
+	memset(&stop, 0, sizeof(stop));
+
+	stop.ase = stream->ep->id;
+
+	iov.iov_base = &stop;
+	iov.iov_len = sizeof(stop);
+
+	req = bap_req_new(stream, BT_ASCS_STOP, &iov, 1, func, user_data);
+
+	if (!bap_queue_req(stream->bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
+static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
+						struct iovec *rsp)
+{
+	DBG(stream->bap, "stream %p", stream);
+
+	ascs_ase_rsp_success(rsp, stream->ep->id);
+
+	util_iov_free(stream->meta, 1);
+	stream->meta = util_iov_dup(meta, 1);
+
+	return 0;
+}
+
+static unsigned int bap_ucast_metadata(struct bt_bap_stream *stream,
+					struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	if (!stream->client) {
+		stream_metadata(stream, data, NULL);
+		return 0;
+	}
+
+	return bap_stream_metadata(stream, BT_ASCS_METADATA, data, func,
+					user_data);
+}
+
+static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
+{
+	struct bt_bap_pac *pac;
+
+	DBG(stream->bap, "stream %p", stream);
+
+	ascs_ase_rsp_success(rsp, stream->ep->id);
+
+	pac = stream->lpac;
+	if (pac->ops && pac->ops->clear)
+		pac->ops->clear(stream, pac->user_data);
+
+	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+
+	return 0;
+}
+
+static bool bap_stream_valid(struct bt_bap_stream *stream)
+{
+	if (!stream || !stream->bap)
+		return false;
+
+	return queue_find(stream->bap->streams, NULL, stream);
+}
+
+static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	struct iovec iov;
+	struct bt_ascs_release rel;
+	struct bt_bap_req *req;
+	struct bt_bap *bap;
+
+	if (!stream->client) {
+		stream_release(stream, NULL);
+		return 0;
+	}
+
+	memset(&req, 0, sizeof(req));
+
+	rel.ase = stream->ep->id;
+
+	iov.iov_base = &rel;
+	iov.iov_len = sizeof(rel);
+
+	bap = stream->bap;
+
+	/* If stream does not belong to a client session, clean it up now */
+	if (!bap_stream_valid(stream)) {
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		stream = NULL;
+		return 0;
+	}
+
+	req = bap_req_new(stream, BT_ASCS_RELEASE, &iov, 1, func, user_data);
+	if (!bap_queue_req(bap, req)) {
+		bap_req_free(req);
+		return 0;
+	}
+
+	return req->id;
+}
+
+static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
+					bool enable_links, struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+		stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_STREAMING);
+	else
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CONFIG);
+
+	return 1;
+}
+
+static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_STREAMING);
+
+	return 1;
+}
+
+static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
+					bool disable_links,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_DISABLING);
+
+	return 1;
+}
+
+static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
+					struct iovec *data,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	util_iov_free(stream->meta, 1);
+	stream->meta = util_iov_dup(data, 1);
+
+	return 1;
+}
+
+static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_RELEASING);
+
+	return 1;
+}
+
+#define STREAM_OPS(_type, _config, _qos, _enable, _start, _disable, _stop, \
+			_metadata, _release) \
+{ \
+	.type = _type, \
+	.config = _config, \
+	.qos = _qos, \
+	.enable = _enable, \
+	.start = _start, \
+	.disable = _disable, \
+	.stop = _stop, \
+	.metadata = _metadata, \
+	.release = _release, \
+}
+
+static const struct bt_bap_stream_ops stream_ops[] = {
+	STREAM_OPS(BT_BAP_SINK,
+			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
+			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
+			bap_ucast_metadata, bap_ucast_release),
+	STREAM_OPS(BT_BAP_SOURCE,
+			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
+			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
+			bap_ucast_metadata, bap_ucast_release),
+	STREAM_OPS(BT_BAP_BCAST_SINK,
+			bap_bcast_config, NULL, bap_bcast_enable,
+			bap_bcast_start, bap_bcast_disable, NULL,
+			bap_bcast_metadata, bap_bcast_release),
+	STREAM_OPS(BT_BAP_BCAST_SOURCE,
+			bap_bcast_config, NULL, bap_bcast_enable,
+			bap_bcast_start, bap_bcast_disable, NULL,
+			bap_bcast_metadata, bap_bcast_release),
+};
+
+static const struct bt_bap_stream_ops *
+bap_stream_new_ops(struct bt_bap_stream *stream)
+{
+	const struct bt_bap_stream_ops *ops;
+	uint8_t type = bt_bap_stream_get_type(stream);
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(stream_ops); i++) {
+		ops = &stream_ops[i];
+
+		if (ops->type == type)
+			return ops;
+	}
+
+	return NULL;
+}
+
+static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
+						struct bt_bap_endpoint *ep,
+						struct bt_bap_pac *lpac,
+						struct bt_bap_pac *rpac,
+						struct iovec *data,
+						bool client)
+{
+	struct bt_bap_stream *stream;
+
+	stream = new0(struct bt_bap_stream, 1);
+	stream->bap = bap;
+	stream->ep = ep;
+	ep->stream = stream;
+	stream->lpac = lpac;
+	stream->rpac = rpac;
+	stream->cc = util_iov_dup(data, 1);
+	stream->client = client;
+	stream->ops = bap_stream_new_ops(stream);
+
+	queue_push_tail(bap->streams, stream);
+
+	return stream;
+}
+
+static struct bt_bap_stream_io *stream_io_ref(struct bt_bap_stream_io *io)
+{
+	if (!io)
+		return NULL;
+
+	__sync_fetch_and_add(&io->ref_count, 1);
+
+	return io;
+}
+
+static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
+{
+	struct io *io;
+	struct bt_bap_stream_io *sio;
+
+	io = io_new(fd);
+	if (!io)
+		return NULL;
+
+	DBG(bap, "fd %d", fd);
+
+	sio = new0(struct bt_bap_stream_io, 1);
+	sio->bap = bap;
+	sio->io = io;
+
+	return stream_io_ref(sio);
+}
+
+static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
+{
+	if (!stream)
+		return NULL;
+
+	if (stream->io)
+		return stream->io;
+
+	if (stream->link)
+		return stream->link->io;
+
+	return NULL;
+}
+
+static bool stream_io_disconnected(struct io *io, void *user_data);
+
+static bool bap_stream_io_attach(struct bt_bap_stream *stream, int fd,
+							bool connecting)
+{
+	struct bt_bap_stream_io *io;
+
+	io = stream_get_io(stream);
+	if (io) {
+		if (fd == stream_io_get_fd(io)) {
+			if (!stream->io)
+				stream->io = stream_io_ref(io);
+
+			io->connecting = connecting;
+			return true;
+		}
+
+		DBG(stream->bap, "stream %p io already set", stream);
+		return false;
+	}
+
+	DBG(stream->bap, "stream %p connecting %s", stream,
+				connecting ? "true" : "false");
+
+	io = stream_io_new(stream->bap, fd);
+	if (!io)
+		return false;
+
+	io->connecting = connecting;
+	stream->io = io;
+	io_set_disconnect_handler(io->io, stream_io_disconnected, stream, NULL);
+
+	return true;
+}
+
+static void bap_stream_set_io(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	int fd = PTR_TO_INT(user_data);
+	bool ret;
+
+	if (fd >= 0)
+		ret = bap_stream_io_attach(stream, fd, false);
+	else
+		ret = bap_stream_io_detach(stream);
+
+	if (!ret)
+		return;
+
+	switch (stream->ep->state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		if (fd < 0)
+			bt_bap_stream_disable(stream, false, NULL, NULL);
+		else
+			bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_DISABLING:
+		if (fd < 0)
+			bt_bap_stream_stop(stream, NULL, NULL);
+		break;
+	}
 }
 
 static void ascs_ase_rsp_add_errno(struct iovec *iov, uint8_t id, int err)
@@ -1518,55 +2269,6 @@ static void ascs_ase_rsp_add_errno(struct iovec *iov, uint8_t id, int err)
 	}
 }
 
-static void ascs_ase_rsp_success(struct iovec *iov, uint8_t id)
-{
-	return ascs_ase_rsp_add(iov, id, BT_ASCS_RSP_SUCCESS,
-					BT_ASCS_REASON_NONE);
-}
-
-static void ep_config_cb(struct bt_bap_stream *stream, int err)
-{
-	if (err)
-		return;
-
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (!bt_bap_stream_io_dir(stream))
-			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_QOS);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
-		return;
-	}
-
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-}
-
-static uint8_t stream_config(struct bt_bap_stream *stream, struct iovec *cc,
-							struct iovec *rsp)
-{
-	struct bt_bap_pac *pac = stream->lpac;
-
-	DBG(stream->bap, "stream %p", stream);
-
-	/* TODO: Wait for pac->ops response */
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	if (!util_iov_memcmp(stream->cc, cc)) {
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-		return 0;
-	}
-
-	util_iov_free(stream->cc, 1);
-	stream->cc = util_iov_dup(cc, 1);
-
-	if (pac->ops && pac->ops->config)
-		pac->ops->config(stream, cc, NULL, ep_config_cb,
-						pac->user_data);
-
-	return 0;
-}
-
 static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 				 struct bt_ascs_config *req,
 				 struct iovec *iov, struct iovec *rsp)
@@ -1826,17 +2528,6 @@ static uint8_t ascs_enable(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_enable(ep, bap, req, iov, rsp);
 }
 
-static uint8_t stream_start(struct bt_bap_stream *stream, struct iovec *rsp)
-{
-	DBG(stream->bap, "stream %p", stream);
-
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
-
-	return 0;
-}
-
 static uint8_t ep_start(struct bt_bap_endpoint *ep, struct iovec *rsp)
 {
 	struct bt_bap_stream *stream = ep->stream;
@@ -1970,20 +2661,6 @@ static uint8_t ascs_disable(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_disable(ep, rsp);
 }
 
-static uint8_t stream_stop(struct bt_bap_stream *stream, struct iovec *rsp)
-{
-	DBG(stream->bap, "stream %p", stream);
-
-	if (!stream)
-		return 0;
-
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-
-	return 0;
-}
-
 static uint8_t ep_stop(struct bt_bap_endpoint *ep, struct iovec *rsp)
 {
 	struct bt_bap_stream *stream = ep->stream;
@@ -2045,19 +2722,6 @@ static uint8_t ascs_stop(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_stop(ep, rsp);
 }
 
-static uint8_t stream_metadata(struct bt_bap_stream *stream, struct iovec *meta,
-						struct iovec *rsp)
-{
-	DBG(stream->bap, "stream %p", stream);
-
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	util_iov_free(stream->meta, 1);
-	stream->meta = util_iov_dup(meta, 1);
-
-	return 0;
-}
-
 static uint8_t ep_metadata(struct bt_bap_endpoint *ep, struct iovec *meta,
 						struct iovec *rsp)
 {
@@ -2110,23 +2774,6 @@ static uint8_t ascs_metadata(struct bt_ascs *ascs, struct bt_bap *bap,
 	return ep_metadata(ep, iov, rsp);
 }
 
-static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
-{
-	struct bt_bap_pac *pac;
-
-	DBG(stream->bap, "stream %p", stream);
-
-	ascs_ase_rsp_success(rsp, stream->ep->id);
-
-	pac = stream->lpac;
-	if (pac->ops && pac->ops->clear)
-		pac->ops->clear(stream, pac->user_data);
-
-	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-
-	return 0;
-}
-
 static uint8_t ascs_release(struct bt_ascs *ascs, struct bt_bap *bap,
 				struct iovec *iov, struct iovec *rsp)
 {
@@ -2363,20 +3010,6 @@ static struct bt_pacs *bap_get_pacs(struct bt_bap *bap)
 	return bap->rdb->pacs;
 }
 
-static struct bt_ascs *bap_get_ascs(struct bt_bap *bap)
-{
-	if (!bap)
-		return NULL;
-
-	if (bap->rdb->ascs)
-		return bap->rdb->ascs;
-
-	bap->rdb->ascs = new0(struct bt_ascs, 1);
-	bap->rdb->ascs->bdb = bap->rdb;
-
-	return bap->rdb->ascs;
-}
-
 static bool match_codec(const void *data, const void *user_data)
 {
 	const struct bt_bap_pac *pac = data;
@@ -3844,156 +4477,6 @@ static void bap_endpoint_attach(struct bt_bap *bap, struct bt_bap_endpoint *ep)
 						bap_endpoint_notify, ep);
 }
 
-static void append_group(void *data, void *user_data)
-{
-	struct bt_bap_req *req = data;
-	struct iovec *iov = user_data;
-	size_t i;
-
-	for (i = 0; i < req->len; i++)
-		util_iov_push_mem(iov, req->iov[i].iov_len,
-					req->iov[i].iov_base);
-}
-
-static uint16_t bap_req_len(struct bt_bap_req *req)
-{
-	uint16_t len = 0;
-	size_t i;
-	const struct queue_entry *e;
-
-	for (i = 0; i < req->len; i++)
-		len += req->iov[i].iov_len;
-
-	e = queue_get_entries(req->group);
-	for (; e; e = e->next)
-		len += bap_req_len(e->data);
-
-	return len;
-}
-
-static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
-{
-	struct bt_ascs *ascs = bap_get_ascs(bap);
-	int ret;
-	uint16_t handle;
-	struct bt_ascs_ase_hdr hdr;
-	struct iovec iov;
-	size_t i;
-
-	iov.iov_len = sizeof(hdr) + bap_req_len(req);
-
-	DBG(bap, "req %p len %u", req, iov.iov_len);
-
-	if (req->stream && !queue_find(bap->streams, NULL, req->stream)) {
-		DBG(bap, "stream %p detached, aborting op 0x%02x", req->op);
-		return false;
-	}
-
-	if (!gatt_db_attribute_get_char_data(ascs->ase_cp, NULL, &handle,
-						NULL, NULL, NULL)) {
-		DBG(bap, "Unable to find Control Point");
-		return false;
-	}
-
-	iov.iov_base = alloca(iov.iov_len);
-	iov.iov_len = 0;
-
-	hdr.op = req->op;
-	hdr.num = 1 + queue_length(req->group);
-
-	util_iov_push_mem(&iov, sizeof(hdr), &hdr);
-
-	for (i = 0; i < req->len; i++)
-		util_iov_push_mem(&iov, req->iov[i].iov_len,
-					req->iov[i].iov_base);
-
-	/* Append the request group with the same opcode */
-	queue_foreach(req->group, append_group, &iov);
-
-	ret = bt_gatt_client_write_without_response(bap->client, handle,
-							false, iov.iov_base,
-							iov.iov_len);
-	if (!ret) {
-		DBG(bap, "Unable to Write to Control Point");
-		return false;
-	}
-
-	bap->req = req;
-
-	return true;
-}
-
-static bool bap_process_queue(void *data)
-{
-	struct bt_bap *bap = data;
-	struct bt_bap_req *req;
-
-	DBG(bap, "");
-
-	if (bap->process_id) {
-		timeout_remove(bap->process_id);
-		bap->process_id = 0;
-	}
-
-	while ((req = queue_pop_head(bap->reqs))) {
-		if (bap_send(bap, req))
-			break;
-		bap_req_complete(req, NULL);
-	}
-
-	return false;
-}
-
-static bool match_req(const void *data, const void *match_data)
-{
-	const struct bt_bap_req *pend = data;
-	const struct bt_bap_req *req = match_data;
-
-	return pend->op == req->op;
-}
-
-static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
-{
-	struct bt_bap_req *pend;
-	struct queue *queue;
-	struct bt_att *att = bt_bap_get_att(bap);
-	uint16_t mtu = bt_att_get_mtu(att);
-	uint16_t len = 2 + bap_req_len(req);
-
-	if (len > mtu) {
-		DBG(bap, "Unable to queue request: req len %u > %u mtu", len,
-									mtu);
-		return false;
-	}
-
-	pend = queue_find(bap->reqs, match_req, req);
-	/* Check if req can be grouped together and it fits in the MTU */
-	if (pend && (bap_req_len(pend) + len < mtu)) {
-		if (!pend->group)
-			pend->group = queue_new();
-		/* Group requests with the same opcode */
-		queue = pend->group;
-	} else {
-		queue = bap->reqs;
-	}
-
-	DBG(bap, "req %p (op 0x%2.2x) queue %p", req, req->op, queue);
-
-	if (!queue_push_tail(queue, req)) {
-		DBG(bap, "Unable to queue request");
-		return false;
-	}
-
-	/* Only attempot to process queue if there is no outstanding request
-	 * and it has not been scheduled.
-	 */
-	if (!bap->req && !bap->process_id)
-		bap->process_id = timeout_add(BAP_PROCESS_TIMEOUT,
-						bap_process_queue, bap, NULL);
-
-	return true;
-}
-
 static void bap_cp_notify(struct bt_bap *bap, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -4562,104 +5045,28 @@ static bool find_ep_pacs(const void *data, const void *user_data)
 	return false;
 }
 
-static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
-					uint8_t op, struct iovec *iov,
-					size_t len,
-					bt_bap_stream_func_t func,
-					void *user_data)
-{
-	struct bt_bap_req *req;
-	static unsigned int id;
-
-	req = new0(struct bt_bap_req, 1);
-	req->id = ++id ? id : ++id;
-	req->stream = stream;
-	req->op = op;
-	req->iov = util_iov_dup(iov, len);
-	req->len = len;
-	req->func = func;
-	req->user_data = user_data;
-
-	return req;
-}
-
-static bool bap_stream_valid(struct bt_bap_stream *stream)
-{
-	if (!stream || !stream->bap)
-		return false;
-
-	return queue_find(stream->bap->streams, NULL, stream);
-}
-
 unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov[2];
-	struct bt_ascs_config config;
-	uint8_t iovlen = 1;
-	struct bt_bap_req *req;
+	unsigned int id;
 
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	switch (bt_bap_stream_get_type(stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		if (!stream->client) {
-			stream_config(stream, data, NULL);
-			return 0;
-		}
+	if (!stream->ops || !stream->ops->config)
+		return 0;
 
-		memset(&config, 0, sizeof(config));
+	if (!bt_bap_ref_safe(stream->bap))
+		return 0;
 
-		config.ase = stream->ep->id;
-		config.latency = qos->ucast.target_latency;
-		config.phy = qos->ucast.io_qos.phy;
-		config.codec = stream->rpac->codec;
+	id = stream->ops->config(stream, qos, data, func, user_data);
 
-		if (config.codec.id == 0xff) {
-			config.codec.cid = cpu_to_le16(config.codec.cid);
-			config.codec.vid = cpu_to_le16(config.codec.vid);
-		}
+	bt_bap_unref(stream->bap);
 
-		iov[0].iov_base = &config;
-		iov[0].iov_len = sizeof(config);
-
-		if (data) {
-			if (!bt_bap_debug_config(data->iov_base, data->iov_len,
-						stream->bap->debug_func,
-						stream->bap->debug_data))
-				return 0;
-
-			config.cc_len = data->iov_len;
-			iov[1] = *data;
-			iovlen++;
-		}
-
-		req = bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen,
-					func, user_data);
-
-		if (!bap_queue_req(stream->bap, req)) {
-			bap_req_free(req);
-			return 0;
-		}
-
-		stream->qos = *qos;
-
-		return req->id;
-	case BT_BAP_STREAM_TYPE_BCAST:
-		stream->qos = *qos;
-		if (stream->lpac->type == BT_BAP_BCAST_SINK) {
-			if (data)
-				stream_config(stream, data, NULL);
-			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-		}
-		return 1;
-	}
-
-	return 0;
+	return id;
 }
 
 static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -4872,83 +5279,22 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov;
-	struct bt_ascs_qos qos;
-	struct bt_bap_req *req;
+	unsigned int id;
 
-	/* Table 3.2: ASE state machine transition
-	 * Initiating device - client Only
-	 */
-	if (!bap_stream_valid(stream) || !stream->client)
+	if (!bap_stream_valid(stream))
 		return 0;
 
-	memset(&qos, 0, sizeof(qos));
-
-	/* TODO: Figure out how to pass these values around */
-	qos.ase = stream->ep->id;
-	qos.cig = data->ucast.cig_id;
-	qos.cis = data->ucast.cis_id;
-	put_le24(data->ucast.io_qos.interval, qos.interval);
-	qos.framing = data->ucast.framing;
-	qos.phy = data->ucast.io_qos.phy;
-	qos.sdu = cpu_to_le16(data->ucast.io_qos.sdu);
-	qos.rtn = data->ucast.io_qos.rtn;
-	qos.latency = cpu_to_le16(data->ucast.io_qos.latency);
-	put_le24(data->ucast.delay, qos.pd);
-
-	iov.iov_base = &qos;
-	iov.iov_len = sizeof(qos);
-
-	req = bap_req_new(stream, BT_ASCS_QOS, &iov, 1, func, user_data);
-
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
+	if (!stream->ops || !stream->ops->qos)
 		return 0;
-	}
 
-	stream->qos = *data;
-
-	return req->id;
-}
-
-static int bap_stream_metadata(struct bt_bap_stream *stream, uint8_t op,
-					struct iovec *data,
-					bt_bap_stream_func_t func,
-					void *user_data)
-{
-	struct iovec iov[2];
-	struct bt_ascs_metadata meta;
-	struct bt_bap_req *req;
-	struct metadata {
-		uint8_t len;
-		uint8_t type;
-		uint8_t data[2];
-	} ctx = LTV(0x02, 0x01, 0x00); /* Context = Unspecified */
-
-	memset(&meta, 0, sizeof(meta));
-
-	meta.ase = stream->ep->id;
-
-	iov[0].iov_base = &meta;
-	iov[0].iov_len = sizeof(meta);
-
-	if (data)
-		iov[1] = *data;
-	else {
-		iov[1].iov_base = &ctx;
-		iov[1].iov_len = sizeof(ctx);
-	}
-
-	meta.len = iov[1].iov_len;
-
-	req = bap_req_new(stream, op, iov, 2, func, user_data);
-
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
+	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
-	}
 
-	return req->id;
+	id = stream->ops->qos(stream, data, func, user_data);
+
+	bt_bap_unref(stream->bap);
+
+	return id;
 }
 
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
@@ -4957,84 +5303,45 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	int ret = 0;
+	unsigned int id;
 
-	/* Table 3.2: ASE state machine transition
-	 * Initiating device - client Only
-	 */
-	if (!bap_stream_valid(stream) || !stream->client)
+	if (!bap_stream_valid(stream))
 		return 0;
 
-	switch (bt_bap_stream_get_type(stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		ret = bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
-							func, user_data);
-		if (!ret || !enable_links)
-			return ret;
+	if (!stream->ops || !stream->ops->enable)
+		return 0;
 
-		if (stream->link)
-			bap_stream_metadata(stream->link, BT_ASCS_ENABLE,
-						metadata, NULL, NULL);
-		break;
-	case BT_BAP_STREAM_TYPE_BCAST:
-		if (!bt_bap_stream_io_dir(stream))
-			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			stream_set_state_broadcast(stream,
-				 BT_BAP_STREAM_STATE_STREAMING);
+	if (!bt_bap_ref_safe(stream->bap))
+		return 0;
 
-		return 1;
-	}
+	id = stream->ops->enable(stream, enable_links, metadata, func,
+					user_data);
 
-	return ret;
+	bt_bap_unref(stream->bap);
+
+	return id;
 }
 
 unsigned int bt_bap_stream_start(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov;
-	struct bt_ascs_start start;
-	struct bt_bap_req *req;
+	unsigned int id;
 
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	switch (bt_bap_stream_get_type(stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		if (!stream->client) {
-			if (stream->ep->dir == BT_BAP_SINK)
-				stream_start(stream, NULL);
-			return 0;
-		}
+	if (!stream->ops || !stream->ops->start)
+		return 0;
 
-		if (stream->ep->dir == BT_BAP_SINK)
-			return 0;
+	if (!bt_bap_ref_safe(stream->bap))
+		return 0;
 
-		memset(&start, 0, sizeof(start));
+	id = stream->ops->start(stream, func, user_data);
 
-		start.ase = stream->ep->id;
+	bt_bap_unref(stream->bap);
 
-		iov.iov_base = &start;
-		iov.iov_len = sizeof(start);
-
-		req = bap_req_new(stream, BT_ASCS_START,
-					&iov, 1, func, user_data);
-
-		if (!bap_queue_req(stream->bap, req)) {
-			bap_req_free(req);
-			return 0;
-		}
-
-		return req->id;
-	case BT_BAP_STREAM_TYPE_BCAST:
-		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_STREAMING);
-		return 1;
-	}
-
-	return 0;
+	return id;
 }
 
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
@@ -5042,84 +5349,44 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov;
-	struct bt_ascs_disable disable;
-	struct bt_bap_req *req;
+	unsigned int id;
 
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	if (!stream->client) {
-		stream_disable(stream, NULL);
+	if (!stream->ops || !stream->ops->disable)
 		return 0;
-	}
 
-	switch (bt_bap_stream_get_type(stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		memset(&disable, 0, sizeof(disable));
+	if (!bt_bap_ref_safe(stream->bap))
+		return 0;
 
-		disable.ase = stream->ep->id;
+	id = stream->ops->disable(stream, disable_links, func, user_data);
 
-		iov.iov_base = &disable;
-		iov.iov_len = sizeof(disable);
+	bt_bap_unref(stream->bap);
 
-		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, func,
-							user_data);
-
-		if (!bap_queue_req(stream->bap, req)) {
-			bap_req_free(req);
-			return 0;
-		}
-
-		if (disable_links)
-			bt_bap_stream_disable(stream->link, false, NULL, NULL);
-
-		return req->id;
-
-	case BT_BAP_STREAM_TYPE_BCAST:
-		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_DISABLING);
-		return 1;
-	}
-
-	return 0;
+	return id;
 }
 
 unsigned int bt_bap_stream_stop(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov;
-	struct bt_ascs_stop stop;
-	struct bt_bap_req *req;
+	unsigned int id;
 
 	if (!bap_stream_valid(stream))
 		return 0;
 
-	if (!stream->client) {
-		if (stream->ep->dir == BT_BAP_SINK)
-			stream_stop(stream, NULL);
-		return 0;
-	}
-
-	if (stream->ep->dir == BT_BAP_SINK)
+	if (!stream->ops || !stream->ops->stop)
 		return 0;
 
-	memset(&stop, 0, sizeof(stop));
-
-	stop.ase = stream->ep->id;
-
-	iov.iov_base = &stop;
-	iov.iov_len = sizeof(stop);
-
-	req = bap_req_new(stream, BT_ASCS_STOP, &iov, 1, func, user_data);
-
-	if (!bap_queue_req(stream->bap, req)) {
-		bap_req_free(req);
+	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
-	}
 
-	return req->id;
+	id = stream->ops->stop(stream, func, user_data);
+
+	bt_bap_unref(stream->bap);
+
+	return id;
 }
 
 unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
@@ -5127,73 +5394,41 @@ unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	if (!stream)
+	unsigned int id;
+
+	if (!bap_stream_valid(stream))
 		return 0;
 
-	switch (bt_bap_stream_get_type(stream)) {
-	case BT_BAP_STREAM_TYPE_UCAST:
-		if (!stream->client) {
-			stream_metadata(stream, metadata, NULL);
-			return 0;
-		}
-		return bap_stream_metadata(stream, BT_ASCS_METADATA,
-				metadata, func,	user_data);
-	case BT_BAP_STREAM_TYPE_BCAST:
-		util_iov_free(stream->meta, 1);
-		stream->meta = util_iov_dup(metadata, 1);
-		return 1;
-	default:
+	if (!stream->ops || !stream->ops->metadata)
 		return 0;
-	}
+
+	if (!bt_bap_ref_safe(stream->bap))
+		return 0;
+
+	id = stream->ops->metadata(stream, metadata, func, user_data);
+
+	bt_bap_unref(stream->bap);
+
+	return id;
 }
 
 unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	struct iovec iov;
-	struct bt_ascs_release rel;
-	struct bt_bap_req *req;
-	struct bt_bap *bap;
+	unsigned int id;
 
-	if (!stream)
+	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
-	if (!stream->client) {
-		stream_release(stream, NULL);
+	if (!bt_bap_ref_safe(stream->bap))
 		return 0;
-	}
 
-	memset(&req, 0, sizeof(req));
+	id = stream->ops->release(stream, func, user_data);
 
-	rel.ase = stream->ep->id;
+	bt_bap_unref(stream->bap);
 
-	iov.iov_base = &rel;
-	iov.iov_len = sizeof(rel);
-
-	bap = stream->bap;
-
-	/* If stream is broadcast, no BT_ASCS_RELEASE is required */
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_RELEASING);
-		return 0;
-	}
-
-	/* If stream does not belong to a client session, clean it up now */
-	if (!bap_stream_valid(stream)) {
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-		stream = NULL;
-	}
-
-	req = bap_req_new(stream, BT_ASCS_RELEASE, &iov, 1, func, user_data);
-
-	if (!bap_queue_req(bap, req)) {
-		bap_req_free(req);
-		return 0;
-	}
-
-	return req->id;
+	return id;
 }
 
 uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
-- 
2.43.0

