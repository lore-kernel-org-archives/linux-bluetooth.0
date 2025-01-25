Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419925A65C
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737823330; cv=pass; b=Hw0b7mQYqrTeaNI19NxgYcgsqIRdMPuFkb8xs558nB+j3DYHcKlUkuC3qXZuQvD9DDz4r8vVrFl/zM0skw9s82BFkudRFneijGcy4kthB7uu8fk+VCP8g69U3NTdEtWjQjyTy0+Czr/MhqGVriZH9XUPCZWunSIVPU8NFw8WLas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737823330; c=relaxed/simple;
	bh=YSHGftoFB3W2ayh22gJy70Jox0CNg592YS4zrqYX8+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKwoPjpB1N8XKIL9Ji8Ocbi2j6rxpSMNfH048C6j0i4+onuWElKXZVMo8Ov48q3p7EASw2xqxaqFUIw0p0IJQsAufcS54PBiFLht0AiUcUoa5I5QXBspBN+DaDpvfDsoQyYPJbiwEH2yMDVAE00TqKkAZxQQZ6q95XSjfoOOsVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cgV+FRBA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cgV+FRBA"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4YgL7B2CLmzyQT;
	Sat, 25 Jan 2025 18:41:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1737823319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v5OVA8qHEoluRV9dBhQPirps1KhRfKKRpIYVms1fs8Y=;
	b=cgV+FRBAm2TfDVeDTG0RtddGwOT0n6lYYQV7cin+spxgBMECtEMDjXpqXTBJnh5NCk+ndS
	zGHuMZbM1S0XLfbNpsxK2RpLTPcSaDYEubTyeG1ukRZRqpW3tYq+0m6em3EZGJbgs6bvQg
	oLL8DyF+B5k8NMzjpgd84zuHxBz8NXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1737823319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v5OVA8qHEoluRV9dBhQPirps1KhRfKKRpIYVms1fs8Y=;
	b=sClLY0pv+m1uy4E2ih00mGDaG6ReK1lBlGXikM3WY+D21m8+f2+jzLgHAZe+V7BSmYdzjr
	lGtE5DnIUy2ABjkwff4c6nOhKtvAPxxsSPtULrDxfd/0M1OKtToNRwmtNJFYH6UZH92dfX
	vKVJYgj0SRmRZc6QpNJd8xHPtWHWfAs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1737823319; a=rsa-sha256; cv=none;
	b=epP7agEBBjdRdy4epgWJ/j700x3MoTqCLq+UPpAuth8Gi3Hc2fQBOOCDiZO3OrHrHdPILl
	xvbFJ0f43zsRsWj74knwznohpCFcY+PEnjnVlwwn7fv3kOUUa65gu4oJUfo5qrNX9cg2LX
	JEIpCEnxBGyUrrfs2yU0br9HVciW5Ho=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: fix issues with BAP volumes > 127
Date: Sat, 25 Jan 2025 18:41:51 +0200
Message-ID: <45ff22ec472a18bf3d83355f7e4af24a2b39d68b.1737823112.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change types used for volumes to int, for BAP volumes > 127 and to
allow -1 as it is used to mean no volume.

Fix BAP max volume check in transport.

Fixes setting BAP volumes.
---
 profiles/audio/transport.c | 60 +++++++++++++++++++++++---------------
 profiles/audio/transport.h |  8 ++---
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5fd20910f..f3ac1a251 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -126,8 +126,8 @@ struct media_transport_ops {
 	void (*set_state)(struct media_transport *transport,
 				transport_state_t state);
 	void *(*get_stream)(struct media_transport *transport);
-	uint8_t (*get_volume)(struct media_transport *transport);
-	int (*set_volume)(struct media_transport *transport, uint8_t level);
+	int (*get_volume)(struct media_transport *transport);
+	int (*set_volume)(struct media_transport *transport, int level);
 	int (*set_delay)(struct media_transport *transport, uint16_t delay);
 	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
@@ -616,7 +616,7 @@ static void transport_a2dp_remove_owner(struct media_transport *transport,
 	a2dp->cancel_resume = FALSE;
 }
 
-static uint8_t transport_a2dp_get_volume(struct media_transport *transport)
+static int transport_a2dp_get_volume(struct media_transport *transport)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	return a2dp->volume;
@@ -624,10 +624,13 @@ static uint8_t transport_a2dp_get_volume(struct media_transport *transport)
 
 #ifdef HAVE_AVRCP
 static int transport_a2dp_src_set_volume(struct media_transport *transport,
-					uint8_t level)
+					int level)
 {
 	struct a2dp_transport *a2dp = transport->data;
 
+	if (level < 0 || level > 127)
+		return -EINVAL;
+
 	if (a2dp->volume == level)
 		return 0;
 
@@ -635,11 +638,14 @@ static int transport_a2dp_src_set_volume(struct media_transport *transport,
 }
 
 static int transport_a2dp_snk_set_volume(struct media_transport *transport,
-					uint8_t level)
+					int level)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	bool notify;
 
+	if (level < 0 || level > 127)
+		return -EINVAL;
+
 	if (a2dp->volume == level)
 		return 0;
 
@@ -1084,7 +1090,7 @@ static void set_delay_report(const GDBusPropertyTable *property,
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
-	int8_t volume;
+	int volume;
 
 	if (media_transport_get_volume(transport, &volume))
 		return FALSE;
@@ -1092,8 +1098,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 	return volume >= 0;
 }
 
-int media_transport_get_volume(struct media_transport *transport,
-					int8_t *volume)
+int media_transport_get_volume(struct media_transport *transport, int *volume)
 {
 	if (transport->ops && transport->ops->get_volume) {
 		*volume = transport->ops->get_volume(transport);
@@ -1107,7 +1112,7 @@ static gboolean get_volume(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	int8_t level;
+	int level;
 	uint16_t volume;
 
 	if (media_transport_get_volume(transport, &level))
@@ -1121,7 +1126,7 @@ static gboolean get_volume(const GDBusPropertyTable *property,
 }
 
 static int media_transport_set_volume(struct media_transport *transport,
-					int8_t level)
+					int level)
 {
 	DBG("Transport %s level %d", transport->path, level);
 
@@ -1147,15 +1152,13 @@ static void set_volume(const GDBusPropertyTable *property,
 	}
 
 	dbus_message_iter_get_basic(iter, &arg);
-	if (arg > INT8_MAX) {
+	err = media_transport_set_volume(transport, arg);
+	if (err == -EINVAL) {
 		g_dbus_pending_property_error(id,
 				ERROR_INTERFACE ".InvalidArguments",
-				"Volume must not be larger than 127");
+				"Invalid volume value");
 		return;
-	}
-
-	err = media_transport_set_volume(transport, arg);
-	if (err) {
+	} else if (err) {
 		error("Unable to set volume: %s (%d)", strerror(-err), err);
 		g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".Failed",
@@ -2190,14 +2193,17 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
-static uint8_t transport_bap_get_volume(struct media_transport *transport)
+static int transport_bap_get_volume(struct media_transport *transport)
 {
 	return bt_audio_vcp_get_volume(transport->device);
 }
 
 static int transport_bap_set_volume(struct media_transport *transport,
-								uint8_t volume)
+								int volume)
 {
+	if (volume < 0 || volume > 255)
+		return -EINVAL;
+
 	return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -EIO;
 }
 
@@ -2355,7 +2361,7 @@ static void transport_asha_cancel(struct media_transport *transport, guint id)
 	}
 }
 
-static uint8_t transport_asha_get_volume(struct media_transport *transport)
+static int transport_asha_get_volume(struct media_transport *transport)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	int8_t volume;
@@ -2370,11 +2376,14 @@ static uint8_t transport_asha_get_volume(struct media_transport *transport)
 }
 
 static int transport_asha_set_volume(struct media_transport *transport,
-							uint8_t volume)
+							int volume)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	int scaled_volume;
 
+	if (volume < 0 || volume > 127)
+		return -EINVAL;
+
 	/* Convert 0-127 to -128-0 */
 	scaled_volume = ((((int) volume) * 128) / 127) - 128;
 
@@ -2585,7 +2594,7 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 }
 
 void media_transport_update_volume(struct media_transport *transport,
-								int8_t volume)
+								int volume)
 {
 	if (volume < 0)
 		return;
@@ -2593,6 +2602,9 @@ void media_transport_update_volume(struct media_transport *transport,
 	if (media_endpoint_get_sep(transport->endpoint)) {
 		struct a2dp_transport *a2dp = transport->data;
 
+		if (volume > 127)
+			return;
+
 		/* Check if volume really changed */
 		if (a2dp->volume == volume)
 			return;
@@ -2604,7 +2616,7 @@ void media_transport_update_volume(struct media_transport *transport,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
-int8_t media_transport_get_device_volume(struct btd_device *dev)
+int media_transport_get_device_volume(struct btd_device *dev)
 {
 	GSList *l;
 
@@ -2619,7 +2631,7 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 
 		/* Volume is A2DP only */
 		if (media_endpoint_get_sep(transport->endpoint)) {
-			int8_t volume;
+			int volume;
 
 			if (!media_transport_get_volume(transport, &volume))
 				return volume;
@@ -2633,7 +2645,7 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 }
 
 void media_transport_update_device_volume(struct btd_device *dev,
-								int8_t volume)
+								int volume)
 {
 	GSList *l;
 
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index b46bc8025..808e1a193 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -22,14 +22,14 @@ const char *media_transport_get_path(struct media_transport *transport);
 void *media_transport_get_stream(struct media_transport *transport);
 struct btd_device *media_transport_get_dev(struct media_transport *transport);
 int media_transport_get_volume(struct media_transport *transport,
-					int8_t *volume);
+					int *volume);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
 void media_transport_update_volume(struct media_transport *transport,
-								int8_t volume);
+								int volume);
 void transport_get_properties(struct media_transport *transport,
 							DBusMessageIter *iter);
 
-int8_t media_transport_get_device_volume(struct btd_device *dev);
+int media_transport_get_device_volume(struct btd_device *dev);
 void media_transport_update_device_volume(struct btd_device *dev,
-								int8_t volume);
+								int volume);
-- 
2.48.1

