Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix NULL pointer dereference
Date: Mon, 31 Mar 2014 14:45:13 +0200
Message-Id: <1396269913-23447-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is no adapter, hal_ipc in not initialized. Below is
message from valgrind:

==22501== Invalid read of size 4
==22501==    at 0x805B809: ipc_unregister (ipc.c:421)
==22501==    by 0x804AEAF: main (main.c:548)
==22501==  Address 0x4 is not stack'd, malloc'd or (recently) free'd
---
 android/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/main.c b/android/main.c
index 828f81d..e229a6d 100644
--- a/android/main.c
+++ b/android/main.c
@@ -541,8 +541,11 @@ int main(int argc, char *argv[])
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
 
-	ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
-	ipc_cleanup(hal_ipc);
+	/* If no adapter was initialized, hal_ipc is NULL */
+	if (hal_ipc) {
+		ipc_unregister(hal_ipc, HAL_SERVICE_ID_CORE);
+		ipc_cleanup(hal_ipc);
+	}
 
 	info("Exit");
 
-- 
1.8.3.1

