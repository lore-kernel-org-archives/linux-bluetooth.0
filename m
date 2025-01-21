Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878491F3D3B
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470669; cv=none; b=WCzfDXv0ip/2njgBO8kyrQtAEnSWz1jlykqjlQjpM7+8cBf9t8sV55RDOfDDl8Ky/jO1TjrPv6beNtonzCZOFGDUhXpApDaXrK6XSnaEowM+BoCVXsh3MIb3ADu1czucndGZ0KL7Te9NfcY24Aci7Hsx+StQxHh2+hepcf9nVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470669; c=relaxed/simple;
	bh=Z56dix/oiDp+VMSmG299Rw694eEi0cQPz+U0fe4Ixrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1WAebIF43ZcKIO1Fl4LlLPKkZZJ2Xz9zmA1iiw7KCt4FqWKiX34zjwkZ6NeMaSWL6aGY6+8jvteOLfEyoNu7KvpoaL6wqKSdT9tamzDJ4nMbiwUEBLjbepDvQCXqr9c2eEYDtIlSThU1295+szyAVrjjJH7B9m0OMFe286J9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=UfC4v0zt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="UfC4v0zt"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e3778bffdso6014721e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470664; x=1738075464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyBSdaXHd09I3bbfigjja1hooXBxREedZ4We5DQhlcc=;
        b=UfC4v0ztfzSe7XoJrwUylX7691RNc3f1BKuq3MAKrRvkC8TuxUrVfDdUtOKbllhA2P
         k7FWkMEz8IjZakm0jfIbvYgOVU+nV6VUugNvqPT9ZlZ+uJ7ZzaKN+4rSk6itcVYbtO1e
         nIo16n4tmIow9eqgqQDf3jX61r8URv0lt+hTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470664; x=1738075464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyBSdaXHd09I3bbfigjja1hooXBxREedZ4We5DQhlcc=;
        b=Y6FP07ipc1DvNACUBSVNBgctTNcI/qjRKLOR8SKxxhWnD+FZWUTq+OXfsawbQSkOIj
         5z7mvJXpwZkSTauUtcNTlvKYn04QgBkghtEIEWe+5O5wrZZxxqV0xUBgGHEjo5JKYnMa
         +2hoqX9hgugWH2eGzyx0BKYnG7sMse31Alin5KdF+hAR1mWct4JAl8sfpLqewkXGZ25T
         E1T2/G+rC+KnWVDGfmkaPLnzOGWDdbRmhRKvX7YgXRyckW4I8uVgymwDV9NEkHeACGkj
         eQjhHft8orazmOLSVkrrpTjXN4AsEYdvVp+wKLfdzOGbWasHd6sm+YN3KEY4MbyxGeej
         WZ5Q==
X-Gm-Message-State: AOJu0YwoITpYHASJXGDgVAsEpie2tzcbJtyj1B2uv1Mcj8VpBJtNZq08
	GWx0KIVq1V9hkcL+kAtl+luQfQp/fsjyiv3D2MkcdAuD+XWag6xq60qoOEfV4KOYUs5SaC8DciA
	=
X-Gm-Gg: ASbGnctktrR9fV9OGHbQYeKPjeNMgXOc1LdbXeBo0Vk5Cedjfb0tYOqrxv9rj2s/4pG
	HFspgFU2LZMgwrx8KkCi6+GZ6eZ8Gw6LZn4lrK1cfC85N8pMtUkXdRveeWG/Mpc1t57xlcogK0o
	DCPuVpp0ghfKasa2QnAqquGCAbav8PQJrCG6CLyFZNBDaptUAPUQGCtyTIjgEsE9ct9piQio7yZ
	x++n1kWAtGDOcpWjzAOFt6qPVIAh5mdzQNoEFV0/EfkBHVPB2Jgo2rLkHbjrGUBPW1wMzV7C88R
	fDqnX/w9VxNoHBK++IMfGIyf6vvdbNSWFx2n0Jb0Jivt
X-Google-Smtp-Source: AGHT+IEms4+idAwtagJdGPwGnvF2Ht0t+9FLI8EKz7XT9ERiW19mSuwonT0Zg4WAfa6X7XgrhmYeSA==
X-Received: by 2002:a05:6512:1252:b0:542:2486:697b with SMTP id 2adb3069b0e04-5439c22a85bmr5990559e87.10.1737470664259;
        Tue, 21 Jan 2025 06:44:24 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:23 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/5] audio: connect VCP profile client to MediaTransport
Date: Tue, 21 Jan 2025 15:44:01 +0100
Message-Id: <20250121144404.4087658-3-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
References: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
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
 Makefile.plugins           |  2 +-
 profiles/audio/transport.c | 37 +++++++++++++++++++------
 profiles/audio/vcp.c       | 57 ++++++++++++++++++++++++++++++++++++--
 profiles/audio/vcp.h       | 12 ++++++++
 4 files changed, 95 insertions(+), 13 deletions(-)
 create mode 100644 profiles/audio/vcp.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 97335d643..81cf3155a 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -128,7 +128,7 @@ endif
 
 if VCP
 builtin_modules += vcp
-builtin_sources += profiles/audio/vcp.c
+builtin_sources += profiles/audio/vcp.h profiles/audio/vcp.c
 endif
 
 if MICP
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a4198d23a..eff95a7c2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -55,6 +55,7 @@
 #include "media.h"
 #include "transport.h"
 #include "bass.h"
+#include "vcp.h"
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
@@ -1420,6 +1421,7 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
 };
 
@@ -2188,6 +2190,17 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
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
@@ -2411,7 +2424,8 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
-			transport_bap_get_stream, NULL, NULL, NULL, \
+			transport_bap_get_stream, transport_bap_get_volume, \
+			transport_bap_set_volume, NULL, \
 			_update_links, transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
@@ -2573,17 +2587,18 @@ struct btd_device *media_transport_get_dev(struct media_transport *transport)
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
@@ -2628,11 +2643,15 @@ void media_transport_update_device_volume(struct btd_device *dev,
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
index 175275f2e..cc6f352c1 100644
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
 
@@ -83,6 +86,33 @@ static struct vcp_data *vcp_data_new(struct btd_device *device)
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
+static int8_t scale_volume_vcp2transport(uint8_t volume)
+{
+	/* Transport has volume range 0-127, VCP has range 0-255 */
+	return volume / 2;
+}
+
+static uint8_t scale_volume_transport2vcp(int8_t volume)
+{
+	return volume * 2;
+}
+
+static void vcp_volume_changed(struct bt_vcp *vcp, uint8_t volume)
+{
+	struct vcp_data *data = queue_find(sessions, match_data, vcp);
+
+	if (data)
+		media_transport_update_device_volume(data->device, scale_volume_vcp2transport(volume));
+}
+
 static void vcp_data_add(struct vcp_data *data)
 {
 	DBG("data %p", data);
@@ -93,6 +123,7 @@ static void vcp_data_add(struct vcp_data *data)
 	}
 
 	bt_vcp_set_debug(data->vcp, vcp_debug, NULL, NULL);
+	bt_vcp_set_volume_callback(data->vcp, vcp_volume_changed);
 
 	if (!sessions)
 		sessions = queue_new();
@@ -103,12 +134,12 @@ static void vcp_data_add(struct vcp_data *data)
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
@@ -137,6 +168,26 @@ static void vcp_data_remove(struct vcp_data *data)
 	}
 }
 
+int8_t bt_audio_vcp_get_volume(struct btd_device *device)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return scale_volume_vcp2transport(bt_vcp_get_volume(data->vcp));
+
+	return 0;
+}
+
+bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
+{
+	struct vcp_data *data = queue_find(sessions, match_device, device);
+
+	if (data)
+		return bt_vcp_set_volume(data->vcp, scale_volume_transport2vcp(volume));
+
+	return FALSE;
+}
+
 static void vcp_detached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
diff --git a/profiles/audio/vcp.h b/profiles/audio/vcp.h
new file mode 100644
index 000000000..f313cd96a
--- /dev/null
+++ b/profiles/audio/vcp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024 StreamUnlimited Engineering GmbH
+ *
+ *
+ */
+
+int8_t bt_audio_vcp_get_volume(struct btd_device *device);
+bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume);
-- 
2.34.1

