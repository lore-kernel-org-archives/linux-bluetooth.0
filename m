Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 01/28] android/ipc: Add ipc_is_connected() check
Date: Wed,  4 Jun 2014 17:17:32 +0300
Message-Id: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Checks that ipc is connected
---
 android/ipc.c | 5 +++++
 android/ipc.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 8cd34ea..137e6f9 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -287,6 +287,11 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+bool ipc_is_connected(struct ipc *ipc)
+{
+	return ipc->cmd_watch;
+}
+
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
 					bool notifications,
 					ipc_disconnect_cb cb, void *cb_data)
diff --git a/android/ipc.h b/android/ipc.h
index cc4e92d..171a77c 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -36,6 +36,7 @@ struct ipc;
 
 typedef void (*ipc_disconnect_cb) (void *data);
 
+bool ipc_is_connected(struct ipc *ipc);
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
 					bool notifications,
 					ipc_disconnect_cb cb, void *cb_data);
-- 
1.8.3.2

