Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] android/ipc: Make struct service_handler private
Date: Wed, 11 Jun 2014 16:32:43 +0200
Message-Id: <1402497172-12436-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c | 5 +++++
 android/ipc.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 8cd34ea..fc58a1c 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -40,6 +40,11 @@
 #include "ipc.h"
 #include "src/log.h"
 
+struct service_handler {
+	const struct ipc_handler *handler;
+	uint8_t size;
+};
+
 struct ipc {
 	struct service_handler *services;
 	int service_max;
diff --git a/android/ipc.h b/android/ipc.h
index cc4e92d..e97f0e6 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -27,11 +27,6 @@ struct ipc_handler {
 	size_t data_len;
 };
 
-struct service_handler {
-	const struct ipc_handler *handler;
-	uint8_t size;
-};
-
 struct ipc;
 
 typedef void (*ipc_disconnect_cb) (void *data);
-- 
1.9.1

