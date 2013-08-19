Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] build: Fix not rebuilding bluetoothd if gdbus changes
Date: Mon, 19 Aug 2013 17:48:46 +0300
Message-Id: <1376923727-12152-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

src_bluetoothd_DEPENDENCIES should list all local libraries including gdbus
otherwise it does not get recompiled whenever gdbus changes.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b8890ec..bf66c2b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -157,7 +157,7 @@ src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
-						src/bluetooth.service
+				gdbus/libgdbus-internal.la src/bluetooth.service
 
 src_bluetoothd_CFLAGS = $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\"
-- 
1.8.3.1

