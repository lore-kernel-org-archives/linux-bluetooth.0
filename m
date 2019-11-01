Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2DCA9ED0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709AF217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 18:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKAS5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:57:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:29978 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKAS5c (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 14:57:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="211833713"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.110])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2019 11:57:32 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 02/10 v2] tools/mesh: Move meshctl specific files to mesh-gatt
Date:   Fri,  1 Nov 2019 11:57:21 -0700
Message-Id: <20191101185729.31661-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.tools                            | 30 +++++++++++++----------
 tools/{mesh => mesh-gatt}/README          |  0
 tools/{mesh => mesh-gatt}/config-client.c | 14 ++++++-----
 tools/{mesh => mesh-gatt}/config-server.c | 14 +++++------
 tools/{mesh => mesh-gatt}/crypto.c        |  5 ++--
 tools/{mesh => mesh-gatt}/crypto.h        |  0
 tools/{mesh => mesh-gatt}/gatt.c          | 11 +++++----
 tools/{mesh => mesh-gatt}/gatt.h          |  0
 tools/{mesh => mesh-gatt}/keys.h          |  0
 tools/{mesh => mesh-gatt}/local_node.json |  0
 tools/{mesh => mesh-gatt}/mesh-net.h      |  0
 tools/{mesh => mesh-gatt}/net.c           | 16 ++++++------
 tools/{mesh => mesh-gatt}/net.h           |  0
 tools/{mesh => mesh-gatt}/node.c          | 16 ++++++------
 tools/{mesh => mesh-gatt}/node.h          |  0
 tools/{mesh => mesh-gatt}/onoff-model.c   | 15 ++++++------
 tools/{mesh => mesh-gatt}/onoff-model.h   |  0
 tools/{mesh => mesh-gatt}/prov-db.c       | 14 +++++------
 tools/{mesh => mesh-gatt}/prov-db.h       |  0
 tools/{mesh => mesh-gatt}/prov.c          | 16 ++++++------
 tools/{mesh => mesh-gatt}/prov.h          |  0
 tools/{mesh => mesh-gatt}/prov_db.json    |  0
 tools/{mesh => mesh-gatt}/util.c          |  7 +++---
 tools/{mesh => mesh-gatt}/util.h          |  0
 tools/meshctl.c                           | 22 +++++++++--------
 25 files changed, 98 insertions(+), 82 deletions(-)
 rename tools/{mesh => mesh-gatt}/README (100%)
 rename tools/{mesh => mesh-gatt}/config-client.c (99%)
 rename tools/{mesh => mesh-gatt}/config-server.c (94%)
 rename tools/{mesh => mesh-gatt}/crypto.c (99%)
 rename tools/{mesh => mesh-gatt}/crypto.h (100%)
 rename tools/{mesh => mesh-gatt}/gatt.c (98%)
 rename tools/{mesh => mesh-gatt}/gatt.h (100%)
 rename tools/{mesh => mesh-gatt}/keys.h (100%)
 rename tools/{mesh => mesh-gatt}/local_node.json (100%)
 rename tools/{mesh => mesh-gatt}/mesh-net.h (100%)
 rename tools/{mesh => mesh-gatt}/net.c (99%)
 rename tools/{mesh => mesh-gatt}/net.h (100%)
 rename tools/{mesh => mesh-gatt}/node.c (98%)
 rename tools/{mesh => mesh-gatt}/node.h (100%)
 rename tools/{mesh => mesh-gatt}/onoff-model.c (96%)
 rename tools/{mesh => mesh-gatt}/onoff-model.h (100%)
 rename tools/{mesh => mesh-gatt}/prov-db.c (99%)
 rename tools/{mesh => mesh-gatt}/prov-db.h (100%)
 rename tools/{mesh => mesh-gatt}/prov.c (98%)
 rename tools/{mesh => mesh-gatt}/prov.h (100%)
 rename tools/{mesh => mesh-gatt}/prov_db.json (100%)
 rename tools/{mesh => mesh-gatt}/util.c (98%)
 rename tools/{mesh => mesh-gatt}/util.h (100%)

diff --git a/Makefile.tools b/Makefile.tools
index 7ce05b7ef..feb2c8550 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -304,25 +304,29 @@ if MESH
 bin_PROGRAMS += tools/meshctl
 
 tools_meshctl_SOURCES = tools/meshctl.c \
-				tools/mesh/mesh-net.h \
-				tools/mesh/node.h tools/mesh/node.c \
-				tools/mesh/gatt.h tools/mesh/gatt.c \
-				tools/mesh/crypto.h tools/mesh/crypto.c \
-				tools/mesh/keys.h \
-				tools/mesh/net.h tools/mesh/net.c \
-				tools/mesh/prov.h tools/mesh/prov.c \
-				tools/mesh/util.h tools/mesh/util.c \
 				tools/mesh/agent.h tools/mesh/agent.c \
-				tools/mesh/prov-db.h tools/mesh/prov-db.c \
-				tools/mesh/config-model.h tools/mesh/config-client.c \
-				tools/mesh/config-server.c \
-				tools/mesh/onoff-model.h tools/mesh/onoff-model.c
+				tools/mesh/config-model.h\
+				tools/mesh-gatt/mesh-net.h \
+				tools/mesh-gatt/node.h tools/mesh-gatt/node.c \
+				tools/mesh-gatt/gatt.h tools/mesh-gatt/gatt.c \
+				tools/mesh-gatt/crypto.h\
+				tools/mesh-gatt/crypto.c \
+				tools/mesh-gatt/keys.h \
+				tools/mesh-gatt/net.h tools/mesh-gatt/net.c \
+				tools/mesh-gatt/prov.h tools/mesh-gatt/prov.c \
+				tools/mesh-gatt/util.h tools/mesh-gatt/util.c \
+				tools/mesh-gatt/prov-db.h \
+				tools/mesh-gatt/prov-db.c \
+				tools/mesh-gatt/config-client.c \
+				tools/mesh-gatt/config-server.c \
+				tools/mesh-gatt/onoff-model.h \
+				tools/mesh-gatt/onoff-model.c
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
 endif
 
-EXTRA_DIST += tools/mesh/local_node.json tools/mesh/prov_db.json
+EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 
 if DEPRECATED
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
diff --git a/tools/mesh/README b/tools/mesh-gatt/README
similarity index 100%
rename from tools/mesh/README
rename to tools/mesh-gatt/README
diff --git a/tools/mesh/config-client.c b/tools/mesh-gatt/config-client.c
similarity index 99%
rename from tools/mesh/config-client.c
rename to tools/mesh-gatt/config-client.c
index df2643622..5e6374f2b 100644
--- a/tools/mesh/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -39,14 +39,16 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/net.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/prov-db.h"
-#include "tools/mesh/util.h"
+
 #include "tools/mesh/config-model.h"
 
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/util.h"
+
 #define MIN_COMPOSITION_LEN 16
 
 static uint32_t print_mod_id(uint8_t *data, bool vid)
diff --git a/tools/mesh/config-server.c b/tools/mesh-gatt/config-server.c
similarity index 94%
rename from tools/mesh/config-server.c
rename to tools/mesh-gatt/config-server.c
index 55035bacf..8fc6edcc0 100644
--- a/tools/mesh/config-server.c
+++ b/tools/mesh-gatt/config-server.c
@@ -36,16 +36,16 @@
 #include <wordexp.h>
 
 #include <glib.h>
+#include "tools/mesh/config-model.h"
 
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/net.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/prov-db.h"
-#include "tools/mesh/util.h"
-#include "tools/mesh/config-model.h"
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/util.h"
 
 static bool server_msg_recvd(uint16_t src, uint8_t *data,
 				uint16_t len, void *user_data)
diff --git a/tools/mesh/crypto.c b/tools/mesh-gatt/crypto.c
similarity index 99%
rename from tools/mesh/crypto.c
rename to tools/mesh-gatt/crypto.c
index 9935612cf..493b502ca 100644
--- a/tools/mesh/crypto.c
+++ b/tools/mesh-gatt/crypto.c
@@ -43,8 +43,9 @@
 #endif
 
 #include "src/shared/util.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/crypto.h"
+
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/crypto.h"
 
 static int alg_new(int fd, const void *keyval, socklen_t keylen,
 		size_t mic_size)
diff --git a/tools/mesh/crypto.h b/tools/mesh-gatt/crypto.h
similarity index 100%
rename from tools/mesh/crypto.h
rename to tools/mesh-gatt/crypto.h
diff --git a/tools/mesh/gatt.c b/tools/mesh-gatt/gatt.c
similarity index 98%
rename from tools/mesh/gatt.c
rename to tools/mesh-gatt/gatt.c
index 0a942d4eb..bff594733 100644
--- a/tools/mesh/gatt.c
+++ b/tools/mesh-gatt/gatt.c
@@ -40,11 +40,12 @@
 #include "gdbus/gdbus.h"
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/util.h"
-#include "tools/mesh/gatt.h"
-#include "tools/mesh/prov.h"
-#include "tools/mesh/net.h"
+
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/gatt.h"
+#include "tools/mesh-gatt/prov.h"
+#include "tools/mesh-gatt/net.h"
 
 #define MESH_PROV_DATA_OUT_UUID_STR	"00002adc-0000-1000-8000-00805f9b34fb"
 #define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
diff --git a/tools/mesh/gatt.h b/tools/mesh-gatt/gatt.h
similarity index 100%
rename from tools/mesh/gatt.h
rename to tools/mesh-gatt/gatt.h
diff --git a/tools/mesh/keys.h b/tools/mesh-gatt/keys.h
similarity index 100%
rename from tools/mesh/keys.h
rename to tools/mesh-gatt/keys.h
diff --git a/tools/mesh/local_node.json b/tools/mesh-gatt/local_node.json
similarity index 100%
rename from tools/mesh/local_node.json
rename to tools/mesh-gatt/local_node.json
diff --git a/tools/mesh/mesh-net.h b/tools/mesh-gatt/mesh-net.h
similarity index 100%
rename from tools/mesh/mesh-net.h
rename to tools/mesh-gatt/mesh-net.h
diff --git a/tools/mesh/net.c b/tools/mesh-gatt/net.c
similarity index 99%
rename from tools/mesh/net.c
rename to tools/mesh-gatt/net.c
index f1ef23ab8..e8171c677 100644
--- a/tools/mesh/net.c
+++ b/tools/mesh-gatt/net.c
@@ -35,14 +35,14 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 
-#include "tools/mesh/crypto.h"
-#include "tools/mesh/gatt.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/util.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/prov-db.h"
-#include "tools/mesh/net.h"
+#include "tools/mesh-gatt/crypto.h"
+#include "tools/mesh-gatt/gatt.h"
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/net.h"
 
 struct address_range
 {
diff --git a/tools/mesh/net.h b/tools/mesh-gatt/net.h
similarity index 100%
rename from tools/mesh/net.h
rename to tools/mesh-gatt/net.h
diff --git a/tools/mesh/node.c b/tools/mesh-gatt/node.c
similarity index 98%
rename from tools/mesh/node.c
rename to tools/mesh-gatt/node.c
index d23315ce4..6afa6d6ab 100644
--- a/tools/mesh/node.c
+++ b/tools/mesh-gatt/node.c
@@ -39,14 +39,16 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 #include "gdbus/gdbus.h"
-#include "tools/mesh/mesh-net.h"
+
 #include "tools/mesh/config-model.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/gatt.h"
-#include "tools/mesh/net.h"
-#include "tools/mesh/prov-db.h"
-#include "tools/mesh/util.h"
+
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/gatt.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/util.h"
 
 struct mesh_model {
 	struct mesh_model_ops cbs;
diff --git a/tools/mesh/node.h b/tools/mesh-gatt/node.h
similarity index 100%
rename from tools/mesh/node.h
rename to tools/mesh-gatt/node.h
diff --git a/tools/mesh/onoff-model.c b/tools/mesh-gatt/onoff-model.c
similarity index 96%
rename from tools/mesh/onoff-model.c
rename to tools/mesh-gatt/onoff-model.c
index b52afe2c8..92c9a3105 100644
--- a/tools/mesh/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -40,13 +40,14 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/net.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/prov-db.h"
-#include "tools/mesh/util.h"
-#include "tools/mesh/onoff-model.h"
+
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/prov-db.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/onoff-model.h"
 
 static uint8_t trans_id;
 static uint16_t onoff_app_idx = APP_IDX_INVALID;
diff --git a/tools/mesh/onoff-model.h b/tools/mesh-gatt/onoff-model.h
similarity index 100%
rename from tools/mesh/onoff-model.h
rename to tools/mesh-gatt/onoff-model.h
diff --git a/tools/mesh/prov-db.c b/tools/mesh-gatt/prov-db.c
similarity index 99%
rename from tools/mesh/prov-db.c
rename to tools/mesh-gatt/prov-db.c
index 05b2547fd..44096e1e1 100644
--- a/tools/mesh/prov-db.c
+++ b/tools/mesh-gatt/prov-db.c
@@ -42,13 +42,13 @@
 #include "src/shared/util.h"
 #include "src/shared/shell.h"
 
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/crypto.h"
-#include "tools/mesh/keys.h"
-#include "tools/mesh/net.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/util.h"
-#include "tools/mesh/prov-db.h"
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/crypto.h"
+#include "tools/mesh-gatt/keys.h"
+#include "tools/mesh-gatt/net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/prov-db.h"
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
diff --git a/tools/mesh/prov-db.h b/tools/mesh-gatt/prov-db.h
similarity index 100%
rename from tools/mesh/prov-db.h
rename to tools/mesh-gatt/prov-db.h
diff --git a/tools/mesh/prov.c b/tools/mesh-gatt/prov.c
similarity index 98%
rename from tools/mesh/prov.c
rename to tools/mesh-gatt/prov.c
index acbc5a1c8..0f9d85d01 100644
--- a/tools/mesh/prov.c
+++ b/tools/mesh-gatt/prov.c
@@ -41,14 +41,16 @@
 #include "src/shared/shell.h"
 
 #include "gdbus/gdbus.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/gatt.h"
-#include "tools/mesh/crypto.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/util.h"
+
 #include "tools/mesh/agent.h"
-#include "tools/mesh/prov.h"
-#include "tools/mesh/net.h"
+
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/gatt.h"
+#include "tools/mesh-gatt/crypto.h"
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/util.h"
+#include "tools/mesh-gatt/prov.h"
+#include "tools/mesh-gatt/net.h"
 
 /* Provisioning Security Levels */
 #define MESH_PROV_SEC_HIGH	2
diff --git a/tools/mesh/prov.h b/tools/mesh-gatt/prov.h
similarity index 100%
rename from tools/mesh/prov.h
rename to tools/mesh-gatt/prov.h
diff --git a/tools/mesh/prov_db.json b/tools/mesh-gatt/prov_db.json
similarity index 100%
rename from tools/mesh/prov_db.json
rename to tools/mesh-gatt/prov_db.json
diff --git a/tools/mesh/util.c b/tools/mesh-gatt/util.c
similarity index 98%
rename from tools/mesh/util.c
rename to tools/mesh-gatt/util.c
index 47abc0b24..564665e5d 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh-gatt/util.c
@@ -33,9 +33,10 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
-#include "tools/mesh/mesh-net.h"
-#include "tools/mesh/node.h"
-#include "tools/mesh/util.h"
+
+#include "tools/mesh-gatt/mesh-net.h"
+#include "tools/mesh-gatt/node.h"
+#include "tools/mesh-gatt/util.h"
 
 void set_menu_prompt(const char *name, const char *id)
 {
diff --git a/tools/mesh/util.h b/tools/mesh-gatt/util.h
similarity index 100%
rename from tools/mesh/util.h
rename to tools/mesh-gatt/util.h
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 6b6f10882..57998fded 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -47,18 +47,20 @@
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "gdbus/gdbus.h"
-#include "mesh/mesh-net.h"
-#include "mesh/gatt.h"
-#include "mesh/crypto.h"
-#include "mesh/node.h"
-#include "mesh/net.h"
-#include "mesh/keys.h"
-#include "mesh/prov.h"
-#include "mesh/util.h"
+
 #include "mesh/agent.h"
-#include "mesh/prov-db.h"
 #include "mesh/config-model.h"
-#include "mesh/onoff-model.h"
+
+#include "mesh-gatt/mesh-net.h"
+#include "mesh-gatt/gatt.h"
+#include "mesh-gatt/crypto.h"
+#include "mesh-gatt/node.h"
+#include "mesh-gatt/net.h"
+#include "mesh-gatt/keys.h"
+#include "mesh-gatt/prov.h"
+#include "mesh-gatt/util.h"
+#include "mesh-gatt/prov-db.h"
+#include "mesh-gatt/onoff-model.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
-- 
2.21.0

