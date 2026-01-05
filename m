Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293292DCBFD
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647290; cv=pass; b=hgPebcSA0RzcF5n3W6HTfeEZpmFCDPGI10dPSYDrX5YUt2SkTNGdrfg1Rp2GIArcdK8N67rRb3PSVXpeBQ+2biWQGILPLO8rc4Vg5laLnW45vsXvSxh4+Y2KGYV0s9hXiqOjusYJB1wuh4J2lCMOrs3jnqzbFE2LrtJqgBfyExI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647290; c=relaxed/simple;
	bh=KQdwxX9O9QqooyBp9U2RouwDtom351S2VT28yT1r3WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETkxS7/wBuIfVXaPuDfAukBivRSRZQMxDkhfPKS30fMoNVFddutbvHy+noR7jAUiiAHBFEtedljyoX6kvElUymaJG41mOcTHF3OT5pJef4PvX+J7ZPWgsKleVaKm9WXMm7WFkUafOmUE+3Bk7Y86pZ6obAedK+fG1KWiTUNJ8iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mO+LVpd3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mO+LVpd3"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dlRht72vmzyZ5;
	Mon, 05 Jan 2026 23:07:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767647279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Vk0FxJ+nw1pK7e36wz2zO5sFexbMXzDHVmD1ZQ0ko=;
	b=mO+LVpd3crbbvrXhnXnwM5hw/905QBk1WFu2JNChfSHX9YvUr5hMlDtUDfeMV2xL0YIv+f
	rVt17ybMD+Dmh1TdYNS83NvvC3jNvgvbzqfXxl5y3bMaX/o4+DKfz+05NO+0JbtZdcvyUB
	yfnynZ8ZT29IPmZm3E7g4sl/nbnm0hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767647279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+Vk0FxJ+nw1pK7e36wz2zO5sFexbMXzDHVmD1ZQ0ko=;
	b=j3seKzKnzoIYBcwkwP4dFMbQama4sJ0Djh7DVBN8ongHd0llSJif8ufGlzEhrB5agagihT
	AsAd+NPS8pJao11IKH2XPLJL+U1/9lSvWkdv3V6dadXH8p5s4OB/W1Imgtzivx4Vd/VhXP
	AmIhtZBI6SclAkbGtSepTvTxKlrcwkk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767647279;
	b=kMw71FwAiy/hzmmcETRzzCiMmwcM3lj+W/EaaAPQoZ9XzTx0KRVKTvRAiOy/M6xSrq/jhe
	FjGnSbM77SXaVh6jOaSdRkS8mOHZQawKqvIftPGthF9IpR8neUJ5Z+t6/azap7anNH+Xq4
	2qU0CpYEPcuARdvCne96QLueeRJrh/E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] transport: clean up volume set/get for A2DP and VCP
Date: Mon,  5 Jan 2026 23:07:54 +0200
Message-ID: <77d193dcca6bfec367876a4f9dda3caabb34e11a.1767647222.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767647222.git.pav@iki.fi>
References: <cover.1767647222.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup uuid comparisons in device transport volume set/get. These are
unnecessary because the transport->ops already do the equivalent check.

Use separate functions for set/get AVRCP volume, to avoid mixing up
AVRCP and VCP volumes.

For VCP send volume update notifications on all transports, since same
volume is listed on all.

To avoid interspersing #ifdefs for A2DP/VCP in this code, define dummy
functions in headers that behave accordingly.

Fix the bt_audio_vcp_get/set_volume to properly indicate when VCP is not
present.
---
 profiles/audio/avrcp.c     |  10 ++--
 profiles/audio/media.c     |   2 +-
 profiles/audio/media.h     |  10 ++++
 profiles/audio/transport.c | 116 +++++++++++++++++++------------------
 profiles/audio/transport.h |  10 ++--
 profiles/audio/vcp.c       |  12 ++--
 profiles/audio/vcp.h       |  21 ++++++-
 7 files changed, 105 insertions(+), 76 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 14889e4b4..724b46c59 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1672,7 +1672,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		volume = media_transport_get_device_volume(dev);
+		volume = media_transport_get_a2dp_volume(dev);
 		if (volume < 0)
 			goto err;
 
@@ -1795,7 +1795,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 
 	volume = pdu->params[0] = pdu->params[0] & 0x7F;
 
-	media_transport_update_device_volume(session->dev, volume);
+	media_transport_set_a2dp_volume(session->dev, volume);
 
 	return AVC_CTYPE_ACCEPTED;
 
@@ -3809,7 +3809,7 @@ static void avrcp_volume_changed(struct avrcp *session,
 	volume = pdu->params[1] & 0x7F;
 
 	/* Always attempt to update the transport volume */
-	media_transport_update_device_volume(session->dev, volume);
+	media_transport_set_a2dp_volume(session->dev, volume);
 }
 
 static void avrcp_status_changed(struct avrcp *session,
@@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
 		player->sessions = g_slist_prepend(player->sessions, session);
 
 		init_volume = btd_device_get_volume(session->dev);
-		media_transport_update_device_volume(session->dev, init_volume);
+		media_transport_set_a2dp_volume(session->dev, init_volume);
 	}
 
 	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
@@ -4646,7 +4646,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	volume = pdu->params[0] & 0x7F;
 
 	/* Always attempt to update the transport volume */
-	media_transport_update_device_volume(session->dev, volume);
+	media_transport_set_a2dp_volume(session->dev, volume);
 
 	return FALSE;
 }
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ad9eb7beb..cc0029750 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -583,7 +583,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 		return FALSE;
 
 	init_volume = btd_device_get_volume(device);
-	media_transport_update_volume(transport, init_volume);
+	media_transport_set_a2dp_volume(device, init_volume);
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 28174a017..1c43075ba 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -18,7 +18,17 @@ typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 int media_register(struct btd_adapter *btd_adapter);
 void media_unregister(struct btd_adapter *btd_adapter);
 
+#ifdef HAVE_A2DP
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
+#else
+struct a2dp_sep;
+static inline struct a2dp_sep *media_endpoint_get_sep(
+						struct media_endpoint *endpoint)
+{
+	return NULL;
+}
+#endif
+
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 bool media_endpoint_get_delay_reporting(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index fc23cf33d..7fc8d8525 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1094,6 +1094,22 @@ static void set_delay_report(const GDBusPropertyTable *property,
 }
 #endif /* HAVE_A2DP */
 
+static int media_transport_get_volume(struct media_transport *transport,
+								int *volume)
+{
+	if (transport->ops && transport->ops->get_volume) {
+		int ret = transport->ops->get_volume(transport);
+
+		if (ret < 0)
+			return ret;
+
+		*volume = ret;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1105,16 +1121,6 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 	return volume >= 0;
 }
 
-int media_transport_get_volume(struct media_transport *transport, int *volume)
-{
-	if (transport->ops && transport->ops->get_volume) {
-		*volume = transport->ops->get_volume(transport);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static gboolean get_volume(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2307,24 +2313,16 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 
 static int transport_bap_get_volume(struct media_transport *transport)
 {
-#ifdef HAVE_VCP
 	return bt_audio_vcp_get_volume(transport->device);
-#else
-	return -ENODEV;
-#endif /* HAVE_VCP */
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
 								int volume)
 {
-#ifdef HAVE_VCP
 	if (volume < 0 || volume > 255)
 		return -EINVAL;
 
-	return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -EIO;
-#else
-	return -ENODEV;
-#endif /* HAVE_VCP */
+	return bt_audio_vcp_set_volume(transport->device, volume);
 }
 
 static void transport_bap_destroy(void *data)
@@ -2739,46 +2737,33 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
-void media_transport_update_volume(struct media_transport *transport,
-								int volume)
+static void media_transport_emit_volume(struct media_transport *transport)
 {
-	if (volume < 0)
+	int volume;
+
+	if (media_transport_get_volume(transport, &volume))
 		return;
 
-#ifdef HAVE_A2DP
-	if (media_endpoint_get_sep(transport->endpoint)) {
-		struct a2dp_transport *a2dp = transport->data;
-
-		if (volume > 127)
-			return;
-
-		/* Check if volume really changed */
-		if (a2dp->volume == volume)
-			return;
-
-		a2dp->volume = volume;
-	}
-#endif
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					transport->path,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
-int media_transport_get_device_volume(struct btd_device *dev)
+int media_transport_get_a2dp_volume(struct btd_device *dev)
 {
 	GSList *l;
 
 	if (dev == NULL)
 		return -1;
 
-#ifdef HAVE_A2DP
 	/* Attempt to locate the transport to get its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+
 		if (transport->device != dev)
 			continue;
 
-		/* Volume is A2DP only */
+		/* A2DP only */
 		if (media_endpoint_get_sep(transport->endpoint)) {
 			int volume;
 
@@ -2788,40 +2773,57 @@ int media_transport_get_device_volume(struct btd_device *dev)
 			return -1;
 		}
 	}
-#endif
 
-	/* If transport volume doesn't exists use device_volume */
+	/* If no transport, use device volume. This is a workaround for the lack
+	 * of ordering between AVRCP and A2DP session start. (Note BAP+VCP do
+	 * not have this issue.)
+	 */
 	return btd_device_get_volume(dev);
 }
 
-void media_transport_update_device_volume(struct btd_device *dev,
-								int volume)
+void media_transport_set_a2dp_volume(struct btd_device *dev, int volume)
 {
 	GSList *l;
 
-	if (dev == NULL || volume < 0)
+	if (dev == NULL || volume < 0 || volume > 127)
 		return;
 
-#ifdef HAVE_A2DP
 	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
-		const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+		struct a2dp_transport *a2dp;
+
+		if (transport->device != dev)
+			continue;
+		if (!media_endpoint_get_sep(transport->endpoint))
+			continue;
+
+		a2dp = transport->data;
+		if (a2dp->volume != volume) {
+			a2dp->volume = volume;
+			media_transport_emit_volume(transport);
+		}
+		break;
+	}
+
+	btd_device_set_volume(dev, volume);
+}
+
+void media_transport_volume_changed(struct btd_device *dev)
+{
+	GSList *l;
+
+	if (dev == NULL)
+		return;
+
+	for (l = transports; l; l = l->next) {
+		struct media_transport *transport = l->data;
+
 		if (transport->device != dev)
 			continue;
 
-		/* Volume is A2DP and BAP only */
-		if (media_endpoint_get_sep(transport->endpoint) ||
-				strcasecmp(uuid, PAC_SINK_UUID) ||
-				strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				strcasecmp(uuid, BAA_SERVICE_UUID)) {
-			media_transport_update_volume(transport, volume);
-			break;
-		}
+		media_transport_emit_volume(transport);
 	}
-#endif
-
-	btd_device_set_volume(dev, volume);
 }
 
 const char *media_transport_stream_path(void *stream)
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 7c107281a..90e079c4c 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -21,8 +21,6 @@ void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 void *media_transport_get_stream(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
-int media_transport_get_volume(struct media_transport *transport,
-					int *volume);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
@@ -30,7 +28,9 @@ void media_transport_update_volume(struct media_transport *transport,
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
-int media_transport_get_device_volume(struct btd_device *dev);
-void media_transport_update_device_volume(struct btd_device *dev,
-								int volume);
+int media_transport_get_a2dp_volume(struct btd_device *dev);
+void media_transport_set_a2dp_volume(struct btd_device *dev, int volume);
+
+void media_transport_volume_changed(struct btd_device *dev);
+
 const char *media_transport_stream_path(void *stream);
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 277c9bbc3..00ee2b64b 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -107,7 +107,7 @@ static void vcp_volume_changed(struct bt_vcp *vcp, uint8_t volume)
 	struct vcp_data *data = queue_find(sessions, match_data, vcp);
 
 	if (data)
-		media_transport_update_device_volume(data->device, volume);
+		media_transport_volume_changed(data->device);
 }
 
 static void vcp_data_add(struct vcp_data *data)
@@ -165,24 +165,24 @@ static void vcp_data_remove(struct vcp_data *data)
 	}
 }
 
-uint8_t bt_audio_vcp_get_volume(struct btd_device *device)
+int bt_audio_vcp_get_volume(struct btd_device *device)
 {
 	struct vcp_data *data = queue_find(sessions, match_device, device);
 
 	if (data)
 		return bt_vcp_get_volume(data->vcp);
 
-	return 0;
+	return -ENODEV;
 }
 
-bool bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume)
+int bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume)
 {
 	struct vcp_data *data = queue_find(sessions, match_device, device);
 
 	if (data)
-		return bt_vcp_set_volume(data->vcp, volume);
+		return bt_vcp_set_volume(data->vcp, volume) ? 0 : -EIO;
 
-	return FALSE;
+	return -ENODEV;
 }
 
 static void vcp_remote_client_detached(struct bt_vcp *vcp, void *user_data)
diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
index cf7935d1a..b538cebf0 100644
--- a/profiles/audio/vcp.h
+++ b/profiles/audio/vcp.h
@@ -8,5 +8,22 @@
  *
  */
 
-uint8_t bt_audio_vcp_get_volume(struct btd_device *device);
-bool bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume);
+#ifdef HAVE_VCP
+
+int bt_audio_vcp_get_volume(struct btd_device *device);
+int bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume);
+
+#else
+
+static inline int bt_audio_vcp_get_volume(struct btd_device *device)
+{
+	return -ENODEV;
+}
+
+static inline int bt_audio_vcp_set_volume(struct btd_device *device,
+								uint8_t volume)
+{
+	return -ENODEV;
+}
+
+#endif
-- 
2.52.0

