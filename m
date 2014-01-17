Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 6/6] android/snoop: Drop capabilities on startup
Date: Fri, 17 Jan 2014 16:30:46 +0100
Message-Id: <1389972646-3761-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
References: <1389972646-3761-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetoothd-snoop.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 9312c11..f69bc2c 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -29,6 +29,9 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <unistd.h>
+#if defined(ANDROID)
+#include <sys/capability.h>
+#endif
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -188,11 +191,36 @@ static void close_monitor(void)
 	monitor_fd = -1;
 }
 
+static void set_capabilities(void)
+{
+#if defined(ANDROID)
+	struct __user_cap_header_struct header;
+	struct __user_cap_data_struct cap;
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = 0;
+
+	/* CAP_NET_RAW: for snooping
+	 * CAP_DAC_READ_SEARCH: override path search permissions
+	 */
+	cap.effective = cap.permitted =
+		CAP_TO_MASK(CAP_NET_RAW) |
+		CAP_TO_MASK(CAP_DAC_READ_SEARCH) ;
+	cap.inheritable = 0;
+
+	/* TODO: Move to cap_set_proc once bionic support it */
+	if (capset(&header, &cap) < 0)
+		exit(EXIT_FAILURE);
+#endif
+}
+
 int main(int argc, char *argv[])
 {
 	const char *path;
 	sigset_t mask;
 
+	set_capabilities();
+
 	if (argc > 1)
 		path = argv[1];
 	else
-- 
1.8.3.2

