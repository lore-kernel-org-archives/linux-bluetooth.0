Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62136F414
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328523; cv=none; b=aRZGxdJ4Rf0jtBXehBZjJXYHBFQfUYIxyofqGwpRkNKeWJ3fKX3WKgjqpL/OGoEACi4quYUO/8hlV8qIbLkP6cROMWDZyIWt35JRkh6VYPIzwl7Ve4yf2AWfXqsAw8M5Yo0LJyaKFq/YdCvCY1SV2fkAQwntB5eGa1dQtkPYwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328523; c=relaxed/simple;
	bh=2v8fZUXiraVq9JY/vAjAC/c1tTfWlxdRtLGHkxeYYqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLXfLpxh4nmlErWEg1E/uX2ovthKwvhl0924lmjfyRm2KbqJgTcV+r3jz8YBzaIV+DraIicW9Ud1h739sUbttb7j+pQkcg1K0F398mRMAgu2Obf2xevNKkdTMzDYA/PyzET5zREsEJmWHQMCXGGS+7lg6AblpciavRlnXow2wS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=sXKdWlTw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="sXKdWlTw"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a422090b14so1836570a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787328517; x=1787933317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eCI4Lp/ZfnAkbbYcD7Xaq28ncvUWirQQnz2uwlXJ0c=;
        b=sXKdWlTwKfwM465SsSs19CcS/Sd4W/qvgyYWEl0dQaD6vIShVkzR81GTO8BDymVZXY
         qmRlAqjN451Pt9/4FZsFqI4kpOmiGGuUC6J/KUa+zHMfXc+AB2Ve1pUXx64N7SCejvdG
         K1PFNIDRNlgWSUm0ClxrhtnwmON0HrUdgq2vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328517; x=1787933317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0eCI4Lp/ZfnAkbbYcD7Xaq28ncvUWirQQnz2uwlXJ0c=;
        b=CKi62msEAVOxcfkKTGnpX03ql5EzFSyRTwUDQWqaYj0DsVspuH56UKdTmfyNFnKE+v
         ffX6Aa2VDTuMDL3r/FvDQW7NL+rOdcWeLjWmDnERLrrDfvohgrknnLZN8T8+//LD2DWn
         C6HtVocFLh3voXBeHSlTQzqCedah96Q4+b45vHLXy4RaNffezpvDM/Gke+b/yL49Wx5e
         QT5DUEsTESO10VqXjPZgKTg5obSMXIaz7EkqdCosKF6z2Gr12N7vaUNYubJ4weucZ/m0
         7x+KY2/2+w6g/+cdkxovb9ptFxFcoU67VfZwd9xflO0Ebn6M9RqQ9njVoHqlhtQStIxN
         e88g==
X-Gm-Message-State: AFuF++nYSHfXhXKHT9LHMVlEaB40C4RSdKWq2Brdyoagw8Iz4Rrx+W/o
	CGIQSgMNREU3JgCUMmIFwUXaYQQmocLazH/iqv6sOvBwuHAyoUmgesxUJ3I51X21sb5W4wdsctG
	0XUa5Gd0=
X-Gm-Gg: AR+sD11lbXG1u6CNXUFDq7ndGEVeGPnICc3W5u+4MKExCt9N6y2Ml24xeb/NDs/Pkrf
	XUvj8bUoqhW9IaUW70zYVTtwMs5zW0Xt9Qxi3iXs1dA/uG41KCXaBSBAQ+ShqN6LZoH9KrZcODR
	tB+Tk1Yda2Vvjd7CBMExdwK0ab/c1GfM6G1teqIMr583MMjyLaVcag29pjG3fcn9r418IqZG9q6
	7VlAK2rPhLLTQItgASgxmHyELFVtRRQmVNpKK4NNMJ68j1Qa5ul7xVmr2sYWyBd3TJA/wD4Je7o
	l6WKQvcKioL/f+qlbilUt1iL6ZoR5qvq3+KNAGZGejtSjdzDF8dYqzvv3NTil7dB2woS5AXKhqi
	aP3O38OXCl2fkzp1x8IM0rTeMnM9Zvd6d3U8e2vThmPmtfb86kWXPqbH+HAZUToYoPXMycMr9E8
	so/G5gqRUhO0Gg2GO0d2Urc9k+0OBvu3lp3hezhvwf5ntyIOlslVawfTnykx/0RwkjQxTix2pfO
	eFSQug+3cF2sKhbdC54j9faUTPaeCzjZVh98F1dBIT+PYPlDb7eRpzxKNc7Gx43x+har23rHfdF
	zfWzvYL2Cp6x5DgjDQWKFwZKC6y4F7o3cuV0mCr0ZxJO3drpeORKiys0l4jxTeSeyzoaDxzZi9U
	IPuBCvl8IcPmsGfSQaC22V65jrrpeZ8TroIWPVIuIEZI07kE=
X-Received: by 2002:a17:906:9fc1:b0:c24:42b1:3092 with SMTP id a640c23a62f3a-c246a6c5e89mr687127066b.15.1787328517021;
        Fri, 21 Aug 2026 09:08:37 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df29esm471299366b.47.2026.08.21.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:08:36 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 3/4] fastpair: Add Message Stream battery profile
Date: Fri, 21 Aug 2026 18:08:02 +0200
Message-ID: <2265ad3658e0f56472ddf0f3396e79e01ef8ea88.1787327795.git.m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787327795.git.m.kurz@irregular.at>
References: <cover.1787327795.git.m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect to the experimental Fast Pair Message Stream service advertised by
compatible BR/EDR devices and parse its 16-bit-length framed messages.

The Message Stream specification defines a fixed endpoint UUID over RFCOMM
and a separate L2CAP PSM transport. This implementation supports the RFCOMM
variant; L2CAP support is left for future work:

https://developers.google.com/nearby/fast-pair/specifications/extensions/messagestream

Publish left, right, and case values as component Battery1 objects. The
Device Information extension defines the battery update message. Its three
component bytes use the Battery Notification encoding:

https://developers.google.com/nearby/fast-pair/specifications/extensions/deviceinformation
https://developers.google.com/nearby/fast-pair/specifications/extensions/batterynotification

Include unknown percentage and charging-state transitions. Decode unknown
levels using the generic Battery Notification status bit while treating the
TWS-specific case value 0xff as unavailable, as required for hearables:

https://developers.google.com/nearby/fast-pair/specifications/devicefeaturerequirement/devicefeaturerequirement_hearables

If only the Message Stream is lost, invalidate its values and reconnect.
Use exponential backoff and reset it only after a battery-producing stream
remains stable. Remove the objects once the BR/EDR bearer disappears.

Keep pending connection callbacks alive through cancellation and ignore
callbacks for detached or superseded channels.

Assisted-by: Codex:gpt-5.6-sol
---
 .gitignore                         |   1 +
 Makefile.am                        |   8 +
 Makefile.plugins                   |   5 +
 doc/test-coverage.txt              |   3 +-
 profiles/fastpair/fastpair.c       | 650 +++++++++++++++++++++++++++++
 profiles/fastpair/message-stream.c | 135 ++++++
 profiles/fastpair/message-stream.h |  58 +++
 unit/test-fastpair.c               | 322 ++++++++++++++
 8 files changed, 1181 insertions(+), 1 deletion(-)
 create mode 100644 profiles/fastpair/fastpair.c
 create mode 100644 profiles/fastpair/message-stream.c
 create mode 100644 profiles/fastpair/message-stream.h
 create mode 100644 unit/test-fastpair.c

diff --git a/.gitignore b/.gitignore
index c5efe8536..76612904f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,7 @@ unit/test-hog
 unit/test-bap
 unit/test-bass
 unit/test-battery
+unit/test-fastpair
 unit/test-tmap
 unit/test-gmap
 unit/test-mcp
diff --git a/Makefile.am b/Makefile.am
index 2754e1b7f..7771feaaa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -799,6 +799,14 @@ unit_test_battery_SOURCES = unit/test-battery.c
 unit_test_battery_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-fastpair
+
+unit_test_fastpair_SOURCES = unit/test-fastpair.c \
+			profiles/fastpair/message-stream.h \
+			profiles/fastpair/message-stream.c
+unit_test_fastpair_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 unit_tests += unit/test-rap
 
 unit_test_rap_SOURCES = unit/test-rap.c $(btio_sources)
diff --git a/Makefile.plugins b/Makefile.plugins
index ac667beda..4b41510f0 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -88,6 +88,11 @@ endif
 builtin_modules += battery
 builtin_sources += profiles/battery/battery.c
 
+builtin_modules += fastpair
+builtin_sources += profiles/fastpair/fastpair.c \
+			profiles/fastpair/message-stream.h \
+			profiles/fastpair/message-stream.c
+
 builtin_modules += rap
 builtin_sources += profiles/ranging/rap.c \
 		profiles/ranging/rap_hci.c
diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index b92a2ae59..6b62c6e60 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -31,8 +31,9 @@ test-gdbus-client	  13	D-Bus client handling
 test-gatt		 180	GATT qualification test cases
 test-hog		   6	HID Over GATT qualification test cases
 test-battery		  10	Battery charge test cases
+test-fastpair		   7	Fast Pair Message Stream parsing
 			-----
-			 771
+			 778
 
 
 Automated end-to-end testing
diff --git a/profiles/fastpair/fastpair.c b/profiles/fastpair/fastpair.c
new file mode 100644
index 000000000..b879ea28a
--- /dev/null
+++ b/profiles/fastpair/fastpair.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Matthias Kurz
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
+#include "bluetooth/uuid.h"
+
+#include "btio/btio.h"
+#include "src/adapter.h"
+#include "src/battery.h"
+#include "src/device.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/service.h"
+
+#include "message-stream.h"
+
+#define FASTPAIR_BATTERY_SOURCE "Fast Pair Message Stream"
+#define FASTPAIR_RECONNECT_MIN 1
+#define FASTPAIR_RECONNECT_MAX 60
+
+struct fastpair {
+	int ref_count;
+	struct btd_service *service;
+	GIOChannel *io;
+	guint io_id;
+	guint reconnect_id;
+	guint disconnect_id;
+	unsigned int reconnect_delay;
+	gint64 connected_since;
+	bool handling_bredr_disconnect;
+	bool battery_update_received;
+	struct fastpair_message_stream *stream;
+	struct btd_battery *batteries[FASTPAIR_BATTERY_COUNT];
+	bool registration_failed[FASTPAIR_BATTERY_COUNT];
+};
+
+static unsigned int service_state_id;
+
+static const char *battery_identifiers[FASTPAIR_BATTERY_COUNT] = {
+	[FASTPAIR_BATTERY_LEFT] = "left",
+	[FASTPAIR_BATTERY_RIGHT] = "right",
+	[FASTPAIR_BATTERY_CASE] = "case",
+};
+
+static struct fastpair *fastpair_ref(struct fastpair *fastpair)
+{
+	__sync_fetch_and_add(&fastpair->ref_count, 1);
+
+	return fastpair;
+}
+
+static void fastpair_unref(void *data)
+{
+	struct fastpair *fastpair = data;
+
+	if (__sync_sub_and_fetch(&fastpair->ref_count, 1))
+		return;
+
+	g_free(fastpair);
+}
+
+static void fastpair_cancel_reconnect(struct fastpair *fastpair)
+{
+	if (!fastpair->reconnect_id)
+		return;
+
+	g_source_remove(fastpair->reconnect_id);
+	fastpair->reconnect_id = 0;
+}
+
+static void fastpair_unregister_batteries(struct fastpair *fastpair)
+{
+	unsigned int i;
+
+	for (i = 0; i < FASTPAIR_BATTERY_COUNT; i++) {
+		if (!fastpair->batteries[i])
+			continue;
+
+		btd_battery_unregister(fastpair->batteries[i]);
+		fastpair->batteries[i] = NULL;
+	}
+
+	memset(fastpair->registration_failed, 0,
+					sizeof(fastpair->registration_failed));
+}
+
+static void fastpair_invalidate_batteries(struct fastpair *fastpair)
+{
+	unsigned int i;
+
+	for (i = 0; i < FASTPAIR_BATTERY_COUNT; i++) {
+		if (!fastpair->batteries[i])
+			continue;
+
+		btd_battery_update(fastpair->batteries[i],
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+		btd_battery_update_charging(fastpair->batteries[i],
+					FASTPAIR_BATTERY_CHARGING_UNKNOWN);
+	}
+}
+
+static void fastpair_handle_bredr_disconnect(struct fastpair *fastpair);
+
+static void fastpair_device_disconnected(struct btd_device *device,
+					 gboolean removal, void *user_data)
+{
+	struct fastpair *fastpair = user_data;
+
+	DBG("%s disconnected%s", device_get_path(device),
+					removal ? " and removed" : "");
+
+	fastpair->disconnect_id = 0;
+	fastpair_handle_bredr_disconnect(fastpair);
+}
+
+static void fastpair_watch_disconnect(struct fastpair *fastpair)
+{
+	struct btd_device *device;
+
+	if (fastpair->handling_bredr_disconnect || fastpair->disconnect_id)
+		return;
+
+	device = btd_service_get_device(fastpair->service);
+	fastpair->disconnect_id = device_add_disconnect_watch(device,
+					fastpair_device_disconnected,
+					fastpair, NULL);
+}
+
+static void fastpair_unwatch_disconnect(struct fastpair *fastpair)
+{
+	struct btd_device *device;
+
+	if (!fastpair->disconnect_id)
+		return;
+
+	device = btd_service_get_device(fastpair->service);
+	device_remove_disconnect_watch(device, fastpair->disconnect_id);
+	fastpair->disconnect_id = 0;
+}
+
+static void fastpair_reset_connection(struct fastpair *fastpair)
+{
+	fastpair_cancel_reconnect(fastpair);
+
+	if (fastpair->io_id) {
+		g_source_remove(fastpair->io_id);
+		fastpair->io_id = 0;
+	}
+
+	if (fastpair->io) {
+		g_io_channel_shutdown(fastpair->io, TRUE, NULL);
+		g_io_channel_unref(fastpair->io);
+		fastpair->io = NULL;
+	}
+
+	fastpair_message_stream_free(fastpair->stream);
+	fastpair->stream = NULL;
+	fastpair->connected_since = 0;
+	fastpair->battery_update_received = false;
+}
+
+static bool fastpair_stream_was_stable(struct fastpair *fastpair)
+{
+	gint64 duration;
+
+	if (!fastpair->battery_update_received || !fastpair->connected_since)
+		return false;
+
+	duration = g_get_monotonic_time() - fastpair->connected_since;
+
+	return duration >= (gint64) FASTPAIR_RECONNECT_MAX *
+							G_USEC_PER_SEC;
+}
+
+static void fastpair_handle_bredr_disconnect(struct fastpair *fastpair)
+{
+	btd_service_state_t state;
+
+	if (fastpair->handling_bredr_disconnect)
+		return;
+
+	fastpair->handling_bredr_disconnect = true;
+	state = fastpair->service ? btd_service_get_state(fastpair->service) :
+						BTD_SERVICE_STATE_UNAVAILABLE;
+
+	fastpair_reset_connection(fastpair);
+
+	if (state == BTD_SERVICE_STATE_CONNECTING)
+		btd_service_connecting_complete(fastpair->service, -ENOTCONN);
+	else if (state == BTD_SERVICE_STATE_CONNECTED ||
+			state == BTD_SERVICE_STATE_DISCONNECTING)
+		btd_service_disconnecting_complete(fastpair->service, 0);
+
+	fastpair->reconnect_delay = FASTPAIR_RECONNECT_MIN;
+	fastpair_unregister_batteries(fastpair);
+	fastpair->handling_bredr_disconnect = false;
+}
+
+static void fastpair_schedule_reconnect(struct fastpair *fastpair);
+
+static bool fastpair_connection_error_is_transient(int err)
+{
+	switch (err) {
+	case -ECONNABORTED:
+	case -ENOENT:
+	case -ENOTSUP:
+	case -EPROTO:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static gboolean fastpair_auto_connect(gpointer user_data)
+{
+	struct fastpair *fastpair = user_data;
+	struct btd_device *device;
+	btd_service_state_t state;
+	int err;
+
+	fastpair->reconnect_id = 0;
+	if (!fastpair->service)
+		return FALSE;
+
+	device = btd_service_get_device(fastpair->service);
+	state = btd_service_get_state(fastpair->service);
+
+	if (!btd_device_bdaddr_type_connected(device, BDADDR_BREDR)) {
+		fastpair_handle_bredr_disconnect(fastpair);
+		return FALSE;
+	}
+
+	if (state != BTD_SERVICE_STATE_DISCONNECTED)
+		return FALSE;
+
+	err = btd_service_connect(fastpair->service);
+	if (err < 0 && err != -EALREADY) {
+		DBG("unable to auto-connect Message Stream: %s",
+		    strerror(-err));
+		if (fastpair_connection_error_is_transient(err))
+			fastpair_schedule_reconnect(fastpair);
+	}
+
+	return FALSE;
+}
+
+static void fastpair_schedule_connect(struct fastpair *fastpair,
+						unsigned int delay)
+{
+	struct btd_device *device;
+	btd_service_state_t state;
+
+	if (!fastpair->service || fastpair->reconnect_id)
+		return;
+
+	device = btd_service_get_device(fastpair->service);
+	state = btd_service_get_state(fastpair->service);
+
+	if (!device_is_paired(device, BDADDR_BREDR) ||
+			!btd_device_bdaddr_type_connected(device,
+							BDADDR_BREDR) ||
+			(state != BTD_SERVICE_STATE_UNAVAILABLE &&
+			 state != BTD_SERVICE_STATE_DISCONNECTED))
+		return;
+
+	if (delay)
+		fastpair->reconnect_id = g_timeout_add_seconds(
+					delay, fastpair_auto_connect, fastpair);
+	else
+		fastpair->reconnect_id = g_idle_add(fastpair_auto_connect,
+								fastpair);
+}
+
+static void fastpair_schedule_auto_connect(struct fastpair *fastpair)
+{
+	fastpair_schedule_connect(fastpair, 0);
+}
+
+static void fastpair_schedule_reconnect(struct fastpair *fastpair)
+{
+	unsigned int delay = fastpair->reconnect_delay;
+
+	fastpair_schedule_connect(fastpair, delay);
+	if (!fastpair->reconnect_id || delay >= FASTPAIR_RECONNECT_MAX)
+		return;
+
+	fastpair->reconnect_delay = MIN(delay * 2,
+						FASTPAIR_RECONNECT_MAX);
+}
+
+static void fastpair_service_state_cb(struct btd_service *service,
+				      btd_service_state_t old_state,
+				      btd_service_state_t new_state,
+				      void *user_data)
+{
+	struct btd_device *device;
+	struct btd_service *fastpair_service;
+	struct fastpair *fastpair;
+
+	device = btd_service_get_device(service);
+	fastpair_service = btd_device_get_service(device,
+						FASTPAIR_MESSAGE_STREAM_UUID);
+	if (!fastpair_service)
+		return;
+
+	fastpair = btd_service_get_user_data(fastpair_service);
+	if (!fastpair)
+		return;
+
+	/*
+	 * A disconnect watch can run before the connected services settle and
+	 * is not invoked again. Use service transitions as a fallback once the
+	 * BR/EDR bearer itself is gone.
+	 */
+	if (!btd_device_bdaddr_type_connected(device, BDADDR_BREDR)) {
+		if (new_state == BTD_SERVICE_STATE_UNAVAILABLE ||
+				new_state == BTD_SERVICE_STATE_DISCONNECTED)
+			fastpair_handle_bredr_disconnect(fastpair);
+		return;
+	}
+
+	if (new_state != BTD_SERVICE_STATE_CONNECTED)
+		return;
+
+	/*
+	 * Disconnect watches are one-shot, so restore ours after reconnection.
+	 */
+	fastpair_watch_disconnect(fastpair);
+
+	if (fastpair_service != service)
+		fastpair_schedule_auto_connect(fastpair);
+}
+
+static void fastpair_update_batteries(struct fastpair *fastpair,
+					      const uint8_t *payload,
+					      uint16_t length)
+{
+	struct fastpair_battery values[FASTPAIR_BATTERY_COUNT];
+	struct btd_device *device;
+	const char *path;
+	unsigned int i;
+
+	if (!fastpair_message_get_batteries(
+			FASTPAIR_DEVICE_INFORMATION_GROUP,
+			FASTPAIR_BATTERY_UPDATE_CODE, payload, length, values))
+		return;
+
+	fastpair->battery_update_received = true;
+
+	device = btd_service_get_device(fastpair->service);
+	path = device_get_path(device);
+
+	for (i = 0; i < FASTPAIR_BATTERY_COUNT; i++) {
+		if (!fastpair->batteries[i] &&
+					!fastpair->registration_failed[i]) {
+			fastpair->batteries[i] = btd_battery_register_component(
+						path, battery_identifiers[i],
+						FASTPAIR_BATTERY_SOURCE);
+			if (!fastpair->batteries[i])
+				fastpair->registration_failed[i] = true;
+		}
+
+		if (!fastpair->batteries[i])
+			continue;
+
+		btd_battery_update(fastpair->batteries[i],
+					values[i].percentage);
+		btd_battery_update_charging(fastpair->batteries[i],
+						values[i].charging);
+	}
+}
+
+static void fastpair_message(uint8_t group, uint8_t code,
+			     const uint8_t *payload, uint16_t length,
+			     void *user_data)
+{
+	struct fastpair *fastpair = user_data;
+
+	DBG("group 0x%02x code 0x%02x length %u", group, code, length);
+
+	if (group != FASTPAIR_DEVICE_INFORMATION_GROUP ||
+			code != FASTPAIR_BATTERY_UPDATE_CODE)
+		return;
+
+	fastpair_update_batteries(fastpair, payload, length);
+}
+
+static void fastpair_disconnected(struct fastpair *fastpair, int err,
+						bool reconnect)
+{
+	struct btd_device *device;
+	btd_service_state_t state;
+	bool bredr_connected;
+	bool stream_was_stable;
+
+	if (!fastpair->service) {
+		fastpair_reset_connection(fastpair);
+		return;
+	}
+
+	device = btd_service_get_device(fastpair->service);
+	state = btd_service_get_state(fastpair->service);
+	bredr_connected = btd_device_bdaddr_type_connected(device,
+							BDADDR_BREDR);
+	if (!bredr_connected) {
+		fastpair_handle_bredr_disconnect(fastpair);
+		return;
+	}
+
+	stream_was_stable = fastpair_stream_was_stable(fastpair);
+	fastpair_reset_connection(fastpair);
+
+	if (state == BTD_SERVICE_STATE_CONNECTING)
+		btd_service_connecting_complete(fastpair->service, err);
+	else if (state == BTD_SERVICE_STATE_CONNECTED ||
+			state == BTD_SERVICE_STATE_DISCONNECTING)
+		btd_service_disconnecting_complete(fastpair->service, 0);
+
+	/* Short battery-producing sessions must continue backing off. */
+	if (stream_was_stable)
+		fastpair->reconnect_delay = FASTPAIR_RECONNECT_MIN;
+
+	fastpair_invalidate_batteries(fastpair);
+	if (reconnect)
+		fastpair_schedule_reconnect(fastpair);
+}
+
+static gboolean fastpair_io_cb(GIOChannel *io, GIOCondition condition,
+				       gpointer user_data)
+{
+	struct fastpair *fastpair = user_data;
+	uint8_t buffer[4096];
+	ssize_t len;
+	int fd;
+
+	if (condition & G_IO_IN) {
+		fd = g_io_channel_unix_get_fd(io);
+
+		do {
+			len = read(fd, buffer, sizeof(buffer));
+		} while (len < 0 && errno == EINTR);
+
+		if (len > 0) {
+			if (!fastpair_message_stream_feed(fastpair->stream,
+							buffer, len)) {
+				error("Invalid Fast Pair Message Stream frame");
+				goto failed;
+			}
+		} else if (!len) {
+			goto failed;
+		} else if (errno != EAGAIN && errno != EWOULDBLOCK) {
+			error("Fast Pair Message Stream read failed: %s",
+							strerror(errno));
+			goto failed;
+		}
+	}
+
+	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	return TRUE;
+
+failed:
+	fastpair->io_id = 0;
+	fastpair_disconnected(fastpair, -EIO, true);
+	return FALSE;
+}
+
+static void fastpair_connect_cb(GIOChannel *io, GError *err,
+				gpointer user_data)
+{
+	struct fastpair *fastpair = user_data;
+
+	/* A closed pending channel can still dispatch its btio source. */
+	if (!fastpair->service || fastpair->io != io)
+		return;
+
+	if (err) {
+		error("Fast Pair Message Stream connection failed: %s",
+							err->message);
+		fastpair_disconnected(fastpair, -EIO, true);
+		return;
+	}
+
+	fastpair->stream = fastpair_message_stream_new(fastpair_message,
+							fastpair);
+	if (!fastpair->stream) {
+		fastpair_disconnected(fastpair, -ENOMEM, true);
+		return;
+	}
+	fastpair->connected_since = g_get_monotonic_time();
+
+	fastpair->io_id = g_io_add_watch(io,
+			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			fastpair_io_cb, fastpair);
+	memset(fastpair->registration_failed, 0,
+					sizeof(fastpair->registration_failed));
+	btd_service_connecting_complete(fastpair->service, 0);
+}
+
+static int fastpair_connect(struct btd_service *service)
+{
+	struct fastpair *fastpair = btd_service_get_user_data(service);
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	const sdp_record_t *record;
+	sdp_list_t *protos;
+	GError *err = NULL;
+	GIOChannel *io;
+	int channel;
+
+	if (fastpair->io)
+		return -EALREADY;
+
+	record = btd_device_get_record(device, FASTPAIR_MESSAGE_STREAM_UUID);
+	if (!record)
+		return -ENOENT;
+
+	if (sdp_get_access_protos(record, &protos) < 0) {
+		error("Unable to get Fast Pair access protocols");
+		return -EPROTO;
+	}
+
+	channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+	if (channel <= 0) {
+		error("Unable to get Fast Pair RFCOMM channel");
+		return -EPROTO;
+	}
+
+	/* Keep the callback context alive until btio destroys its source. */
+	fastpair_ref(fastpair);
+	io = bt_io_connect(fastpair_connect_cb, fastpair, fastpair_unref, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(adapter),
+			BT_IO_OPT_DEST_BDADDR, device_get_address(device),
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+			BT_IO_OPT_CHANNEL, channel,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		fastpair_unref(fastpair);
+		error("Unable to start Fast Pair connection: %s",
+				err ? err->message : strerror(EIO));
+		g_clear_error(&err);
+		return -EIO;
+	}
+
+	fastpair->io = io;
+
+	return 0;
+}
+
+static int fastpair_disconnect(struct btd_service *service)
+{
+	struct fastpair *fastpair = btd_service_get_user_data(service);
+
+	if (!fastpair->io)
+		return -ENOTCONN;
+
+	fastpair_disconnected(fastpair, 0, false);
+
+	return 0;
+}
+
+static int fastpair_probe(struct btd_service *service)
+{
+	struct fastpair *fastpair;
+
+	fastpair = g_new0(struct fastpair, 1);
+	fastpair->ref_count = 1;
+	fastpair->service = service;
+	fastpair->reconnect_delay = FASTPAIR_RECONNECT_MIN;
+	btd_service_set_user_data(service, fastpair);
+	fastpair_watch_disconnect(fastpair);
+	fastpair_schedule_auto_connect(fastpair);
+
+	return 0;
+}
+
+static void fastpair_remove(struct btd_service *service)
+{
+	struct fastpair *fastpair = btd_service_get_user_data(service);
+
+	btd_service_set_user_data(service, NULL);
+	fastpair_unwatch_disconnect(fastpair);
+	fastpair->service = NULL;
+	fastpair_reset_connection(fastpair);
+	fastpair_unregister_batteries(fastpair);
+	fastpair_unref(fastpair);
+}
+
+static struct btd_profile fastpair_profile = {
+	.name		= "fastpair",
+	.priority	= BTD_PROFILE_PRIORITY_LOW,
+	.bearer		= BTD_PROFILE_BEARER_BREDR,
+	.remote_uuid	= FASTPAIR_MESSAGE_STREAM_UUID,
+	.auto_connect	= true,
+	.experimental	= true,
+	.device_probe	= fastpair_probe,
+	.device_remove	= fastpair_remove,
+	.connect	= fastpair_connect,
+	.disconnect	= fastpair_disconnect,
+};
+
+static int fastpair_init(void)
+{
+	int err;
+
+	err = btd_profile_register(&fastpair_profile);
+	if (err < 0)
+		return err;
+
+	service_state_id = btd_service_add_state_cb(fastpair_service_state_cb,
+								NULL);
+
+	return 0;
+}
+
+static void fastpair_exit(void)
+{
+	btd_service_remove_state_cb(service_state_id);
+	btd_profile_unregister(&fastpair_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(fastpair, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			fastpair_init, fastpair_exit)
diff --git a/profiles/fastpair/message-stream.c b/profiles/fastpair/message-stream.c
new file mode 100644
index 000000000..1d8770c3e
--- /dev/null
+++ b/profiles/fastpair/message-stream.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Matthias Kurz
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "message-stream.h"
+
+struct fastpair_message_stream {
+	GByteArray *buffer;
+	fastpair_message_func_t callback;
+	void *user_data;
+};
+
+struct fastpair_message_stream *
+fastpair_message_stream_new(fastpair_message_func_t callback, void *user_data)
+{
+	struct fastpair_message_stream *stream;
+
+	if (!callback)
+		return NULL;
+
+	stream = g_new0(struct fastpair_message_stream, 1);
+	stream->buffer = g_byte_array_new();
+	stream->callback = callback;
+	stream->user_data = user_data;
+
+	return stream;
+}
+
+void fastpair_message_stream_free(struct fastpair_message_stream *stream)
+{
+	if (!stream)
+		return;
+
+	g_byte_array_unref(stream->buffer);
+	g_free(stream);
+}
+
+bool fastpair_message_stream_feed(struct fastpair_message_stream *stream,
+					  const void *data, size_t length)
+{
+	const uint8_t *bytes = data;
+
+	if (!stream || (!data && length))
+		return false;
+
+	if (length > G_MAXUINT || stream->buffer->len > G_MAXUINT - length)
+		return false;
+
+	if (!length)
+		return true;
+
+	g_byte_array_append(stream->buffer, bytes, length);
+
+	while (stream->buffer->len >= FASTPAIR_MESSAGE_HEADER_LENGTH) {
+		const uint8_t *header = stream->buffer->data;
+		uint16_t payload_length;
+		guint frame_length;
+
+		payload_length = ((uint16_t)
+			header[FASTPAIR_MESSAGE_LENGTH_OFFSET] << 8) |
+			header[FASTPAIR_MESSAGE_LENGTH_OFFSET + 1];
+		frame_length = FASTPAIR_MESSAGE_HEADER_LENGTH + payload_length;
+		if (stream->buffer->len < frame_length)
+			break;
+
+		stream->callback(header[FASTPAIR_MESSAGE_GROUP_OFFSET],
+				header[FASTPAIR_MESSAGE_CODE_OFFSET],
+				stream->buffer->data +
+					FASTPAIR_MESSAGE_HEADER_LENGTH,
+				payload_length, stream->user_data);
+		g_byte_array_remove_range(stream->buffer, 0, frame_length);
+	}
+
+	return true;
+}
+
+bool fastpair_message_get_batteries(uint8_t group, uint8_t code,
+				    const uint8_t *payload, uint16_t length,
+				    struct fastpair_battery *batteries)
+{
+	unsigned int i;
+
+	if (group != FASTPAIR_DEVICE_INFORMATION_GROUP ||
+			code != FASTPAIR_BATTERY_UPDATE_CODE ||
+			length != FASTPAIR_BATTERY_COUNT ||
+			!payload || !batteries)
+		return false;
+
+	for (i = 0; i < FASTPAIR_BATTERY_COUNT; i++) {
+		uint8_t percentage = payload[i] & FASTPAIR_BATTERY_LEVEL_MASK;
+		bool case_unavailable;
+		bool level_valid = percentage <= FASTPAIR_BATTERY_LEVEL_MAX;
+		bool status_valid;
+
+		batteries[i].percentage = level_valid ? percentage :
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN;
+
+		/*
+		 * Battery Notification retains the status bit for an unknown
+		 * level (0bS1111111). The TWS requirements separately define
+		 * 0xff as invalid when the case level is unsupported. Do not
+		 * infer charging from that sentinel. Reserved levels have no
+		 * defined charging state.
+		 */
+		case_unavailable = i == FASTPAIR_BATTERY_CASE &&
+				payload[i] == FASTPAIR_BATTERY_CASE_UNAVAILABLE;
+		status_valid = level_valid ||
+				(percentage == FASTPAIR_BATTERY_LEVEL_UNKNOWN &&
+				 !case_unavailable);
+
+		if (!status_valid)
+			batteries[i].charging =
+				FASTPAIR_BATTERY_CHARGING_UNKNOWN;
+		else
+			batteries[i].charging =
+				!!(payload[i] & FASTPAIR_BATTERY_CHARGING_MASK);
+	}
+
+	return true;
+}
diff --git a/profiles/fastpair/message-stream.h b/profiles/fastpair/message-stream.h
new file mode 100644
index 000000000..78455fe5f
--- /dev/null
+++ b/profiles/fastpair/message-stream.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Matthias Kurz
+ *
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#define FASTPAIR_MESSAGE_STREAM_UUID \
+	"df21fe2c-2515-4fdb-8886-f12c4d67927c"
+
+#define FASTPAIR_MESSAGE_GROUP_OFFSET 0
+#define FASTPAIR_MESSAGE_CODE_OFFSET 1
+#define FASTPAIR_MESSAGE_LENGTH_OFFSET 2
+#define FASTPAIR_MESSAGE_HEADER_LENGTH 4
+
+#define FASTPAIR_DEVICE_INFORMATION_GROUP 0x03
+#define FASTPAIR_BATTERY_UPDATE_CODE 0x03
+#define FASTPAIR_BATTERY_LEVEL_MASK 0x7f
+#define FASTPAIR_BATTERY_CHARGING_MASK 0x80
+#define FASTPAIR_BATTERY_LEVEL_MAX 100
+#define FASTPAIR_BATTERY_LEVEL_UNKNOWN FASTPAIR_BATTERY_LEVEL_MASK
+#define FASTPAIR_BATTERY_CASE_UNAVAILABLE UINT8_MAX
+#define FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN UINT8_MAX
+#define FASTPAIR_BATTERY_CHARGING_UNKNOWN (-1)
+
+enum fastpair_battery_component {
+	FASTPAIR_BATTERY_LEFT,
+	FASTPAIR_BATTERY_RIGHT,
+	FASTPAIR_BATTERY_CASE,
+	FASTPAIR_BATTERY_COUNT,
+};
+
+struct fastpair_message_stream;
+
+struct fastpair_battery {
+	uint8_t percentage;
+	int charging;
+};
+
+typedef void (*fastpair_message_func_t)(uint8_t group, uint8_t code,
+					const uint8_t *payload, uint16_t length,
+					void *user_data);
+
+struct fastpair_message_stream *
+fastpair_message_stream_new(fastpair_message_func_t callback, void *user_data);
+void fastpair_message_stream_free(struct fastpair_message_stream *stream);
+bool fastpair_message_stream_feed(struct fastpair_message_stream *stream,
+					  const void *data, size_t length);
+
+bool fastpair_message_get_batteries(uint8_t group, uint8_t code,
+				    const uint8_t *payload, uint16_t length,
+				    struct fastpair_battery *batteries);
diff --git a/unit/test-fastpair.c b/unit/test-fastpair.c
new file mode 100644
index 000000000..c840c8758
--- /dev/null
+++ b/unit/test-fastpair.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Matthias Kurz
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "src/shared/tester.h"
+
+#include "profiles/fastpair/message-stream.h"
+
+struct expected_message {
+	uint8_t group;
+	uint8_t code;
+	uint16_t length;
+	const uint8_t *payload;
+};
+
+struct parse_context {
+	const struct expected_message *messages;
+	unsigned int count;
+	unsigned int seen;
+};
+
+static void message_cb(uint8_t group, uint8_t code, const uint8_t *payload,
+			uint16_t length, void *user_data)
+{
+	struct parse_context *context = user_data;
+	const struct expected_message *expected;
+
+	g_assert_cmpuint(context->seen, <, context->count);
+	expected = &context->messages[context->seen++];
+	g_assert_cmpuint(group, ==, expected->group);
+	g_assert_cmpuint(code, ==, expected->code);
+	g_assert_cmpuint(length, ==, expected->length);
+	if (length)
+		g_assert_cmpmem(payload, length, expected->payload,
+						expected->length);
+}
+
+static void test_complete_message(const void *data)
+{
+	static const uint8_t payload[] = { 0x60, 0x00, 0x5c };
+	static const uint8_t frame[] = {
+		FASTPAIR_DEVICE_INFORMATION_GROUP,
+		FASTPAIR_BATTERY_UPDATE_CODE,
+		0x00, sizeof(payload), 0x60, 0x00, 0x5c,
+	};
+	static const struct expected_message messages[] = {
+		{ FASTPAIR_DEVICE_INFORMATION_GROUP,
+		  FASTPAIR_BATTERY_UPDATE_CODE, sizeof(payload), payload },
+	};
+	struct parse_context context = {
+		.messages = messages,
+		.count = G_N_ELEMENTS(messages),
+	};
+	struct fastpair_message_stream *stream;
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	g_assert_true(fastpair_message_stream_feed(stream, frame,
+							 sizeof(frame)));
+	g_assert_cmpuint(context.seen, ==, context.count);
+
+	fastpair_message_stream_free(stream);
+	tester_test_passed();
+}
+
+static void test_fragmented_messages(const void *data)
+{
+	static const uint8_t battery[] = { 0x60, 0x00, 0x5c };
+	static const uint8_t other[] = { 0xaa, 0xbb };
+	static const uint8_t frames[] = {
+		FASTPAIR_DEVICE_INFORMATION_GROUP,
+		FASTPAIR_BATTERY_UPDATE_CODE,
+		0x00, sizeof(battery), 0x60, 0x00, 0x5c,
+		0x01, 0x02, 0x00, sizeof(other), 0xaa, 0xbb,
+	};
+	static const struct expected_message messages[] = {
+		{ FASTPAIR_DEVICE_INFORMATION_GROUP,
+		  FASTPAIR_BATTERY_UPDATE_CODE, sizeof(battery), battery },
+		{ 0x01, 0x02, sizeof(other), other },
+	};
+	struct parse_context context = {
+		.messages = messages,
+		.count = G_N_ELEMENTS(messages),
+	};
+	struct fastpair_message_stream *stream;
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	/* Split after the first byte of the first payload. */
+	g_assert_true(fastpair_message_stream_feed(stream, frames, 5));
+	g_assert_cmpuint(context.seen, ==, 0);
+	g_assert_true(fastpair_message_stream_feed(stream, frames + 5,
+						     sizeof(frames) - 5));
+	g_assert_cmpuint(context.seen, ==, context.count);
+
+	fastpair_message_stream_free(stream);
+	tester_test_passed();
+}
+
+static void test_coalesced_partial_message(const void *data)
+{
+	static const uint8_t battery[] = { 0x60, 0x00, 0x5c };
+	static const uint8_t other[] = { 0xaa, 0xbb };
+	static const uint8_t frames[] = {
+		FASTPAIR_DEVICE_INFORMATION_GROUP,
+		FASTPAIR_BATTERY_UPDATE_CODE,
+		0x00, sizeof(battery), 0x60, 0x00, 0x5c,
+		0x01, 0x02, 0x00, sizeof(other), 0xaa, 0xbb,
+	};
+	static const struct expected_message messages[] = {
+		{ FASTPAIR_DEVICE_INFORMATION_GROUP,
+		  FASTPAIR_BATTERY_UPDATE_CODE, sizeof(battery), battery },
+		{ 0x01, 0x02, sizeof(other), other },
+	};
+	struct parse_context context = {
+		.messages = messages,
+		.count = G_N_ELEMENTS(messages),
+	};
+	struct fastpair_message_stream *stream;
+	size_t first_feed = FASTPAIR_MESSAGE_HEADER_LENGTH +
+							sizeof(battery) + 2;
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	g_assert_true(fastpair_message_stream_feed(stream, frames, first_feed));
+	g_assert_cmpuint(context.seen, ==, 1);
+	g_assert_true(fastpair_message_stream_feed(stream, frames + first_feed,
+						sizeof(frames) - first_feed));
+	g_assert_cmpuint(context.seen, ==, context.count);
+
+	fastpair_message_stream_free(stream);
+	tester_test_passed();
+}
+
+static void test_invalid_input(const void *data)
+{
+	static const uint8_t frame[] = { 0x01, 0x02, 0x00, 0x00 };
+	struct parse_context context = {};
+	struct fastpair_message_stream *stream;
+	size_t oversized_length = (size_t) G_MAXUINT + 1;
+
+	g_assert_null(fastpair_message_stream_new(NULL, NULL));
+	fastpair_message_stream_free(NULL);
+
+	g_assert_false(fastpair_message_stream_feed(NULL, frame,
+							sizeof(frame)));
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	g_assert_false(fastpair_message_stream_feed(stream, NULL, 1));
+	g_assert_true(fastpair_message_stream_feed(stream, NULL, 0));
+
+	if (oversized_length > G_MAXUINT)
+		g_assert_false(fastpair_message_stream_feed(stream, frame,
+							oversized_length));
+
+	fastpair_message_stream_free(stream);
+	tester_test_passed();
+}
+
+static void test_zero_length_message(const void *data)
+{
+	static const uint8_t frame[] = { 0x01, 0x02, 0x00, 0x00 };
+	static const struct expected_message messages[] = {
+		{ 0x01, 0x02, 0, NULL },
+	};
+	struct parse_context context = {
+		.messages = messages,
+		.count = G_N_ELEMENTS(messages),
+	};
+	struct fastpair_message_stream *stream;
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	g_assert_true(fastpair_message_stream_feed(stream, frame,
+							 sizeof(frame)));
+	g_assert_cmpuint(context.seen, ==, context.count);
+
+	fastpair_message_stream_free(stream);
+	tester_test_passed();
+}
+
+static void test_maximum_length_message(const void *data)
+{
+	struct expected_message message;
+	struct parse_context context = {
+		.messages = &message,
+		.count = 1,
+	};
+	struct fastpair_message_stream *stream;
+	uint8_t *frame;
+	size_t frame_length = FASTPAIR_MESSAGE_HEADER_LENGTH + UINT16_MAX;
+
+	frame = g_malloc(frame_length);
+	frame[FASTPAIR_MESSAGE_GROUP_OFFSET] = 0x01;
+	frame[FASTPAIR_MESSAGE_CODE_OFFSET] = 0x02;
+	frame[FASTPAIR_MESSAGE_LENGTH_OFFSET] = 0xff;
+	frame[FASTPAIR_MESSAGE_LENGTH_OFFSET + 1] = 0xff;
+	memset(frame + FASTPAIR_MESSAGE_HEADER_LENGTH, 0xa5, UINT16_MAX);
+
+	message.group = frame[FASTPAIR_MESSAGE_GROUP_OFFSET];
+	message.code = frame[FASTPAIR_MESSAGE_CODE_OFFSET];
+	message.length = UINT16_MAX;
+	message.payload = frame + FASTPAIR_MESSAGE_HEADER_LENGTH;
+
+	stream = fastpair_message_stream_new(message_cb, &context);
+	g_assert_nonnull(stream);
+	g_assert_true(fastpair_message_stream_feed(stream, frame, 1024));
+	g_assert_cmpuint(context.seen, ==, 0);
+	g_assert_true(fastpair_message_stream_feed(stream, frame + 1024,
+						frame_length - 1024));
+	g_assert_cmpuint(context.seen, ==, context.count);
+
+	fastpair_message_stream_free(stream);
+	g_free(frame);
+	tester_test_passed();
+}
+
+static void test_battery_message(const void *data)
+{
+	static const uint8_t payload[] = { 0x60, 0xaa, 0x7f };
+	static const uint8_t unknown[] = { 0xff, 0x7f, 0xff };
+	static const uint8_t reserved[] = { 0x65, 0xe5, 0x65 };
+	struct fastpair_battery batteries[FASTPAIR_BATTERY_COUNT];
+
+	g_assert_true(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					payload, sizeof(payload), batteries));
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_LEFT].percentage, ==, 96);
+	g_assert_false(batteries[FASTPAIR_BATTERY_LEFT].charging);
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_RIGHT].percentage, ==, 42);
+	g_assert_true(batteries[FASTPAIR_BATTERY_RIGHT].charging);
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_CASE].percentage, ==,
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+	g_assert_cmpint(batteries[FASTPAIR_BATTERY_CASE].charging, ==, 0);
+
+	g_assert_true(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					unknown, sizeof(unknown), batteries));
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_LEFT].percentage, ==,
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+	g_assert_cmpint(batteries[FASTPAIR_BATTERY_LEFT].charging, ==, 1);
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_RIGHT].percentage, ==,
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+	g_assert_cmpint(batteries[FASTPAIR_BATTERY_RIGHT].charging, ==, 0);
+	g_assert_cmpuint(batteries[FASTPAIR_BATTERY_CASE].percentage, ==,
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+	g_assert_cmpint(batteries[FASTPAIR_BATTERY_CASE].charging, ==,
+					FASTPAIR_BATTERY_CHARGING_UNKNOWN);
+
+	g_assert_true(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					reserved, sizeof(reserved), batteries));
+	for (unsigned int i = 0; i < FASTPAIR_BATTERY_COUNT; i++) {
+		g_assert_cmpuint(batteries[i].percentage, ==,
+					FASTPAIR_BATTERY_PERCENTAGE_UNKNOWN);
+		g_assert_cmpint(batteries[i].charging, ==,
+					FASTPAIR_BATTERY_CHARGING_UNKNOWN);
+	}
+
+	g_assert_false(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP - 1,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					payload, sizeof(payload), batteries));
+	g_assert_false(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE - 1,
+					payload, sizeof(payload), batteries));
+	g_assert_false(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					payload, sizeof(payload) - 1,
+					batteries));
+	g_assert_false(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					NULL, sizeof(payload), batteries));
+	g_assert_false(fastpair_message_get_batteries(
+					FASTPAIR_DEVICE_INFORMATION_GROUP,
+					FASTPAIR_BATTERY_UPDATE_CODE,
+					payload, sizeof(payload), NULL));
+	tester_test_passed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/fastpair/complete-message", NULL, NULL,
+				test_complete_message, NULL);
+	tester_add("/fastpair/fragmented-messages", NULL, NULL,
+				test_fragmented_messages, NULL);
+	tester_add("/fastpair/coalesced-partial-message", NULL, NULL,
+				test_coalesced_partial_message, NULL);
+	tester_add("/fastpair/invalid-input", NULL, NULL,
+				test_invalid_input, NULL);
+	tester_add("/fastpair/zero-length-message", NULL, NULL,
+				test_zero_length_message, NULL);
+	tester_add("/fastpair/maximum-length-message", NULL, NULL,
+				test_maximum_length_message, NULL);
+	tester_add("/fastpair/battery-message", NULL, NULL,
+				test_battery_message, NULL);
+
+	return tester_run();
+}
-- 
2.55.0

