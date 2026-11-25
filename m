Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626137;
	b=jLIIwkiorHPrXCzvSeTMErmQ2BVEC9nsexmuyj64P9sUAeZrhmFILt1Je8B7plQtxW8h
	 scR3XDZt03HD0Se+B13b5FkHEs4GEgu1vcWVkmLYl5tiMrHMMfsaYfFQ2UPfub0TnfzKN
	 Ex2bygd8PsfHLFA18rIRFGKVUS/Ihpqv1weSobh2fxdb+APHNV3Um/TWNb0yPuLEJZreF
	 1aDI+DjoVEYnp6pp6vkZMrujT7RDXQ6Y6H2l9gu3rpCelq5cYDfd1yMvJ4ZY+xrUf/dPl
	 fwa5bpXJJoa0/TDbWYgyqN13lgL+KxcbeoEqGqJbBPaYnOoeBwOZkSUyKuNkEgVh44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
	b=OBdUjLboIJtQh0BlF9Pt7fCqzohM0p19nQim4vTx89+wWsrD4AOGMsM1ZT8tnbsc7cFL
	 t3ZqmCTnRUAwWrSsgP0gcwcPF/nSUTCBUPZOzS9YPOqrleGlfcME3JBsMnqT4SEqH+TR9
	 nH2kQFOUlp4e97Ahba31VO81hhDfwUb4FobmSRxTzW6/toVM1emvz8wJB1qQkIagc4ELC
	 FbuvYgzgRAWWa8ZyXC18H1jBuCgucic3nJWzvvlhLO0OVbMG0frQe9MAnQIAyWdQxGSR2
	 I+wxQihH1dH6Mvy1BULpqkyfs5WMlORZtkvjjSQ3pFcOS/fmubc6EhsrJvCOcE251mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b2c9Fss5;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E1606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C2E1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=b2c9Fss5
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e3b22e971so3192489f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626135; x=1796230935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
        b=b2c9Fss5fWXZDgEc5HZmbBQ5OZioVL1XDgGSylOxH3uRc1u0d5QDb3xZoQOGlRaAX1
         7BSnDdHFidYBsn0VPjnuyv9CWDLPz9Z02x1S+zCF9J4U04wRQTccRHG1AlXkYtkvGWb9
         eN9ohbMbk7HotgHpITRUkOAoYc6CVXhJgdQ1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626135; x=1796230935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7w43LkP2xl8tQJhRCXzrPilDCpphxlZSv9kmfU2Uj8=;
        b=tvBhJ8D+knQfik97IxuCVDX9DGC+c/niBdRz6hltk1Jz4ND/4V2YcdzEF1OBhliisa
         h/LoP4rO6Wd+dB7ovhSuikvSwtg0VBS4/JKzweo7GQKXm7rrARcJyB+VCIfkEcDPpmXF
         OTRdXkYA+L9kUXXBRBnPiMtSgMzrOLufToe5d0AS6zRicHshl9vj28DInZJiN/Q3XZwP
         reV0N/+XWky0MS9ucso+qC/KHAg1NmL989/eVqIqEtsJxNtUqyXsk/UMlkOqErjXi+CT
         UtIgXj4rf4AoMyn7UP8Jif35L85K+Y4jts9uGltLmvTZnuwduSIhT1KV+Y7JOL4r809f
         Izbg==
X-Gm-Message-State: APuU4Z/iEWUO/YLq/3iJVELdy6CB4gY5GNu6ezTmObqTHgRXPcMMuYf+
	bbZab13Zq9IyBQjVGnrPMHxDZiG31t0p26aKcRcxaezyEngCoWej4wEdbwJO56zmH/EWQTkoyRG
	W4yjB
X-Gm-Gg: AZFdTZcvuWehkQ7y9Vn5IH/sRUQCy3FgnK0TcWtQfmfzZGMSZJo1ISmyfCZ7PweymMx
	caqmG610zp1NpyCC46sKX+dey7G4fIeUaF4oimAx9uCz2hVSku7zx6mspYEeLHCEtCvxFq3Dsqi
	qDWQbeBtH3Jg3RVDBbVvUT8Ac6dGQZ5WXz/DrOTtodG7A22JmtaQJ1qFOfWmmJ2yGlpk1edKS44
	Fiobh/QM2X1IIsU6iisYxmntXfP8g44qUGqptK52O+RKIPBA4vLFLOJ8/jRQxJfkbBOBwgS9iNn
	wEOrv6fAIedO1s1H6O0EqC8Rd5FMnboN0CTbdeD0dF61OjKbEMQgJ9pclZzdedwbunxUR7nyGR3
	F3UJd5UHczrzLgs/t9/fm2hA/gCHjNUP4e9TxkbFd/uwADrrT7slCtzuW8DwsKx7TQYy4cC2kV0
	HoOzNmIUAVSoivmBQNmQxAZmsCu3VQvrh9SP+4dK/jmrTBeg4b1Ucfmh0EHprBTbehgtBIpDbsq
	s97P3yJaNunRdAUUvXajWL73KDH4QQlkrTG2qh9hkuX+F9kW23NDijjr5hb7XUCKtyh2voeKlLv
	PAh7kB9ybObBvjL6sXaO9fjC+XVagWvTdb88pcsgVNbs8ci1jg==
X-Received: by 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr382430285e9.2.1795626135592;
        Wed, 25 Nov 2026 09:02:15 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm40475725e9.2.2026.11.25.09.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:15 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/4] audio/transport: Add Mute property
Date: Wed, 25 Nov 2026 18:02:06 +0100
Message-ID: <20261125170207.1648671-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
References: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
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

