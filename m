Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0143C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382093AbhLCQNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:13:19 -0500
Received: from smtp202-pc.aruba.it ([62.149.157.202]:36198 "EHLO
        smtp200-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1382081AbhLCQMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 11:12:49 -0500
Received: from danbia2MBL ([188.217.48.39])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tB0vmxOChrBxFtB0xmsYOA; Fri, 03 Dec 2021 17:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638547343; bh=axnz2iXZOpsRaOM1yJe8Gz9PwCsF1ixzct8ePXQAx8s=;
        h=From:To:Subject:Date:MIME-Version:Content-Type;
        b=BqmIu831hcNeDB5KJ7yJoCmc8OIGu+YIgt40ukt2dfsOtxgB/fvljMJAwtuoRfY3g
         kfa8blE7NJWyAdYZaW3cD8Cl8LDYmbswFTdfN2n0bFP0eDf/74DCfgJuFU+/dOz2Vt
         kpGbbLUthM3AStzl0h+C9EATyOkUDE6kZK7puWe3HcPYz/fhMXMDaf+i8XMbmY+Q48
         0/Fwaozn+pTD4c2tcyUyhsyuZLh4jIklexhLeUvty17qrPkiHlIIjJMLfYmjF7MWXD
         uhLY2bKUgFO0oaJJA8oASPQx8CuIbGe4i/0GRqwOpf9wxSIyBu3oho9oHARykGd+Lb
         ch5JeZ4NTIvUw==
From:   <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 6/6] tools/mesh-gatt: Add generic power onoff client model
Date:   Fri, 3 Dec 2021 17:02:22 +0100
Message-ID: <000a01d7e85f$27fedbf0$77fc93d0$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfoXpcU6cWukPw3RuyAQPiuJHNBOA==
Content-Language: it
X-CMAE-Envelope: MS4xfIzP7DPMWkNgiMxSkbALpDpmuMIEmBt/zojNoxfmwqPEPwtGDrNhgaAPnpd/ZPeKv76jU5Z5dXoneDns16bMxWehsuJVyK6wHB784HKyunulUAIELzqK
 XV0PeV86KTiUMnm8blqYiUeZkKCa6RNzPFUT3RNTlg00aycJxVstGgQvti4z9IS+zs/DADVvvMbY2/258vuQEgnm2LT2/x5hSVMTz488noHEh2NlcFVCsYtO
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.tools                    |   4 +-
 tools/mesh-gatt/local_node.json   |   6 +-
 tools/mesh-gatt/onpowerup-model.c | 250 ++++++++++++++++++++++++++++++
 tools/mesh-gatt/onpowerup-model.h |  21 +++
 tools/meshctl.c                   |   4 +
 5 files changed, 283 insertions(+), 2 deletions(-)
 create mode 100644 tools/mesh-gatt/onpowerup-model.c
 create mode 100644 tools/mesh-gatt/onpowerup-model.h

diff --git a/Makefile.tools b/Makefile.tools
index c0d2e27de..f9fecfe9d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -333,7 +333,9 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 				tools/mesh-gatt/onoff-model.h \
 				tools/mesh-gatt/onoff-model.c \
 				tools/mesh-gatt/level-model.h \
-				tools/mesh-gatt/level-model.c
+				tools/mesh-gatt/level-model.c \
+				tools/mesh-gatt/onpowerup-model.h \
+				tools/mesh-gatt/onpowerup-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c
-lreadline
diff --git a/tools/mesh-gatt/local_node.json
b/tools/mesh-gatt/local_node.json
index 462cd815d..2c332eb1c 100644
--- a/tools/mesh-gatt/local_node.json
+++ b/tools/mesh-gatt/local_node.json
@@ -36,7 +36,7 @@
             {
                 "elementIndex": 0,
                 "location": "0001",
-                "models": ["0000", "0001", "1001", "1003"]
+                "models": ["0000", "0001", "1001", "1003", "1008"]
             }
         ]
     },
@@ -56,6 +56,10 @@
                 {
                  "modelId": "1003",
                  "bind": [1]
+                },
+                {
+                 "modelId": "1008",
+                 "bind": [1]
                 }
             ]
           }
diff --git a/tools/mesh-gatt/onpowerup-model.c
b/tools/mesh-gatt/onpowerup-model.c
new file mode 100644
index 000000000..4ae7713e4
--- /dev/null
+++ b/tools/mesh-gatt/onpowerup-model.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <sys/uio.h>
+#include <wordexp.h>
+#include <readline/readline.h>
+#include <readline/history.h>
+#include <glib.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/util.h"
+
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/onpowerup-model.h"
+
+static uint8_t trans_id;
+static uint16_t power_onoff_app_idx = APP_IDX_INVALID;
+
+static int client_bind(uint16_t app_idx, int action)
+{
+	if (action == ACTION_ADD) {
+                if (power_onoff_app_idx != APP_IDX_INVALID) {
+			return MESH_STATUS_INSUFF_RESOURCES;
+		} else {
+                        power_onoff_app_idx = app_idx;
+                        bt_shell_printf("OnPowerUp client model: new
binding"
+					" %4.4x\n", app_idx);
+		}
+	} else {
+                if (power_onoff_app_idx == app_idx)
+                        power_onoff_app_idx = APP_IDX_INVALID;
+	}
+	return MESH_STATUS_SUCCESS;
+}
+
+static bool client_msg_recvd(uint16_t src, uint8_t *data,
+				uint16_t len, void *user_data)
+{
+	uint32_t opcode;
+	int n;
+        char s[10];
+
+	if (mesh_opcode_get(data, len, &opcode, &n)) {
+		len -= n;
+		data += n;
+	} else
+		return false;
+
+	switch (opcode) {
+	default:
+		return false;
+
+        case OP_GENERIC_POWER_ONOFF_STATUS:
+                bt_shell_printf("OnPowerUp Model Message received (%d)
opcode %x\n",
+
len, opcode);
+                print_byte_array("\t",data, len);
+                if (len != 1)
+                        break;
+                if(data[0] == 0){
+                    sprintf(s, "%s", "OFF");
+                }else if(data[0] == 1){
+                    sprintf(s, "%s", "ON");
+                }else if(data[0] == 2){
+                    sprintf(s, "%s", "RESUME");
+                }else{
+                    sprintf(s, "%s", "?UNKNOWN");
+                }
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present =
%s\n", src, s);
+                break;
+	}
+	return true;
+}
+
+
+static uint32_t target;
+static uint32_t parms[8];
+
+static uint32_t read_input_parameters(int argc, char *argv[])
+{
+	uint32_t i;
+
+	if (!argc)
+		return 0;
+
+	--argc;
+	++argv;
+
+	if (!argc || argv[0][0] == '\0')
+		return 0;
+
+	memset(parms, 0xff, sizeof(parms));
+
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned)
argc;
+									i++)
{
+		sscanf(argv[i], "%x", &parms[i]);
+		if (parms[i] == 0xffffffff)
+			break;
+	}
+
+	return i;
+}
+
+static void cmd_set_node(int argc, char *argv[])
+{
+	uint32_t dst;
+	char *end;
+
+	dst = strtol(argv[1], &end, 16);
+	if (end != (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: "
+				"expected format 4 digit hex\n", argv[1]);
+		target = UNASSIGNED_ADDRESS;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
+                bt_shell_printf("Controlling OnPowerUp for node %4.4x\n",
dst);
+		target = dst;
+                set_menu_prompt("OnPowerUp", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+}
+
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node = node_get_local_node();
+	uint8_t ttl;
+
+	if(!node)
+		return false;
+
+	ttl = node_get_default_ttl(node);
+
+	return net_access_layer_send(ttl, node_get_primary(node),
+                                        target, power_onoff_app_idx, buf,
len);
+}
+
+static void cmd_get_status(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	node = node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+        }
+
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_GET, msg);
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF
GET\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_set(int argc, char *argv[])
+{
+	uint16_t n;
+	uint8_t msg[32];
+	struct mesh_node *node;
+
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	node = node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+        }
+
+	if ((read_input_parameters(argc, argv) != 1) &&
+                                        parms[0] != 0 && parms[0] != 1 &&
parms[0] != 2) {
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" or
\"2\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_SET, msg);
+	msg[n++] = parms[0];
+	msg[n++] = trans_id++;
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF
SET\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu power_onoff_menu = {
+        .name = "power_onoff",
+        .desc = "Power OnOff (OnPowerUp) Model Submenu",
+	.entries = {
+	{"target",		"<unicast>",
cmd_set_node,
+						"Set node to configure"},
+	{"get",			NULL,
cmd_get_status,
+                                                "Get OnPowerUp status"},
+        {"set",                 "<0/1/2>",			cmd_set,
+                                                "Set OnPowerUp status
(OFF/ON/RESTORE)"},
+	{} },
+};
+
+static struct mesh_model_ops client_cbs = {
+	client_msg_recvd,
+	client_bind,
+	NULL,
+	NULL
+};
+
+bool power_onoff_client_init(uint8_t ele)
+{
+        if (!node_local_model_register(ele,
GENERIC_POWER_ONOFF_CLIENT_MODEL_ID,
+					&client_cbs, NULL))
+		return false;
+
+        bt_shell_add_submenu(&power_onoff_menu);
+
+	return true;
+}
diff --git a/tools/mesh-gatt/onpowerup-model.h
b/tools/mesh-gatt/onpowerup-model.h
new file mode 100644
index 000000000..f8347d830
--- /dev/null
+++ b/tools/mesh-gatt/onpowerup-model.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#define GENERIC_POWER_ONOFF_SERVER_MODEL_ID         0x1006
+#define GENERIC_POWER_ONOFF_SETUP_SERVER_MODEL_ID   0x1007
+#define GENERIC_POWER_ONOFF_CLIENT_MODEL_ID         0x1008
+
+#define OP_GENERIC_POWER_ONOFF_GET			0x8211
+#define OP_GENERIC_POWER_ONOFF_STATUS			0x8212
+#define OP_GENERIC_POWER_ONOFF_SET			0x8213
+#define OP_GENERIC_POWER_ONOFF_SET_UNACK		0x8214
+
+void power_onoff_set_node(const char *args);
+bool power_onoff_client_init(uint8_t ele);
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 69f8d412f..bd4314790 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -49,6 +49,7 @@
 #include "mesh-gatt/prov-db.h"
 #include "mesh-gatt/onoff-model.h"
 #include "mesh-gatt/level-model.h"
+#include "mesh-gatt/onpowerup-model.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -2003,6 +2004,9 @@ int main(int argc, char *argv[])
 	if (!level_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic level
client\n");
 
+	if (!power_onoff_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic power On/Off
client\n");
+
 	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
-- 
2.25.1


