Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 10/14] android: Add cap to bind to port < 1024
Date: Tue,  1 Oct 2013 18:03:15 +0300
Message-Id: <1380639799-25790-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For SDP server we need to bind to lower port, acquire this capability.
---
 android/main.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac   |    4 ++++
 2 files changed, 67 insertions(+)

diff --git a/android/main.c b/android/main.c
index db435f9..36f9c1a 100644
--- a/android/main.c
+++ b/android/main.c
@@ -31,6 +31,22 @@
 #include <stdio.h>
 #include <stdlib.h>
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
 
@@ -321,6 +337,50 @@ static void cleanup_mgmt_interface(void)
 	mgmt_if = NULL;
 }
 
+static bool android_set_aid_and_cap()
+{
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct cap;
+
+	DBG("pid %d uid %d gid %d", getpid(), getuid(), getgid());
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = getpid();
+	if (capget(&header, &cap) < 0)
+		error("%s: capget(): %s", __func__, strerror(errno));
+	else
+		DBG("Caps: eff: 0x%x, perm: 0x%x, inh: 0x%x", cap.effective,
+					cap.permitted, cap.inheritable);
+
+#if defined(__ANDROID_API__)
+	if (setgid(AID_BLUETOOTH) < 0) {
+		error("%s: setgid(): %s", __func__, strerror(errno));
+		return false;
+	}
+
+	if (setuid(AID_BLUETOOTH) < 0) {
+		error("%s: setuid(): %s", __func__, strerror(errno));
+		return false;
+	}
+#endif
+
+	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = 0;
+
+	cap.effective = cap.permitted = cap.inheritable =
+		CAP_TO_MASK(CAP_NET_ADMIN) |
+		CAP_TO_MASK(CAP_NET_BIND_SERVICE);
+
+	if (capset(&header, &cap)) {
+		error("%s: capset(): %s", __func__, strerror(errno));
+		return false;
+	}
+
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -359,6 +419,9 @@ int main(int argc, char *argv[])
 	/* no need to keep parsed option in memory */
 	free_options();
 
+	if (android_set_aid_and_cap() == false)
+		exit(EXIT_FAILURE);
+
 	init_mgmt_interface();
 
 	DBG("Entering main loop");
diff --git a/configure.ac b/configure.ac
index 3b7a5d9..af418d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,4 +247,8 @@ AC_ARG_ENABLE(android-daemon, AC_HELP_STRING([--enable-android-daemon],
 					[android_daemon=${enableval}])
 AM_CONDITIONAL(ANDROID_DAEMON, test "${android_daemon}" = "yes")
 
+if (test "${android_daemon}" = "yes"); then
+	AC_CHECK_LIB(cap, capget, dummy=yes, AC_MSG_ERROR(libcap is required))
+fi
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.7.10.4

