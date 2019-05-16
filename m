Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4213C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A95820848
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 14:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEPOm3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 10:42:29 -0400
Received: from mail.pedsan.it ([185.96.219.211]:39610 "EHLO mail.tinia.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfEPOm2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 10:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id E555B2229C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:06 +0200 (CEST)
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0bwBggef7pCv for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.tinia.eu (Postfix) with ESMTP id 4CCD3222816
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at yes
Received: from mail.tinia.eu ([127.0.0.1])
        by localhost (mail.tinia.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HD0lN_d_BvFY for <linux-bluetooth@vger.kernel.org>;
        Thu, 16 May 2019 16:36:04 +0200 (CEST)
Received: from DANBIAMBL (customer-31-185-23-59.com-com.it [31.185.23.59])
        by mail.tinia.eu (Postfix) with ESMTPSA id 0590B2226BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 16:36:03 +0200 (CEST)
From:   "Daniele Biagetti" <daniele.biagetti@cblelectronics.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 3/4] meshctl: Added generic level model support
Date:   Thu, 16 May 2019 16:35:48 +0200
Message-ID: <000401d50bf4$b01af4a0$1050dde0$@cblelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdUL8XRoXnORLUZ+TdGGg9LaPQOhtg==
Content-Language: it
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added generic level model support

Signed-off-by: Daniele Biagetti <daniele.biagetti@cblelectronics.com>

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
index 379e127b6..6b5fc6bd3 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -310,7 +310,8 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 				tools/mesh/prov-db.h tools/mesh/prov-db.c \
 				tools/mesh/config-model.h
tools/mesh/config-client.c \
 				tools/mesh/config-server.c \
-				tools/mesh/onoff-model.h
tools/mesh/onoff-model.c
+				tools/mesh/onoff-model.h
tools/mesh/onoff-model.c \
+				tools/mesh/level-model.h
tools/mesh/level-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c
-lreadline
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
USA
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
+static uint16_t level_app_idx = APP_IDX_INVALID;
+static int client_bind(uint16_t app_idx, int action)
+{
+        if (action == ACTION_ADD) {
+                if (level_app_idx != APP_IDX_INVALID) {
+                        return MESH_STATUS_INSUFF_RESOURCES;
+                } else {
+                        level_app_idx = app_idx;
+                        bt_shell_printf("Level client model: new binding"
+                                        " %4.4x\n", app_idx);
+                }
+        } else {
+                if (level_app_idx == app_idx)
+                        level_app_idx = APP_IDX_INVALID;
+        }
+        return MESH_STATUS_SUCCESS;
+}
+static void print_remaining_time(uint8_t remaining_time)
+{
+        uint8_t step = (remaining_time & 0xc0) >> 6;
+        uint8_t count = remaining_time & 0x3f;
+        int secs = 0, msecs = 0, minutes = 0, hours = 0;
+        switch (step) {
+        case 0:
+                msecs = 100 * count;
+                secs = msecs / 1000;
+                msecs -= (secs * 1000);
+                break;
+        case 1:
+                secs = 1 * count;
+                minutes = secs / 60;
+                secs -= (minutes * 60);
+                break;
+        case 2:
+                secs = 10 * count;
+                minutes = secs / 60;
+                secs -= (minutes * 60);
+                break;
+        case 3:
+                minutes = 10 * count;
+                hours = minutes / 60;
+                minutes -= (hours * 60);
+                break;
+        default:
+                break;
+        }
+        bt_shell_printf("\n\t\tRemaining time: %d hrs %d mins %d secs %d"
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
+                len -= n;
+                data += n;
+        } else
+                return false;
+
+        switch (opcode & ~OP_UNRELIABLE) {
+        default:
+                return false;
+        case OP_GENERIC_LEVEL_STATUS:
+                bt_shell_printf("Level Model Message received (%d) opcode
%x\n",
+                                len, opcode);
+                print_byte_array("\t",data, len);
+
+                if (len != 2 && len != 4 && len != 5)
+                        break;
+                lev = 0;
+                p = (uint8_t *)&lev;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+                p[0] = data[0];
+                p[1] = data[1];
+#elif __BYTE_ORDER == __BIG_ENDIAN
+                p[1] = data[0];
+                p[0] = data[1];
+#else
+#error "Unknown byte order"
+#error Processor endianness unknown!
+#endif
+                sprintf(s, "Node %4.4x: Level Status present = %d",
+                                src, lev);
+                if (len >= 4) {
+                        lev = (int16_t)(((uint16_t)data[3] << 8) |
(uint16_t)data[2]);
+                        sprintf(s, ", target = %d",
+                                        lev);
+                }
+                bt_shell_printf("%s\n", s);
+                if(len == 5){
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
+        if (!argc || argv[0][0] == '\0')
+                return 0;
+        for (i = 0; i < sizeof(parms)/sizeof(parms[0]) && i < (unsigned)
argc;
+             i++) {
+                if(sscanf(argv[i], "%d", &parms[i]) <= 0)
+                        break;
+        }
+        return i;
+}
+static void cmd_set_node(int argc, char *argv[])
+{
+        uint32_t dst;
+        char *end;
+        dst = strtol(argv[1], &end, 16);
+        if (end != (argv[1] + 4)) {
+                bt_shell_printf("Bad unicast address %s: "
+                                "expected format 4 digit hex\n", argv[1]);
+                target = UNASSIGNED_ADDRESS;
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        } else {
+                bt_shell_printf("Controlling Level for node %4.4x\n", dst);
+                target = dst;
+                set_menu_prompt("Level", argv[1]);
+                return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+        }
+}
+static bool send_cmd(uint8_t *buf, uint16_t len)
+{
+        struct mesh_node *node = node_get_local_node();
+        uint8_t ttl;
+        if(!node)
+                return false;
+        ttl = node_get_default_ttl(node);
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
+        node = node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+        }
+
+        n = mesh_opcode_set(OP_GENERIC_LEVEL_GET, msg);
+        if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC LEVEL GET\"\n");
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
+        node = node_find_by_addr(target);
+
+        if (!node){
+                bt_shell_printf("Warning: node %4.4x not found in
database\n",target);
+        }
+
+        np = read_input_parameters(argc, argv);
+        if ((np != 1) && (np != 2) &&
+                        parms[0] < -32768 && parms[0] > 32767 &&
+                        parms[1] != 0 && parms[1] != 1) {
+                bt_shell_printf("Bad arguments: Expecting an integer "
+                                "-32768 to 32767 and an optional 0 or 1 as
unack\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        if( (np==2) && parms[1] ){
+                opcode = OP_GENERIC_LEVEL_SET_UNACK;
+        }else{
+                opcode = OP_GENERIC_LEVEL_SET;
+        }
+
+        n = mesh_opcode_set(opcode, msg);
+        level = (int16_t)parms[0];
+        p = (uint8_t *)&level;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+        msg[n++] = p[0];
+        msg[n++] = p[1];
+#elif __BYTE_ORDER == __BIG_ENDIAN
+        msg[n++] = p[1];
+        msg[n++] = p[0];
+#else
+#error "Unknown byte order"
+#error Processor endianness unknown!
+#endif
+        msg[n++] = trans_id++;
+        if (!send_cmd(msg, n)) {
+                bt_shell_printf("Failed to send \"GENERIC LEVEL SET\"\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+static const struct bt_shell_menu level_menu = {
+        .name = "level",
+        .desc = "Level Model Submenu",
+        .entries = {
+                {"target",		"<unicast>",
cmd_set_node,
+                 "Set node to configure"},
+                {"get",			NULL,
cmd_get_status,
+                 "Get Level status"},
+                {"level",		"<-32768/+32767> [unack]",
cmd_set,
+                 "Send \"SET Level\" command"},
+                {} },
+};
+static struct mesh_model_ops client_cbs = {
+        client_msg_recvd,
+        client_bind,
+        NULL,
+        NULL
+};
+bool level_client_init(uint8_t ele)
+{
+        if (!node_local_model_register(ele, GENERIC_LEVEL_CLIENT_MODEL_ID,
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
USA
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
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -2010,6 +2011,9 @@ int main(int argc, char *argv[])
 	if (!onoff_client_init(PRIMARY_ELEMENT_IDX))
 		g_printerr("Failed to initialize mesh generic On/Off
client\n");
 
+	if (!level_client_init(PRIMARY_ELEMENT_IDX))
+		g_printerr("Failed to initialize mesh generic level
client\n");
+
 	status = bt_shell_run();
 
 	g_dbus_client_unref(client);
-- 
2.19.2.windows.1

