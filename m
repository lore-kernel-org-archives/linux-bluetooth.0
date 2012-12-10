Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] build: Fix 'hcitool' and 'bdaddr' compilation
Date: Mon, 10 Dec 2012 16:34:02 -0300
Message-Id: <1355168042-1205-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now with the addition of src/oui.c that depends on udev, these tools
should also be linked against libudev, in case libudev includes the
function udev_hwdb_new().
---
 Makefile.tools | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 36b43dc..d6532b8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -32,7 +32,7 @@ tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c
 tools_hciconfig_LDADD = lib/libbluetooth-private.la
 
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c
-tools_hcitool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_hcitool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @UDEV_LIBS@
 
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
 tools_sdptool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
@@ -107,7 +107,7 @@ tools_bccmd_LDADD += @USB_LIBS@
 endif
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
-tools_bdaddr_LDADD = lib/libbluetooth-private.la
+tools_bdaddr_LDADD = lib/libbluetooth-private.la @UDEV_LIBS@
 
 dist_man_MANS += tools/rfcomm.1 tools/l2ping.1 tools/rctest.1 \
 			tools/hciattach.1 tools/hciconfig.1 \
-- 
1.8.0.1

