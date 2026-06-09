Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD693FFFB3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028693; cv=none; b=gPj7MhVe1M2CJByC5m6fy9U3lzmNAK22352L1Rm5zeyfH0anDEfvqSkMA8ayxA6KTQ19Z2y7bhYC+RiZ9jpSDpShkVhYsssHCzKC2eYiCqYIf/Spm1mA9YFBegXb7u0vZTlLSseBXXrN9K2wacbPe731dewKwocfnvlUdgUbXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028693; c=relaxed/simple;
	bh=LDgDZb22lMlodCEY8FeE3zrcqkmHZJJ8fRYt1eTg2UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3KLBqYVpChadkZBmv9FN6PhbMyg9FlfRVcce7lRO4lk5hMVl+n9ymIImGhBleXf0U3h07YBOam6dfEZmQ8VQ/2SH2b9gVGG/0+/KW//guUnk5Wvu65jewy3hir+hr6ikDKYf9QjTJYZDu4Ts3Zv2rIGSkn6dDdBKEJ9JPhNJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=0CauHGfE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="0CauHGfE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cdae130cso17113395e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781028689; x=1781633489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xb1uLCPZBNCl8fM1qNoo91S1Ox8D6WfpFD0US12JPCw=;
        b=0CauHGfEQ0rK33FJHwjm9chyvkqEMrc9rpJdcgxj5of8ZRnejtyh8AKDBJsjdWJV5e
         m6bAvJa4OilqG8fGj43FjFIYw/QwAFLlK2GiyvQSbNI8/HeIdGGkOMuqI0ikp40As6Tc
         uvJ/ReKq6py0Kmc7+k8iOpnAsVPEwnj5fjhtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028689; x=1781633489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb1uLCPZBNCl8fM1qNoo91S1Ox8D6WfpFD0US12JPCw=;
        b=V1Sl1UPldTv0dnOCrF7pCLmUgT5uYpjIFHf7nQoeZc+tYU9dZ+dSss1NyHmJj4wzxY
         BuVkEcIXwm1EkiHuNIB/RlbxsTd/5fgL1CwCdr3P5D/CupwP+cxPvLgwtF0uVcA2Y64r
         QkKE3TJrNKSuDs3JkFNTLXzt/gH81jls+xTB7QjGFsqmVnjQGmTI6CnvUtSB0Aw96lsj
         ywJsPYmgsm0Pkilm5VaQfBNn9XYhH+U90JdXpTm4wAzWNu6jTehb0fxNQfBf0coOZw8x
         5yap9p2tNJ965c+u8LcLFJkczYLEdSW+tXwScPXb/YYlDBKnckkpoiQk3EBCynWXOstw
         s3hg==
X-Gm-Message-State: AOJu0Yy3J0lKwiXZ911McnI8NnhuKU6duvEn3uv0BcI9sfQvjd3B9+K8
	K8boSHNWv0lVoHt2JjKL3sG0YHlsFXIX+M5AwID+VxquP+dWL+e3z3kV6N3PI4QaEh5bY0yo2ae
	GITeR
X-Gm-Gg: Acq92OHsOUaddErNOSCH/1mQAY9k94glelrUUXge/N8ZpH3jLTA2wJaaOTzerHpE/k2
	Cs1WkEemB1dJp7VhOgLUBjAi5G9WhvXX5uq+el7mHbLrCtPLlKuU0Gs2PBMI2nWSIgzw/Ws+F0i
	o92GuOyht6ixB9A0U7T00AYWBWNZIUwmLBHUr40WPHn2yK5Yfd9gav7LEBdipYAW1a6VCwoGOXk
	7iyNwXxV3Byf6YxdalCIOD1DKR+Rkv5KP1dqe9iMsHUJOHDNK3r9eNoJ201zObEf6pfSW+NKSi0
	7GbyETxGjIqn18ZrKfnUskPDSY4uuzNfIHd1lMY9OWL3Hwa2SBQhUktzzzp/4rNrIjBwNHB3/MC
	vj31BzPzAYRJH2Kto3a7qMB3dZA5r1bxp3AK4dQoqLBUEtn8H/YroZROWncjRQIfg2IWBb4xF3M
	TkttssZTVKjv+PtILw6jmQQTIaSaxBB7Ur37FUDgT5CtbqvJlUHtm2JF+tdHpe5c5Bpg==
X-Received: by 2002:a05:600c:46ca:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-490c25a7f8amr358053795e9.8.1781028689027;
        Tue, 09 Jun 2026 11:11:29 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:824f:5c20:dbd5:c2c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm532750505e9.12.2026.06.09.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:11:28 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] media: Add Mute property to MediaTransport1
Date: Tue,  9 Jun 2026 20:11:07 +0200
Message-ID: <20260609181108.3787224-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boolean, optional, readwrite. Only present for LE Audio (BAP) unicast
transports backed by VCS. A2DP has no mute concept in AVRCP.

bt_vcp_set_mute() writes VCS Control Point Mute/Unmute for a client
session, or updates Volume State for a server session.
bt_vcp_get_mute() returns the cached value updated by Volume State
notifications.
---
 doc/org.bluez.MediaTransport.rst |  6 +++
 profiles/audio/transport.c       | 75 ++++++++++++++++++++++++++++
 profiles/audio/vcp.c             | 20 ++++++++
 profiles/audio/vcp.h             | 12 +++++
 src/shared/vcp.c                 | 86 ++++++++++++++++++++++++++++++++
 src/shared/vcp.h                 |  3 ++
 6 files changed, 202 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index e50ec3f20..33d468325 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -160,6 +160,12 @@ Examples:
 
 :bluetoothctl: > transport.volume <transport> [value]
 
+boolean Mute [readwrite, optional]
+``````````````````````````````````
+
+Indicates mute state of the transport, only present for LE Audio (BAP)
+transports backed by VCS.
+
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4b9d26c5e..6b7dd9360 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1191,6 +1191,64 @@ static void set_volume(const GDBusPropertyTable *property,
 	g_dbus_pending_property_success(id);
 }
 
+static int transport_bap_get_mute(struct media_transport *transport);
+static int transport_bap_set_mute(struct media_transport *transport,
+								bool mute);
+
+static gboolean mute_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+
+	return transport_bap_get_mute(transport) >= 0;
+}
+
+static gboolean get_mute(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	dbus_bool_t mute;
+	int ret;
+
+	ret = transport_bap_get_mute(transport);
+	if (ret < 0)
+		return FALSE;
+
+	mute = ret;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &mute);
+
+	return TRUE;
+}
+
+static void set_mute(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_transport *transport = data;
+	dbus_bool_t mute;
+	int err;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected BOOLEAN");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &mute);
+
+	err = transport_bap_set_mute(transport, mute);
+	if (err) {
+		error("Unable to set mute: %s (%d)", strerror(-err), err);
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+						"Internal error %s (%d)",
+						strerror(-err), err);
+		return;
+	}
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1544,6 +1602,7 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "Metadata", "ay", get_metadata, set_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "Mute", "b", get_mute, set_mute, mute_exists },
 	{ }
 };
 
@@ -2428,6 +2487,22 @@ static int transport_bap_set_volume(struct media_transport *transport,
 		return -ENOTSUP; /* TODO: MICP */
 }
 
+static int transport_bap_get_mute(struct media_transport *transport)
+{
+	if (transport_bap_is_playback(transport))
+		return bt_audio_vcp_get_mute(transport->device);
+	else
+		return -ENOTSUP; /* TODO: MICP */
+}
+
+static int transport_bap_set_mute(struct media_transport *transport, bool mute)
+{
+	if (transport_bap_is_playback(transport))
+		return bt_audio_vcp_set_mute(transport->device, mute);
+	else
+		return -ENOTSUP; /* TODO: MICP */
+}
+
 static void transport_bap_destroy(void *data)
 {
 	struct bap_transport *bap = data;
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 00ee2b64b..7adac4dd5 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -185,6 +185,26 @@ int bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume)
 	return -ENODEV;
 }
 
+int bt_audio_vcp_get_mute(struct btd_device *device)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return bt_vcp_get_mute(data->vcp);
+
+	return -ENODEV;
+}
+
+int bt_audio_vcp_set_mute(struct btd_device *device, bool mute)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return bt_vcp_set_mute(data->vcp, mute) ? 0 : -EIO;
+
+	return -ENODEV;
+}
+
 static void vcp_remote_client_detached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
index b538cebf0..35ffc09f8 100644
--- a/profiles/audio/vcp.h
+++ b/profiles/audio/vcp.h
@@ -12,6 +12,8 @@
 
 int bt_audio_vcp_get_volume(struct btd_device *device);
 int bt_audio_vcp_set_volume(struct btd_device *device, uint8_t volume);
+int bt_audio_vcp_get_mute(struct btd_device *device);
+int bt_audio_vcp_set_mute(struct btd_device *device, bool mute);
 
 #else
 
@@ -26,4 +28,14 @@ static inline int bt_audio_vcp_set_volume(struct btd_device *device,
 	return -ENODEV;
 }
 
+static inline int bt_audio_vcp_get_mute(struct btd_device *device)
+{
+	return -ENODEV;
+}
+
+static inline int bt_audio_vcp_set_mute(struct btd_device *device, bool mute)
+{
+	return -ENODEV;
+}
+
 #endif
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c7f74956e..49eff8d02 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -216,6 +216,7 @@ struct bt_vcp {
 
 	uint8_t volume;
 	uint8_t volume_counter;
+	uint8_t mute;
 
 	struct bt_vcp_client_op pending_op;
 
@@ -861,6 +862,9 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	vstate->mute = 0x01;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
+				 sizeof(struct vol_state),
+				 bt_vcp_get_att(vcp));
 	return 0;
 }
 
@@ -2076,6 +2080,7 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 
 	vcp->volume = vstate->vol_set;
 	vcp->volume_counter = vstate->counter;
+	vcp->mute = vstate->mute;
 
 	if (vcp->volume_changed)
 		vcp->volume_changed(vcp, vcp->volume);
@@ -2207,6 +2212,86 @@ uint8_t bt_vcp_get_volume(struct bt_vcp *vcp)
 	return vcp->volume;
 }
 
+static void vcp_mute_cp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+
+	if (!success)
+		DBG(vcp, "setting mute failed: error 0x%x", err);
+}
+
+static bool vcp_set_mute_client(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcs_param req;
+	uint16_t value_handle;
+	struct bt_vcs *vcs = vcp_get_vcs(vcp);
+
+	if (!vcs || !vcs->vol_cp) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
+							NULL, NULL, NULL)) {
+		DBG(vcp, "error: vol_cp characteristic not available");
+		return false;
+	}
+
+	if (vcp->mute == mute)
+		return true;
+
+	req.op = mute ? BT_VCS_MUTE : BT_VCS_UNMUTE;
+	req.change_counter = vcp->volume_counter;
+
+	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *)&req,
+					sizeof(req), vcp_mute_cp_sent, vcp,
+					NULL)) {
+		DBG(vcp, "error writing mute");
+		return false;
+	}
+
+	return true;
+}
+
+static bool vcp_set_mute_server(struct bt_vcp *vcp, uint8_t mute)
+{
+	struct bt_vcp_db *vdb = vcp_get_vdb(vcp);
+	struct vol_state *vstate;
+
+	vcp->mute = mute;
+
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		return false;
+	}
+
+	vstate = vdb_get_vstate(vdb);
+	if (!vstate) {
+		DBG(vcp, "error: VSTATE not available");
+		return false;
+	}
+
+	vstate->mute = mute;
+	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+
+	gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
+			sizeof(struct vol_state), bt_vcp_get_att(vcp));
+	return true;
+}
+
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute)
+{
+	if (vcp->client)
+		return vcp_set_mute_client(vcp, mute);
+	else
+		return vcp_set_mute_server(vcp, mute);
+}
+
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp)
+{
+	return vcp->mute;
+}
+
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -2320,6 +2405,7 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 
 	vcp->volume = vs->vol_set;
 	vcp->volume_counter = vs->counter;
+	vcp->mute = vs->mute;
 }
 
 static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index e031beafd..807d2bdbe 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -42,6 +42,9 @@ void bt_vcp_detach(struct bt_vcp *vcp);
 uint8_t bt_vcp_get_volume(struct bt_vcp *vcp);
 bool bt_vcp_set_volume(struct bt_vcp *vcp, uint8_t volume);
 
+uint8_t bt_vcp_get_mute(struct bt_vcp *vcp);
+bool bt_vcp_set_mute(struct bt_vcp *vcp, uint8_t mute);
+
 bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
 			void *user_data, bt_vcp_destroy_func_t destroy);
 
-- 
2.43.0

