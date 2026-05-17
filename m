Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FA348866
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779011961; cv=pass; b=TbIrfII+lybkAUtKd6tBPHsR02a38lrCXdn95JTPiJ3nLYClpi3s22zPxU7UaPfpVjRUy4aBUMZL8aVfKeDuuF+BHK4hajwdPCPrl2+CuaMAoArS2SLQM9jFRAKgma1v71A9P/9Ez6nEy0+RVrVm4e/hGWyR+GW4oK9T2XmdUu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779011961; c=relaxed/simple;
	bh=SQrxWLCXcQEBKq5NZwYvnChAQhzHr8Em3YWFGWOTjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAX9D7vG8gcVc+dDADrOXsxoL6m1jgLqDmd8GqdTDORiY61pL8htdDIY6k4wrD/G18vvZiRQo9fOWFZRob1QVmlC0TAK//A8s6SL4z+Jbk1NJMJNYcQzxw7tYHE3SL5Z5XcjYHkoyUssQzku5n0ldDV9FrHZ6Iha8MSBD9QaR+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SgY0O8pv; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SgY0O8pv"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gJGcC34Bvz49Q11;
	Sun, 17 May 2026 12:59:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1779011947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kMnYMaDQ7DGAHqfA1kFp11ywn4E6yqZAvpqpf5VWYw=;
	b=SgY0O8pvzvN1ZOx9zSA2/FWD0K55i8HUmfNtLmiHBygr1MhXWq/T8JzaYzV6FL1KC2VUqY
	2gBkc1w8rbx/kjKcawS23VScSEnvX+Zmhp9I1EfPf0Zjw4cUsFvWOO7aOcMkQcrFsRfeoJ
	/1rJ1YMMF+zVK9D0c5yGCCl7RxzMq6SBHs7N0IWSeeEjrbfULuckZRJElc8AinpO/+dNnj
	fK2W4Cbm3eX36zB3abO0YbbEcvwIrJqA0nDfX9q0wamcAeXW5XO92NUqqVkifJn9wunHJe
	Q/AVGasvajIa0yQuwk2pMx1e87SI8jig7tLYUHao8FMC9eGr19g7EZ8h/2SqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1779011947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+kMnYMaDQ7DGAHqfA1kFp11ywn4E6yqZAvpqpf5VWYw=;
	b=f99DNAWJgZ12A77xtCXDEaMimuTW5hN/Gk52IJQMcAFEr5ZD+BljaF6sAcNB9fQjsJd3mf
	OlJfyiDOy5cXjnjsyvt2/myfD8nTKjuToikbLHTvkcuEQ1wLxBUKthyTT1oM/dnAyaCFX6
	bs/hlwtxp8rASsuV3byKMJ6UBLi2y9tjsnl6XeShzNb9OKGoAixY/TV8pG7wL7BqemhdiQ
	5calCpUTYJtUXD3NCZguy0foRoX+L6NrmSepkuSn3oncwgVOW4tax4k9k5llPz4kNvPg4v
	hdtRXNYzMxr8pYVBkRsf0mMr6z0z6BujvGOIA00uKE+VoDGVWKSjZ/TL17yU8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1779011947;
	b=AjosRXi7+FQcWy2V10byvz9cWo8J6880WQaIOQeVI3d3VQ2whf0aSAShmI5mlqK77ydF06
	VAOuswqdELVHTAwYFuXaYlkDeWvPRy32VCPxy0/bdn6k5vdGUQjcMbE8lLZSXNsbUDJReP
	dfREWWQlL9J6STtS2D7JOnak0WN1W4kBtfkrUMqaxjBVLENxbRL05oZLdPrUgQ/wDTMubo
	XOnC2XRUSYsRYUj6c2GqxFC2J5SKj+U/frvRqPKNp3kIBn2u3/4kvIc4JsANzUDvFFKE6D
	FM5mSIjWtlut0pVapd85mCKu0Rfcq+CMpCad8LfPA7Oka9pwBgIioyR/dC9MAw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] media: use custom DBus timeouts only when remote side is waiting
Date: Sun, 17 May 2026 12:59:05 +0300
Message-ID: <60b9da865b9beb482f914818c31866ebb00960f7.1779011736.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under high system load (VM instance on boot) it's observed the 3 sec
timeout BlueZ uses for BAP broadcast SetConfiguration may be missed by
Wireplumber, as these are set up immediately on startup together with
any other setup (eg ALSA) that may need time.

There's no actual need for using a short custom timeout in BlueZ for
this, as in this case there is no remote side that is waiting for a reply.

Fix by limiting custom timeouts to cases where there is a waiting
remote.  A2DP-specific timeout should be used only for A2DP
SetConfiguration.  Similarly, using timeout for BAP only makes sense for
unicast, and should derive from the ATT timeout.
---
 profiles/audio/media.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index cdaafb04e..0297e4c79 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -71,7 +71,11 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
 
-#define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
+/* Timeout should be less than avdtp request timeout (4 seconds) */
+#define A2DP_REQUEST_TIMEOUT_MSEC	(3 * 1000)
+
+/* Timeout should be less than ATT timeout (30 seconds) */
+#define BAP_REQUEST_TIMEOUT_MSEC	(20 * 1000)
 
 struct media_app {
 	struct media_adapter	*adapter;
@@ -465,16 +469,16 @@ static gboolean media_endpoint_async_call(DBusMessage *msg,
 					struct media_transport *transport,
 					media_endpoint_cb_t cb,
 					void *user_data,
-					GDestroyNotify destroy)
+					GDestroyNotify destroy,
+					int timeout_msec)
 {
 	struct endpoint_request *request;
 
 	request = g_new0(struct endpoint_request, 1);
 
-	/* Timeout should be less than avdtp request timeout (4 seconds) */
 	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 						msg, &request->call,
-						REQUEST_TIMEOUT) == FALSE) {
+						timeout_msec) == FALSE) {
 		error("D-Bus send failed");
 		g_free(request);
 		return FALSE;
@@ -521,7 +525,7 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 					DBUS_TYPE_INVALID);
 
 	return media_endpoint_async_call(msg, endpoint, NULL,
-						cb, user_data, destroy);
+						cb, user_data, destroy, -1);
 }
 
 static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
@@ -604,7 +608,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
 	return media_endpoint_async_call(msg, endpoint, transport,
-						cb, user_data, destroy);
+						cb, user_data, destroy,
+						A2DP_REQUEST_TIMEOUT_MSEC);
 }
 #endif
 
@@ -1093,7 +1098,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	dbus_message_iter_close_container(&iter, &dict);
 
 	if (!media_endpoint_async_call(msg, endpoint, NULL, pac_select_cb,
-								data, free))
+								data, free, -1))
 		return -EIO;
 
 	return 0;
@@ -1233,6 +1238,7 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	DBusMessage *msg;
 	DBusMessageIter iter;
 	const char *path;
+	int timeout_msec;
 
 	DBG("endpoint %p stream %p", endpoint, stream);
 
@@ -1243,9 +1249,11 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		transport = pac_ucast_config(stream, cfg, endpoint);
+		timeout_msec = BAP_REQUEST_TIMEOUT_MSEC;
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		transport = pac_bcast_config(stream, cfg, endpoint);
+		timeout_msec = -1;
 		break;
 	default:
 		transport = NULL;
@@ -1279,7 +1287,8 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
 	if (!media_endpoint_async_call(msg, endpoint, transport,
-						pac_config_cb, data, free))
+						pac_config_cb, data, free,
+						timeout_msec))
 		return -EIO;
 
 	return 0;
-- 
2.54.0

