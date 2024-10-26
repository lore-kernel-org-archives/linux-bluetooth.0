Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CE1D6DDF
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729970111; cv=none; b=hEvSk8+CZ11QF6TPidLXGFfBU33sC8/tkLB6oAwtJE7s4ejbviywsipKKg8Ouc1Ua0Dqa8DPZstzGpYvBvytx4IfLt1Lp2moLZMV44yjX87/gQDpw8+sDXNoXqgmTzrE0XIKyqC7R8zZKlctqEahodMH/AQhfZ7DEouK598CH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729970111; c=relaxed/simple;
	bh=7H5G57gtR61gp4xPmYQCEeLcjbGQfZ9SsjKmhfvqaB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwZDLGHoUsv7OrmdhZ7YBbc8nCHnJnf4dJjkd1w+rYnDKpXsz2FZBdVWeoKF0bx/hxBA9XzKXQcbNGCdQfbVenu759X9YMfreLY4a1yUj7gNnmQySPlZjFOdcfYd7pbgK3qxVMmaefUuiijPvXyOZUcAwAEdhIoz28Xz6VAUX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkGpsdjz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkGpsdjz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so3411784a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729970106; x=1730574906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj8vNfI0c9+5zQffwdoulFtUtytO4rt1yMEim7mSyFk=;
        b=QkGpsdjzybUppfhUU4RnLwabp+P18Pyj9cpR3Qnxoh57aBEatRSI7H0J8aHeCbwRzA
         33JOExI9O5FtjYj/4tY0ONyhs8taNdgAjiSUGkAZt7P3I9NFSygxkCtrxcaUdCVVw4wi
         BvCvDpEmx6mdcyKXMhiF6ItvGCMqtNIooLlNl5rt4yizgYDst+zD3l3pJIMJk9azKLpn
         VX/3zMkkdwKmKMr9ttx4lTfbD4HG+wFaGLdmGaROKwkxwBUREMtUsEvvUKulNLhJv+SR
         9ZIYeI98jzjKommzOGafpgQHHu0a0nIOFJUrDj5usuVzmM+LPJLy+2g89TamCUf6jcOI
         kE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729970106; x=1730574906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj8vNfI0c9+5zQffwdoulFtUtytO4rt1yMEim7mSyFk=;
        b=HcXStCU04WBEmbBbrk+S953Zl6Hmy6SLgcCJwLt7nP6x4phrbYS9Cb/+NXcgxZBbp9
         obYfk8Z+4MzcbtpXVi20Gc3R8P7wk2LppTy8Vi0VqxKEeBw5HdjbGPVX/ZtMaln1CJ8z
         hg/BdKvwDF0qdRL4Qn6rIJGYc8JXiv534z7KZwg4fWOmbCI33hzIUEB2AfggJy3WH6DC
         KcNaP3EbS/tWEAYWzz3cjFK98zsiqq0UB6GafTr3uNLNBXDl0VNc9NrgUFSkFuLH58td
         ZYCuLXYxiqqRkZ57GtpfgiQ8tF0yWE2x8rpn+PPgU6upxE5fE41y3WNg7U96KoBlWb60
         U5dg==
X-Gm-Message-State: AOJu0Yx32WXb6rfRXQSxRjryQ9ZJCRvDaQdGpddyA2J/PyM9wR5AwbFL
	DxvoFsCvm5o+G9U//JDNHUkcoh25NlocgKRy93DE4qC/PtHw1rPg94FVsA==
X-Google-Smtp-Source: AGHT+IHbmUWTB5BGg/mdto22KROcbHM16WUyrtITYn6B9NHwqgBQHOCAiA1aZ1R5WT2jqBflzUUrFQ==
X-Received: by 2002:a05:6402:26c9:b0:5cb:69be:db47 with SMTP id 4fb4d7f45d1cf-5cbbf922bb5mr2612210a12.28.1729970106123;
        Sat, 26 Oct 2024 12:15:06 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c250sm1776677a12.27.2024.10.26.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 12:15:04 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 2/2] transport: Allow to set A2DP transport delay property
Date: Sat, 26 Oct 2024 21:14:34 +0200
Message-Id: <20241026191434.556716-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
References: <20241026191434.556716-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to properly synchronize audio/video playback it is required to
report audio delay to the A2DP source. This commit allows connected
media application to update the Delay property of the A2DP transport
which will inform remote source about the playback delay.

The functionality was tested by streaming audio between two hosts
running BlueZ Bluetooth stack.
---
 doc/org.bluez.MediaTransport.rst |  2 +-
 profiles/audio/transport.c       | 87 +++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 5da13b3b5..310a69c6f 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -125,7 +125,7 @@ uint16 Delay [readwrite, optional]
 
 	Transport delay in 1/10 of millisecond.
 	This property is available only if the DelayReporting is true and is
-	writeable only when the transport was acquired by the sender.
+	writeable only when the transport corresponds to a sink endpoint.
 
 uint16 Volume [readwrite, optional]
 ```````````````````````````````````
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dd6878427..be34cc899 100644
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
@@ -900,6 +931,47 @@ static gboolean get_delay_report(const GDBusPropertyTable *property,
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
+	uint16_t arg;
+	int err;
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
@@ -1036,7 +1108,7 @@ static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
 	{ "DelayReporting", "b", get_delay_reporting },
-	{ "Delay", "q", get_delay_report, NULL, delay_reporting_exists },
+	{ "Delay", "q", get_delay_report, set_delay_report, delay_reporting_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -2196,7 +2268,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
-		      _get_volume, _set_volume, _update_links, _destroy) \
+		      _get_volume, _set_volume, _set_delay, _update_links, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
@@ -2210,16 +2282,17 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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
@@ -2227,7 +2300,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
-			transport_bap_get_stream, NULL, NULL, _update_links, \
+			transport_bap_get_stream, NULL, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
@@ -2245,14 +2318,16 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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

