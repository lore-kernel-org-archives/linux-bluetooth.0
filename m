Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356A347FEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878489; cv=none; b=b68pJ+iQVGEziGnTIi/0RxjQ5MhvIa6KlFn9+0r9i+46renE4DzV/+L7rCO38LovsxF2ShLYQeuUnwClLHOUO4428eDtM2/ZoLzANHu0MuOFABw32SW5av4O1IrMMIY6/jcp6sWJStQmA2ZYsoADBNbdus1kcGPtwWS3b/SPWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878489; c=relaxed/simple;
	bh=/U4+tPLs356uPzvfqOEJzWi7jkqSMPs5UJgLG5zt0bQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evDhW9usuYCqqU178BYTzx+jZYnDrv0LB0DCb87kqHUV3DQNgjabn/Uk1QSzW2d07z1DAIyQEWUfe+yVQTmtQ7r+aeIIO1tuBkoc2UjC03O8t7aVgpVgA0T35Ll1VMts9D2RkT7frdX6ORTmdHd4Vvbeqg4nyDiBtCpb3uchPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cxJ9Y1kf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cxJ9Y1kf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771878485;
	bh=/U4+tPLs356uPzvfqOEJzWi7jkqSMPs5UJgLG5zt0bQ=;
	h=From:To:Subject:Date:From;
	b=cxJ9Y1kfLvGpvH/2G1T1eIzUpm4WShforLRyTSF95y8TMYtAIIZI4DZ7dehKcI/4r
	 leaRlTfNciQXTfUn6OoY1kTS/xIc0m9Ia+xs5XSjWMsQGFcRu2YIxr0i8RedK4ed9+
	 0fDG3OZ7I7tbQbVObR547p2jdNsfqrWNW+wwU8UUc5mLOgdy3kyKnaxTSHJg+lNBFz
	 gWZzCdJiX1ojW2/28rxeXWYOu27gXCDONsYLfhsuJ7LAr2ssU65gLVtv5ez389TzvV
	 SdbRKTQ46cuzX05QEzjCagLzRN1uN0fNqlLaXqAIiBrsaldWQuYPW1+zwDLYuU85Jb
	 RvlDb+X3Uy0gg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-AF44-1001-0F6F-A0f8-dADF-0a2C.rev.sfr.net [IPv6:2a02:8428:af44:1001:f6f:a0f8:dadf:a2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 630B417E06CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 21:28:05 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] client/btpclient: Move BTP definitions per service
Date: Mon, 23 Feb 2026 21:27:58 +0100
Message-ID: <20260223202758.260251-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Over the years, BTP interface has grown way over what has been
initially anticipated in terms of number of services and commands.

To simplify addition and maintenance of new services this commit
split the commands in btp.h per services and move them under
client/btpclient/btp folder.
---
 Makefile.tools                  |   2 +
 client/btpclient/btp/core.h     |  24 ++++
 client/btpclient/btp/gap.h      | 236 ++++++++++++++++++++++++++++++
 client/btpclient/btpclient.c    |   1 +
 client/btpclient/btpclientctl.c |   1 +
 client/btpclient/core.c         |   1 +
 client/btpclient/gap.c          |   2 +-
 client/btpclient/services.h     |  11 ++
 src/shared/btp.h                | 244 --------------------------------
 9 files changed, 277 insertions(+), 245 deletions(-)
 create mode 100644 client/btpclient/btp/core.h
 create mode 100644 client/btpclient/btp/gap.h
 create mode 100644 client/btpclient/services.h

diff --git a/Makefile.tools b/Makefile.tools
index 589f7c94f..3aa11ab70 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -588,6 +588,8 @@ noinst_PROGRAMS += client/btpclient/btpclient client/btpclient/btpclientctl
 client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
 				client/btpclient/btpclient.h \
 				src/shared/btp.c src/shared/btp.h \
+				client/btpclient/btp/core.h client/btpclient/btp/gap.h\
+				client/btpclient/services.h \
 				client/btpclient/core.c client/btpclient/core.h \
 				client/btpclient/gap.c client/btpclient/gap.h
 client_btpclient_btpclient_LDADD = lib/libbluetooth-internal.la \
diff --git a/client/btpclient/btp/core.h b/client/btpclient/btp/core.h
new file mode 100644
index 000000000..100b9b5c5
--- /dev/null
+++ b/client/btpclient/btp/core.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2017  Intel Corporation. All rights reserved.
+ *
+ */
+
+#define BTP_OP_CORE_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_CORE_READ_SUPPORTED_SERVICES	0x02
+
+#define BTP_OP_CORE_REGISTER			0x03
+struct btp_core_register_cp {
+	uint8_t service_id;
+} __packed;
+
+#define BTP_OP_CORE_UNREGISTER			0x04
+struct btp_core_unregister_cp {
+	uint8_t service_id;
+} __packed;
+
+#define BTP_EV_CORE_READY			0x80
diff --git a/client/btpclient/btp/gap.h b/client/btpclient/btp/gap.h
new file mode 100644
index 000000000..309a633dd
--- /dev/null
+++ b/client/btpclient/btp/gap.h
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2017  Intel Corporation. All rights reserved.
+ *
+ */
+
+#define BTP_OP_GAP_READ_SUPPORTED_COMMANDS	0x01
+
+#define BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST	0x02
+struct btp_gap_read_index_rp {
+	uint8_t num;
+	uint8_t indexes[];
+} __packed;
+
+#define BTP_GAP_SETTING_POWERED			0x00000001
+#define BTP_GAP_SETTING_CONNECTABLE		0x00000002
+#define BTP_GAP_SETTING_FAST_CONNECTABLE	0x00000004
+#define BTP_GAP_SETTING_DISCOVERABLE		0x00000008
+#define BTP_GAP_SETTING_BONDABLE		0x00000010
+#define BTP_GAP_SETTING_LL_SECURITY		0x00000020
+#define BTP_GAP_SETTING_SSP			0x00000040
+#define BTP_GAP_SETTING_BREDR			0x00000080
+#define BTP_GAP_SETTING_HS			0x00000100
+#define BTP_GAP_SETTING_LE			0x00000200
+#define BTP_GAP_SETTING_ADVERTISING		0x00000400
+#define BTP_GAP_SETTING_SC			0x00000800
+#define BTP_GAP_SETTING_DEBUG_KEYS		0x00001000
+#define BTP_GAP_SETTING_PRIVACY			0x00002000
+#define BTP_GAP_SETTING_CONTROLLER_CONF		0x00004000
+#define BTP_GAP_SETTING_STATIC_ADDRESS		0x00008000
+
+#define BTP_OP_GAP_READ_CONTROLLER_INFO		0x03
+struct btp_gap_read_info_rp {
+	bdaddr_t address;
+	uint32_t supported_settings;
+	uint32_t current_settings;
+	uint8_t cod[3];
+	uint8_t name[249];
+	uint8_t short_name[11];
+} __packed;
+
+#define BTP_OP_GAP_RESET			0x04
+struct btp_gap_reset_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_SET_POWERED			0x05
+struct btp_gap_set_powered_cp {
+	uint8_t powered;
+} __packed;
+
+struct btp_gap_set_powered_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_SET_CONNECTABLE		0x06
+struct btp_gap_set_connectable_cp {
+	uint8_t connectable;
+} __packed;
+
+struct btp_gap_set_connectable_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_SET_FAST_CONNECTABLE		0x07
+struct btp_gap_set_fast_connectable_cp {
+	uint8_t fast_connectable;
+} __packed;
+
+struct btp_gap_set_fast_connectable_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_SET_DISCOVERABLE		0x08
+struct btp_gap_set_discoverable_cp {
+	uint8_t discoverable;
+} __packed;
+
+struct btp_gap_set_discoverable_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_SET_BONDABLE			0x09
+struct btp_gap_set_bondable_cp {
+	uint8_t bondable;
+} __packed;
+
+struct btp_gap_set_bondable_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_START_ADVERTISING		0x0a
+struct btp_gap_start_adv_cp {
+	uint8_t adv_data_len;
+	uint8_t scan_rsp_len;
+	uint8_t data[];
+} __packed;
+
+struct btp_gap_start_adv_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_OP_GAP_STOP_ADVERTISING		0x0b
+struct btp_gap_stop_adv_rp {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_GAP_DISCOVERY_FLAG_LE		0x01
+#define BTP_GAP_DISCOVERY_FLAG_BREDR		0x02
+#define BTP_GAP_DISCOVERY_FLAG_LIMITED		0x04
+#define BTP_GAP_DISCOVERY_FLAG_ACTIVE		0x08
+#define BTP_GAP_DISCOVERY_FLAG_OBSERVATION	0x10
+
+#define BTP_OP_GAP_START_DISCOVERY		0x0c
+struct btp_gap_start_discovery_cp {
+	uint8_t flags;
+} __packed;
+
+#define BTP_OP_GAP_STOP_DISCOVERY		0x0d
+
+#define BTP_GAP_ADDR_PUBLIC			0x00
+#define BTP_GAP_ADDR_RANDOM			0x01
+
+#define BTP_OP_GAP_CONNECT			0x0e
+struct btp_gap_connect_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_OP_GAP_DISCONNECT			0x0f
+struct btp_gap_disconnect_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_GAP_IOCAPA_DISPLAY_ONLY		0x00
+#define BTP_GAP_IOCAPA_DISPLAY_YESNO		0x01
+#define BTP_GAP_IOCAPA_KEYBOARD_ONLY		0x02
+#define BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT	0x03
+#define BTP_GAP_IOCAPA_KEYBOARD_DISPLAY		0x04
+
+#define BTP_OP_GAP_SET_IO_CAPA			0x10
+struct btp_gap_set_io_capa_cp {
+	uint8_t capa;
+} __packed;
+
+#define BTP_OP_GAP_PAIR				0x11
+struct btp_gap_pair_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_OP_GAP_UNPAIR			0x12
+struct btp_gap_unpair_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_OP_GAP_PASSKEY_ENTRY_RSP		0x13
+struct btp_gap_passkey_entry_rsp_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint32_t passkey;
+} __packed;
+
+#define BTP_OP_GAP_PASSKEY_CONFIRM_RSP		0x14
+struct btp_gap_passkey_confirm_rsp_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t match;
+} __packed;
+
+#define BTP_EV_GAP_NEW_SETTINGS			0x80
+struct btp_new_settings_ev {
+	uint32_t current_settings;
+} __packed;
+
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI	0x01
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_AD		0x02
+#define BTP_EV_GAP_DEVICE_FOUND_FLAG_SR		0x04
+
+#define BTP_EV_GAP_DEVICE_FOUND			0x81
+struct btp_device_found_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	int8_t rssi;
+	uint8_t flags;
+	uint16_t eir_len;
+	uint8_t eir[];
+} __packed;
+
+#define BTP_EV_GAP_DEVICE_CONNECTED		0x82
+struct btp_gap_device_connected_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint16_t connection_interval;
+	uint16_t connection_latency;
+	uint16_t supervision_timeout;
+} __packed;
+
+#define BTP_EV_GAP_DEVICE_DISCONNECTED		0x83
+struct btp_gap_device_disconnected_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_EV_GAP_PASSKEY_DISPLAY		0x84
+struct btp_gap_passkey_display_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint32_t passkey;
+} __packed;
+
+#define BTP_EV_GAP_PASSKEY_REQUEST		0x85
+struct btp_gap_passkey_req_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+} __packed;
+
+#define BTP_EV_GAP_PASSKEY_CONFIRM		0x86
+struct btp_gap_passkey_confirm_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint32_t passkey;
+} __packed;
+
+#define BTP_EV_GAP_IDENTITY_RESOLVED		0x87
+struct btp_gap_identity_resolved_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t identity_address_type;
+	bdaddr_t identity_address;
+} __packed;
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index e46d2366f..90f34ef75 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -26,6 +26,7 @@
 #include "btpclient.h"
 #include "core.h"
 #include "gap.h"
+#include "services.h"
 
 static struct l_dbus *dbus;
 
diff --git a/client/btpclient/btpclientctl.c b/client/btpclient/btpclientctl.c
index df8d12e94..3a92071cf 100644
--- a/client/btpclient/btpclientctl.c
+++ b/client/btpclient/btpclientctl.c
@@ -31,6 +31,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
+#include "services.h"
 
 #define DEFAULT_SOCKET_PATH	"/tmp/bt-stack-tester"
 
diff --git a/client/btpclient/core.c b/client/btpclient/core.c
index c0b8d6b74..04064a76d 100644
--- a/client/btpclient/core.c
+++ b/client/btpclient/core.c
@@ -14,6 +14,7 @@
 #include "btpclient.h"
 #include "core.h"
 #include "gap.h"
+#include "services.h"
 
 static struct btp *btp;
 static struct l_dbus *dbus;
diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 85cdad631..1f93f689e 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -18,8 +18,8 @@
 #include "bluetooth/bluetooth.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
-#include "core.h"
 #include "gap.h"
+#include "services.h"
 
 #define AD_PATH "/org/bluez/advertising"
 #define AG_PATH "/org/bluez/agent"
diff --git a/client/btpclient/services.h b/client/btpclient/services.h
new file mode 100644
index 000000000..fd50213f4
--- /dev/null
+++ b/client/btpclient/services.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Collabora Ltd.
+ *
+ */
+
+#include "btp/core.h"
+#include "btp/gap.h"
diff --git a/src/shared/btp.h b/src/shared/btp.h
index ad18cfb3a..fcc0e7511 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -41,250 +41,6 @@ struct btp_error {
 
 #define BTP_OP_ERROR				0x00
 
-#define BTP_OP_CORE_READ_SUPPORTED_COMMANDS	0x01
-
-#define BTP_OP_CORE_READ_SUPPORTED_SERVICES	0x02
-
-#define BTP_OP_CORE_REGISTER			0x03
-struct btp_core_register_cp {
-	uint8_t service_id;
-} __packed;
-
-#define BTP_OP_CORE_UNREGISTER			0x04
-struct btp_core_unregister_cp {
-	uint8_t service_id;
-} __packed;
-
-#define BTP_EV_CORE_READY			0x80
-
-#define BTP_OP_GAP_READ_SUPPORTED_COMMANDS	0x01
-
-#define BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST	0x02
-struct btp_gap_read_index_rp {
-	uint8_t num;
-	uint8_t indexes[0];
-} __packed;
-
-#define BTP_GAP_SETTING_POWERED			0x00000001
-#define BTP_GAP_SETTING_CONNECTABLE		0x00000002
-#define BTP_GAP_SETTING_FAST_CONNECTABLE	0x00000004
-#define BTP_GAP_SETTING_DISCOVERABLE		0x00000008
-#define BTP_GAP_SETTING_BONDABLE		0x00000010
-#define BTP_GAP_SETTING_LL_SECURITY		0x00000020
-#define BTP_GAP_SETTING_SSP			0x00000040
-#define BTP_GAP_SETTING_BREDR			0x00000080
-#define BTP_GAP_SETTING_HS			0x00000100
-#define BTP_GAP_SETTING_LE			0x00000200
-#define BTP_GAP_SETTING_ADVERTISING		0x00000400
-#define BTP_GAP_SETTING_SC			0x00000800
-#define BTP_GAP_SETTING_DEBUG_KEYS		0x00001000
-#define BTP_GAP_SETTING_PRIVACY			0x00002000
-#define BTP_GAP_SETTING_CONTROLLER_CONF		0x00004000
-#define BTP_GAP_SETTING_STATIC_ADDRESS		0x00008000
-
-#define BTP_OP_GAP_READ_CONTROLLER_INFO		0x03
-struct btp_gap_read_info_rp {
-	bdaddr_t address;
-	uint32_t supported_settings;
-	uint32_t current_settings;
-	uint8_t cod[3];
-	uint8_t name[249];
-	uint8_t short_name[11];
-} __packed;
-
-#define BTP_OP_GAP_RESET			0x04
-struct btp_gap_reset_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_SET_POWERED			0x05
-struct btp_gap_set_powered_cp {
-	uint8_t powered;
-} __packed;
-
-struct btp_gap_set_powered_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_SET_CONNECTABLE		0x06
-struct btp_gap_set_connectable_cp {
-	uint8_t connectable;
-} __packed;
-
-struct btp_gap_set_connectable_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_SET_FAST_CONNECTABLE		0x07
-struct btp_gap_set_fast_connectable_cp {
-	uint8_t fast_connectable;
-} __packed;
-
-struct btp_gap_set_fast_connectable_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_SET_DISCOVERABLE		0x08
-struct btp_gap_set_discoverable_cp {
-	uint8_t discoverable;
-} __packed;
-
-struct btp_gap_set_discoverable_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_SET_BONDABLE			0x09
-struct btp_gap_set_bondable_cp {
-	uint8_t bondable;
-} __packed;
-
-struct btp_gap_set_bondable_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_START_ADVERTISING		0x0a
-struct btp_gap_start_adv_cp {
-	uint8_t adv_data_len;
-	uint8_t scan_rsp_len;
-	uint8_t data[0];
-} __packed;
-
-struct btp_gap_start_adv_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_OP_GAP_STOP_ADVERTISING		0x0b
-struct btp_gap_stop_adv_rp {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_GAP_DISCOVERY_FLAG_LE		0x01
-#define BTP_GAP_DISCOVERY_FLAG_BREDR		0x02
-#define BTP_GAP_DISCOVERY_FLAG_LIMITED		0x04
-#define BTP_GAP_DISCOVERY_FLAG_ACTIVE		0x08
-#define BTP_GAP_DISCOVERY_FLAG_OBSERVATION	0x10
-
-#define BTP_OP_GAP_START_DISCOVERY		0x0c
-struct btp_gap_start_discovery_cp {
-	uint8_t flags;
-} __packed;
-
-#define BTP_OP_GAP_STOP_DISCOVERY		0x0d
-
-#define BTP_GAP_ADDR_PUBLIC			0x00
-#define BTP_GAP_ADDR_RANDOM			0x01
-
-#define BTP_OP_GAP_CONNECT			0x0e
-struct btp_gap_connect_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_OP_GAP_DISCONNECT			0x0f
-struct btp_gap_disconnect_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_GAP_IOCAPA_DISPLAY_ONLY		0x00
-#define BTP_GAP_IOCAPA_DISPLAY_YESNO		0x01
-#define BTP_GAP_IOCAPA_KEYBOARD_ONLY		0x02
-#define BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT	0x03
-#define BTP_GAP_IOCAPA_KEYBOARD_DISPLAY		0x04
-
-#define BTP_OP_GAP_SET_IO_CAPA			0x10
-struct btp_gap_set_io_capa_cp {
-	uint8_t capa;
-} __packed;
-
-#define BTP_OP_GAP_PAIR				0x11
-struct btp_gap_pair_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_OP_GAP_UNPAIR			0x12
-struct btp_gap_unpair_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_OP_GAP_PASSKEY_ENTRY_RSP		0x13
-struct btp_gap_passkey_entry_rsp_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint32_t passkey;
-} __packed;
-
-#define BTP_OP_GAP_PASSKEY_CONFIRM_RSP		0x14
-struct btp_gap_passkey_confirm_rsp_cp {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint8_t match;
-} __packed;
-
-#define BTP_EV_GAP_NEW_SETTINGS			0x80
-struct btp_new_settings_ev {
-	uint32_t current_settings;
-} __packed;
-
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI	0x01
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_AD		0x02
-#define BTP_EV_GAP_DEVICE_FOUND_FLAG_SR		0x04
-
-#define BTP_EV_GAP_DEVICE_FOUND			0x81
-struct btp_device_found_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-	int8_t rssi;
-	uint8_t flags;
-	uint16_t eir_len;
-	uint8_t eir[0];
-} __packed;
-
-#define BTP_EV_GAP_DEVICE_CONNECTED		0x82
-struct btp_gap_device_connected_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint16_t connection_interval;
-	uint16_t connection_latency;
-	uint16_t supervision_timeout;
-} __packed;
-
-#define BTP_EV_GAP_DEVICE_DISCONNECTED		0x83
-struct btp_gap_device_disconnected_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_EV_GAP_PASSKEY_DISPLAY		0x84
-struct btp_gap_passkey_display_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint32_t passkey;
-} __packed;
-
-#define BTP_EV_GAP_PASSKEY_REQUEST		0x85
-struct btp_gap_passkey_req_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-} __packed;
-
-#define BTP_EV_GAP_PASSKEY_CONFIRM		0x86
-struct btp_gap_passkey_confirm_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint32_t passkey;
-} __packed;
-
-#define BTP_EV_GAP_IDENTITY_RESOLVED		0x87
-struct btp_gap_identity_resolved_ev {
-	uint8_t address_type;
-	bdaddr_t address;
-	uint8_t identity_address_type;
-	bdaddr_t identity_address;
-} __packed;
-
 struct btp;
 
 typedef void (*btp_destroy_func_t)(void *user_data);
-- 
2.43.0

