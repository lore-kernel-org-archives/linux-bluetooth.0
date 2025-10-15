Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97520320CD5
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542833; cv=pass; b=KPnBvXdc3O0hoMckVx4kFZDRfIdW28/NqoIZLdZg9mJfAUfDeECY4CSYcRqQmFG2r/FLrOFQT/oSrUQL43eU59rg4BKHg1Abt8glGiew11xmPhxXoUVDhCkJXNXFQgh4ogxG3pHCd+q//QN++lI8wobsIOjWL/qxXezeguh4Sno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542833; c=relaxed/simple;
	bh=4eeBmy1SfuPcjAU3lNuSReY14C23i2+gmylOtCtoLuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwpWNCtmUVX33ZL4VYuV9Nxlm9RZnF4+jLZh0jw+lqS2lh92TTXq/ILImKD8DPF/faS7bxaL0c23/OlfwqjVihQxWyHhSVDwKueWiHZRweI2jWmsvn6bPpN24aRM0oGAVcbAS2/3SgNExEyqXdI+hKsitgUZ9mjUKmDxak0q/qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tq2qj3s7; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tq2qj3s7"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cmwJg5L2SzyWM;
	Wed, 15 Oct 2025 18:40:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760542819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNbYjQ4gomm3+rLmoZ5Ms+9356URhX24jPG8+ejqMnE=;
	b=tq2qj3s7t4Yz2BhEKaQm/ffjFZ3uOX7/tYSg67DYKcqqfpZFYM+REJrcwU0czG9cTahA5l
	eqcSlrtbDnZ78T2hKnQEBNKUBx+Kk+wHHCDFLo5GJenIN8ZLYzWCiFy0AV97Rg7Y2/5qv7
	pPWQOAnj9S3udld3OxfGslmdhqsAW0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760542819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNbYjQ4gomm3+rLmoZ5Ms+9356URhX24jPG8+ejqMnE=;
	b=AnY2HZliw3KdBjha7BOEOmx6+R8276tQIYTHAfFrnguvVJKdpYwrvx6CJBvRCWMk/UQBSl
	AsDUpFjh6LIKZ5+b9ro8h7Svmu/ytJpFcJBnS2EKfmbvk8vdxtFjRPOqMlPHBg65pVzNdc
	jOCbHg60Dm8SDQp91LcMq2hK4H6A5+k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760542819; a=rsa-sha256; cv=none;
	b=eTopaPj56u2pIqUpBrWLD6j79se/gqxvS7eUEkK4f72r80bfz9fqljzSL7piDm0qOAwknd
	Vo5oj8i5gQ2ac/xhMSjnyZ+C3LlkBdszB37MLhbFtFkoAHTj91tok806zkOJhv0iVl0ou6
	wLGmE2XhDtM1w4ofjnWbNCc8OZ8WqiE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] transport: wait until BAP fd is writable/readable before resuming
Date: Wed, 15 Oct 2025 18:40:12 +0300
Message-ID: <8dea3458a29d223698dcdd189ea6d8de079d8328.1760542606.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
References: <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connection may still be pending when entering STREAMING.

Wait until the fd becomes readable/writable before continuing.
---
 profiles/audio/transport.c | 69 ++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 83e3c9791..08ed699b2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -108,6 +108,7 @@ struct bap_transport {
 	struct bt_bap_qos	qos;
 	guint			resume_id;
 	struct iovec		*meta;
+	guint			chan_id;
 };
 
 struct media_transport_ops {
@@ -2098,10 +2099,20 @@ static guint transport_bap_suspend(struct media_transport *transport,
 	return id;
 }
 
+static void bap_clear_chan(struct bap_transport *bap)
+{
+	if (bap->chan_id) {
+		g_source_remove(bap->chan_id);
+		bap->chan_id = 0;
+	}
+}
+
 static void transport_bap_cancel(struct media_transport *transport, guint id)
 {
 	struct bap_transport *bap = transport->data;
 
+	bap_clear_chan(bap);
+
 	if (id == bap->resume_id && bap->resume_id) {
 		g_source_remove(bap->resume_id);
 		bap->resume_id = 0;
@@ -2162,6 +2173,38 @@ static void bap_metadata_changed(struct media_transport *transport)
 	}
 }
 
+static gboolean bap_transport_fd_ready(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	int fd;
+	uint16_t imtu, omtu;
+	GError *err = NULL;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		error("Transport connection failed");
+		goto done;
+	}
+
+	if (!bt_io_get(chan, &err, BT_IO_OPT_OMTU, &omtu,
+					BT_IO_OPT_IMTU, &imtu,
+					BT_IO_OPT_INVALID)) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	fd = g_io_channel_unix_get_fd(chan);
+	media_transport_set_fd(transport, fd, imtu, omtu);
+	transport_update_playing(transport, TRUE);
+
+done:
+	bap->chan_id = 0;
+	bap_resume_complete(transport);
+
+	return FALSE;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -2170,9 +2213,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	struct media_owner *owner = transport->owner;
 	struct io *io;
 	GIOChannel *chan;
-	GError *err = NULL;
 	int fd;
-	uint16_t imtu, omtu;
 
 	if (bap->stream != stream)
 		return;
@@ -2209,7 +2250,6 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 
 		bap_metadata_changed(transport);
-		transport_update_playing(transport, TRUE);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
@@ -2231,21 +2271,20 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		goto done;
 	}
 
+	/* Wait for FD to become ready */
+	bap_clear_chan(bap);
+
 	chan = g_io_channel_unix_new(fd);
-
-	if (!bt_io_get(chan, &err, BT_IO_OPT_OMTU, &omtu,
-					BT_IO_OPT_IMTU, &imtu,
-					BT_IO_OPT_INVALID)) {
-		error("%s", err->message);
-		goto done;
-	}
-
+	bap->chan_id = g_io_add_watch(chan,
+				G_IO_OUT | G_IO_IN |
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				bap_transport_fd_ready, transport);
 	g_io_channel_unref(chan);
-
-	media_transport_set_fd(transport, fd, imtu, omtu);
-	transport_update_playing(transport, TRUE);
+	if (bap->chan_id)
+		return;
 
 done:
+	bap_clear_chan(bap);
 	bap_resume_complete(transport);
 }
 
@@ -2287,6 +2326,8 @@ static void transport_bap_destroy(void *data)
 {
 	struct bap_transport *bap = data;
 
+	bap_clear_chan(bap);
+
 	util_iov_free(bap->meta, 1);
 	bt_bap_state_unregister(bt_bap_stream_get_session(bap->stream),
 							bap->state_id);
-- 
2.51.0

