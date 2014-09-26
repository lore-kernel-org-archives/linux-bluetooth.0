Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v3 4/4] Modify Makefile.tool to link
Date: Fri, 26 Sep 2014 15:48:48 +0800
Message-Id: <1411717728-15415-5-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix patch set v2 link issue when compiling.

---
 Makefile.tools |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 4807813..8823fc0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -365,7 +365,8 @@ tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c \
 				src/shared/timeout.h src/shared/timeout-mainloop.c \
 				src/shared/att-types.h src/shared/att.h src/shared/att.c \
 				src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
-				src/shared/gatt-client.h src/shared/gatt-client.c
+				src/shared/gatt-client.h src/shared/gatt-client.c \
+				src/shared/crypto.h src/shared/crypto.c
 tools_btgatt_client_LDADD = lib/libbluetooth-internal.la
 
 EXTRA_DIST += tools/bdaddr.1
-- 
1.7.10.4

