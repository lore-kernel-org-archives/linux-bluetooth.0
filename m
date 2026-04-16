Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6534B1A7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365365; cv=none; b=djkXjxT7iH1eYAa/PAJQs9FOFLWm4xIdz3llKGf7tGBho8TwtqYWM5ZJ2Q0m8p882u52nZJkkgcCE9W+9kaHuG3B9ABwpFrS83TiAzkdYs9IQ/KVZvorMAi1Z1IIxhPckbRkCggRRzCCuJ80m+rVP94qD/O0ftO64a2+UJAiisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365365; c=relaxed/simple;
	bh=7X2Zeh57YaIfzfmkbzq37uikt3UxeSXarGKuISGM+8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GUh+JoWQk7T/uNubD8mcezJhoIWoXp3titUV83HYn0RGdtX+8Zdom7kVt2c9nEXDt3rkM2G+ZZEVbaAspMZulM3aUY6lScIUdT7foeD3rWQ+syX47JQTHQzLhu0uKjMcF0FPA5l0aSbAa3YTLeRE+0cv55b+4hgxOSyV8/3zGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D+Q7gkxZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D+Q7gkxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776365360;
	bh=7X2Zeh57YaIfzfmkbzq37uikt3UxeSXarGKuISGM+8w=;
	h=From:To:Subject:Date:From;
	b=D+Q7gkxZOkD1rWx5n52kHV56GuzEOlk9ekV8Q7Nc84Il9s8NSEB4WfvLpKupq9ImI
	 5r4wXCoRnLMVNS/JeAS8m/OVo4WNz1spp7FK3WD39xvrGZLy71hyPz1PPApHOB6Ywd
	 zpebnTSpMCydIDiX3o32SljbNsN1GnZBtDOd2piAhv928iM/FVYGO3nrAHeCHHznht
	 +1llobN4NDG1DB7YoAO4sTctBoCcGUo03FfMgBPibxb3/nwxCQC1THCAp2FTCJuczM
	 JtCzVwgv4tjFgpybVgwCobquBRym9rXKJ49AV2KHwRhHPqv3nRfYjO15o+YeY3LKKi
	 14IaPRcaatIxA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 798A517E1276
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 20:49:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Add BTP_OP_BAP_DISCOVER support
Date: Thu, 16 Apr 2026 20:49:14 +0200
Message-ID: <20260416184914.145135-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

BAP/CL/CGGIT/SER/BV-01-C expects IUT to discover the services before
continuation.

This reduces connection time for the BAP tests.
---
 Makefile.tools          |   1 +
 client/btpclient/bap.c  | 109 ++++++++++++++++++++++++++++++++++++++++
 client/btpclient/bap.h  |  13 +++++
 client/btpclient/core.c |  15 ++++++
 src/shared/btp.h        |  16 ++++++
 5 files changed, 154 insertions(+)
 create mode 100644 client/btpclient/bap.c
 create mode 100644 client/btpclient/bap.h

diff --git a/Makefile.tools b/Makefile.tools
index 8e0eae04e..001d0129f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -562,6 +562,7 @@ noinst_PROGRAMS += client/btpclient/btpclient client/btpclient/btpclientctl
 client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
 				client/btpclient/btpclient.h \
 				src/shared/btp.c src/shared/btp.h \
+				client/btpclient/bap.c client/btpclient/bap.h \
 				client/btpclient/core.c client/btpclient/core.h \
 				client/btpclient/gap.c client/btpclient/gap.h \
 				client/btpclient/gatt.c client/btpclient/gatt.h
diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
new file mode 100644
index 000000000..d64828894
--- /dev/null
+++ b/client/btpclient/bap.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include <ell/ell.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+#include "src/shared/btp.h"
+#include "btpclient.h"
+#include "bap.h"
+
+static struct btp *btp;
+static bool bap_service_registered;
+
+static void btp_bap_read_commands(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint16_t commands = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_BAP_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	commands |= (1 << BTP_OP_BAP_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_BAP_DISCOVER);
+
+	commands = L_CPU_TO_LE16(commands);
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_OP_BAP_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+}
+
+static void btp_bap_discover(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_bap_discover_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	struct btp_device *dev;
+	struct btp_bap_discovery_completed_ev ev;
+	bool prop;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_OP_BAP_DISCOVER, index, 0, NULL);
+
+	dev = find_device_by_address(adapter, &cp->address, cp->address_type);
+
+	/* Services should have been resolved during connection */
+	if (!l_dbus_proxy_get_property(dev->proxy, "ServicesResolved", "b",
+					&prop) || !prop)
+		goto failed;
+
+	memcpy(&ev.address, &dev->address, sizeof(ev.address));
+	ev.address_type = dev->address_type;
+	ev.status = 0;
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_EV_BAP_DISCOVERY_COMPLETED,
+			adapter->index, sizeof(ev), &ev);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_BAP_SERVICE, index, status);
+}
+
+bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client)
+{
+	btp = btp_;
+
+	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_READ_SUPPORTED_COMMANDS,
+					btp_bap_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_DISCOVER,
+					btp_bap_discover, NULL, NULL);
+
+	bap_service_registered = true;
+
+	return true;
+}
+
+void bap_unregister_service(struct btp *btp)
+{
+	btp_unregister_service(btp, BTP_BAP_SERVICE);
+	bap_service_registered = false;
+}
+
+bool bap_is_service_registered(void)
+{
+	return bap_service_registered;
+}
diff --git a/client/btpclient/bap.h b/client/btpclient/bap.h
new file mode 100644
index 000000000..2b7a218b5
--- /dev/null
+++ b/client/btpclient/bap.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ */
+
+bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client);
+void bap_unregister_service(struct btp *btp);
+bool bap_is_service_registered(void);
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
index cfff131f1..772178670 100644
--- a/client/btpclient/core.c
+++ b/client/btpclient/core.c
@@ -13,6 +13,7 @@
 #include "bluetooth/uuid.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
+#include "bap.h"
 #include "core.h"
 #include "gap.h"
 #include "gatt.h"
@@ -89,6 +90,14 @@ static void btp_core_register(uint8_t index, const void *param,
 		if (!gatt_register_service(btp, dbus, client))
 			goto failed;
 
+		break;
+	case BTP_BAP_SERVICE:
+		if (bap_is_service_registered())
+			goto failed;
+
+		if (!bap_register_service(btp, dbus, client))
+			goto failed;
+
 		break;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
@@ -132,6 +141,12 @@ static void btp_core_unregister(uint8_t index, const void *param,
 
 		gatt_unregister_service(btp);
 		break;
+	case BTP_BAP_SERVICE:
+		if (!bap_is_service_registered())
+			goto failed;
+
+		bap_unregister_service(btp);
+		break;
 	case BTP_L2CAP_SERVICE:
 	case BTP_MESH_NODE_SERVICE:
 	case BTP_CORE_SERVICE:
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 8b5078f82..c23346f4e 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -26,6 +26,7 @@
 #define BTP_GATT_SERVICE	2
 #define BTP_L2CAP_SERVICE	3
 #define BTP_MESH_NODE_SERVICE	4
+#define BTP_BAP_SERVICE		14
 
 struct btp_hdr {
 	uint8_t service;
@@ -344,6 +345,21 @@ struct btp_gatt_write_rp {
 	uint8_t att_response;
 } __packed;
 
+#define BTP_OP_BAP_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_BAP_DISCOVER			0x02
+struct btp_bap_discover_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_EV_BAP_DISCOVERY_COMPLETED		0x80
+struct btp_bap_discovery_completed_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t status;
+} __packed;
+
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
-- 
2.43.0

