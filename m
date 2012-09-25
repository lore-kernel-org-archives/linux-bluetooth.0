Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v3 3/6] hog: Add suspend/resume callbacks declaration
Date: Tue, 25 Sep 2012 12:34:17 -0300
Message-Id: <1348587260-431-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348587260-431-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1346696594-1062-1-git-send-email-claudio.takahasi@openbossa.org>
 <1348587260-431-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch declares the callbacks functions that intend to be used
by the suspend back-ends.
---
 profiles/input/hog_manager.c   | 12 +++++++++++-
 profiles/input/suspend-dummy.c | 10 +++++++++-
 profiles/input/suspend.h       |  5 ++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 8ddaf2f..6d173cc 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -42,6 +42,16 @@
 
 static gboolean suspend_supported = FALSE;
 
+static void suspend_callback(void)
+{
+	DBG("Suspending ...");
+}
+
+static void resume_callback(void)
+{
+	DBG("Resuming ...");
+}
+
 static int hog_device_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
@@ -72,7 +82,7 @@ static int hog_manager_init(void)
 {
 	int err;
 
-	err = suspend_init();
+	err = suspend_init(suspend_callback, resume_callback);
 	if (err < 0)
 		DBG("Suspend: %s(%d)", strerror(-err), -err);
 	else
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 0a97158..282d3fb 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -26,10 +26,18 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
+
 #include "suspend.h"
 
-int suspend_init(void)
+static suspend_event suspend_cb = NULL;
+static resume_event resume_cb = NULL;
+
+int suspend_init(suspend_event suspend, resume_event resume)
 {
+	suspend_cb = suspend;
+	resume_cb = resume;
+
 	return 0;
 }
 
diff --git a/profiles/input/suspend.h b/profiles/input/suspend.h
index 3f37a29..bfee3cf 100644
--- a/profiles/input/suspend.h
+++ b/profiles/input/suspend.h
@@ -22,5 +22,8 @@
  *
  */
 
-int suspend_init(void);
+typedef void (*suspend_event) (void);
+typedef void (*resume_event) (void);
+
+int suspend_init(suspend_event suspend, resume_event resume);
 void suspend_exit(void);
-- 
1.7.12

