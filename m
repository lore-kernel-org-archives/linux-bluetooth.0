Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B16C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA262071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKRNxs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:48 -0500
Received: from mail.borgobrufa.it ([212.104.57.17]:44909 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfKRNxr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 1370B220985;
        Mon, 18 Nov 2019 14:44:23 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oTu8tCK0Ig3c; Mon, 18 Nov 2019 14:44:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 31E252229AF;
        Mon, 18 Nov 2019 14:44:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZTFfo5Z8BEHl; Mon, 18 Nov 2019 14:44:21 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id 02F0122270B;
        Mon, 18 Nov 2019 14:44:20 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 6/6] tools/mesh: Add generic power onoff client model
Date:   Mon, 18 Nov 2019 14:44:05 +0100
Message-Id: <20191118134405.20212-7-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
References: <20191118134405.20212-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Daniele <dbiagio@tiscali.it>

---
 Makefile.tools               |   3 +-
 tools/mesh/local_node.json   |   6 +-
 tools/mesh/onpowerup-model.c | 262 +++++++++++++++++++++++++++++++++++
 tools/mesh/onpowerup-model.h |  34 +++++
 tools/meshctl.c              |   4 +
 5 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 tools/mesh/onpowerup-model.c
 create mode 100644 tools/mesh/onpowerup-model.h

diff --git a/Makefile.tools b/Makefile.tools
index 9c0cdedb8..c4dd2b388 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -317,7 +317,8 @@ tools_meshctl_SOURCES =3D tools/meshctl.c \
 				tools/mesh/config-model.h tools/mesh/config-client.c \
 				tools/mesh/config-server.c \
 				tools/mesh/onoff-model.h tools/mesh/onoff-model.c \
-				tools/mesh/level-model.h tools/mesh/level-model.c
+				tools/mesh/level-model.h tools/mesh/level-model.c \
+				tools/mesh/onpowerup-model.h tools/mesh/onpowerup-model.c
 tools_meshctl_LDADD =3D gdbus/libgdbus-internal.la src/libshared-glib.la=
 \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
diff --git a/tools/mesh/local_node.json b/tools/mesh/local_node.json
index 462cd815d..2c332eb1c 100644
--- a/tools/mesh/local_node.json
+++ b/tools/mesh/local_node.json
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
diff --git a/tools/mesh/onpowerup-model.c b/tools/mesh/onpowerup-model.c
new file mode 100644
index 000000000..0d582bffe
--- /dev/null
+++ b/tools/mesh/onpowerup-model.c
@@ -0,0 +1,262 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
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
+#include "tools/mesh/mesh-net.h"
+#include "tools/mesh/keys.h"
+#include "tools/mesh/net.h"
+#include "tools/mesh/node.h"
+#include "tools/mesh/prov-db.h"
+#include "tools/mesh/util.h"
+#include "tools/mesh/onpowerup-model.h"
+
+static uint8_t trans_id;
+static uint16_t power_onoff_app_idx =3D APP_IDX_INVALID;
+
+static int client_bind(uint16_t app_idx, int action)
+{
+	if (action =3D=3D ACTION_ADD) {
+                if (power_onoff_app_idx !=3D APP_IDX_INVALID) {
+			return MESH_STATUS_INSUFF_RESOURCES;
+		} else {
+                        power_onoff_app_idx =3D app_idx;
+                        bt_shell_printf("OnPowerUp client model: new bin=
ding"
+					" %4.4x\n", app_idx);
+		}
+	} else {
+                if (power_onoff_app_idx =3D=3D app_idx)
+                        power_onoff_app_idx =3D APP_IDX_INVALID;
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
+		len -=3D n;
+		data +=3D n;
+	} else
+		return false;
+
+	switch (opcode & ~OP_UNRELIABLE) {
+	default:
+		return false;
+
+        case OP_GENERIC_POWER_ONOFF_STATUS:
+                bt_shell_printf("OnPowerUp Model Message received (%d) o=
pcode %x\n",
+                                                                        =
len, opcode);
+                print_byte_array("\t",data, len);
+                if (len !=3D 1)
+                        break;
+                if(data[0] =3D=3D 0){
+                    sprintf(s, "%s", "OFF");
+                }else if(data[0] =3D=3D 1){
+                    sprintf(s, "%s", "ON");
+                }else if(data[0] =3D=3D 2){
+                    sprintf(s, "%s", "RESUME");
+                }else{
+                    sprintf(s, "%s", "?UNKNOWN");
+                }
+                bt_shell_printf("Node %4.4x: OnPowerUp Status present =3D=
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
+	if (!argc || argv[0][0] =3D=3D '\0')
+		return 0;
+
+	memset(parms, 0xff, sizeof(parms));
+
+	for (i =3D 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned) argc=
;
+									i++) {
+		sscanf(argv[i], "%x", &parms[i]);
+		if (parms[i] =3D=3D 0xffffffff)
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
+	dst =3D strtol(argv[1], &end, 16);
+	if (end !=3D (argv[1] + 4)) {
+		bt_shell_printf("Bad unicast address %s: "
+				"expected format 4 digit hex\n", argv[1]);
+		target =3D UNASSIGNED_ADDRESS;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
+                bt_shell_printf("Controlling OnPowerUp for node %4.4x\n"=
, dst);
+		target =3D dst;
+                set_menu_prompt("OnPowerUp", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+}
+
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+	struct mesh_node *node =3D node_get_local_node();
+	uint8_t ttl;
+
+	if(!node)
+		return false;
+
+	ttl =3D node_get_default_ttl(node);
+
+	return net_access_layer_send(ttl, node_get_primary(node),
+                                        target, power_onoff_app_idx, buf=
, len);
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
+	node =3D node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in databa=
se\n",target);
+        }
+
+        n =3D mesh_opcode_set(OP_GENERIC_POWER_ONOFF_GET, msg);
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF GE=
T\"\n");
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
+	node =3D node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in databa=
se\n",target);
+        }
+
+	if ((read_input_parameters(argc, argv) !=3D 1) &&
+                                        parms[0] !=3D 0 && parms[0] !=3D=
 1 && parms[0] !=3D 2) {
+                bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\"=
 or \"2\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+        n =3D mesh_opcode_set(OP_GENERIC_POWER_ONOFF_SET, msg);
+	msg[n++] =3D parms[0];
+	msg[n++] =3D trans_id++;
+
+	if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC POWER ONOFF SE=
T\"\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static const struct bt_shell_menu power_onoff_menu =3D {
+        .name =3D "power_onoff",
+        .desc =3D "Power OnOff (OnPowerUp) Model Submenu",
+	.entries =3D {
+	{"target",		"<unicast>",			cmd_set_node,
+						"Set node to configure"},
+	{"get",			NULL,				cmd_get_status,
+                                                "Get OnPowerUp status"},
+        {"set",                 "<0/1/2>",			cmd_set,
+                                                "Set OnPowerUp status (O=
FF/ON/RESTORE)"},
+	{} },
+};
+
+static struct mesh_model_ops client_cbs =3D {
+	client_msg_recvd,
+	client_bind,
+	NULL,
+	NULL
+};
+
+bool power_onoff_client_init(uint8_t ele)
+{
+        if (!node_local_model_register(ele, GENERIC_POWER_ONOFF_CLIENT_M=
ODEL_ID,
+					&client_cbs, NULL))
+		return false;
+
+        bt_shell_add_submenu(&power_onoff_menu);
+
+	return true;
+}
diff --git a/tools/mesh/onpowerup-model.h b/tools/mesh/onpowerup-model.h
new file mode 100644
index 000000000..bc9b514ff
--- /dev/null
+++ b/tools/mesh/onpowerup-model.h
@@ -0,0 +1,34 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
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
index 656575a94..3ca82bf81 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -60,6 +60,7 @@
 #include "mesh/config-model.h"
 #include "mesh/onoff-model.h"
 #include "mesh/level-model.h"
+#include "mesh/onpowerup-model.h"
=20
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -2014,6 +2015,9 @@ int main(int argc, char *argv[])
 	if (!level_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic level client\n");
=20
+	if (!power_onoff_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic power On/Off client\n");
+
 	status =3D bt_shell_run();
=20
 	g_dbus_client_unref(client);
--=20
2.20.1

