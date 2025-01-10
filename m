Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92A211A03
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520642; cv=none; b=BboS84ABmW5JOtRc2lkJ1PAIGWP+tsdM5e7Ujq3jjhgviHZ/kbcQsJEV+LSX38k3RGppWCkDwv9GANwIzowvW1HivqUp1w4fvK3aZ7T0Y0f76sWX1OPcjRKCmLgeU0lNndhrLETtP4eMkLQAWhnp5XArV5VIiapfeldHQizJm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520642; c=relaxed/simple;
	bh=XxqKGxrQdzcgpKN8poJpuJFM0AJGAoj2+euwhma/sMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3XvHWBsU1yNQIw08HtUNKxPHHaxDLht0C0kjLGrq7HNHmEMwvsIXuXSRN4KDROyrcpovcO81HOzFxTzhJcpOZoNzRTKxMrkcPjAN9x73023n5+TliKqSXxZ/Lct8DbVSRuIFhaBPlDJ/pTN51rCeU8qlXtBg2Xw1NuaUsuS37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=EskcweZa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="EskcweZa"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so3682946a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1736520638; x=1737125438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZH+hlBTjq+aHDe/u2IIl34Z5Xs8NmgDqU9yPqOH9ec=;
        b=EskcweZaRntodkLnrHdaVy6lQ5cttOe5nUFuCjFC1IZHXzjbC7JsQA4fLiu571/LOD
         poSxEYiOg6Ys1ehb4axBTMHC5p/UhY+kB6oEWLXaXjtqJSlcY1SuWDZu05lPWpcj5oWJ
         oYTxby4sl3f4xnC6EzcwmbllL9sqxRQP2Goys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520638; x=1737125438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZH+hlBTjq+aHDe/u2IIl34Z5Xs8NmgDqU9yPqOH9ec=;
        b=hHWXsZyHe+8GGTbo/M8tM2/NnDwrjoIhEgbUO5PArbXG2DEbvguRM+fS0/eKtm7Rio
         tH6LJKgqOwV73/yHYH7n+QDRP3e9wVKpx+A+CSSJA158a4RwWhTHDLGwd7pEMt8bW44x
         gFdm9nsxdJYWIECW55JI/BHvEjSzLelO+qsac/9oztPXPfjsHRiYnnB9ftKpkzHDSLcB
         5b8X1ghoJRpco2QWWjXrC3aN7+k9j1IiOyAIYBJ+gn9ZK9sKnqOWQ7gJrDm0DKDU6aA3
         uY9euPvXL33DJ2mL4AYPZTqA80m8QhDqjSaFdCJYKJ6BTS/+ecY937LJAuALT/7R17tY
         V0nA==
X-Gm-Message-State: AOJu0YzoYuZBb1rEG1CtZqxo6ytj4wi6XyvhZmEpBxv5RVDIogSuLyci
	a+6PJe9HK3FRl1m2Vw8q9GifEPP8Mamh0Osi2C8Q0fYP92mSake293N9gbL9ksf6Hd4VcDjopo8
	=
X-Gm-Gg: ASbGnctooNPIpq5CqmhHo3XCrOT+p0icow+AU5taEFEueTjrP5QLPYMgu12vCOsLxqy
	PtgL0jxwhdIrpv9LZljoQVEbS0OwiR4mZrvO7Ji/swkF/fXK75u5FMMOniQgu64ne8ZMZJTC9Mk
	9aPDXQQxcGGgwBqPR87/yRJKaEJgsXW9NkkLh/3ZOu87JXmwNbrh0YkfbXLElMpN8lbipQwRyXm
	pNx54sYRqLeLp6Fl2UHjzuWdVdQ9otnP8z0W4QftokeoL4N4d+A194ZX7xApPkb1FnSBOudqY0g
	B1B+E2JQNeujcB05s5CYSm0a/lAExdQ=
X-Google-Smtp-Source: AGHT+IHbXoVyptT1S+ZJTA+V6ZCfZDIg3yojpca7sLa4jfxevqsFbwON8XIQX8Sv6pMpuN0UD61E0g==
X-Received: by 2002:a05:6402:50d0:b0:5d3:d917:dd90 with SMTP id 4fb4d7f45d1cf-5d972dfb3d9mr10753720a12.6.1736520637920;
        Fri, 10 Jan 2025 06:50:37 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm1679331a12.21.2025.01.10.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:50:37 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 1/3] vcp: connect VCP profile client to MediaTransport
Date: Fri, 10 Jan 2025 15:50:17 +0100
Message-Id: <20250110145019.2380299-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is now possible to control absolute volume of remote volume renderer
device via dbus and also get notifications if the volume changes.
---
 profiles/audio/transport.c | 37 ++++++++++++-----
 profiles/audio/vcp.c       | 46 +++++++++++++++++++--
 profiles/audio/vcp.h       | 12 ++++++
 src/shared/vcp.c           | 82 ++++++++++++++++++++++++++++++++++++++
 src/shared/vcp.h           |  7 ++++
 5 files changed, 172 insertions(+), 12 deletions(-)
 create mode 100644 profiles/audio/vcp.h

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dbebb1ea5..c0f922ff7 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -47,6 +47,7 @@
 #include "source.h"
 #include "avrcp.h"
 #include "bass.h"
+#include "vcp.h"
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
@@ -1404,6 +1405,7 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
 };
 
@@ -2166,6 +2168,17 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	bap_update_links(transport);
 }
 
+static int8_t transport_bap_get_volume(struct media_transport *transport)
+{
+	return bt_audio_vcp_get_volume(transport->device);
+}
+
+static int transport_bap_set_volume(struct media_transport *transport,
+								int8_t volume)
+{
+	return bt_audio_vcp_set_volume(transport->device, volume) ? 0 : -EIO;
+}
+
 static void transport_bap_destroy(void *data)
 {
 	struct bap_transport *bap = data;
@@ -2387,7 +2400,8 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
-			transport_bap_get_stream, NULL, NULL, NULL, \
+			transport_bap_get_stream, transport_bap_get_volume, \
+			transport_bap_set_volume, NULL, \
 			_update_links, transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
@@ -2537,17 +2551,18 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
 void media_transport_update_volume(struct media_transport *transport,
 								int8_t volume)
 {
-	struct a2dp_transport *a2dp = transport->data;
-
 	if (volume < 0)
 		return;
 
-	/* Check if volume really changed */
-	if (a2dp->volume == volume)
-		return;
+	if (media_endpoint_get_sep(transport->endpoint)) {
+		struct a2dp_transport *a2dp = transport->data;
 
-	a2dp->volume = volume;
+		/* Check if volume really changed */
+		if (a2dp->volume == volume)
+			return;
 
+		a2dp->volume = volume;
+	}
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					transport->path,
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
@@ -2592,11 +2607,15 @@ void media_transport_update_device_volume(struct btd_device *dev,
 	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+		const char *uuid = media_endpoint_get_uuid(transport->endpoint);
 		if (transport->device != dev)
 			continue;
 
-		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint)) {
+		/* Volume is A2DP and BAP only */
+		if (media_endpoint_get_sep(transport->endpoint) ||
+				strcasecmp(uuid, PAC_SINK_UUID) ||
+				strcasecmp(uuid, PAC_SOURCE_UUID) ||
+				strcasecmp(uuid, BAA_SERVICE_UUID)) {
 			media_transport_update_volume(transport, volume);
 			break;
 		}
diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 175275f2e..83e568f22 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -51,6 +51,9 @@
 #include "src/log.h"
 #include "src/error.h"
 
+#include "vcp.h"
+#include "transport.h"
+
 #define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 
@@ -83,6 +86,22 @@ static struct vcp_data *vcp_data_new(struct btd_device *device)
 	return data;
 }
 
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct vcp_data *vdata = data;
+	const struct bt_vcp *vcp = match_data;
+
+	return vdata->vcp == vcp;
+}
+
+static void vcp_volume_changed(struct bt_vcp *vcp, int8_t volume)
+{
+	struct vcp_data *data = queue_find(sessions, match_data, vcp);
+
+	if (data)
+		media_transport_update_device_volume(data->device, volume);
+}
+
 static void vcp_data_add(struct vcp_data *data)
 {
 	DBG("data %p", data);
@@ -93,6 +112,7 @@ static void vcp_data_add(struct vcp_data *data)
 	}
 
 	bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
+	bt_vcp_set_volume_callback(data->vcp, vcp_volume_changed);
 
 	if (!sessions)
 		sessions = queue_new();
@@ -103,12 +123,12 @@ static void vcp_data_add(struct vcp_data *data)
 		btd_service_set_user_data(data->service, data);
 }
 
-static bool match_data(const void *data, const void *match_data)
+static bool match_device(const void *data, const void *match_data)
 {
 	const struct vcp_data *vdata = data;
-	const struct bt_vcp *vcp = match_data;
+	const struct btd_device *device = match_data;
 
-	return vdata->vcp == vcp;
+	return vdata->device == device;
 }
 
 static void vcp_data_free(struct vcp_data *data)
@@ -137,6 +157,26 @@ static void vcp_data_remove(struct vcp_data *data)
 	}
 }
 
+int8_t bt_audio_vcp_get_volume(struct btd_device *device)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return bt_vcp_get_volume(data->vcp);
+
+	return 0;
+}
+
+bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return bt_vcp_set_volume(data->vcp, volume);
+
+	return FALSE;
+}
+
 static void vcp_detached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
new file mode 100644
index 000000000..f5f2d2885
--- /dev/null
+++ b/profiles/audio/vcp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 Stream Unlimited
+ *
+ *
+ */
+
+int8_t bt_audio_vcp_get_volume(struct btd_device *device);
+bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume);
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index cfc426624..489cd2b97 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -147,6 +147,12 @@ struct bt_vcs_ab_vol {
 	uint8_t	vol_set;
 } __packed;
 
+struct bt_vcs_client_ab_vol {
+	uint8_t	op;
+	uint8_t	change_counter;
+	uint8_t	vol_set;
+} __packed;
+
 struct bt_vocs_set_vol_off {
 	uint8_t	change_counter;
 	int16_t set_vol_offset;
@@ -192,6 +198,11 @@ struct bt_vcp {
 
 	bt_vcp_debug_func_t debug_func;
 	bt_vcp_destroy_func_t debug_destroy;
+	bt_vcp_volume_func_t volume_changed;
+
+	uint8_t volume;
+	uint8_t volume_counter;
+
 	void *debug_data;
 	void *user_data;
 };
@@ -1874,6 +1885,15 @@ bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t func,
 	return true;
 }
 
+bool bt_vcp_set_volume_callback(struct bt_vcp *vcp,
+				bt_vcp_volume_func_t volume_changed)
+{
+	if (!vcp)
+		return false;
+
+	vcp->volume_changed = volume_changed;
+	return true;
+}
 unsigned int bt_vcp_register(bt_vcp_func_t attached, bt_vcp_func_t detached,
 							void *user_data)
 {
@@ -1959,6 +1979,65 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 	DBG(vcp, "Vol Settings 0x%x", vstate.vol_set);
 	DBG(vcp, "Mute Status 0x%x", vstate.mute);
 	DBG(vcp, "Vol Counter 0x%x", vstate.counter);
+
+	vcp->volume = vstate.vol_set;
+	vcp->volume_counter = vstate.counter;
+
+	if (vcp->volume_changed)
+		vcp->volume_changed(vcp, vcp->volume / 2);
+}
+
+static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+
+	if (!success) {
+		if (err == BT_ATT_ERROR_INVALID_CHANGE_COUNTER)
+			DBG(vcp, "setting volume failed: invalid counter");
+		else
+			DBG(vcp, "setting volume failed: error 0x%x", err);
+	}
+}
+
+int8_t bt_vcp_get_volume(struct bt_vcp *vcp)
+{
+	return vcp->volume / 2;
+}
+
+bool bt_vcp_set_volume(struct bt_vcp *vcp, int8_t volume)
+{
+	struct bt_vcs_client_ab_vol req;
+	uint16_t value_handle;
+	struct bt_vcs *vcs = vcp_get_vcs(vcp);
+
+	if (!vcs) {
+		DBG(vcp, "error: vcs not available");
+		return false;
+	}
+
+	if (!vcs->vol_cp) {
+		DBG(vcp, "error: vol_cp characteristics not available");
+		return false;
+	}
+
+	if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_handle,
+							NULL, NULL, NULL)) {
+		DBG(vcp, "error: vol_cp characteristics not available");
+		return false;
+	}
+
+	vcp->volume = volume * 2;
+	req.op = BT_VCS_SET_ABSOLUTE_VOL;
+	req.vol_set = vcp->volume;
+	req.change_counter = vcp->volume_counter;
+
+	if (!bt_gatt_client_write_value(vcp->client, value_handle, (void *) &req,
+		sizeof(struct bt_vcs_client_ab_vol), vcp_volume_cp_sent, vcp,
+									NULL)) {
+		DBG(vcp, "error writing volume");
+		return false;
+	}
+	return true;
 }
 
 static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
@@ -2061,6 +2140,9 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 	DBG(vcp, "Vol Set:%x", vs->vol_set);
 	DBG(vcp, "Vol Mute:%x", vs->mute);
 	DBG(vcp, "Vol Counter:%x", vs->counter);
+
+	vcp->volume = vs->vol_set;
+	vcp->volume_counter = vs->counter;
 }
 
 static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 26db5732d..a9c6287ad 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -36,6 +36,7 @@ struct bt_vcp;
 typedef void (*bt_vcp_destroy_func_t)(void *user_data);
 typedef void (*bt_vcp_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_vcp_func_t)(struct bt_vcp *vcp, void *user_data);
+typedef void (*bt_vcp_volume_func_t)(struct bt_vcp *vcp, int8_t volume);
 
 struct bt_vcp *bt_vcp_ref(struct bt_vcp *vcp);
 void bt_vcp_unref(struct bt_vcp *vcp);
@@ -45,9 +46,15 @@ void bt_vcp_add_db(struct gatt_db *db);
 bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client);
 void bt_vcp_detach(struct bt_vcp *vcp);
 
+int8_t bt_vcp_get_volume(struct bt_vcp *vcp);
+bool bt_vcp_set_volume(struct bt_vcp *vcp, int8_t volume);
+
 bool bt_vcp_set_debug(struct bt_vcp *vcp, bt_vcp_debug_func_t cb,
 			void *user_data, bt_vcp_destroy_func_t destroy);
 
+bool bt_vcp_set_volume_callback(struct bt_vcp *vcp,
+				bt_vcp_volume_func_t volume_changed);
+
 struct bt_att *bt_vcp_get_att(struct bt_vcp *vcp);
 
 bool bt_vcp_set_user_data(struct bt_vcp *vcp, void *user_data);
-- 
2.34.1

