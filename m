Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] adapter: Move MGMT_VERSION macro to mgmt.h
Date: Tue, 5 Nov 2013 15:18:44 +0100
Message-ID: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will be also used in Android daemon.
---
 src/adapter.c     | 1 -
 src/shared/mgmt.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 30bcc4d..d904a56 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -99,7 +99,6 @@ static GSList *adapters = NULL;
 
 static struct mgmt *mgmt_master = NULL;
 
-#define MGMT_VERSION(v, r) ((v << 16) + (r))
 static uint8_t mgmt_version = 0;
 static uint8_t mgmt_revision = 0;
 
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 60a2128..99ea96f 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -24,6 +24,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 
+#define MGMT_VERSION(v, r) ((v << 16) + (r))
+
 typedef void (*mgmt_destroy_func_t)(void *user_data);
 
 struct mgmt;
-- 
1.8.4.2

