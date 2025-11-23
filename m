Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053A2C3272
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914654; cv=pass; b=eSnp69pRYUc6YRhJJX7OrmPXznmmNiO8oqfQmbChWySMkAlc9wlV1q3UCZBlJnrW/1CQL2SdFIfglbSIViz61EiwvXEQMoSWQ/sJadEVep47a/IGE8c68Bh22GYNEvS3aruLom9ekVEXHX+tM6MU1mEAwCtphKguG6FV0S5r0Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914654; c=relaxed/simple;
	bh=DPPufjm+F6116nE2bGfxkDafHpsGrv+k4yOOzR5y3WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzjjzwmII9ePP49rVVfjC0+KpHVOwhuoXaQGOgEI3+y9MTYNAaL8C5hBwuPeGhK2b3Ccn+en/S6B7WZvM62J65ugulaxsyCKuFkaJOvydbwl4waGklJFCr7sMkOrzzj8xpSgtYBR5GFIxFIOcrmyGmo/7JtBwJaxl2o9obwn8kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AEN+ZUmU; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AEN+ZUmU"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHR119Gz107j;
	Sun, 23 Nov 2025 18:17:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv+JEYGjr+O4KN1hqpwMrPIo4LsgvDtgQzc9K40ExEk=;
	b=AEN+ZUmUs4NK9elMz8Oe2M2yiNueeqJ4YKfai8Xmfvxi3PrSGbGaf6mX5vpl95RB4d6vtn
	RuykIMAkoRWmzWURUE+Vt3N/VoW84H77++tWWLd6rRIFZkkX9u5N0VuA0lPcioX9/cssaB
	b0CZD3vgGMjuN940LcWAJRJfXHS7QZI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914644;
	b=I/yNWAz3IoDiS4Ykj2fBVOuPuSAvqfveanVUTkmfm4+FjQ0hKurNqoJrRJx2C8vcrcs/a5
	Fko+XSq/HC1dVzuHZ1iQCN3FwZF0D/l9YcFwi4k1xUnm2KxnhfuGQseKS1aVWynLXXZZVN
	Sexh1841vBOAu4onscVs6u1fifM0XlE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv+JEYGjr+O4KN1hqpwMrPIo4LsgvDtgQzc9K40ExEk=;
	b=hbEVAbV+TBPt1tdCgdO7af3hIAsZbjnsvCXDaqkhIbasDwTmq8ty7DZBl81chPkhRLKvp6
	sM9ZrkJ1hjW06oMXxMER97mdDF9xvFMm3Tdr6M3EbY79cZ/v5Ck/6Gqot0+Sbds7CRDHrX
	YbuG8twMWfLzyScL4/vBSl/tpjIJdbM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 03/10] tmap: add TMAP profile
Date: Sun, 23 Nov 2025 18:17:08 +0200
Message-ID: <4e07fb089d9895efb28bfc5dae7b54ab3595d424.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read TMAP Role from remote devices and enable advertising the value for
local services.
---
 Makefile.plugins      |   5 ++
 configure.ac          |   7 ++
 profiles/audio/tmap.c | 203 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 profiles/audio/tmap.c

diff --git a/Makefile.plugins b/Makefile.plugins
index bae4363d0..c976c66f4 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -146,6 +146,11 @@ builtin_modules += csip
 builtin_sources += profiles/audio/csip.c
 endif
 
+if TMAP
+builtin_modules += tmap
+builtin_sources += profiles/audio/tmap.c
+endif
+
 if ASHA
 builtin_modules += asha
 builtin_sources += profiles/audio/asha.h profiles/audio/asha.c
diff --git a/configure.ac b/configure.ac
index fa7ed185f..29a322cb5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -227,6 +227,13 @@ AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
 
+AC_ARG_ENABLE(tmap, AS_HELP_STRING([--disable-tmap],
+		[disable TMAP profile]), [enable_tmap=${enableval}])
+AM_CONDITIONAL(TMAP, test "${enable_tmap}" != "no")
+if test "${enable_tmap}" != "no"; then
+	AC_DEFINE(HAVE_TMAP, 1, [Define to 1 if you have TMAP support.])
+fi
+
 AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
 		[disable ASHA support]), [enable_asha=${enableval}])
 AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
diff --git a/profiles/audio/tmap.c b/profiles/audio/tmap.c
new file mode 100644
index 000000000..2525c33bf
--- /dev/null
+++ b/profiles/audio/tmap.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Pauli Virtanen. All rights reserved.
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
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/hci.h"
+#include "bluetooth/sdp.h"
+#include "bluetooth/uuid.h"
+
+#include "src/dbus-common.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/tmap.h"
+
+#include "btio/btio.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/gatt-database.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+#include "src/error.h"
+
+#include "vcp.h"
+#include "transport.h"
+
+#define TMAS_UUID_STR			"00001855-0000-1000-8000-00805f9b34fb"
+
+static void tmap_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static void service_ready(struct bt_tmap *tmap, void *user_data)
+{
+	struct btd_service *service = user_data;
+
+	btd_service_connecting_complete(service, 0);
+}
+
+static struct bt_tmap *add_service(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bt_tmap *tmap = btd_service_get_user_data(service);
+
+	if (tmap)
+		return tmap;
+
+	tmap = bt_tmap_attach(client, service_ready, service);
+	if (!tmap) {
+		error("TMAP client unable to attach");
+		return NULL;
+	}
+
+	bt_tmap_set_debug(tmap, tmap_debug, NULL, NULL);
+
+	btd_service_set_user_data(service, tmap);
+	return tmap;
+}
+
+static void remove_service(struct btd_service *service)
+{
+	struct bt_tmap *tmap = btd_service_get_user_data(service);
+
+	if (!tmap)
+		return;
+
+	btd_service_set_user_data(service, NULL);
+	bt_tmap_unref(tmap);
+}
+
+static int tmap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_tmap *tmap;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	tmap = add_service(service);
+	if (!tmap)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int tmap_disconnect(struct btd_service *service)
+{
+	remove_service(service);
+
+	btd_service_disconnecting_complete(service, 0);
+	return 0;
+}
+
+static int tmap_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+	return 0;
+}
+
+static void tmap_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+}
+
+static int tmap_adapter_probe(struct btd_profile *p,
+				  struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bt_tmap *tmap;
+
+	DBG("Add TMAP server %s", adapter_get_path(adapter));
+	tmap = bt_tmap_add_db(btd_gatt_database_get_db(database));
+
+	bt_tmap_set_debug(tmap, tmap_debug, NULL, NULL);
+	return 0;
+}
+
+static void tmap_adapter_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bt_tmap *tmap;
+
+	DBG("Remove TMAP server %s", adapter_get_path(adapter));
+	tmap = bt_tmap_find(btd_gatt_database_get_db(database));
+	bt_tmap_unref(tmap);
+}
+
+static struct btd_profile tmap_profile = {
+	.name		= "tmap",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= TMAS_UUID_STR,
+
+	.device_probe	= tmap_probe,
+	.device_remove	= tmap_remove,
+	.accept		= tmap_accept,
+	.disconnect	= tmap_disconnect,
+
+	.adapter_probe = tmap_adapter_probe,
+	.adapter_remove = tmap_adapter_remove,
+
+	.experimental	= true,
+};
+
+static int tmap_init(void)
+{
+	int err;
+
+	err = btd_profile_register(&tmap_profile);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void tmap_exit(void)
+{
+	btd_profile_unregister(&tmap_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(tmap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							tmap_init, tmap_exit)
-- 
2.51.1

