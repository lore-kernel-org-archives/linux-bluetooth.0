Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32661DE4CA
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374543; cv=pass; b=Wd7FNnBoV1TKMAId2b67JUs9wOvESkjAg/kHddQL+1QxxUBkDYWADciWt5zJ8PNdML5fmdcEwo12mZovIGkcNob1bcsUyek3uLdJXr4l66xdf9lYy7rzhluE/KPvTXGM9jNtBhXlG/A2JareMMb3HtVlkDRyzORizgQ3HTlDc6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374543; c=relaxed/simple;
	bh=ImCUGNYSigWSXsLnybzruU6uBY2ULonkAGOC2F/XR+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtoBBk7Z06IFNHDu6576m4HkvXCpvlE9E2k2Fw2t3YuKBsv85IJu9xBBXYm0JglKYolO68CYleG26Ww98FOanYl4KdpkHrbBKmpTj2mg4SgKtbDa/mWnxHFj73qijcaRQNcBBWKRFWvQk8/11yIaSzfoSg/H04npFNSeiHVuF1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=IxParE8f; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="IxParE8f"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yc0pVSz109d;
	Sun,  4 May 2025 19:02:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+vaWcprgXsakvH71ixpQA+PrGwhO4jcBa7JNlxmpH0=;
	b=IxParE8fyKvfHEVUn7phang53WmMRCdylCXLclRHQEdD4AqGRsQwKoV9Li3xFvaYId1X/O
	6m4Q0t05xWGuAWIShLdSW49kOJIIF8j370orzv826HZhxjxXTNhzTvf8OG9hdzPHSVrjGw
	ZJY44im2E241szIW4mu5CxP0QI67te0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+vaWcprgXsakvH71ixpQA+PrGwhO4jcBa7JNlxmpH0=;
	b=HRUm/tdKWYrld2Br2Q7fBWaYPVjZF8iKqTHmeNU0PjJEryTa7HumSVmNkpzVr9hx+BOpof
	teSqBtBBZ4meOdUxo7lQoNpvJ5lJLfG4kr/I8Gj92AIkv/t+FUsOXIbeZx2Ya9UYwN/Cmt
	8pSpIawRb0ohurXRdtceexeono2pBhs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374532; a=rsa-sha256; cv=none;
	b=JgbkVNKexv11JmX9KlHVoKfJFhc5+5TI5lD6xJV1Pm41+r3aGJEfgeBFwNcAwE7YQOcjac
	yLG36PXpLJNZ6xJ8qqP1+aAiR1wmyPjl68i8itzTgharuwwzHddXi7IX2bHVnhVbv3UGUD
	+b7PofrUk5AKW6U/gDWCq2ogPymYdoc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 06/11] bap: do not try QoS before links are updated & io created
Date: Sun,  4 May 2025 19:01:58 +0300
Message-ID: <3c011d53782206ba0f8f6e7434166df46525d5a7.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In setup config, QoS must be done after corresponding bap_state
callback, because stream links are updated only at that point.  If the
ASE was in CONFIG state before reconfiguration, this gets done in wrong
order.

Track explicitly that bap_state() is done after bt_bap_stream_config(),
before proceeding to QoS.
---
 profiles/audio/bap.c | 82 ++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dcef98148..9b3bd405f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -75,6 +75,7 @@ struct bap_setup {
 	bool recreate;
 	bool cig_active;
 	uint8_t sid;
+	bool config_pending;
 	struct iovec *caps;
 	struct iovec *metadata;
 	unsigned int id;
@@ -720,6 +721,46 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 	setup->msg = NULL;
 }
 
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+				struct bt_bap_stream *stream, int defer);
+
+static int setup_qos(struct bap_setup *setup)
+{
+	struct bap_data *data = setup->ep->data;
+	struct bt_bap_stream *stream = setup->stream;
+
+	if (!stream)
+		return -EINVAL;
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_CONFIG)
+		goto error;
+	if (setup->id)
+		goto error;
+
+	setup_create_io(data, setup, stream, true);
+	if (!setup->io) {
+		error("Unable to create io");
+		goto error;
+	}
+
+	/* Wait QoS response to respond */
+	setup->id = bt_bap_stream_qos(stream, &setup->qos, qos_cb, setup);
+	if (!setup->id) {
+		error("Failed to Configure QoS");
+		goto error;
+	}
+
+	/* Bcast does not call the callback */
+	if (bt_bap_stream_get_type(setup->stream) == BT_BAP_STREAM_TYPE_BCAST)
+		setup->id = 0;
+
+	return 0;
+
+error:
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_RELEASING)
+		bt_bap_stream_release(stream, NULL, NULL);
+	return -EIO;
+}
+
 static void config_cb(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
@@ -732,17 +773,8 @@ static void config_cb(struct bt_bap_stream *stream,
 	setup->id = 0;
 
 	if (!code) {
-		/* Check state is already set to config then proceed to qos */
-		if (bt_bap_stream_get_state(stream) ==
-					BT_BAP_STREAM_STATE_CONFIG) {
-			setup->id = bt_bap_stream_qos(stream, &setup->qos,
-							qos_cb, setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream, NULL, NULL);
-			}
-		}
-
+		if (!setup->config_pending)
+			setup_qos(setup);
 		return;
 	}
 
@@ -986,6 +1018,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
+	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -1005,6 +1038,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
 		setup->id = 0;
+		setup->config_pending = false;
 
 		if (ep->data->service)
 			service_set_connecting(ep->data->service);
@@ -1403,6 +1437,7 @@ static void setup_config(void *data, void *user_data)
 						ep->rpac, &setup->qos,
 						setup->caps);
 
+	setup->config_pending = true;
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 						setup->caps, config_cb, setup);
 	if (!setup->id) {
@@ -1807,9 +1842,6 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
-				struct bt_bap_stream *stream, int defer);
-
 static gboolean setup_io_recreate(void *user_data)
 {
 	struct bap_setup *setup = user_data;
@@ -2189,25 +2221,9 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->server_streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (setup && !setup->id) {
-			setup_create_io(data, setup, stream, true);
-			if (!setup->io) {
-				error("Unable to create io");
-				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
-					bt_bap_stream_release(stream, NULL,
-								NULL);
-				return;
-			}
-
-			/* Wait QoS response to respond */
-			setup->id = bt_bap_stream_qos(stream,
-							&setup->qos,
-							qos_cb,	setup);
-			if (!setup->id) {
-				error("Failed to Configure QoS");
-				bt_bap_stream_release(stream,
-							NULL, NULL);
-			}
+		if (setup) {
+			setup->config_pending = false;
+			setup_qos(setup);
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-- 
2.49.0

