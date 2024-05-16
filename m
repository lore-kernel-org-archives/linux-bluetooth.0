Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1114B961
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871323; cv=none; b=UAp/1eqtIfhtVMNIp8NqQUUiSX2eXtpZGaZU72+kh/N9zf6l5a9jHb3wCiu0j2K8tklxKYUYk/sHOAfhorNZidd1/p2Y6/tWut9g8js4cEdcjQTDY8GjRl3OMwUTD5330hacDFqAp4n4Dxz+3TiGKIOW1KnMaWdIdEi738d251I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871323; c=relaxed/simple;
	bh=S5b7sa49GfIIM4dJsfcmQbupSNOuGdNTLPbJlitdHNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwfIUzwJqBT23czjPJjYZdmZ7VSMSORfoBw3rttUt46J86mx8azJyr45GW//o4k7Ldb0PWiB50VNrotuy0+uCt/qgcsBVfVQSNqg/lD4NkxhIyj8xz+rs3NS6AUDdx4ljVrry4aG/rGDizCdAR5/SUb9Az7sFluBqnbwlpygoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=laleZJ6T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="laleZJ6T"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5751237a79bso26320a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871318; x=1716476118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4FiOg2/eURCB3nuNWoXpqFFWdW0xJgSHnuo2FSpr3w=;
        b=laleZJ6TXHys55OH4gYOU2gHAtEQW/fG0zE6rR4AAKF2BA9JfSo1Y4a8K9VjCpeB/c
         Z4l6d3r1ItZLyq9th5Dw46xwGhrc86kRPmvuw5IHneeoyWD2sokKYgWqBPeLypHDr4Mu
         rFyfOtsUqxKMMmkANkEWBdutRdAKshH/9Zy+bVh+o2EcafNw1yyRF4Fr5ixr8SgtWzAP
         7dznzPkB4IR/rT2lVNbtnzPgnZSsyQUFm5yUb0LlrpthzwWXVnKb59cX4ZdOrkoJu95O
         QRVsNhL5LC7FVBVC9zmojdvIeolJm2nSkHk4RFTsKiPMIT6/AnY4IdggZWQQKjs4i+jG
         QArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871318; x=1716476118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4FiOg2/eURCB3nuNWoXpqFFWdW0xJgSHnuo2FSpr3w=;
        b=RC++sZl2TjZ6RfhtmCt8hC8UAvsv3iGmBPK2058/GxOH+byFJlXu3uDLOz5/4tdj92
         N5jEzBAnvyPPUBOd7Q1UfjC2Ww+ApTETJ7U+9E9yEh9EihLm34HMDrvTnA0mgvksuS61
         uHrrRwliDSzXxtwiYmmABbBtoDRUuCaVqkVGU0+7vf9n8V8t59jzliN2gvWdOCX4lPgb
         sTq67CXQyMJuSJ/KXJxwInZmpJaQhEnqfyTQ+Yv06ep5qyYanUn3AhwwQ3j2R/Thwmn3
         srWmJYbSHN2MjKxyBzD+51dzmcNBA2vwLaKbAj4630PiOGmfh7e91VjImGIRxbk9y7iI
         08zw==
X-Gm-Message-State: AOJu0YyUMZIeCcgDBIM/9pp8epKhethBioF3ig8VHu6mYO0pSFGCBpnk
	TqCzyOS8CJ9f/r7AfPberwgDly5ufFdLPSo/88ddObfLITb2LYXd5ezXdh3pcoTHqxm7hDvOqKV
	ZKdo=
X-Google-Smtp-Source: AGHT+IFqNVYnArYk+twHJmSQHfnJdaVkEos88B/MvIHmAm9RRzeoZUVhApJsxhD4JTMYBt8CGBiqvA==
X-Received: by 2002:a50:870d:0:b0:572:5fff:accd with SMTP id 4fb4d7f45d1cf-5734d590348mr13417283a12.6.1715871317716;
        Thu, 16 May 2024 07:55:17 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:17 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 1/5] src/shared: Add initial implementation for an ASHA profile
Date: Thu, 16 May 2024 10:54:57 -0400
Message-ID: <20240516145501.134118-2-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145501.134118-1-arun@asymptotic.io>
References: <20240516145501.134118-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the server role for the Audio Streaming for Hearing Aid
specification[1]. Includes basic ability to probe the ASHA GATT service,
as well as starting/stopping streaming.

[1] https://source.android.com/docs/core/connect/bluetooth/asha
---
 Makefile.am                |   3 +-
 configure.ac               |   4 +
 lib/uuid.h                 |   3 +
 profiles/audio/media.c     |  30 +++
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c | 173 ++++++++++++-
 src/shared/asha.c          | 505 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h          |  73 ++++++
 8 files changed, 790 insertions(+), 3 deletions(-)
 create mode 100644 src/shared/asha.c
 create mode 100644 src/shared/asha.h

diff --git a/Makefile.am b/Makefile.am
index 05d02932f..3e6610017 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -238,7 +238,8 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bass.h src/shared/bass.c \
 			src/shared/ccp.h src/shared/ccp.c \
 			src/shared/lc3.h src/shared/tty.h \
-			src/shared/bap-defs.h
+			src/shared/bap-defs.h \
+			src/shared/asha.h src/shared/asha.c
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/configure.ac b/configure.ac
index 8b3cdb4e8..213e36b32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -216,6 +216,10 @@ AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
 
+AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
+		[disable ASHA support]), [enable_asha=${enableval}])
+AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/lib/uuid.h b/lib/uuid.h
index 8404b287e..479986f06 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -163,6 +163,9 @@ extern "C" {
 #define BAA_SERVICE					0x1851
 #define BAA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
 
+#define ASHA_SERVICE					0xFDF0
+#define ASHA_PROFILE_UUID	"0000FDF0-0000-1000-8000-00805f9b34fb"
+
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4bbd584de..b5644736a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -38,6 +38,7 @@
 #include "src/log.h"
 #include "src/error.h"
 #include "src/gatt-database.h"
+#include "src/shared/asha.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
@@ -88,6 +89,7 @@ struct endpoint_request {
 struct media_endpoint {
 	struct a2dp_sep		*sep;
 	struct bt_bap_pac	*pac;
+	struct bt_asha_device	*asha;
 	char			*sender;	/* Endpoint DBus bus id */
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
@@ -1330,6 +1332,12 @@ static bool endpoint_init_broadcast_sink(struct media_endpoint *endpoint,
 	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
 }
 
+static bool endpoint_init_asha(struct media_endpoint *endpoint,
+						int *err)
+{
+	return true;
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1454,6 +1462,11 @@ static bool experimental_bcast_sink_ep_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_asha_supported(struct btd_adapter *adapter)
+{
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static const struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1471,6 +1484,8 @@ static const struct media_endpoint_init {
 			experimental_broadcaster_ep_supported },
 	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
 			experimental_bcast_sink_ep_supported },
+	{ ASHA_PROFILE_UUID, endpoint_init_asha,
+			experimental_asha_supported },
 };
 
 static struct media_endpoint *
@@ -3393,3 +3408,18 @@ bool media_endpoint_is_broadcast(struct media_endpoint *endpoint)
 
 	return false;
 }
+
+const struct media_endpoint *media_endpoint_get_asha(void)
+{
+	/*
+	 * Because ASHA does not require the application to register an
+	 * endpoint, we need a minimal media_endpoint for transport creation to
+	 * work, so let's create one
+	 */
+	static struct media_endpoint asha_endpoint =  {
+		.uuid = ASHA_PROFILE_UUID,
+		.codec = 0x2, /* Currently on G.722 is defined by the spec */
+	};
+
+	return &asha_endpoint;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 2b579877b..2b2e8e157 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -24,3 +24,5 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
 bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
+
+const struct media_endpoint *media_endpoint_get_asha(void);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..7b8892203 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -32,6 +32,7 @@
 
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/asha.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/bap.h"
@@ -90,6 +91,10 @@ struct bap_transport {
 	guint			resume_id;
 };
 
+struct asha_transport {
+	uint16_t		delay;
+};
+
 struct media_transport_ops {
 	const char *uuid;
 	const GDBusPropertyTable *properties;
@@ -115,7 +120,7 @@ struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
 	struct btd_adapter	*adapter;	/* Transport adapter bcast*/
-	const char		*remote_endpoint; /* Transport remote SEP */
+	char			*remote_endpoint; /* Transport remote SEP */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
@@ -219,6 +224,9 @@ void media_transport_destroy(struct media_transport *transport)
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
 
+	if (transport->remote_endpoint)
+		g_free(transport->remote_endpoint);
+
 	g_free(path);
 }
 
@@ -1199,6 +1207,32 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ }
 };
 
+static gboolean get_asha_delay(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bt_asha_device *asha = transport->data;
+	uint16_t delay;
+
+	// Delay property is in 1/10ths of ms, while ASHA RenderDelay is in ms
+	delay = bt_asha_device_get_render_delay(asha) * 10;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &delay);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable transport_asha_properties[] = {
+	{ "Device", "o", get_device },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "State", "s", get_state },
+	{ "Delay", "q", get_asha_delay },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ }
+};
+
 static void transport_a2dp_destroy(void *data)
 {
 	struct a2dp_transport *a2dp = data;
@@ -1713,6 +1747,132 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
+static void asha_transport_sync_state(struct media_transport *transport,
+		struct bt_asha_device *asha)
+{
+	switch (bt_asha_device_get_state(asha)) {
+	case ASHA_STOPPED:
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+		break;
+	case ASHA_STARTING:
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
+		break;
+	case ASHA_STARTED:
+		transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+		break;
+	case ASHA_STOPPING:
+		transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
+		break;
+	}
+}
+
+static void asha_transport_state_cb(int status, void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct bt_asha_device *asha = transport->data;
+	enum bt_asha_state_t state;
+
+	state = bt_asha_device_get_state(asha);
+
+	if (state == ASHA_STARTED) {
+		int fd;
+		uint16_t imtu, omtu;
+		gboolean ret;
+
+		fd = bt_asha_device_get_fd(asha);
+		imtu = omtu = bt_asha_device_get_mtu(asha);
+
+		media_transport_set_fd(transport, fd, imtu, omtu);
+
+		owner->pending->id = 0;
+		ret = g_dbus_send_reply(btd_get_dbus_connection(),
+				owner->pending->msg,
+				DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_UINT16, &imtu,
+				DBUS_TYPE_UINT16, &omtu,
+				DBUS_TYPE_INVALID);
+		if (!ret) {
+			media_transport_remove_owner(transport);
+			return;
+		}
+
+		media_owner_remove(owner);
+	} else if (state == ASHA_STOPPED) {
+		if (owner->pending) {
+			owner->pending->id = 0;
+			media_request_reply(owner->pending, 0);
+			media_owner_remove(owner);
+		}
+
+		media_transport_remove_owner(transport);
+	}
+
+	asha_transport_sync_state(transport, asha);
+}
+
+static guint transport_asha_resume(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bt_asha_device *asha = transport->data;
+	guint ret;
+
+	ret = bt_asha_device_start(asha, asha_transport_state_cb, owner);
+	asha_transport_sync_state(transport, asha);
+
+	return ret;
+}
+
+static guint transport_asha_suspend(struct media_transport *transport,
+				struct media_owner *owner)
+{
+	struct bt_asha_device *asha = transport->data;
+	guint ret = 0;
+
+	if (owner) {
+		ret = bt_asha_device_stop(asha, asha_transport_state_cb, owner);
+		asha_transport_sync_state(transport, asha);
+	} else {
+		ret = bt_asha_device_stop(asha, NULL, NULL);
+		/* We won't have a callback to set the final state */
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	}
+
+	return ret;
+}
+
+static int8_t transport_asha_get_volume(struct media_transport *transport)
+{
+	struct bt_asha_device *asha = transport->data;
+	int8_t volume;
+	int scaled_volume;
+
+	volume = bt_asha_device_get_volume(asha);
+
+	/* Convert -128-0 to 0-127 */
+	scaled_volume = ((((int) volume) + 128) * 127) / 128;
+
+	return scaled_volume;
+}
+
+static int transport_asha_set_volume(struct media_transport *transport,
+					int8_t volume)
+{
+	struct bt_asha_device *asha = transport->data;
+	int scaled_volume;
+
+	/* Convert 0-127 to -128-0 */
+	scaled_volume = ((((int) volume) * 128) / 127) - 128;
+
+	return bt_asha_device_set_volume(asha, scaled_volume) ? 0 : -EIO;
+}
+
+static void *transport_asha_init(struct media_transport *transport, void *data)
+{
+	/* We just store the struct asha_device on the transport */
+	return data;
+}
+
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
 		      _get_volume, _set_volume, _destroy) \
@@ -1754,6 +1914,14 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 #define BAP_BC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
 
+#define ASHA_OPS(_uuid) \
+	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
+			transport_asha_init, \
+			transport_asha_resume, transport_asha_suspend, \
+			NULL, NULL, NULL, \
+			transport_asha_get_volume, transport_asha_set_volume, \
+			NULL)
+
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 			transport_a2dp_src_set_volume,
@@ -1765,6 +1933,7 @@ static const struct media_transport_ops transport_ops[] = {
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
 	BAP_BC_OPS(BAA_SERVICE_UUID),
+	ASHA_OPS(ASHA_PROFILE_UUID),
 };
 
 static const struct media_transport_ops *
@@ -1802,7 +1971,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->endpoint = endpoint;
 	transport->configuration = util_memdup(configuration, size);
 	transport->size = size;
-	transport->remote_endpoint = remote_endpoint;
+	transport->remote_endpoint = g_strdup(remote_endpoint);
 
 	if (device)
 		transport->path = g_strdup_printf("%s/fd%d",
diff --git a/src/shared/asha.c b/src/shared/asha.c
new file mode 100644
index 000000000..58987a7f2
--- /dev/null
+++ b/src/shared/asha.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Asymptotic Inc.
+ *
+ *  Author: Arun Raghavan <arun@asymptotic.io>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+
+#include "lib/bluetooth.h"
+#include "lib/l2cap.h"
+#include "lib/uuid.h"
+
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-db.h"
+#include "src/log.h"
+
+#include "asha.h"
+
+/* We use strings instead of uint128_t to maintain readability */
+#define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c902aad37bb"
+#define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937b0996cc0"
+#define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b56404837"
+#define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
+#define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
+
+/* 2 byte SDU length, 1 byte sequence number, and then 20ms of G.722 */
+#define ASHA_MTU 163
+
+struct bt_asha_device *bt_asha_device_new(void)
+{
+	struct bt_asha_device *asha;
+
+	asha = new0(struct bt_asha_device, 1);
+
+	return asha;
+}
+
+void bt_asha_device_reset(struct bt_asha_device *asha)
+{
+	if (asha->status_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->status_notify_id);
+	}
+
+	if (asha->volume_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->volume_notify_id);
+	}
+
+	gatt_db_unref(asha->db);
+	asha->db = NULL;
+
+	bt_gatt_client_unref(asha->client);
+	asha->client = NULL;
+
+	asha->psm = 0;
+}
+
+void bt_asha_state_reset(struct bt_asha_device *asha)
+{
+	close(asha->fd);
+	asha->fd = -1;
+
+	asha->state = ASHA_STOPPED;
+	asha->resume_id = 0;
+
+	asha->cb = NULL;
+	asha->cb_user_data = NULL;
+}
+
+void bt_asha_device_free(struct bt_asha_device *asha)
+{
+	gatt_db_unref(asha->db);
+	bt_gatt_client_unref(asha->client);
+	free(asha);
+}
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha)
+{
+	return asha->render_delay;
+}
+
+enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *asha)
+{
+	return asha->state;
+}
+
+int bt_asha_device_get_fd(struct bt_asha_device *asha)
+{
+	return asha->fd;
+}
+
+uint16_t bt_asha_device_get_mtu(struct bt_asha_device *asha)
+{
+	return ASHA_MTU;
+}
+
+static int asha_connect_socket(struct bt_asha_device *asha)
+{
+	int fd = 0, err;
+	struct sockaddr_l2 addr = { 0, };
+	struct l2cap_options opts;
+
+	fd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (fd < 0) {
+		error("Could not open L2CAP CoC socket: %s", strerror(errno));
+		goto error;
+	}
+
+	addr.l2_family = AF_BLUETOOTH;
+	addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
+
+	/*
+	 * We need to bind before connect to work around getting the wrong addr
+	 * type on older(?) kernels
+	 */
+	err = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		error("Could not bind L2CAP CoC socket: %s", strerror(errno));
+		goto error;
+	}
+
+	addr.l2_psm = asha->psm;
+	bacpy(&addr.l2_bdaddr, device_get_address(asha->device));
+
+	opts.mode = BT_MODE_LE_FLOWCTL;
+	opts.omtu = opts.imtu = ASHA_MTU;
+
+	err = setsockopt(fd, SOL_BLUETOOTH, BT_MODE, &opts.mode,
+							sizeof(opts.mode));
+	if (err < 0) {
+		error("Could not set L2CAP CoC socket flow control mode: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	err = setsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &opts.imtu,
+							sizeof(opts.imtu));
+	if (err < 0) {
+		error("Could not set L2CAP CoC socket receive MTU: %s",
+				strerror(errno));
+		/* Let this be non-fatal? */
+	}
+
+	err = connect(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		error("Could not connect L2CAP CoC socket: %s",
+							strerror(errno));
+		goto error;
+	}
+
+	DBG("L2CAP CoC socket is open");
+	return fd;
+
+error:
+	if (fd)
+		close(fd);
+	return -1;
+}
+
+static void asha_acp_sent(bool success, uint8_t err, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	if (success) {
+		DBG("AudioControlPoint command successfully sent");
+	} else {
+		error("Failed to send AudioControlPoint command: %d", err);
+
+		if (asha->cb)
+			asha->cb(-1, asha->cb_user_data);
+
+		bt_asha_state_reset(asha);
+	}
+}
+
+static int asha_send_acp(struct bt_asha_device *asha, uint8_t *cmd,
+		unsigned int len, bt_asha_cb_t cb, void *user_data)
+{
+	if (!bt_gatt_client_write_value(asha->client, asha->acp_handle, cmd,
+				len, asha_acp_sent, asha, NULL)) {
+		error("Error writing ACP start");
+		return -1;
+	}
+
+	asha->cb = cb;
+	asha->cb_user_data = user_data;
+
+	return 0;
+}
+
+unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data)
+{
+	uint8_t acp_start_cmd[] = {
+		0x01,		/* START */
+		0x01,		/* G.722, 16 kHz */
+		0,		/* Unknown media type */
+		asha->volume,	/* Volume */
+		0,		/* Other disconnected */
+	};
+	int ret;
+
+	if (asha->state != ASHA_STOPPED) {
+		error("ASHA device start failed. Bad state %d", asha->state);
+		return 0;
+	}
+
+	ret = asha_connect_socket(asha);
+	if (ret < 0)
+		return 0;
+
+	asha->fd = ret;
+
+	ret = asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
+			user_data);
+	if (ret < 0)
+		return 0;
+
+	asha->state = ASHA_STARTING;
+
+	return (++asha->resume_id);
+}
+
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data)
+{
+	uint8_t acp_stop_cmd[] = {
+		0x02, /* STOP */
+	};
+	int ret;
+
+	if (asha->state != ASHA_STARTED)
+		return 0;
+
+	asha->state = ASHA_STOPPING;
+
+	ret = asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), cb,
+			user_data);
+	if (ret < 0)
+		return 0;
+
+	return asha->resume_id;
+}
+
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha)
+{
+	return asha->volume;
+}
+
+bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volume)
+{
+	if (!bt_gatt_client_write_value(asha->client, asha->volume_handle,
+				(const uint8_t *)&volume, 1, NULL, NULL,
+				NULL)) {
+		error("Error writing ACP start");
+		return false;
+	}
+
+	asha->volume = volume;
+	return true;
+}
+
+static bool uuid_cmp(const char *uuid1, const bt_uuid_t *uuid2)
+{
+	bt_uuid_t lhs;
+
+	bt_string_to_uuid(&lhs, uuid1);
+
+	return bt_uuid_cmp(&lhs, uuid2) == 0;
+}
+
+static void read_psm(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	if (!success) {
+		DBG("Reading PSM failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 2) {
+		DBG("Reading PSM failed: unexpected length %u", length);
+		return;
+	}
+
+	asha->psm = get_le16(value);
+
+	DBG("Got PSM: %u", asha->psm);
+}
+
+static void read_rops(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	if (!success) {
+		DBG("Reading ROPs failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 17) {
+		DBG("Reading ROPs failed: unexpected length %u", length);
+		return;
+	}
+
+	if (value[0] != 0x01) {
+		DBG("Unexpected ASHA version: %u", value[0]);
+		return;
+	}
+
+	/* Device Capabilities */
+	asha->right_side = (value[1] & 0x1) != 0;
+	asha->binaural = (value[1] & 0x2) != 0;
+	asha->csis_supported = (value[1] & 0x4) != 0;
+	/* HiSyncId: 2 byte company id, 6 byte ID shared by left and right */
+	memcpy(asha->hisyncid, &value[2], 8);
+	/* FeatureMap */
+	asha->coc_streaming_supported = (value[10] & 0x1) != 0;
+	/* RenderDelay */
+	asha->render_delay = get_le16(&value[11]);
+	/* byte 13 & 14 are reserved */
+	/* Codec IDs */
+	asha->codec_ids = get_le16(&value[15]);
+
+	DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: %u",
+			asha->right_side, asha->binaural, asha->csis_supported,
+			asha->render_delay, asha->codec_ids);
+}
+
+static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+	uint8_t status = *value;
+	/* Back these up to survive the reset paths */
+	bt_asha_cb_t cb = asha->cb;
+	bt_asha_cb_t cb_user_data = asha->cb_user_data;
+
+	if (asha->state == ASHA_STARTING) {
+		if (status == 0) {
+			asha->state = ASHA_STARTED;
+			DBG("ASHA start complete");
+		} else {
+			bt_asha_state_reset(asha);
+			DBG("ASHA start failed");
+		}
+	} else if (asha->state == ASHA_STOPPING) {
+		/* We reset our state, regardless */
+		bt_asha_state_reset(asha);
+		DBG("ASHA stop %s", status == 0 ? "complete" : "failed");
+	}
+
+	if (cb) {
+		cb(status, cb_user_data);
+		asha->cb = NULL;
+		asha->cb_user_data = NULL;
+	}
+}
+
+static void read_volume(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	if (!success) {
+		DBG("Reading volume failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 2) {
+		DBG("Reading volume failed: unexpected length %u", length);
+		return;
+	}
+
+	asha->volume = get_s8(value);
+
+	DBG("Got volume: %d", asha->volume);
+}
+
+static void volume_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	asha->volume = get_s8(value);
+
+	DBG("Volume changed: %d", asha->volume);
+}
+
+static void handle_characteristic(struct gatt_db_attribute *attr,
+								void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL,
+								NULL, &uuid)) {
+		error("Failed to obtain characteristic data");
+		return;
+	}
+
+	if (uuid_cmp(ASHA_CHRC_LE_PSM_OUT_UUID, &uuid)) {
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_psm, asha, NULL))
+			DBG("Failed to send request to read battery level");
+	} else if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) {
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_rops, asha, NULL))
+			DBG("Failed to send request for readonly properties");
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
+		/* Store this for later writes */
+		asha->acp_handle = value_handle;
+	} else if (uuid_cmp(ASHA_CHRC_VOLUME_UUID, &uuid)) {
+		/* Store this for later reads and writes */
+		asha->volume_handle = value_handle;
+		asha->volume_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, NULL, volume_notify, asha,
+				NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify volume");
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_volume, asha, NULL))
+			DBG("Failed to send request to volume");
+	} else if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
+		asha->status_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, NULL, audio_status_notify, asha,
+				NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify AudioStatus");
+	} else {
+		char uuid_str[MAX_LEN_UUID_STR];
+
+		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
+		DBG("Unsupported characteristic: %s", uuid_str);
+	}
+}
+
+static void foreach_asha_service(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	struct bt_asha_device *asha = user_data;
+
+	DBG("Found ASHA GATT service");
+
+	asha->attr = attr;
+	gatt_db_service_foreach_char(asha->attr, handle_characteristic, asha);
+}
+
+bool bt_asha_device_probe(struct bt_asha_device *asha)
+{
+	struct btd_device *device = asha->device;
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	bt_uuid_t asha_uuid;
+
+	asha->db = gatt_db_ref(db);
+	asha->client = bt_gatt_client_clone(client);
+
+	bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
+	gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
+
+	if (!asha->attr) {
+		error("ASHA attribute not found");
+		bt_asha_device_reset(asha);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/asha.h b/src/shared/asha.h
new file mode 100644
index 000000000..475e9e16c
--- /dev/null
+++ b/src/shared/asha.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2024  Asymptotic Inc.
+ *
+ *  Author: Arun Raghavan <arun@asymptotic.io>
+ *
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+struct bt_asha_device;
+
+enum bt_asha_state_t {
+	ASHA_STOPPED = 0,
+	ASHA_STARTING,
+	ASHA_STARTED,
+	ASHA_STOPPING,
+};
+
+typedef void (*bt_asha_cb_t)(int status, void *data);
+
+struct bt_asha_device {
+	struct btd_device *device;
+	struct bt_gatt_client *client;
+	struct gatt_db *db;
+	struct gatt_db_attribute *attr;
+	uint16_t acp_handle;
+	uint16_t volume_handle;
+	unsigned int status_notify_id;
+	unsigned int volume_notify_id;
+
+	uint16_t psm;
+	bool right_side;
+	bool binaural;
+	bool csis_supported;
+	bool coc_streaming_supported;
+	uint8_t hisyncid[8];
+	uint16_t render_delay;
+	uint16_t codec_ids;
+	int8_t volume;
+
+	struct media_transport *transport;
+	int fd;
+	enum bt_asha_state_t state;
+	bt_asha_cb_t cb;
+	void *cb_user_data;
+	int resume_id;
+};
+
+struct bt_asha_device *bt_asha_device_new(void);
+void bt_asha_device_reset(struct bt_asha_device *asha);
+void bt_asha_state_reset(struct bt_asha_device *asha);
+void bt_asha_device_free(struct bt_asha_device *asha);
+
+uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha);
+enum bt_asha_state_t bt_asha_device_get_state(struct bt_asha_device *asha);
+int bt_asha_device_get_fd(struct bt_asha_device *asha);
+uint16_t bt_asha_device_get_mtu(struct bt_asha_device *asha);
+
+unsigned int bt_asha_device_start(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data);
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha, bt_asha_cb_t cb,
+		void *user_data);
+
+int8_t bt_asha_device_get_volume(struct bt_asha_device *asha);
+bool bt_asha_device_set_volume(struct bt_asha_device *asha, int8_t volume);
+
+bool bt_asha_device_probe(struct bt_asha_device *asha);
-- 
2.45.0

