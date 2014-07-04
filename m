Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 01/32] android/ipc: Add ipc_is_connected() check
Date: Fri,  4 Jul 2014 16:46:46 +0300
Message-Id: <1404481637-900-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Checks that ipc is connected
---
 android/ipc.c | 5 +++++
 android/ipc.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 2e67428..3504143 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -292,6 +292,11 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
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
index fd2b985..0eef515 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -31,6 +31,7 @@ struct ipc;
 
 typedef void (*ipc_disconnect_cb) (void *data);
 
+bool ipc_is_connected(struct ipc *ipc);
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
 					bool notifications,
 					ipc_disconnect_cb cb, void *cb_data);
-- 
1.9.1

