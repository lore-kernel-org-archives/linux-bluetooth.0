Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0902E7F22
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035913; cv=none; b=HLuBneGnxnDGv02OwL15D7Lpk9kPMkyoERxHnT4zWieIn4Bu/5K9BhO31Wf5IZT92hgJ052C8ccEnlIi/lnJd8h7RY4/Q2llKcnfXq/KvcIQ2ZLUrHxQunup9yKBBByyPP+dRV+LURDUt2rP88V3v/MKPelh4zE9tD6qpjLieQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035913; c=relaxed/simple;
	bh=rVVOKBhJKvvmzK9tuwU9dsfWTRYQgWqTISTfsOpIMgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERO3t0+VIc7Rnjze8Bv+SWemM7ft2aNSSap0eAYLJOogrcCa9FxVwupyhpBnP2BK8qFs7fHhnBb4pRf0RXuHs5pzq/+owm97BMbY0DXPqJd22WrGw1f99H8TNFaB64VoVAmWZZ8ChAAdZ6pEQXB6POHW9U8Z6Q55IM8hMWd2G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qS0SNhHw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qS0SNhHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035902;
	bh=rVVOKBhJKvvmzK9tuwU9dsfWTRYQgWqTISTfsOpIMgQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qS0SNhHwTmG8braKJf6KMKjlA9SQCh9WD1PbblnC0yRr8+2ulWjhLkEF0j23bMCnI
	 F8HuTCiu48EAgp9LKbJxXoAa44uCBda+9kzPaSoY7H+4eg59p/8M9xolXweaafUmha
	 KhKc5RhUkEuz5MylbsWun30PzB5/rp+fd4znjuetrk6vu7ymZCtVpA7WKwX4x3oyB+
	 hF/aJMklIAVSEY2dl68UWRiVX0ZIbyntUp76i2BSn9Hld4++9cT7cnD2Fc0t8IFaFO
	 OBKnkEu9ZFg5qq9DB8DraJFN2sCdCsK2KnjMbFfvkAzjctDKv+D9nAvfqSqkbgLofh
	 kBc64HbYRI4Fw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF42117E07F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:42 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 03/27] audio/telephony: Add skeleton for HFP profile
Date: Fri, 27 Jun 2025 16:51:12 +0200
Message-ID: <20250627145136.421853-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 Makefile.plugins        |   5 +
 configure.ac            |   7 ++
 profiles/audio/hfp-hf.c | 216 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 profiles/audio/hfp-hf.c

diff --git a/Makefile.plugins b/Makefile.plugins
index bae4363d0..66e8033e4 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -150,3 +150,8 @@ if ASHA
 builtin_modules += asha
 builtin_sources += profiles/audio/asha.h profiles/audio/asha.c
 endif
+
+if HFP
+builtin_modules += hfp
+builtin_sources += profiles/audio/telephony.c profiles/audio/hfp-hf.c
+endif
diff --git a/configure.ac b/configure.ac
index 07aeb46ca..247e1c928 100644
--- a/configure.ac
+++ b/configure.ac
@@ -238,6 +238,13 @@ if test "${enable_asha}" != "no"; then
 	AC_DEFINE(HAVE_ASHA, 1, [Define to 1 if you have ASHA support.])
 fi
 
+AC_ARG_ENABLE(hfp, AS_HELP_STRING([--disable-hfp],
+		[disable HFP support]), [enable_hfp=${enableval}])
+AM_CONDITIONAL(HFP, test "${enable_hfp}" != "no")
+if test "${enable_hfp}" != "no"; then
+	AC_DEFINE(HAVE_HFP, 1, [Define to 1 if you have HFP support.])
+fi
+
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
new file mode 100644
index 000000000..f049ee5f7
--- /dev/null
+++ b/profiles/audio/hfp-hf.c
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *  Copyright © 2025 Collabora Ltd.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <limits.h>
+
+#include <stdint.h>
+
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/sdp_lib.h"
+#include "lib/uuid.h"
+
+#include "gdbus/gdbus.h"
+
+#include "btio/btio.h"
+#include "src/adapter.h"
+#include "src/btd.h"
+#include "src/dbus-common.h"
+#include "src/device.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/profile.h"
+#include "src/service.h"
+
+#include "telephony.h"
+
+struct hfp_device {
+	struct telephony	*telephony;
+	uint16_t		version;
+	GIOChannel		*io;
+};
+
+static void device_destroy(struct hfp_device *dev)
+{
+	DBG("%s", telephony_get_path(dev->telephony));
+
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
+
+	telephony_unregister_interface(dev->telephony);
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct hfp_device *dev = user_data;
+	struct btd_service *service = telephony_get_service(dev->telephony);
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		goto failed;
+	}
+
+	g_io_channel_set_close_on_unref(chan, FALSE);
+
+	btd_service_connecting_complete(service, 0);
+
+	return;
+
+failed:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	device_destroy(dev);
+}
+
+struct telephony_callbacks hfp_callbacks = {
+};
+
+static int hfp_connect(struct btd_service *service)
+{
+	struct hfp_device *dev;
+	struct btd_profile *p;
+	const sdp_record_t *rec;
+	sdp_list_t *list, *protos;
+	sdp_profile_desc_t *desc;
+	int channel;
+	bdaddr_t src, dst;
+	GError *err = NULL;
+
+	DBG("");
+
+	dev = btd_service_get_user_data(service);
+
+	p = btd_service_get_profile(service);
+	rec = btd_device_get_record(telephony_get_device(dev->telephony),
+					p->remote_uuid);
+	if (!rec)
+		return -EIO;
+
+	if (sdp_get_profile_descs(rec, &list) == 0) {
+		desc = list->data;
+		dev->version = desc->version;
+	}
+	sdp_list_free(list, free);
+
+	if (sdp_get_access_protos(rec, &protos) < 0) {
+		error("unable to get access protocols from record");
+		return -EIO;
+	}
+
+	channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+	if (channel <= 0) {
+		error("unable to get RFCOMM channel from record");
+		return -EIO;
+	}
+
+	src = telephony_get_src(dev->telephony);
+	dst = telephony_get_dst(dev->telephony);
+	dev->io = bt_io_connect(connect_cb, dev,
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR, &src,
+		BT_IO_OPT_DEST_BDADDR, &dst,
+		BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+		BT_IO_OPT_CHANNEL, channel,
+		BT_IO_OPT_INVALID);
+	if (dev->io == NULL) {
+		error("unable to start connection");
+		return -EIO;
+	}
+
+	return telephony_register_interface(dev->telephony);
+}
+
+static int hfp_disconnect(struct btd_service *service)
+{
+	DBG("");
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static int hfp_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	struct hfp_device *dev;
+
+	DBG("%s", path);
+
+	dev = g_new0(struct hfp_device, 1);
+	if (!dev)
+		return -EINVAL;
+
+	dev->telephony = telephony_new(service, dev, &hfp_callbacks);
+	btd_service_set_user_data(service, dev);
+
+	return 0;
+}
+
+static void hfp_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	struct hfp_device *dev;
+
+	DBG("%s", path);
+
+	dev = btd_service_get_user_data(service);
+
+	telephony_free(dev->telephony);
+	g_free(dev);
+}
+
+static struct btd_profile hfp_hf_profile = {
+	.name		= "hfp",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+
+	.remote_uuid	= HFP_AG_UUID,
+	.device_probe	= hfp_probe,
+	.device_remove	= hfp_remove,
+
+	.auto_connect	= true,
+	.connect	= hfp_connect,
+	.disconnect	= hfp_disconnect,
+
+	.experimental	= true,
+};
+
+static int hfp_init(void)
+{
+	btd_profile_register(&hfp_hf_profile);
+
+	return 0;
+}
+
+static void hfp_exit(void)
+{
+	btd_profile_unregister(&hfp_hf_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hfp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+		hfp_init, hfp_exit)
-- 
2.43.0

