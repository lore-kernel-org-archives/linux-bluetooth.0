Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/gatt: Fix daemon crash
Date: Wed, 16 Jul 2014 11:08:31 +0300
Message-Id: <1405498111-4585-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Due to insufficient error check bluetooth daemon goes to crash loop with
logs shown below. The patch adds error check in a case crypto failed to
initialize with the same approach as in other helper functions.

...
I/ProbeModule(24651): insmod_by_dep: parse base black list error -1
E/ProbeModule(24651): insmod_by_dep: cannot find module's dependency
info: [net-pf-38]
I/bluetoothd(24639): bluetoothd[24640]: gatt: Failed to setup crypto
...
I/DEBUG   (16237): *** *** *** *** *** *** *** *** *** *** *** *** ***
*** *** ***
I/DEBUG   (16237): Build fingerprint:
'Intel/hsb/hsb:4.4.2/KOT49H/eng.android.20140514.123328:eng/test-keys'
I/DEBUG   (16237): Revision: '0'
I/DEBUG   (16237): pid: 24640, tid: 24640, name: bluetoothd-main  >>>
/system/bin/bluetoothd-main <<<
I/DEBUG   (16237): signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr
00000004
...
I/DEBUG   (16237): stack:
I/DEBUG   (16237):          ff81a9dc  ff81aa14  [stack]
I/DEBUG   (16237):          ff81a9e0  00000000
I/DEBUG   (16237):          ff81a9e4  f75c2e06  /system/lib/libc.so
(vsyslog+6)
I/DEBUG   (16237):          ff81a9e8  f77c0cd8
/system/bin/bluetoothd-main
I/DEBUG   (16237):          ff81a9ec  f778692c
/system/bin/bluetoothd-main (gatt_db_destroy+12)
I/DEBUG   (16237):     #00  ff81a9f0  00000003
I/DEBUG   (16237):          ff81a9f4  f77865c0
/system/bin/bluetoothd-main (gatt_db_service_destroy)
I/DEBUG   (16237):          ff81a9f8  f7784709
...
---
 src/shared/gatt-db.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f671480..b3f95d2 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -138,6 +138,9 @@ static void gatt_db_service_destroy(void *data)
 
 void gatt_db_destroy(struct gatt_db *db)
 {
+	if (!db)
+		return;
+
 	queue_destroy(db->services, gatt_db_service_destroy);
 	free(db);
 }
-- 
1.9.1

