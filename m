Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Add capabilities and set userid
Date: Tue, 22 Oct 2013 09:28:12 +0300
Message-Id: <1382423292-9122-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch set UID as standard Bluetooth user for Android (AID_BLUETOOTH).
It also sets the same capability needed for systemd service (found
in src/bluetooth.service.
---
 android/main.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac   |  4 ++++
 2 files changed, 57 insertions(+)

diff --git a/android/main.c b/android/main.c
index fac1003..e7f842e 100644
--- a/android/main.c
+++ b/android/main.c
@@ -33,10 +33,17 @@
 #include <stdbool.h>
 #include <string.h>
 #include <errno.h>
+#include <unistd.h>
+
 #include <sys/signalfd.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 
+#if defined(ANDROID)
+#include <sys/prctl.h>
+#include <private/android_filesystem_config.h>
+#endif
+
 #include <glib.h>
 
 #include "log.h"
@@ -409,6 +416,49 @@ static void cleanup_hal_connection(void)
 	}
 }
 
+static bool set_capabilities(void)
+{
+#if defined(ANDROID)
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct cap;
+
+	DBG("pid %d uid %d gid %d", getpid(), getuid(), getgid());
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+
+	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+
+	if (setgid(AID_BLUETOOTH) < 0)
+		warn("%s: setgid(): %s", __func__, strerror(errno));
+
+	if (setuid(AID_BLUETOOTH) < 0)
+		warn("%s: setuid(): %s", __func__, strerror(errno));
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = 0;
+
+	cap.effective = cap.permitted =
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
+	if (capget(&header, &cap) < 0)
+		error("%s: capget(): %s", __func__, strerror(errno));
+	else
+		DBG("Caps: eff: 0x%x, perm: 0x%x, inh: 0x%x", cap.effective,
+					cap.permitted, cap.inheritable);
+
+	DBG("pid %d uid %d gid %d", getpid(), getuid(), getgid());
+#endif
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -442,6 +492,9 @@ int main(int argc, char *argv[])
 
 	__btd_log_init("*", 0);
 
+	if (!set_capabilities())
+		return EXIT_FAILURE;
+
 	if (!init_mgmt_interface())
 		return EXIT_FAILURE;
 
diff --git a/configure.ac b/configure.ac
index b4d3998..e3b5220 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,4 +247,8 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+if (test "${enable_android}" = "yes"); then
+	AC_CHECK_LIB(cap, capget, dummy=yes, AC_MSG_ERROR(libcap is required))
+fi
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.8.1.2

