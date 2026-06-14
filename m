Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A472EB5B8
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436150; cv=pass; b=RdagCpKBYsk56drK01r0T7kOvlRnwQdvv8I3mJHb+DvY8vMD+opw6JGnTQUNfxWLQrXlqcVDtur6Mi+w0I/CSsa6gWV2ZdUKgtAWwRWaPD7o4Ip7w93WwUgw9EBkl+733p8pWuPHOKOWARhi55F5LXOmYsDJt36rQ+okEPxeYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436150; c=relaxed/simple;
	bh=9A9/Ig2rSjRAWSevw+6sF9YuAlTtbTYq1xUB2pCdHwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4MH/xg+x8t6u0/cQsDcSvdfFJw6Fb/sLU5UHCkc4Io1VVDVCj1xEZ8OGCJNHPZel//Wh4xKAEfHddutqZYSi/29M+Oqnanq7LRL7ZlKnA+4r42GA04YBh5ctMDHHCQLnKoJhJOcxCao858Y7BfYj2FT6BxDttX9QjjtBfXhGbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Q6AyFfo2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Q6AyFfo2"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdW7Q3rSvzyTm;
	Sun, 14 Jun 2026 14:22:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781436147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmEc55X5EZBrBX7xl2izLmOiZe0xh2RCQGJVxA4Ag8k=;
	b=Q6AyFfo2LHdCdLaa8nfzM92HDSylFc9FSTm4AmKvfIkzudO8kcoPqAmBYJ47kSj8e9FgeT
	DK2sDcxk3Y2lmfG9k2vdUQtgef3YBPwa0wKIVnO+xWmUqaRTJdn//wjb3UiVRBaLQRFqdc
	j8tq4wo0l+cjPhigwF0p+w0lZ7F41Tw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781436147;
	b=OrMrlf7IPAtk71U9pzeWcjl2czRl9W3bS1GFBryeYyyTLaKE8wek4VO5hyoeSVj8V0SCLj
	+jmQp5OyCwHfKkFGw6R1UNDEXwtd2BTAMc35x4FHrds0AnjUmEfSHjEGuQTtdhG1qSRAft
	V1Egxw2nt2QnfOMbIQfGnFrnh3wlWvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781436147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmEc55X5EZBrBX7xl2izLmOiZe0xh2RCQGJVxA4Ag8k=;
	b=PY5FwF7UHo/QdG3BWU2R5DHZvRXzw9nSiynYpTekAke0wouAdEEybcZT9XUEqUH9kq5Ruq
	hWZjlZBkRxRffGszp+HuU8OX3Vm4zTL1wR9EEEyaQOYz9el3TjJ/uetqi+Bb16koTOm+mc
	SiP2zVdu3n8zZIOihbcbzbuBaC7PWzY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] media: use custom DBus timeouts only when remote side is waiting
Date: Sun, 14 Jun 2026 14:22:23 +0300
Message-ID: <499a2bfcdd6ed488104bad57b285ddc9c7788f7e.1781436012.git.pav@iki.fi>
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
remote, and use separate defines for A2DP and BAP.
---

Notes:
    v2: shorter BAP_REQUEST_TIMEOUT_MSEC, no particular reason to have
        it 20 sec. Use that for cases where there may be remote side,
        i.e. all except us being bcast source.

 profiles/audio/media.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index cdaafb04e..5d9ea2cbc 100644
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
+#define BAP_REQUEST_TIMEOUT_MSEC	(3 * 1000)
 
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
 
@@ -1243,9 +1249,16 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		transport = pac_ucast_config(stream, cfg, endpoint);
+		timeout_msec = BAP_REQUEST_TIMEOUT_MSEC;
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		transport = pac_bcast_config(stream, cfg, endpoint);
+
+		/* If we are sink, BASS remote may be waiting: custom timeout */
+		if (bt_bap_stream_get_dir(stream) == BT_BAP_SOURCE)
+			timeout_msec = BAP_REQUEST_TIMEOUT_MSEC;
+		else
+			timeout_msec = -1;
 		break;
 	default:
 		transport = NULL;
@@ -1279,7 +1292,8 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
 	if (!media_endpoint_async_call(msg, endpoint, transport,
-						pac_config_cb, data, free))
+						pac_config_cb, data, free,
+						timeout_msec))
 		return -EIO;
 
 	return 0;
-- 
2.54.0

