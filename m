Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Adam=20Go=C5=82=C4=99biowski?= <adamg@pld-linux.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Adam=20Go=C5=82=C4=99biowski?= <adamg@pld-linux.org>
Subject: [PATCH] Fix parallel build
Date: Tue, 22 Sep 2009 12:59:05 +0200
Message-Id: <1253617145-190991-1-git-send-email-adamg@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since src/bluetoothd needs libbluetooth, add it to its dependencies.
Parallel build tested with make -j16.

Signed-off-by: Adam Gołębiowski <adamg@pld-linux.org>
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0226554..642affc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -194,7 +194,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 					-Wl,--version-script=src/bluetooth.ver
-src_bluetoothd_DEPENDENCIES = src/bluetooth.ver
+src_bluetoothd_DEPENDENCIES = src/bluetooth.ver lib/libbluetooth.la
 
 builtin_files = src/builtin.h $(builtin_nodist)
 
-- 
1.6.4.4

