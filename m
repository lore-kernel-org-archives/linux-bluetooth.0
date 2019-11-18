Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE271C43215
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1C42071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 13:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKRNxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:53:49 -0500
Received: from mail.ccbi.it ([212.104.57.17]:44907 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfKRNxs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 08:53:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 6786022270B;
        Mon, 18 Nov 2019 14:44:22 +0100 (CET)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pPwRdFR3fif0; Mon, 18 Nov 2019 14:44:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 68529220985;
        Mon, 18 Nov 2019 14:44:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4ehZApkJjo4O; Mon, 18 Nov 2019 14:44:20 +0100 (CET)
Received: from blemesh.cbl.lan (customer-93-189-143-66.com-com.it [93.189.143.66])
        by mail.tinia.eu (Postfix) with ESMTPA id 2816422270B;
        Mon, 18 Nov 2019 14:44:20 +0100 (CET)
From:   Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele <dbiagio@tiscali.it>
Subject: [PATCH 5/6] tools/mesh: Add generic level model support
Date:   Mon, 18 Nov 2019 14:44:04 +0100
Message-Id: <20191118134405.20212-6-daniele.biagetti@cblelectronics.com>
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
 Makefile.tools             |   3 +-
 tools/mesh/level-model.c   | 298 +++++++++++++++++++++++++++++++++++++
 tools/mesh/level-model.h   |  34 +++++
 tools/mesh/local_node.json |   6 +-
 tools/meshctl.c            |   4 +
 5 files changed, 343 insertions(+), 2 deletions(-)
 create mode 100644 tools/mesh/level-model.c
 create mode 100644 tools/mesh/level-model.h

diff --git a/Makefile.tools b/Makefile.tools
index 7ce05b7ef..9c0cdedb8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -316,7 +316,8 @@ tools_meshctl_SOURCES =3D tools/meshctl.c \
 				tools/mesh/prov-db.h tools/mesh/prov-db.c \
 				tools/mesh/config-model.h tools/mesh/config-client.c \
 				tools/mesh/config-server.c \
-				tools/mesh/onoff-model.h tools/mesh/onoff-model.c
+				tools/mesh/onoff-model.h tools/mesh/onoff-model.c \
+				tools/mesh/level-model.h tools/mesh/level-model.c
 tools_meshctl_LDADD =3D gdbus/libgdbus-internal.la src/libshared-glib.la=
 \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
diff --git a/tools/mesh/level-model.c b/tools/mesh/level-model.c
new file mode 100644
index 000000000..03a0d24c6
--- /dev/null
+++ b/tools/mesh/level-model.c
@@ -0,0 +1,298 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
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
+#include "tools/mesh/level-model.h"
+
+static uint8_t trans_id;
+static uint16_t level_app_idx =3D APP_IDX_INVALID;
+static int client_bind(uint16_t app_idx, int action)
+{
+        if (action =3D=3D ACTION_ADD) {
+                if (level_app_idx !=3D APP_IDX_INVALID) {
+                        return MESH_STATUS_INSUFF_RESOURCES;
+                } else {
+                        level_app_idx =3D app_idx;
+                        bt_shell_printf("Level client model: new binding=
"
+                                        " %4.4x\n", app_idx);
+                }
+        } else {
+                if (level_app_idx =3D=3D app_idx)
+                        level_app_idx =3D APP_IDX_INVALID;
+        }
+        return MESH_STATUS_SUCCESS;
+}
+static void print_remaining_time(uint8_t remaining_time)
+{
+        uint8_t step =3D (remaining_time & 0xc0) >> 6;
+        uint8_t count =3D remaining_time & 0x3f;
+        int secs =3D 0, msecs =3D 0, minutes =3D 0, hours =3D 0;
+        switch (step) {
+        case 0:
+                msecs =3D 100 * count;
+                secs =3D msecs / 1000;
+                msecs -=3D (secs * 1000);
+                break;
+        case 1:
+                secs =3D 1 * count;
+                minutes =3D secs / 60;
+                secs -=3D (minutes * 60);
+                break;
+        case 2:
+                secs =3D 10 * count;
+                minutes =3D secs / 60;
+                secs -=3D (minutes * 60);
+                break;
+        case 3:
+                minutes =3D 10 * count;
+                hours =3D minutes / 60;
+                minutes -=3D (hours * 60);
+                break;
+        default:
+                break;
+        }
+        bt_shell_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d=
"
+                        " msecs\n", hours, minutes, secs, msecs);
+}
+static bool client_msg_recvd(uint16_t src, uint8_t *data,
+                             uint16_t len, void *user_data)
+{
+        uint32_t opcode;
+        int n;
+        uint8_t *p;
+        int16_t lev;
+        char s[128];
+
+        if (mesh_opcode_get(data, len, &opcode, &n)) {
+                len -=3D n;
+                data +=3D n;
+        } else
+                return false;
+
+        switch (opcode & ~OP_UNRELIABLE) {
+        default:
+                return false;
+        case OP_GENERIC_LEVEL_STATUS:
+                bt_shell_printf("Level Model Message received (%d) opcod=
e %x\n",
+                                len, opcode);
+                print_byte_array("\t",data, len);
+
+                if (len !=3D 2 && len !=3D 4 && len !=3D 5)
+                        break;
+                lev =3D 0;
+                p =3D (uint8_t *)&lev;
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+                p[0] =3D data[0];
+                p[1] =3D data[1];
+#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
+                p[1] =3D data[0];
+                p[0] =3D data[1];
+#else
+#error "Unknown byte order"
+#error Processor endianness unknown!
+#endif
+                sprintf(s, "Node %4.4x: Level Status present =3D %d",
+                                src, lev);
+                if (len >=3D 4) {
+                        lev =3D (int16_t)(((uint16_t)data[3] << 8) |  (u=
int16_t)data[2]);
+                        sprintf(s, ", target =3D %d",
+                                        lev);
+                }
+                bt_shell_printf("%s\n", s);
+                if(len =3D=3D 5){
+                        print_remaining_time(data[4]);
+                }
+                break;
+        }
+        return true;
+}
+static uint32_t target;
+static int32_t parms[8];
+static uint32_t read_input_parameters(int argc, char *argv[])
+{
+        uint32_t i;
+        if (!argc)
+                return 0;
+        --argc;
+        ++argv;
+        if (!argc || argv[0][0] =3D=3D '\0')
+                return 0;
+        for (i =3D 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigne=
d) argc;
+             i++) {
+                if(sscanf(argv[i], "%d", &parms[i]) <=3D 0)
+                        break;
+        }
+        return i;
+}
+static void cmd_set_node(int argc, char *argv[])
+{
+        uint32_t dst;
+        char *end;
+        dst =3D strtol(argv[1], &end, 16);
+        if (end !=3D (argv[1] + 4)) {
+                bt_shell_printf("Bad unicast address %s: "
+                                "expected format 4 digit hex\n", argv[1]=
);
+                target =3D UNASSIGNED_ADDRESS;
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        } else {
+                bt_shell_printf("Controlling Level for node %4.4x\n", ds=
t);
+                target =3D dst;
+                set_menu_prompt("Level", argv[1]);
+                return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+        }
+}
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+        struct mesh_node *node =3D node_get_local_node();
+        uint8_t ttl;
+        if(!node)
+                return false;
+        ttl =3D node_get_default_ttl(node);
+        return net_access_layer_send(ttl, node_get_primary(node),
+                                     target, level_app_idx, buf, len);
+}
+static void cmd_get_status(int argc, char *argv[])
+{
+        uint16_t n;
+        uint8_t msg[32];
+        struct mesh_node *node;
+        if (IS_UNASSIGNED(target)) {
+                bt_shell_printf("Destination not set\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+        node =3D node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in databa=
se\n",target);
+        }
+
+        n =3D mesh_opcode_set(OP_GENERIC_LEVEL_GET, msg);
+        if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC LEVEL GET\"\n"=
);
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+static void cmd_set(int argc, char *argv[])
+{
+        uint16_t n;
+        uint8_t msg[32];
+        struct mesh_node *node;
+        uint8_t *p;
+        int np;
+        uint32_t opcode;
+        int16_t level;
+
+        if (IS_UNASSIGNED(target)) {
+                bt_shell_printf("Destination not set\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+        node =3D node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in databa=
se\n",target);
+        }
+
+        np =3D read_input_parameters(argc, argv);
+        if ((np !=3D 1) && (np !=3D 2) &&
+                        parms[0] < -32768 && parms[0] > 32767 &&
+                        parms[1] !=3D 0 && parms[1] !=3D 1) {
+                bt_shell_printf("Bad arguments: Expecting an integer "
+                                "-32768 to 32767 and an optional 0 or 1 =
as unack\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        if( (np=3D=3D2) && parms[1] ){
+                opcode =3D OP_GENERIC_LEVEL_SET_UNACK;
+        }else{
+                opcode =3D OP_GENERIC_LEVEL_SET;
+        }
+
+        n =3D mesh_opcode_set(opcode, msg);
+        level =3D (int16_t)parms[0];
+        p =3D (uint8_t *)&level;
+#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
+        msg[n++] =3D p[0];
+        msg[n++] =3D p[1];
+#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
+        msg[n++] =3D p[1];
+        msg[n++] =3D p[0];
+#else
+#error "Unknown byte order"
+#error Processor endianness unknown!
+#endif
+        msg[n++] =3D trans_id++;
+        if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC LEVEL SET\"\n"=
);
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+static const struct bt_shell_menu level_menu =3D {
+        .name =3D "level",
+        .desc =3D "Level Model Submenu",
+        .entries =3D {
+                {"target",		"<unicast>",			cmd_set_node,
+                 "Set node to configure"},
+                {"get",			NULL,				cmd_get_status,
+                 "Get Level status"},
+                {"level",		"<-32768/+32767> [unack]",	cmd_set,
+                 "Send \"SET Level\" command"},
+                {} },
+};
+static struct mesh_model_ops client_cbs =3D {
+        client_msg_recvd,
+        client_bind,
+        NULL,
+        NULL
+};
+bool level_client_init(uint8_t ele)
+{
+        if (!node_local_model_register(ele, GENERIC_LEVEL_CLIENT_MODEL_I=
D,
+                                       &client_cbs, NULL))
+                return false;
+        bt_shell_add_submenu(&level_menu);
+        return true;
+}
diff --git a/tools/mesh/level-model.h b/tools/mesh/level-model.h
new file mode 100644
index 000000000..80c08f14a
--- /dev/null
+++ b/tools/mesh/level-model.h
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
+#define GENERIC_LEVEL_SERVER_MODEL_ID	0x1002
+#define GENERIC_LEVEL_CLIENT_MODEL_ID	0x1003
+#define OP_GENERIC_LEVEL_GET			0x8205
+#define OP_GENERIC_LEVEL_SET			0x8206
+#define OP_GENERIC_LEVEL_SET_UNACK		0x8207
+#define OP_GENERIC_LEVEL_STATUS			0x8208
+#define OP_GENERIC_DELTA_SET			0x8209
+#define OP_GENERIC_DELTA_SET_UNACK		0x820A
+#define OP_GENERIC_MOVE_SET			0x820B
+#define OP_GENERIC_MOVE_SET_UNACK		0x820C
+void level_set_node(const char *args);
+bool level_client_init(uint8_t ele);
diff --git a/tools/mesh/local_node.json b/tools/mesh/local_node.json
index 5ffa7ada1..462cd815d 100644
--- a/tools/mesh/local_node.json
+++ b/tools/mesh/local_node.json
@@ -36,7 +36,7 @@
             {
                 "elementIndex": 0,
                 "location": "0001",
-                "models": ["0000", "0001", "1001"]
+                "models": ["0000", "0001", "1001", "1003"]
             }
         ]
     },
@@ -52,6 +52,10 @@
                {
                  "modelId": "1001",
                  "bind": [1]
+                },
+                {
+                 "modelId": "1003",
+                 "bind": [1]
                 }
             ]
           }
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 6b6f10882..656575a94 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -59,6 +59,7 @@
 #include "mesh/prov-db.h"
 #include "mesh/config-model.h"
 #include "mesh/onoff-model.h"
+#include "mesh/level-model.h"
=20
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -2010,6 +2011,9 @@ int main(int argc, char *argv[])
 	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic On/Off client\n");
=20
+	if (!level_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic level client\n");
+
 	status =3D bt_shell_run();
=20
 	g_dbus_client_unref(client);
--=20
2.20.1

