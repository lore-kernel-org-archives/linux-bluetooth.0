Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 5/6] android: Change user to bluetooth when starting daemon
Date: Fri, 17 Jan 2014 16:30:45 +0100
Message-Id: <1389972646-3761-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
References: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/main.c b/android/main.c
index 6324f31..8983a84 100644
--- a/android/main.c
+++ b/android/main.c
@@ -38,6 +38,7 @@
 #include <sys/signalfd.h>
 #if defined(ANDROID)
 #include <sys/capability.h>
+#include <linux/prctl.h>
 #endif
 
 #include <glib.h>
@@ -350,6 +351,18 @@ static bool set_capabilities(void)
 		CAP_TO_MASK(CAP_NET_BIND_SERVICE);
 	cap.inheritable = 0;
 
+	/* don't clear capabilities when dropping root */
+	if (prctl(PR_SET_KEEPCAPS, 1) < 0) {
+		error("%s: prctl(): %s", __func__,strerror(errno));
+		return false;
+	}
+
+	/* Android bluetooth user UID=1002 */
+	if (setuid(1002) < 0) {
+		error("%s: setuid(): %s", __func__, strerror(errno));
+		return false;
+	}
+
 	/* TODO: Move to cap_set_proc once bionic support it */
 	if (capset(&header, &cap) < 0) {
 		error("%s: capset(): %s", __func__, strerror(errno));
-- 
1.8.3.2

