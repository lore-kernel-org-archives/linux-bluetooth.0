Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCA2D8DCF
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914655; cv=pass; b=dTuUzLN2b6Uv0LBdHp6ymeZdz6BytIIjtTW+QjiWxWBOcGmvXaaTfcfzjdw35ZQ0nZC21vCk0W9aiLnKjidTYR27MmyorxJOHJCopIIIzVbxBjLzYp4Z/uN1nvNr3PoCqch0J01HtkoFUrWarDPqdCCyMGC9BEkB1dKqo8u7uEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914655; c=relaxed/simple;
	bh=7cX9vyhvGoS3XOTV5fYWUzcmIxKFLyP7yEXKNA7wUXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNKZi5IuoO5No9amywe1EbEVRS0PC4Ul9cxCdKF5kfgz+VPaA8Ty79PoOLstTl+gpx/tlrp897uFpT3ZHZNU6xwNm3ZUOxbZNm8EdtINbiZHZBqVYGRWjNXT6puMeOZkJBdMVCT97cvy42TCxIWdU+DjebeJEbKbUk9qcONPWpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HNhAM0pp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HNhAM0pp"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHX0HLTzySJ;
	Sun, 23 Nov 2025 18:17:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr359rsswLbk0MXdVHA2JkielIJGkG5+tzu3W0xyNcQ=;
	b=HNhAM0pp66SRHI1REyWogj/8k5515ZzEp86Q1ouLPm04VASSuwcCVWvl9U7a5nwoicAloy
	VcJQSh0r/6K7g0gE9LDWxZ9Thy987cv8TcnQuBsVLpyrMviFEDOtuLMZZnamMMZo2HZcdO
	jZupncbiUCGIBg22nZzZlKJLbDheBAw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914648;
	b=UlqgKrzlTgCfUPOdk029OKo3jhao3Mrcv2MmT5/zgGK8sSLIzXZpcJBQS80S5SlSbpnDbt
	D96qcx6cSzsHj9kk6wdywB0jTnYIzSGA1ufZm2NtSdF8q/Gat4Ab2m7QrhJElya8fJZ5Fj
	VboKN9mIEhu1Bof0VjzutG/+xrCRd7A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr359rsswLbk0MXdVHA2JkielIJGkG5+tzu3W0xyNcQ=;
	b=nhzvmuWoCenx35G+8u+nOBvyUmWRnf2eS3BgrrXqNOVK7VtPWJv5/fQl9Zsi0ddp+B9n6l
	PZ5bBTJEZK6bJ6yNMQkBqX3tNJmTO1RnvUpBSI0hHsl/5I0s6273IyeXwdNpXNcH/2trvW
	exmnVSfFYL9MmnIQIGY4NIl3OivsX7U=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 07/10] gmap: Add GMAP profile
Date: Sun, 23 Nov 2025 18:17:12 +0200
Message-ID: <a153d199c8dea9e5d78731d9a43f80148c05adfa.1763914558.git.pav@iki.fi>
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

Read GMAP properties from remote devices and enable advertising the
values for local services.
---
 Makefile.plugins      |   5 ++
 configure.ac          |   7 ++
 profiles/audio/gmap.c | 203 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 profiles/audio/gmap.c

diff --git a/Makefile.plugins b/Makefile.plugins
index c976c66f4..3572ee845 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -151,6 +151,11 @@ builtin_modules += tmap
 builtin_sources += profiles/audio/tmap.c
 endif
 
+if GMAP
+builtin_modules += gmap
+builtin_sources += profiles/audio/gmap.c
+endif
+
 if ASHA
 builtin_modules += asha
 builtin_sources += profiles/audio/asha.h profiles/audio/asha.c
diff --git a/configure.ac b/configure.ac
index 29a322cb5..16b81aca3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -234,6 +234,13 @@ if test "${enable_tmap}" != "no"; then
 	AC_DEFINE(HAVE_TMAP, 1, [Define to 1 if you have TMAP support.])
 fi
 
+AC_ARG_ENABLE(gmap, AS_HELP_STRING([--disable-gmap],
+		[disable GMAP profile]), [enable_gmap=${enableval}])
+AM_CONDITIONAL(GMAP, test "${enable_gmap}" != "no")
+if test "${enable_gmap}" != "no"; then
+	AC_DEFINE(HAVE_GMAP, 1, [Define to 1 if you have GMAP support.])
+fi
+
 AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
 		[disable ASHA support]), [enable_asha=${enableval}])
 AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
diff --git a/profiles/audio/gmap.c b/profiles/audio/gmap.c
new file mode 100644
index 000000000..eb3f82f9c
--- /dev/null
+++ b/profiles/audio/gmap.c
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
+#include "src/shared/gmap.h"
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
+#define GMAS_UUID_STR			"00001858-0000-1000-8000-00805f9b34fb"
+
+static void gmap_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static void service_ready(struct bt_gmap *gmap, void *user_data)
+{
+	struct btd_service *service = user_data;
+
+	btd_service_connecting_complete(service, 0);
+}
+
+static struct bt_gmap *add_service(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct bt_gmap *gmap = btd_service_get_user_data(service);
+
+	if (gmap)
+		return gmap;
+
+	gmap = bt_gmap_attach(client, service_ready, service);
+	if (!gmap) {
+		error("GMAP client unable to attach");
+		return NULL;
+	}
+
+	bt_gmap_set_debug(gmap, gmap_debug, NULL, NULL);
+
+	btd_service_set_user_data(service, gmap);
+	return gmap;
+}
+
+static void remove_service(struct btd_service *service)
+{
+	struct bt_gmap *gmap = btd_service_get_user_data(service);
+
+	if (!gmap)
+		return;
+
+	btd_service_set_user_data(service, NULL);
+	bt_gmap_unref(gmap);
+}
+
+static int gmap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gmap *gmap;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	gmap = add_service(service);
+	if (!gmap)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int gmap_disconnect(struct btd_service *service)
+{
+	remove_service(service);
+
+	btd_service_disconnecting_complete(service, 0);
+	return 0;
+}
+
+static int gmap_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+	return 0;
+}
+
+static void gmap_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+}
+
+static int gmap_adapter_probe(struct btd_profile *p,
+				  struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bt_gmap *gmap;
+
+	DBG("Add GMAP server %s", adapter_get_path(adapter));
+	gmap = bt_gmap_add_db(btd_gatt_database_get_db(database));
+
+	bt_gmap_set_debug(gmap, gmap_debug, NULL, NULL);
+	return 0;
+}
+
+static void gmap_adapter_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bt_gmap *gmap;
+
+	DBG("Remove GMAP server %s", adapter_get_path(adapter));
+	gmap = bt_gmap_find(btd_gatt_database_get_db(database));
+	bt_gmap_unref(gmap);
+}
+
+static struct btd_profile gmap_profile = {
+	.name		= "gmap",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= GMAS_UUID_STR,
+
+	.device_probe	= gmap_probe,
+	.device_remove	= gmap_remove,
+	.accept		= gmap_accept,
+	.disconnect	= gmap_disconnect,
+
+	.adapter_probe = gmap_adapter_probe,
+	.adapter_remove = gmap_adapter_remove,
+
+	.experimental	= true,
+};
+
+static int gmap_init(void)
+{
+	int err;
+
+	err = btd_profile_register(&gmap_profile);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void gmap_exit(void)
+{
+	btd_profile_unregister(&gmap_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(gmap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							gmap_init, gmap_exit)
-- 
2.51.1

