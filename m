Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025A1DF99C
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253063; cv=pass; b=GlFSKVE2yBiIc6rkquUWCzktCwFfiawoqE/zsYnxI1oXTTKCcr/HEjk+tY/IsiOpGEnUS1Cgmsc7lFmpG1dZYurPvv6GJk4sjrEPAbPVU2MW/bt1YDsFmZhm82DW/sxtV9GAkK8YiMyHvFDCCkcBlUHBW4ZBuIlqXUWoEYUFCZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253063; c=relaxed/simple;
	bh=kj0LmN2UfybPNgnVftunKQsft0AcqQAMuODbTY96aPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7nh7BZtePIknxmdRORnDyCFhBTt/nAocRqi2GxTFBI1fHw2d08zA9GpFFc8I+7kYaDNlzZ05IBitfAcdTrJviYzckVWvXMF9yxNMaCgS5R1RSsw3WfuxwPwD1eiaPcd1OAjBvzG+SRHL2MKbag8xrw2nBWo0g21vBIQdUH72mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=F71Pl7ly; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="F71Pl7ly"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zh9pn1BbLzyQl;
	Mon, 21 Apr 2025 19:30:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745253057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFq9zFrmnvdWEfA6r2rEC8YSb0cXf9m7Kv2s9RpM28g=;
	b=F71Pl7lyiEirjENi1v0CmLriXPVx5M+h+OZwNtq6SrIiRm9K4ysBr0OZao98vGdaD4I/ju
	/OEScXQ03cKxONmb0ZvfJh4roNOdxuG9T6C0Q/XnWyvg5valhJyqx0J4jFlSfp/eRyE3Ku
	tjiQ5AKmeBacM2JacSwfBjde0EtafTs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745253057; a=rsa-sha256; cv=none;
	b=a1/oWxTkT5mtF1VtZWjtGlYWAeWZRF36HERK8ZInOP3WCfw79t8yZ36JwVHBECbqENN1b3
	xOVFX/UsClgVaWgYs+8XfammH+4uEOnpAGFJhFjer61aoCaCJHRAGoK+wlDHrNyGNEVrBo
	KPYV2sMHifL/kjH1mCYC44Q7nkRU4L4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745253057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFq9zFrmnvdWEfA6r2rEC8YSb0cXf9m7Kv2s9RpM28g=;
	b=mbMfGDCNRSPiRVU5bolGj7JzJDlTkKEnc6g+++6fOayjNfNpSWwSOIO4LLXJu+jSDrp4zU
	GL4jGIREnbwpNEaCwGUd9bXDDD1CEEkwqlVC274HXjDsiERbV09mHqwLtVp42vcyO+cbsd
	52Vv6MDTu3TZevRV6QZx9wceBmnHGss=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: don't track streams without setup except for ucast server
Date: Mon, 21 Apr 2025 19:30:53 +0300
Message-ID: <b3c84d2181db1acdc096df03e8d1046b89a7628d.1745252942.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data->streams is is used for determining which streams can connect to
listening socket. This stream list is specific to ucast server.

Rename the variable to data->server_streams, and only put ucast server
streams there.

Fixes data->streams accumulating dead stream pointers.
---
 profiles/audio/bap.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 88d170585..ee7c8bc49 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -106,7 +106,7 @@ struct bap_data {
 	struct queue *snks;
 	struct queue *bcast;
 	struct queue *bcast_snks;
-	struct queue *streams;
+	struct queue *server_streams;
 	GIOChannel *listen_io;
 	unsigned int io_id;
 	int selecting;
@@ -158,7 +158,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->snks, ep_unregister);
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
-	queue_destroy(data->streams, NULL);
+	queue_destroy(data->server_streams, NULL);
 	queue_destroy(data->bcast_snks, setup_free);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
@@ -1695,7 +1695,7 @@ static void iso_confirm_cb(GIOChannel *io, void *user_data)
 	DBG("ISO: incoming connect from %s (CIG 0x%02x CIS 0x%02x)",
 					address, qos.ucast.cig, qos.ucast.cis);
 
-	stream = queue_remove_if(data->streams, match_stream_qos, &qos);
+	stream = queue_remove_if(data->server_streams, match_stream_qos, &qos);
 	if (!stream) {
 		error("No matching stream found");
 		goto drop;
@@ -2040,6 +2040,12 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 
 	DBG("stream %p", stream);
 
+	if (!data->server_streams)
+		data->server_streams = queue_new();
+
+	if (!queue_find(data->server_streams, NULL, stream))
+		queue_push_tail(data->server_streams, stream);
+
 	/* If IO already set skip creating it again */
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
@@ -2143,12 +2149,6 @@ static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 	DBG("setup %p stream %p defer %s", setup, stream,
 				defer ? "true" : "false");
 
-	if (!data->streams)
-		data->streams = queue_new();
-
-	if (!queue_find(data->streams, NULL, stream))
-		queue_push_tail(data->streams, stream);
-
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		setup_create_ucast_io(data, setup, stream, defer);
@@ -2184,7 +2184,7 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		if (setup)
 			setup_free(setup);
 		else
-			queue_remove(data->streams, stream);
+			queue_remove(data->server_streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup && !setup->id) {
@@ -2365,8 +2365,6 @@ static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 		/* Release stream if idle */
 		if (setup)
 			setup_free(setup);
-		else
-			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		// TO DO Reconfiguration
@@ -2469,8 +2467,6 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 		/* Release stream if idle */
 		if (setup)
 			setup_free(setup);
-		else
-			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup)
-- 
2.49.0

