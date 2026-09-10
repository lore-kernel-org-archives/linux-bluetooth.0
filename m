Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888137AA64
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030167; cv=none; b=BDD8HL/FeKf+FlmNhXS5DA3aIWeu7+qoSr3cBlcvGXUdDndcBX4NBUa3g3WENf7y6mVgiQeYylWqU6c4bdwxqXWZZG4ePkDI+gWEpC/7WfHrVtUQo11atsx9zhYfQZsiWEHXGjSF728qIfY6ZPP1WLS72JSMTUYML9HrcrueDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030167; c=relaxed/simple;
	bh=EmOZeIpTGe9bqLFie4pqhEZkoHAhapU9uBiIZgLCzoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGeuzyyuPFgCBo6YzusVWvlDhaVOG0jlyrJM3YiCkpb+2+gBD8Yxkiy21E02XNXwAJq/C+W3Tm0+NmbG/3CI9MfY5DZBcYYEP+QrL2osvgOtqtgMOo/A493XYfKmFp5iCSYvx4dKTapO8mJwmLXxmH8euVmipqNc+4l3BL6KrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EPXEsBQ7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EPXEsBQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789030164;
	bh=EmOZeIpTGe9bqLFie4pqhEZkoHAhapU9uBiIZgLCzoQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EPXEsBQ7J0iX2/okLbgWl3wchSQAHlfj+XMBXUDtc5LGJqnuV0gEzfCIIw+WaEIrQ
	 fAA+wQH1S/DaRUJWb36Gti33rGSyFrm52u2y8INp5uwbQKe0GMVcc10mTfHA+oNKmy
	 CCCWb7kaW4raIMGpTD2qUtpRd1DLB+P49cYUWZRYRYtVui/iHSkICH4XmJVwClS61n
	 JZhpuGITtwa/Bzc/isPC2/lNM7uFgmRHo0e5k8WQtXnV7ssvTo2hesVl+9z+A4Zfa7
	 sebGeWZKQXcvApZUdxHTAunKVoTmFRZ+ikmcoZVFAvAtUcgT+OLcJLPNPqYpsy1nXV
	 WdH+mCAaQLKBw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0FD8B17E0CBE
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:49:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/8] client/btpclient: Add BTP_OP_PACS_SET_LOCATION support
Date: Thu, 10 Sep 2026 10:49:13 +0200
Message-ID: <20260910084917.23512-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910084917.23512-1-frederic.danis@collabora.com>
References: <20260910084917.23512-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows to store the expected location for a local endpoint.
---
 Makefile.tools               |   1 +
 client/btpclient/btpclient.h |   3 +
 client/btpclient/core.c      |  16 ++++++
 client/btpclient/pacs.c      | 107 +++++++++++++++++++++++++++++++++++
 client/btpclient/pacs.h      |  13 +++++
 src/shared/btp.h             |   9 +++
 6 files changed, 149 insertions(+)
 create mode 100644 client/btpclient/pacs.c
 create mode 100644 client/btpclient/pacs.h

diff --git a/Makefile.tools b/Makefile.tools
index 5c1130bff..0ca80a293 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -573,6 +573,7 @@ client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
 				client/btpclient/core.c client/btpclient/core.h \
 				client/btpclient/gap.c client/btpclient/gap.h \
 				client/btpclient/gatt.c client/btpclient/gatt.h \
+				client/btpclient/pacs.c client/btpclient/pacs.h \
 				client/btpclient/vendor.c client/btpclient/vendor.h
 client_btpclient_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 0d81405d3..2ba612ade 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -19,6 +19,9 @@ struct btp_adapter {
 	uint32_t default_settings;
 	struct l_queue *devices;
 
+	uint32_t sink_locations;
+	uint32_t source_locations;
+
 	uint8_t target_latency;
 };
 
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
index 8ab3f3e34..bbbc7edfd 100644
--- a/client/btpclient/core.c
+++ b/client/btpclient/core.c
@@ -18,6 +18,7 @@
 #include "core.h"
 #include "gap.h"
 #include "gatt.h"
+#include "pacs.h"
 #include "vendor.h"
 
 static struct btp *btp;
@@ -67,6 +68,7 @@ static void btp_core_read_services(uint8_t index, const void *param,
 		BTP_CORE_SERVICE,
 		BTP_GAP_SERVICE,
 		BTP_GATT_SERVICE,
+		BTP_PACS_SERVICE,
 		BTP_ASCS_SERVICE,
 		BTP_BAP_SERVICE,
 		BTP_VENDOR_SERVICE,
@@ -130,6 +132,14 @@ static void btp_core_register(uint8_t index, const void *param,
 		if (!gatt_register_service(btp, dbus, client))
 			goto failed;
 
+		break;
+	case BTP_PACS_SERVICE:
+		if (pacs_is_service_registered())
+			goto failed;
+
+		if (!pacs_register_service(btp, dbus, client))
+			goto failed;
+
 		break;
 	case BTP_ASCS_SERVICE:
 		if (ascs_is_service_registered())
@@ -197,6 +207,12 @@ static void btp_core_unregister(uint8_t index, const void *param,
 
 		gatt_unregister_service(btp);
 		break;
+	case BTP_PACS_SERVICE:
+		if (!pacs_is_service_registered())
+			goto failed;
+
+		ascs_unregister_service(btp);
+		break;
 	case BTP_ASCS_SERVICE:
 		if (!ascs_is_service_registered())
 			goto failed;
diff --git a/client/btpclient/pacs.c b/client/btpclient/pacs.c
new file mode 100644
index 000000000..6277812a0
--- /dev/null
+++ b/client/btpclient/pacs.c
@@ -0,0 +1,107 @@
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
+#include <ell/ell.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+#include "src/shared/btp.h"
+#include "btpclient.h"
+#include "pacs.h"
+
+static struct btp *btp;
+static bool pacs_service_registered;
+
+static void btp_pacs_read_commands(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const uint8_t supported_commands[] = {
+		BTP_OP_PACS_READ_SUPPORTED_COMMANDS,
+		BTP_OP_PACS_SET_LOCATION,
+	};
+	uint8_t *commands = NULL;
+	size_t commands_len = 0;
+	size_t i;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_PACS_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	for (i = 0; i < L_ARRAY_SIZE(supported_commands); i++) {
+		if (!add_supported_command(&commands, &commands_len,
+						supported_commands[i]))
+			goto failed;
+	}
+
+	btp_send(btp, BTP_PACS_SERVICE, BTP_OP_PACS_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, commands_len, commands);
+
+	l_free(commands);
+
+	return;
+
+failed:
+	l_free(commands);
+	btp_send_error(btp, BTP_PACS_SERVICE, index, BTP_ERROR_FAIL);
+}
+
+static void btp_pacs_set_location(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_pacs_set_location_cp *cp = param;
+
+	switch (cp->dir) {
+	case BTP_BAP_DIR_SINK:
+		adapter->sink_locations = cp->location;
+		break;
+	case BTP_BAP_DIR_SOURCE:
+		adapter->source_locations = cp->location;
+		break;
+	default:
+		btp_send_error(btp, BTP_PACS_SERVICE, index, BTP_ERROR_FAIL);
+		return;
+	}
+
+	btp_send(btp, BTP_PACS_SERVICE, BTP_OP_PACS_SET_LOCATION, index, 0,
+									NULL);
+}
+
+bool pacs_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client)
+{
+	btp = btp_;
+
+	btp_register(btp, BTP_PACS_SERVICE, BTP_OP_PACS_READ_SUPPORTED_COMMANDS,
+					btp_pacs_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_PACS_SERVICE, BTP_OP_PACS_SET_LOCATION,
+					btp_pacs_set_location, NULL, NULL);
+
+	pacs_service_registered = true;
+
+	return true;
+}
+
+void pacs_unregister_service(struct btp *btp)
+{
+	btp_unregister_service(btp, BTP_PACS_SERVICE);
+	pacs_service_registered = false;
+}
+
+bool pacs_is_service_registered(void)
+{
+	return pacs_service_registered;
+}
diff --git a/client/btpclient/pacs.h b/client/btpclient/pacs.h
new file mode 100644
index 000000000..a1579a8d6
--- /dev/null
+++ b/client/btpclient/pacs.h
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
+bool pacs_register_service(struct btp *btp_, struct l_dbus *dbus_,
+					struct l_dbus_client *client);
+void pacs_unregister_service(struct btp *btp);
+bool pacs_is_service_registered(void);
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 65a8c8b6a..8ad57f48f 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -26,6 +26,7 @@
 #define BTP_GATT_SERVICE	2
 #define BTP_L2CAP_SERVICE	3
 #define BTP_MESH_NODE_SERVICE	4
+#define BTP_PACS_SERVICE	12
 #define BTP_ASCS_SERVICE	13
 #define BTP_BAP_SERVICE		14
 #define BTP_VENDOR_SERVICE	255
@@ -427,6 +428,14 @@ struct btp_gatt_write_rp {
 	uint8_t att_response;
 } __packed;
 
+#define BTP_OP_PACS_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_PACS_SET_LOCATION		0x03
+struct btp_pacs_set_location_cp {
+	uint8_t dir;
+	uint32_t location;
+} __packed;
+
 #define BTP_OP_ASCS_READ_SUPPORTED_COMMANDS	0x01
 
 #define BTP_OP_ASCS_CONFIGURE_CODEC		0x02
-- 
2.43.0

