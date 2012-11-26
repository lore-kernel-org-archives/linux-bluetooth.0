Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] adapter: Call driver remove callback when unregistering driver
Date: Mon, 26 Nov 2012 10:07:38 +0100
Message-ID: <1353920860-14912-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This seems to be what plugins expect as only dbusoob explicite called
its remove function before unregistering adapter drivers.

This results in cleaner shutdown path:

Without patch:
bluetoothd[13563]: src/mgmt.c:mgmt_remove_uuid() index 0
bluetoothd[13563]: src/adapter.c:btd_adapter_unref() 0x606b2a0: ref=4
bluetoothd[13563]: src/adapter.c:btd_adapter_unref() 0x606b2a0: ref=3
bluetoothd[13563]: Stopping SDP server
bluetoothd[13563]: Exit
==13563==
==13563== HEAP SUMMARY:
==13563==     in use at exit: 64,908 bytes in 395 blocks
==13563==   total heap usage: 7,035 allocs, 6,640 frees, 4,432,371 bytes allocated
==13563==
==13563== LEAK SUMMARY:
==13563==    definitely lost: 0 bytes in 0 blocks
==13563==    indirectly lost: 0 bytes in 0 blocks
==13563==      possibly lost: 17,429 bytes in 169 blocks
==13563==    still reachable: 47,479 bytes in 226 blocks
==13563==         suppressed: 0 bytes in 0 blocks

With patch:
bluetoothd[13301]: src/mgmt.c:mgmt_remove_uuid() index 0
bluetoothd[13301]: src/adapter.c:btd_adapter_unref() 0x606b2a0: ref=1
bluetoothd[13301]: src/adapter.c:btd_adapter_unref() 0x606b2a0: ref=0
bluetoothd[13301]: src/adapter.c:adapter_free() 0x606b2a0
bluetoothd[13301]: Stopping SDP server
bluetoothd[13301]: Exit
==13301==
==13301== HEAP SUMMARY:
==13301==     in use at exit: 64,954 bytes in 348 blocks
==13301==   total heap usage: 7,247 allocs, 6,899 frees, 4,625,672 bytes allocated
==13301==
==13301== LEAK SUMMARY:
==13301==    definitely lost: 0 bytes in 0 blocks
==13301==    indirectly lost: 0 bytes in 0 blocks
==13301==      possibly lost: 17,334 bytes in 150 blocks
==13301==    still reachable: 47,620 bytes in 198 blocks
==13301==         suppressed: 0 bytes in 0 blocks
---
 plugins/dbusoob.c |    2 --
 src/adapter.c     |    5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index e58b353..7d9a858 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -346,8 +346,6 @@ static void dbusoob_exit(void)
 {
 	DBG("Cleanup dbusoob plugin");
 
-	manager_foreach_adapter((adapter_cb) oob_remove, NULL);
-
 	btd_unregister_adapter_driver(&oob_driver);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 0d1dfea..163360f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3291,6 +3291,11 @@ int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 
 static void unload_driver(struct btd_adapter *adapter, gpointer data)
 {
+	struct btd_adapter_driver *driver = data;
+
+	if (driver->remove)
+		driver->remove(adapter);
+
 	adapter->drivers = g_slist_remove(adapter->drivers, data);
 }
 
-- 
1.7.9.5

