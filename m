Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/15] android: Add cap to bind to port < 1024
Date: Tue,  8 Oct 2013 13:33:53 +0300
Message-Id: <1381228437-5553-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For SDP server we need to bind to lower port, acquire this capability.
---
 android/main.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac   |    4 ++++
 2 files changed, 75 insertions(+)

diff --git a/android/main.c b/android/main.c
index 7968ed0..4ef70bd 100644
--- a/android/main.c
+++ b/android/main.c
@@ -32,6 +32,22 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/prctl.h>
+#include <linux/capability.h>
+
+/**
+ * Include <sys/capability.h> for host build and
+ * also for Android 4.3 when it is added to bionic
+ */
+#if !defined(__ANDROID_API__) || (__ANDROID_API__ > 17)
+#include <sys/capability.h>
+#endif
+
+#if defined(__ANDROID_API__)
+#include <private/android_filesystem_config.h>
+#endif
 
 #include <glib.h>
 
@@ -279,6 +295,58 @@ static void cleanup_mgmt_interface(void)
 	mgmt_if = NULL;
 }
 
+static bool android_set_aid_and_cap(void)
+{
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct cap;
+#if defined(__ANDROID_API__)
+	gid_t groups[] = {AID_NET_BT, AID_NET_BT_ADMIN, AID_NET_ADMIN};
+#endif
+
+	DBG("pid %d uid %d gid %d", getpid(), getuid(), getgid());
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+
+	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+
+#if defined(__ANDROID_API__)
+	if (setgid(AID_BLUETOOTH) < 0)
+		warn("%s: setgid(): %s", __func__, strerror(errno));
+
+	if (setuid(AID_BLUETOOTH) < 0)
+		warn("%s: setuid(): %s", __func__, strerror(errno));
+#endif
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = 0;
+
+	cap.effective = cap.permitted =
+		CAP_TO_MASK(CAP_SETGID) |
+		CAP_TO_MASK(CAP_NET_RAW) |
+		CAP_TO_MASK(CAP_NET_ADMIN) |
+		CAP_TO_MASK(CAP_NET_BIND_SERVICE);
+	cap.inheritable = 0;
+
+	if (capset(&header, &cap) < 0) {
+		error("%s: capset(): %s", __func__, strerror(errno));
+		return false;
+	}
+
+#if defined(__ANDROID_API__)
+	if (setgroups(sizeof(groups)/sizeof(groups[0]), groups) < 0)
+		warn("%s: setgroups: %s", __func__, strerror(errno));
+#endif
+	if (capget(&header, &cap) < 0)
+		error("%s: capget(): %s", __func__, strerror(errno));
+	else
+		DBG("Caps: eff: 0x%x, perm: 0x%x, inh: 0x%x", cap.effective,
+					cap.permitted, cap.inheritable);
+
+	DBG("pid %d uid %d gid %d", getpid(), getuid(), getgid());
+
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -312,6 +380,9 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 
+	if (android_set_aid_and_cap() == false)
+		exit(EXIT_FAILURE);
+
 	init_mgmt_interface();
 	sdp_start();
 
diff --git a/configure.ac b/configure.ac
index 7b1f64a..5406434 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,4 +247,8 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+if (test "${android_daemon}" = "yes"); then
+	AC_CHECK_LIB(cap, capget, dummy=yes, AC_MSG_ERROR(libcap is required))
+fi
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.7.10.4

