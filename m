Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 1/7] android: Add capabilities and set userid
Date: Thu, 17 Oct 2013 11:26:40 +0300
Message-Id: <1381998406-16662-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch set UID as standard Bluetooth user for Android (AID_BLUETOOTH).
For SDP server we need to bind to lower port, acquire this capability.
Other capabilities are required to access management interface.
---
 android/main.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac   |    4 ++++
 2 files changed, 62 insertions(+)

diff --git a/android/main.c b/android/main.c
index 3a20148..2b2e4d8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -32,6 +32,13 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+#if defined(ANDROID)
+#include <sys/prctl.h>
+#include <private/android_filesystem_config.h>
+#endif
 
 #include <glib.h>
 
@@ -230,6 +237,54 @@ static void cleanup_mgmt_interface(void)
 	mgmt_if = NULL;
 }
 
+static bool set_capabilities(void)
+{
+#if defined(ANDROID)
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct cap;
+	gid_t groups[] = {AID_NET_BT, AID_NET_BT_ADMIN, AID_NET_ADMIN};
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
+	if (setgroups(sizeof(groups)/sizeof(groups[0]), groups) < 0)
+		warn("%s: setgroups: %s", __func__, strerror(errno));
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
@@ -263,6 +318,9 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 
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
1.7.10.4

