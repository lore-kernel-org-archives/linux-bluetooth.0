Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FD208998
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234523; cv=none; b=KBgBe9gaoiM/MLSFohgyBkO/+/4OYqPTa/6Fnkev8VRMIQ24v50ReionhgfoCaDKQhTgh5y6bAmRVgVk/OtNoLavoDdfUSsllmJ097m/VenAccb20Ft/PsF4na5tPJyO6OfFcFHCEtJLkoSn0P2t2+fKpdVUu5VfisEELrDXZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234523; c=relaxed/simple;
	bh=vqZ2kBZxhztTifev/UYuSN5bXpLkXbIx+Q13yqfHWPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BluRIHs1J+czhsI2ujpWcvFc9rlEMelgTMthEYPo0dO9M9ZfioJl4X27UyFM8DuoE2FwZoLF8HA1jsyVQjkBrzPnc2BwGGuxi4k9atniw7rswJIRAU4vjSpIV/FtXuFc8geRLIgby8/DjzhrG6W9zgLwqX6wlRIddi9DLoW8ySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzbUdfJj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzbUdfJj"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fc968b3545so58825741fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730234518; x=1730839318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJNgISCbCj6sNfrsAV39HsHpI3S7Jy/a7uALdZWmAd4=;
        b=SzbUdfJjG65hdsgBySzuUtn7ChPEL6E5jWgQTc5SG/1MUkeoGVNoFIuWiwKZezaoAQ
         kNPaNHAgNjOJTHny2xnK64Z1qC9odqvdO1k6tZxYVGQlz7ng/5Q/KHQFMyO0iEqmsTiD
         U+HllVZEevo4gtXq2CKpjeOyYLNSIx3glzs0auYGgFQS4mFZO1obCNTC85P6VIOSFf6W
         RzPPPMwdpx+5N+TwvDRosFqm0LJ1T5BI0oJWk2G1I/iIKtbStKIFd3N/C+pdSI+K2YD/
         YxBbYkpeOKlnF3mwXcmN9ntGpb2bbaXAxocNFUmB6RwFMgUMsbr/2nmR/nICDHGXJbZA
         Dojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234518; x=1730839318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJNgISCbCj6sNfrsAV39HsHpI3S7Jy/a7uALdZWmAd4=;
        b=rDEZCFnwudymk7F+Oq4ODMX7ybUK3p1kIG2PKj0UqoBlrQBwUzyX2sz1MgGA+VOrLj
         PlbwmEN7wvumZPapHjW4PyF8p4cH0uynpC/+XsdSWWixpaDj+OXPFWaJELzxeFW565Xj
         HEYx9baZDaavzFAbxeVTSj9GFmOsGneLwxp2FkOPKa9+JGk7fpkI8JdNFAfa97yntCLN
         bjn17VDUBfBy4pEV0tUYy4Fcu2chQ3gfcZS2duKo1Ysd36h0XKwexRCv+ltoEGVggmBw
         +Sg6ozK6teK7cyoUaIy/vOmp64GH1ec/t17xdVbbthVauoWXi8tdVG1wP8+6YV0JkCYj
         SFSQ==
X-Gm-Message-State: AOJu0YzF/7MkTnWmKCgupVbpiKkx1i7TJ5JntuJzImMggilIj/JotsPo
	Py/xg7MriYRWfW4CBhIrnp4XM1Vy75AwRUxYan8LLwx/zZTlneZhKpPowA==
X-Google-Smtp-Source: AGHT+IFDh/kUZfbtAH2bFwyXdyLtrO/dDXdXZakoNb12ct5cmJZN3iUFgZAanvWi2r3WzPgAIQw8SA==
X-Received: by 2002:a05:651c:4ca:b0:2fb:3d86:d915 with SMTP id 38308e7fff4ca-2fcbdf7da15mr58418611fa.11.1730234517815;
        Tue, 29 Oct 2024 13:41:57 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fd53603415sm435251fa.85.2024.10.29.13.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:41:56 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v3 2/3] transport: Allow to set A2DP transport delay property
Date: Tue, 29 Oct 2024 21:41:31 +0100
Message-Id: <20241029204132.586663-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
References: <CABBYNZJyrKnWGcFb9k2YbucPub0hkhG-OH=RWEhdKPJKLVLfpA@mail.gmail.com>
 <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to properly synchronize audio/video playback it is required
to report audio delay to the A2DP source. This commit allows connected
media application to update the Delay property of the A2DP transport
which will inform remote source about the playback delay.

In case when the transport is not acquired, everyone is allowed to set
the delay. However, when the transport is acquired only the owner can
modify the delay. This restriction is here to prevent interference
caused by 3rd party actors.

The functionality was tested by streaming audio between two hosts
running BlueZ Bluetooth stack.
---
 profiles/audio/transport.c | 103 ++++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0f7909a94..dad8604eb 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,6 +116,7 @@ struct media_transport_ops {
 	void *(*get_stream)(struct media_transport *transport);
 	int8_t (*get_volume)(struct media_transport *transport);
 	int (*set_volume)(struct media_transport *transport, int8_t level);
+	int (*set_delay)(struct media_transport *transport, uint16_t delay);
 	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
 };
@@ -551,6 +552,36 @@ static int transport_a2dp_snk_set_volume(struct media_transport *transport,
 	return avrcp_set_volume(transport->device, level, notify);
 }
 
+static int transport_a2dp_snk_set_delay(struct media_transport *transport,
+					uint16_t delay)
+{
+	struct a2dp_transport *a2dp = transport->data;
+	struct avdtp_stream *stream;
+
+	if (a2dp->delay == delay)
+		return 0;
+
+	if (a2dp->session == NULL) {
+		a2dp->session = a2dp_avdtp_get(transport->device);
+		if (a2dp->session == NULL)
+			return -EIO;
+	}
+
+	stream = media_transport_get_stream(transport);
+	if (stream == NULL)
+		return -EIO;
+
+	if (a2dp->watch) {
+		a2dp->delay = delay;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Delay");
+	}
+
+	return avdtp_delay_report(a2dp->session, stream, delay);
+}
+
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
@@ -873,7 +904,7 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 	return avdtp_stream_has_delay_reporting(stream);
 }
 
-static gboolean get_delay_reporting(const GDBusPropertyTable *property,
+static gboolean get_delay_report(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
@@ -884,6 +915,61 @@ static gboolean get_delay_reporting(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static int media_transport_set_delay(struct media_transport *transport,
+					uint16_t delay)
+{
+	DBG("Transport %s delay %d", transport->path, delay);
+
+	if (transport->ops && transport->ops->set_delay)
+		return transport->ops->set_delay(transport, delay);
+
+	return 0;
+}
+
+static void set_delay_report(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, GDBusPendingPropertySet id,
+				void *data)
+{
+	struct media_transport *transport = data;
+	struct media_owner *owner = transport->owner;
+	const char *sender;
+	uint16_t arg;
+	int err;
+
+	if (owner != NULL) {
+		/* If the transport is acquired, do not allow to modify
+		 * the delay anyone but the owner. */
+		sender = g_dbus_pending_property_get_sender(id);
+		if (g_strcmp0(owner->name, sender) != 0) {
+			g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotAuthorized",
+					"Operation Not Authorized");
+			return;
+		}
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected UINT16");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &arg);
+
+	err = media_transport_set_delay(transport, arg);
+	if (err) {
+		error("Unable to set delay: %s (%d)", strerror(-err), err);
+		g_dbus_pending_property_error(id,
+						ERROR_INTERFACE ".Failed",
+						"Internal error %s (%d)",
+						strerror(-err), err);
+		return;
+	}
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1019,7 +1105,7 @@ static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "Delay", "q", get_delay_reporting, NULL, delay_reporting_exists },
+	{ "Delay", "q", get_delay_report, set_delay_report, delay_reporting_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -2170,7 +2256,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
-		      _get_volume, _set_volume, _update_links, _destroy) \
+		      _get_volume, _set_volume, _set_delay, _update_links, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
@@ -2184,16 +2270,17 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 	.get_stream = _get_stream, \
 	.get_volume = _get_volume, \
 	.set_volume = _set_volume, \
+	.set_delay = _set_delay, \
 	.update_links = _update_links, \
 	.destroy = _destroy \
 }
 
-#define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
+#define A2DP_OPS(_uuid, _init, _set_volume, _set_delay, _destroy) \
 	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-			_set_volume, NULL, _destroy)
+			_set_volume, _set_delay, NULL, _destroy)
 
 #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
 		_set_state) \
@@ -2201,7 +2288,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
-			transport_bap_get_stream, NULL, NULL, _update_links, \
+			transport_bap_get_stream, NULL, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
@@ -2219,14 +2306,16 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL, NULL)
+			NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 			transport_a2dp_src_set_volume,
+			NULL,
 			transport_a2dp_src_destroy),
 	A2DP_OPS(A2DP_SINK_UUID, transport_a2dp_snk_init,
 			transport_a2dp_snk_set_volume,
+			transport_a2dp_snk_set_delay,
 			transport_a2dp_snk_destroy),
 	BAP_UC_OPS(PAC_SOURCE_UUID),
 	BAP_UC_OPS(PAC_SINK_UUID),
-- 
2.39.5

