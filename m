Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/build: Fix including wrong log include header for bluetoothd
Date: Wed, 10 Dec 2014 10:58:09 +0200
Message-Id: <1418201890-8255-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes build for Nexus 9.
...
aarch64-linux-android/bin/ld:
out/target/product/flounder/obj/EXECUTABLES/bluetoothd-main_intermediates/bluez/android/a2dp-sink.o:
undefined reference to symbol '__android_log_print'
...
---
 android/a2dp-sink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/a2dp-sink.c b/android/a2dp-sink.c
index 07508c0..7c1e1a0 100644
--- a/android/a2dp-sink.c
+++ b/android/a2dp-sink.c
@@ -29,7 +29,7 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
-#include "hal-log.h"
+#include "src/log.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "a2dp-sink.h"
-- 
2.1.0

