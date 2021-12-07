Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D57C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbhLGW7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbhLGW7q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD4C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so1752491edd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k29Yask3mdkR+7G6OrLgpmlSD3gqpf13sdN5hx+HlFE=;
        b=ZIzngSvU3CyHtCRQ1WiShIo6swOZ7nHsWzEHlDLdOGG/vHkALMDaqNEb+ro8EVthtH
         TTKO7gSFOtiuNgdLbMkoHu85YdVdp6Bv+N/h/2VuTI4ReRYLBJBIyjDnWDWWC4g8bSKx
         WWfhdtiZX/B7hqQdvOqeNnf5n/xT7EVxO7aW4hKfaX6LTJ+IaluMCsa7DaT5zTizkDpE
         WtN19+4IIRVbI5CALjmqIlppL0juCBtr9gEL39STnwDcRXijI0mnlrBlnHAApUpamcyQ
         lfBk/gBNC4sbqkmbrN0M65oHSfbGFNOrTMU7VgJ3//ATrVkmKNhYZTecKVFG2VLXuJsZ
         i3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k29Yask3mdkR+7G6OrLgpmlSD3gqpf13sdN5hx+HlFE=;
        b=VgJidpWzbHglvrZHnSGJpyKrxcvyRwNNHb+mQfHiL2FHGixSDGLEgtSac0jgWkTIsE
         KShF/Qykt6EOX4o/xMHPPUinXC8kTQvpyAoZeO4qGHIKxFdq/VIKeyPaBT4x8ZwJib5k
         5LdnzZN3CffPkJsyryerSczm7E++rRSTSRao/yWKhV/1wka6p/c0UgzNHkSQ8yt7wd6l
         CAKyNehjhX9laom/h90qQ9dGi26k4sl/gVhObR91R6lpIDF4iTsQ+qFjrOV9/KPqfKMp
         mZBj0Gh1UWklUBY7abNHS50Ln5Wogs7shTjBiBl8fy3PrNvfpn4jGY6aj9FOaI3191EN
         Yf1w==
X-Gm-Message-State: AOAM530jIZPNCGrQShm65Vcvz8X619/Vl3bzOqCvpcaNoBBOB3CYuqVJ
        7GgnsmOKGlYmWSD2I8m5EodAsi7760g=
X-Google-Smtp-Source: ABdhPJwHILBP+anZvlM58PnbBKyH80RnBVx4a3WlKmPyRVCWdoZGp5aVWtwQvwEws0Oqs557WSQlKw==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr2876952ejc.385.1638917773492;
        Tue, 07 Dec 2021 14:56:13 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:13 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 6/6] tools/mesh-gatt: Add generic power onoff client model
Date:   Tue,  7 Dec 2021 23:56:04 +0100
Message-Id: <20211207225604.35156-7-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
diff --git a/tools/mesh-gatt/local_node.json b/tools/mesh-gatt/local_node.json
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
diff --git a/tools/mesh-gatt/onpowerup-model.c b/tools/mesh-gatt/onpowerup-model.c
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
+                        bt_shell_printf("OnPowerUp client model: new binding"
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
+                bt_shell_printf("OnPowerUp Model Message received (%d) opcode %x\n",
+                                                                        len, opcode);
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
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present = %s\n", src, s);
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
+	for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc;
+									i++) {
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
+                bt_shell_printf("Controlling OnPowerUp for node %4.4x\n", dst);
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
+                                        target, power_onoff_app_idx, buf, len);
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
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }
+
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_GET, msg);
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF GET\"\n");
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
+                bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+        }
+
+	if ((read_input_parameters(argc, argv) != 1) &&
+                                        parms[0] != 0 && parms[0] != 1 && parms[0] != 2) {
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" or \"2\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+        n = mesh_opcode_set(OP_GENERIC_POWER_ONOFF_SET, msg);
+	msg[n++] = parms[0];
+	msg[n++] = trans_id++;
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF SET\"\n");
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
+	{"target",		"<unicast>",			cmd_set_node,
+						"Set node to configure"},
+	{"get",			NULL,				cmd_get_status,
+                                                "Get OnPowerUp status"},
+        {"set",                 "<0/1/2>",			cmd_set,
+                                                "Set OnPowerUp status (OFF/ON/RESTORE)"},
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
+        if (!node_local_model_register(ele, GENERIC_POWER_ONOFF_CLIENT_MODEL_ID,
+					&client_cbs, NULL))
+		return false;
+
+        bt_shell_add_submenu(&power_onoff_menu);
+
+	return true;
+}
diff --git a/tools/mesh-gatt/onpowerup-model.h b/tools/mesh-gatt/onpowerup-model.h
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
 		g_printerr("Failed to initialize mesh generic level client\n");
 
+	if (!power_onoff_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic power On/Off client\n");
+
 	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
-- 
2.25.1

