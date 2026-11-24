Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526411;
	b=ldT3K0InmwTnaqByv3oWh1dn1lun44G1rU3dK1xN2as3MRyrbwHgDb/dr/oK5dC1qe5v
	 v0QweQsM5xileB0Ir/FGyGQRuaSL9ksr/71r5XrQOiYQkyl60OkDo74bTu82hyLTLkJVm
	 sT6K1j+Tu41PkisnSqmttAd3WTxiTXy5M5e6cZa7DLJksiv6aDdmTR1KJn4MxuwO/O8ga
	 3MbMKK8jVIi0cSP6+5+CYuUYF66+3McoS+SDqXWyUakQTDqD/oveDKBKYW8M0T0MZIGKw
	 OQ1+kragNk6okrzWcL6yZrG81zykJg58kNkHitKRUgE6ws1v0092Ouecvf+SEwNWi9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
	b=I6qIH0VutUxRBZBKRgenU53pDpILsaydsPj1yYoN04Iapv2m1yx5hk5o/mo+0MNOahu5
	 YmH+bQHTYHM86cvJGCxZ5SFI6ubiyqidFw4QveANWOLxDbWi9TTnlurkEKwPQf4LfboCg
	 a5W9wNDHiUYAApY22Ugbjv35+Ckg77aGhagyvuyIK2PEO9vQj3RGo2L0s0OYxpNdmEWNo
	 JiR8lC4pm72jnILNCPoJ8dwHsmCIwAM3g9yWoaH+HohhxAOAxLr5PhQCObsZwaEfCGxTj
	 bcEfDsQYKWJX7xzya/w+shEKP3HsuCr7bX4zuvozYdl00Ux1QRDv4SiZ+zxmOi4ENqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Vh1yiEk8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E24606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E24606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Vh1yiEk8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4b467581b98so43382525e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526410; x=1796131210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
        b=Vh1yiEk8isdxhj7/lELSbfUoW/XaAveHXvmVX3Dq3Q6YhHBk38BlQjsf8C8n4PWMWa
         GXIKs2B+vXYQ93cfcFIgshJEPA7MnD+7Azi/4G8ASjn254ryR0cMRJnA1D7kU4QElWFm
         4hHh5SCJDcY1edthAypyl275Q+P42tsN0DxLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526410; x=1796131210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
        b=iRQQ2fgl7lKgJYs/SM6u2bSEoIEmah/4W41CbpStLg1uKr6JFLtiWrKkXl39m6oxJ7
         eaHJlXgml0XxuSr3c4UijbLpe2rKnGb/5hLGVcTDsmX73rpdQdI06jcOgnjDNkpglaUi
         zvuAvnXd22dcF7r+8G5qANcBjTZBJ4v5j5eoy7sThavo/sGvrlbnvWfd9yXJI/qkgR5/
         RgrICbPV63dwCAwRoZRAXtthgzTLcFXvDGyUoVQG2cUaAgBdKh1u689Txw/wxm2DSRWL
         ddib/eJu7nJKiLd5MApMVWhrgBbKRl4UQM9HD8lHby6qR/TnaShHz7LQdEoc4/h0oHZ6
         x5+w==
X-Gm-Message-State: APuU4Z+zsK4mX4UpfMtFPR7JaQtl5IT2jj3nwHdZB7Qtz7pBIKsfXPE+
	Y5sfMT6tNXhXS43VmZTBpR5GI5VTUS2VqljiDuHr0AD7rUE/KtA12xTILWEetFEHtCvj2zZBurX
	4oRJC
X-Gm-Gg: AZFdTZdCZSUEt9srfHiMamCHr/+YAXzkp7O8tXLHVvNdcMNQbrlgnW67qcBnyjlrlqz
	I8as7J6c929vIYFgDRfWom2htqi/vxqKvHXM6imPnMdaUsrY3TY4BsGv/pIl8dh2GrsknVK8iSS
	D+QB1Z8XeMIyvJVPLfvzQV3vwTn3jdaCrKZRGOknWAT+2peFn0nPnj013mOWgOh9tL3njisRews
	GrNCC6Gaxf/saW7pzO5bt/l1bDsSrtjSUx0Ec3uKiIgDpJPyVKLqp2Ye3Me38qNiiu0vaR/QKMt
	QqrjCqAq77Jjeoq2uUgKqgv3hj04o4D8SnnVwJWNhDj4C3BImHVXwTKuKGhL77ZHmcz/TPkq5wY
	Yc/DP3yhLYr+iTek/rf32BBPlI540YD9qzL70QHnPn9HGCu7sDgIguz+uKJ3e0ku9J8U7oxQViW
	6RDZpuY5FrJVJsq9VStn2BuYarw6q5agX9BbkkNB6vDXWQ3yY7xdN702t+6FNpHcuMHf5oN7lzW
	oL3QN8rs9NXlw097IFbVxKZ8uxMQcMGsaJcWe4uyd/DF26PRczgocjitFnDyiSDnUstpHjUP/0P
	fkZGGwle/EWZa/g5MwfHfNb3YkyTrnyH8C8F1qu42erAZrUOclZdGvGayudWW1tXPkkWC0Q=
X-Received: by 2002:a05:600c:1c1b:b0:4bb:87be:c138 with SMTP id 5b1f17b1804b1-4bb8893e021mr329442345e9.32.1795526409677;
        Tue, 24 Nov 2026 05:20:09 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm270963015e9.4.2026.11.24.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:20:09 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/4] audio/transport: Add Mute property
Date: Tue, 24 Nov 2026 14:20:02 +0100
Message-ID: <20261124132003.3899120-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
References: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Mute to BAP unicast transports that have a VCP session, read and
written through VCP like Volume. A2DP transports don't get it: AVRCP
has no mute.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 93 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/vcp.c       | 20 ++++++++
 profiles/audio/vcp.h       | 12 +++++
 3 files changed, 125 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index ad2fc2c1c..ca5bda560 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1267,6 +1267,64 @@ static void set_volume(const GDBusPropertyTable *property,
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
@@ -1620,6 +1678,7 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "Metadata", "ay", get_metadata, set_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "Mute", "b", get_mute, set_mute, mute_exists },
 	{ }
 };
 
@@ -1635,6 +1694,7 @@ static const GDBusPropertyTable transport_bap_uc_test_properties[] = {
 	{ "Metadata", "ay", get_metadata, set_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "Mute", "b", get_mute, set_mute, mute_exists },
 	{ "Desynchronized", "b", get_desync, set_desync, links_exists},
 	{ }
 };
@@ -2620,6 +2680,22 @@ static int transport_bap_set_volume(struct media_transport *transport,
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
@@ -3198,6 +3274,22 @@ static void media_transport_emit_volume(struct media_transport *transport)
 					MEDIA_TRANSPORT_INTERFACE, "Volume");
 }
 
+static void media_transport_emit_mute(struct media_transport *transport)
+{
+	const char *uuid = media_endpoint_get_uuid(transport->endpoint);
+
+	if (strcasecmp(uuid, PAC_SINK_UUID) &&
+				strcasecmp(uuid, PAC_SOURCE_UUID))
+		return;
+
+	if (!mute_exists(NULL, transport))
+		return;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "Mute");
+}
+
 int media_transport_get_a2dp_volume(struct btd_device *dev)
 {
 	GSList *l;
@@ -3272,6 +3364,7 @@ void media_transport_volume_changed(struct btd_device *dev)
 			continue;
 
 		media_transport_emit_volume(transport);
+		media_transport_emit_mute(transport);
 	}
 }
 
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
-- 
2.43.0

