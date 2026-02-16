Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3F26FD93
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270309; cv=none; b=TbuAodR3jxbI9a+Qnj6Bq1IqqwsM/vsw2vZEy+z5C5vXz20tC8yDzQSbNTJJpJo6rV3CCsMR1kLLKoxctTwO0zNgjGdZDB86z4DLZCT/clxE2M4Bg/zBhGoFNlOxQkXXQsoeiU7hgwDD8m/OGruTgpSTD31BrOQh/STegiVgK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270309; c=relaxed/simple;
	bh=ZdzmqogjuiJMxP/bhRZtNAD9jyoc0tFrvJRwWHBqjlg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eL22i77dWb1h+LO/RTPWpirgefhMY0hMcqbjWa2JkF6lOe1MZavCl/JGsjMj4m0UHSqaQu82tFRj2KyKZFzmzNf8Pc9O1wgBWSuaDP0GxQt7RjJFBmJU6IlKiYYDTN5SrqFnRnoWdgGKSVFQVI0LcNw2kzaK+4wtJDlnKCEjvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bg6sMUUU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bg6sMUUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771270305;
	bh=ZdzmqogjuiJMxP/bhRZtNAD9jyoc0tFrvJRwWHBqjlg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bg6sMUUU/RiFHsXVehQ96QkYhguys0BnjAFMvZLGceuramdeYYotntGW9RGbFQBpf
	 bO0I0q3rQNUkH9wXEpWO4g5801OYWSsClCt1fiQkyCcei6ITi8kJALHLsF3nPa4cw4
	 Yy2ODEp5UHOd/KUIowc6kl3LadfW2tj/OM/sAWK43f6KjMzGPCVDKxyIk7nL+EJIAl
	 vorZtWpscUCiErDnhNm2rN4BJc06lSvNZ/XYVPNzmXBkdyE9QYlrpLqJGrVokCUU7P
	 cektcLzR9z3zv5uQgt7qqanxHblhMdl9syFzb84hsNr1xTefUP2Y8tOmSLY4ROQOUe
	 102+uJDUx6lSg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-4C10-12D9-233c-Cfc3.rev.sfr.net [IPv6:2a02:8428:af44:1001:4c10:12d9:233c:cfc3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 90B7C17E04DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 20:31:45 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] client/btpclient: Move btp core service in its own file
Date: Mon, 16 Feb 2026 20:31:35 +0100
Message-ID: <20260216193136.292051-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216193136.292051-1-frederic.danis@collabora.com>
References: <20260216193136.292051-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Moving the btp services in their own files will simplify maintenance.
---
v1->v2: Fix make distcheck

 Makefile.tools               |   4 +-
 client/btpclient/btpclient.c | 139 ++++----------------------------
 client/btpclient/btpclient.h |  12 +++
 client/btpclient/core.c      | 150 +++++++++++++++++++++++++++++++++++
 client/btpclient/core.h      |  10 +++
 5 files changed, 189 insertions(+), 126 deletions(-)
 create mode 100644 client/btpclient/btpclient.h
 create mode 100644 client/btpclient/core.c
 create mode 100644 client/btpclient/core.h

diff --git a/Makefile.tools b/Makefile.tools
index edfb5282c..823a1e1dd 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -586,7 +586,9 @@ if BTPCLIENT
 noinst_PROGRAMS += client/btpclient/btpclient client/btpclient/btpclientctl
 
 client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
-				src/shared/btp.c src/shared/btp.h
+				client/btpclient/btpclient.h \
+				src/shared/btp.c src/shared/btp.h \
+				client/btpclient/core.c client/btpclient/core.h
 client_btpclient_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 client/btpclient/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index b70e2b573..1e30f49eb 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -23,6 +23,8 @@
 
 #include "bluetooth/bluetooth.h"
 #include "src/shared/btp.h"
+#include "btpclient.h"
+#include "core.h"
 
 #define AD_PATH "/org/bluez/advertising"
 #define AG_PATH "/org/bluez/agent"
@@ -2769,138 +2771,25 @@ static void register_gap_service(void)
 					btp_gap_confirm_entry_rsp, NULL, NULL);
 }
 
-static void btp_core_read_commands(uint8_t index, const void *param,
-					uint16_t length, void *user_data)
-{
-	uint8_t commands = 0;
-
-	if (index != BTP_INDEX_NON_CONTROLLER) {
-		btp_send_error(btp, BTP_CORE_SERVICE, index,
-						BTP_ERROR_INVALID_INDEX);
-		return;
-	}
-
-	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_COMMANDS);
-	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_SERVICES);
-	commands |= (1 << BTP_OP_CORE_REGISTER);
-	commands |= (1 << BTP_OP_CORE_UNREGISTER);
-
-	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
-			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
-}
-
-static void btp_core_read_services(uint8_t index, const void *param,
-					uint16_t length, void *user_data)
-{
-	uint8_t services = 0;
-
-	if (index != BTP_INDEX_NON_CONTROLLER) {
-		btp_send_error(btp, BTP_CORE_SERVICE, index,
-						BTP_ERROR_INVALID_INDEX);
-		return;
-	}
-
-	services |= (1 << BTP_CORE_SERVICE);
-	services |= (1 << BTP_GAP_SERVICE);
-
-	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_SERVICES,
-			BTP_INDEX_NON_CONTROLLER, sizeof(services), &services);
-}
-
-static void btp_core_register(uint8_t index, const void *param,
-					uint16_t length, void *user_data)
+bool gap_register_service(void)
 {
-	const struct btp_core_register_cp  *cp = param;
-
-	if (length < sizeof(*cp))
-		goto failed;
-
-	if (index != BTP_INDEX_NON_CONTROLLER) {
-		btp_send_error(btp, BTP_CORE_SERVICE, index,
-						BTP_ERROR_INVALID_INDEX);
-		return;
-	}
-
-	switch (cp->service_id) {
-	case BTP_GAP_SERVICE:
-		if (gap_service_registered)
-			goto failed;
-
-		if (!register_default_agent(NULL,
-					BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT,
-					register_default_agent_reply))
-			goto failed;
-
-		return;
-	case BTP_GATT_SERVICE:
-	case BTP_L2CAP_SERVICE:
-	case BTP_MESH_NODE_SERVICE:
-	case BTP_CORE_SERVICE:
-	default:
-		goto failed;
-	}
-
-	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
-					BTP_INDEX_NON_CONTROLLER, 0, NULL);
-	return;
+	if (!register_default_agent(NULL,
+				BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT,
+				register_default_agent_reply))
+		return false;
 
-failed:
-	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
+	return true;
 }
 
-static void btp_core_unregister(uint8_t index, const void *param,
-					uint16_t length, void *user_data)
+void gap_unregister_service(void)
 {
-	const struct btp_core_unregister_cp  *cp = param;
-
-	if (length < sizeof(*cp))
-		goto failed;
-
-	if (index != BTP_INDEX_NON_CONTROLLER) {
-		btp_send_error(btp, BTP_CORE_SERVICE, index,
-						BTP_ERROR_INVALID_INDEX);
-		return;
-	}
-
-	switch (cp->service_id) {
-	case BTP_GAP_SERVICE:
-		if (!gap_service_registered)
-			goto failed;
-
-		btp_unregister_service(btp, BTP_GAP_SERVICE);
-		gap_service_registered = false;
-		break;
-	case BTP_GATT_SERVICE:
-	case BTP_L2CAP_SERVICE:
-	case BTP_MESH_NODE_SERVICE:
-	case BTP_CORE_SERVICE:
-	default:
-		goto failed;
-	}
-
-	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_UNREGISTER,
-					BTP_INDEX_NON_CONTROLLER, 0, NULL);
-	return;
-
-failed:
-	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
+	btp_unregister_service(btp, BTP_GAP_SERVICE);
+	gap_service_registered = false;
 }
 
-static void register_core_service(void)
+bool gap_is_service_registered(void)
 {
-	btp_register(btp, BTP_CORE_SERVICE,
-					BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
-					btp_core_read_commands, NULL, NULL);
-
-	btp_register(btp, BTP_CORE_SERVICE,
-					BTP_OP_CORE_READ_SUPPORTED_SERVICES,
-					btp_core_read_services, NULL, NULL);
-
-	btp_register(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
-						btp_core_register, NULL, NULL);
-
-	btp_register(btp, BTP_CORE_SERVICE, BTP_OP_CORE_UNREGISTER,
-					btp_core_unregister, NULL, NULL);
+	return gap_service_registered;
 }
 
 static void signal_handler(uint32_t signo, void *user_data)
@@ -3196,7 +3085,7 @@ static void client_ready(struct l_dbus_client *client, void *user_data)
 
 	btp_set_disconnect_handler(btp, btp_disconnect_handler, NULL, NULL);
 
-	register_core_service();
+	core_register_service(btp);
 
 	btp_send(btp, BTP_CORE_SERVICE, BTP_EV_CORE_READY,
 					BTP_INDEX_NON_CONTROLLER, 0, NULL);
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
new file mode 100644
index 000000000..467e48278
--- /dev/null
+++ b/client/btpclient/btpclient.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2017  Intel Corporation. All rights reserved.
+ *
+ */
+
+bool gap_register_service(void);
+void gap_unregister_service(void);
+bool gap_is_service_registered(void);
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
new file mode 100644
index 000000000..1b4fa0390
--- /dev/null
+++ b/client/btpclient/core.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2017  Intel Corporation. All rights reserved.
+ *
+ */
+
+#include <ell/ell.h>
+
+#include "bluetooth/bluetooth.h"
+#include "src/shared/btp.h"
+#include "btpclient.h"
+#include "core.h"
+
+static struct btp *btp;
+
+static void btp_core_read_commands(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint8_t commands = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_CORE_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_CORE_READ_SUPPORTED_SERVICES);
+	commands |= (1 << BTP_OP_CORE_REGISTER);
+	commands |= (1 << BTP_OP_CORE_UNREGISTER);
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+}
+
+static void btp_core_read_services(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint8_t services = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_CORE_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	services |= (1 << BTP_CORE_SERVICE);
+	services |= (1 << BTP_GAP_SERVICE);
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_SERVICES,
+			BTP_INDEX_NON_CONTROLLER, sizeof(services), &services);
+}
+
+static void btp_core_register(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const struct btp_core_register_cp  *cp = param;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_CORE_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	switch (cp->service_id) {
+	case BTP_GAP_SERVICE:
+		if (gap_is_service_registered())
+			goto failed;
+
+		if (!gap_register_service())
+			goto failed;
+
+		return;
+	case BTP_GATT_SERVICE:
+	case BTP_L2CAP_SERVICE:
+	case BTP_MESH_NODE_SERVICE:
+	case BTP_CORE_SERVICE:
+	default:
+		goto failed;
+	}
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+	return;
+
+failed:
+	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
+}
+
+static void btp_core_unregister(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const struct btp_core_unregister_cp  *cp = param;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_CORE_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	switch (cp->service_id) {
+	case BTP_GAP_SERVICE:
+		if (!gap_is_service_registered())
+			goto failed;
+
+		gap_unregister_service();
+		break;
+	case BTP_GATT_SERVICE:
+	case BTP_L2CAP_SERVICE:
+	case BTP_MESH_NODE_SERVICE:
+	case BTP_CORE_SERVICE:
+	default:
+		goto failed;
+	}
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_UNREGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+	return;
+
+failed:
+	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
+}
+
+void core_register_service(struct btp *btp_)
+{
+	btp = btp_;
+
+	btp_register(btp, BTP_CORE_SERVICE,
+					BTP_OP_CORE_READ_SUPPORTED_COMMANDS,
+					btp_core_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_CORE_SERVICE,
+					BTP_OP_CORE_READ_SUPPORTED_SERVICES,
+					btp_core_read_services, NULL, NULL);
+
+	btp_register(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
+					btp_core_register, NULL, NULL);
+
+	btp_register(btp, BTP_CORE_SERVICE, BTP_OP_CORE_UNREGISTER,
+					btp_core_unregister, NULL, NULL);
+}
diff --git a/client/btpclient/core.h b/client/btpclient/core.h
new file mode 100644
index 000000000..4c6d0437a
--- /dev/null
+++ b/client/btpclient/core.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2017  Intel Corporation. All rights reserved.
+ *
+ */
+
+void core_register_service(struct btp *btp);
-- 
2.43.0

