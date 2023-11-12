Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822914ABC
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IAgkvRRn"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA197270C
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Nov 2023 08:00:15 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SSy260q5rz49Q7j;
	Sun, 12 Nov 2023 18:00:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699804814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SboCuILEitsKKZv2da7stJZC84zQez3mCufNSw1yIVw=;
	b=IAgkvRRnCI3pEbbU92EqnNk24J8M/L3k3I28wZ8e/EwKPK9LNnj21x9Q7Y/fi+KhmLZYEX
	O2JFLcX6hX4eOjh3AZ2Misq0SjI7vDrXNudVnULkRWs172fn6UASwvC12VwjNzWkv3ZqBI
	IyY0Gy7BujHwcSKscu24vQPYVkzIhBF27YRHJ+Y5QkznwGbaiNMpFgD+UTHiPkOHinJNfW
	q6RX0ZscB0WesU+go5HwqU77fbboRlrGZPvbJqSs/45nOejhDvxIB2J4vqjkBx6XuscNbk
	WetGVUbq5DarmyWD5GIElChui6/jjtXkJW/Z/Ty2+k462voMeKluJBQyD8FmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699804814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SboCuILEitsKKZv2da7stJZC84zQez3mCufNSw1yIVw=;
	b=k2lHl+z4HMorqySrjDWeFrsptpEPvdeMGtGUAMyVnb9uyVmw/AeZ3jSzG3vTWmz8J6RpzJ
	VKhliiyGj7xdOXQHCiQQ/dvlgmeAyCPRcx02KughWgeAZAPNndtZyZquA4EBKfEdLNMEz1
	zPxA7Q6fW528hCc/OvSwICutxk0g23o4kj1QVSgoF+HxLaUe0thxFqcfinIu5p9vkxEAnj
	FrH5vPfZuldP7pj8Kl2WFpigtGMcpWiZ/HIRFf1XTvWwiNp56NfcS3fNtJWsoL8NVD/VJt
	M5lX5rqCMxPFgomeQBZHeOprvj8Mvai9WvylQJAO2rPyDGnFa//7p5fufn8ZTw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699804814; a=rsa-sha256;
	cv=none;
	b=CqR4xg5a80dC6ljZMvXWl/vODrR3PN5vSuABlZu9TZO+OZNDdlBhfZR7tHe4Hx1FdimuOB
	hBRLo5CcDO/y016+jUAc3R4oWn4ikHARQFrjcKLdjEtwH2hzT8Xk8BWlqpdW69GVbL6tUF
	rpr0rKWNpinhMNISTlej73xBiAVAta0H6Y9vqKtpRc0YcEL2LXNbfV1PJvEUV4aEuI62bb
	tAWUGZpohWr+aS665d045T9tz1cMpl8Z8FYJ4V1ShFqiQV3rOMup0jlPDvcj8SoB3gjNfk
	pfE7ZI2CW4QSdy9SX/LkCYoySQz64JfqAwtlnO7b/Uq/mfIaXAsQZJPwrC9Asw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] bap: skip Config Codec when it is not needed
Date: Sun, 12 Nov 2023 18:00:05 +0200
Message-ID: <d87d28773b298e80913df611eb446dcc2a7c9733.1699802164.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
References: <b48261aeab5a4f5927c9da5296b2ffb079bee375.1699802164.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the ASE is in Codec Configured state and the configuration matches
what we want, skip Config Codec and proceed directly to Config QoS.

Combine the config setup in set_configuration with the one in
bap_config.
---
 profiles/audio/bap.c | 137 +++++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 51 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 85532b1af..2c869e33c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -99,6 +99,10 @@ struct bap_data {
 
 static struct queue *sessions;
 
+static int ep_bap_config(struct bap_ep *ep);
+static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
+				struct bt_bap_stream *stream, int defer);
+
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
@@ -837,25 +841,11 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	/* TODO: Check if stream capabilities match add support for Latency
-	 * and PHY.
-	 */
-	if (!ep->stream)
-		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
-						ep->rpac, &ep->qos, ep->caps);
-
-	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
-	if (!ep->id) {
+	if (ep_bap_config(ep) < 0) {
 		DBG("Unable to config stream");
-		free(ep->caps);
-		ep->caps = NULL;
 		return btd_error_invalid_args(msg);
 	}
 
-	bt_bap_stream_set_user_data(ep->stream, ep->path);
-	bt_bap_stream_bcast_configured(ep->stream);
-
 	if (ep->metadata && ep->metadata->iov_len)
 		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
 
@@ -1175,34 +1165,100 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	return ep;
 }
 
-static void bap_config(void *data, void *user_data)
+static int ep_bap_qos(struct bap_ep *ep)
 {
-	struct bap_ep *ep = data;
+	struct bap_data *data = ep->data;
+	struct bt_bap_stream *stream = ep->stream;
+
+	if (ep->id)
+		return -EBUSY;
+	if (!stream || !ep->caps)
+		return -EINVAL;
+
+	bap_create_io(data, ep, stream, true);
+	if (!ep->io) {
+		error("Unable to create io");
+		goto fail;
+	}
+
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		/* Wait QoS response to respond */
+		ep->id = bt_bap_stream_qos(stream, &ep->qos, qos_cb, ep);
+		if (!ep->id) {
+			error("Failed to Configure QoS");
+			goto fail;
+		}
+		break;
+	}
+
+	return 0;
+
+fail:
+	bt_bap_stream_release(stream, NULL, NULL);
+	return -EIO;
+}
+
+static void ep_clear_config(struct bap_ep *ep)
+{
+	util_iov_free(ep->caps, 1);
+	ep->caps = NULL;
+	util_iov_free(ep->metadata, 1);
+	ep->metadata = NULL;
+	memset(&ep->qos, 0, sizeof(ep->qos));
+}
+
+static int ep_bap_config(struct bap_ep *ep)
+{
+	struct iovec *caps;
 
 	DBG("ep %p caps %p metadata %p", ep, ep->caps, ep->metadata);
 
 	if (!ep->caps)
-		return;
+		return -EINVAL;
+	if (ep->id)
+		return -EBUSY;
 
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
-	if (!ep->stream)
+	if (!ep->stream) {
 		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
-						ep->rpac, &ep->qos, ep->caps);
+						ep->rpac, NULL, NULL);
+		if (!ep->stream)
+			goto fail;
+	}
+
+	bt_bap_stream_set_user_data(ep->stream, ep->path);
+
+	/* Skip to QoS if reconfiguration not needed */
+	caps = bt_bap_stream_get_config(ep->stream);
+	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_UCAST &&
+	    bt_bap_stream_get_state(ep->stream) == BT_BAP_STREAM_STATE_CONFIG &&
+	    util_iov_memcmp(caps, ep->caps) == 0) {
+		DBG("ep %p stream %p no reconfig needed", ep, ep->stream);
+		bt_bap_stream_config_update(ep->stream, &ep->qos);
+		return ep_bap_qos(ep);
+	}
 
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
 						config_cb, ep);
-	if (!ep->id) {
-		DBG("Unable to config stream");
-		util_iov_free(ep->caps, 1);
-		ep->caps = NULL;
-		util_iov_free(ep->metadata, 1);
-		ep->metadata = NULL;
-	}
+	if (!ep->id)
+		goto fail;
 
-	bt_bap_stream_set_user_data(ep->stream, ep->path);
 	bt_bap_stream_bcast_configured(ep->stream);
+
+	return 0;
+
+fail:
+	DBG("Unable to config stream");
+	ep_clear_config(ep);
+	return -EIO;
+}
+
+static void bap_config(void *data, void *user_data)
+{
+	ep_bap_config(data);
 }
 
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
@@ -1513,9 +1569,6 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
-				struct bt_bap_stream *stream, int defer);
-
 static gboolean bap_io_recreate(void *user_data)
 {
 	struct bap_ep *ep = user_data;
@@ -1909,26 +1962,8 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (ep && !ep->id) {
-			bap_create_io(data, ep, stream, true);
-			if (!ep->io) {
-				error("Unable to create io");
-				bt_bap_stream_release(stream, NULL, NULL);
-				return;
-			}
-
-			if (bt_bap_stream_get_type(stream) ==
-					BT_BAP_STREAM_TYPE_UCAST) {
-				/* Wait QoS response to respond */
-				ep->id = bt_bap_stream_qos(stream, &ep->qos,
-								qos_cb,	ep);
-				if (!ep->id) {
-					error("Failed to Configure QoS");
-					bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
-			}
-		}
+		if (ep)
+			ep_bap_qos(ep);
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
 		if (bt_bap_stream_get_type(stream) ==
-- 
2.41.0

