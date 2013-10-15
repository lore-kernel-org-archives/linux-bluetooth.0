Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH v2 1/5] android: Add haltest skeleton
Date: Tue, 15 Oct 2013 15:13:16 +0200
Message-ID: <1381842800-3554-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tool will be used to test Android Bluetooth HAL implementation.
---
 android/Android.mk               |   17 ++++++
 android/hal-client/haltest.c     |   51 ++++++++++++++++
 android/hal-client/pollhandler.c |  123 ++++++++++++++++++++++++++++++++++++++
 android/hal-client/pollhandler.h |   26 ++++++++
 4 files changed, 217 insertions(+)
 create mode 100644 android/hal-client/haltest.c
 create mode 100644 android/hal-client/pollhandler.c
 create mode 100644 android/hal-client/pollhandler.h

diff --git a/android/Android.mk b/android/Android.mk
index 0e025ac..c84fbe3 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -49,3 +49,20 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
 
 include $(BUILD_SHARED_LIBRARY)
+
+#
+# haltest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	hal-client/haltest.c \
+	hal-client/pollhandler.c \
+
+LOCAL_SHARED_LIBRARIES := libhardware
+
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE := haltest
+
+include $(BUILD_EXECUTABLE)
diff --git a/android/hal-client/haltest.c b/android/hal-client/haltest.c
new file mode 100644
index 0000000..11cdd97
--- /dev/null
+++ b/android/hal-client/haltest.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdlib.h>
+#include <poll.h>
+#include <unistd.h>
+
+#include "pollhandler.h"
+
+
+/* called when there is something on stdin */
+static void stdin_handler(struct pollfd *pollfd)
+{
+	char buf[10];
+
+	if (pollfd->revents & POLLIN) {
+		int count = read(0, buf, 10);
+
+		if (count > 0) {
+			int i;
+
+			for (i = 0; i < count; ++i) {
+				/* TODO: process input */
+			}
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	/* Register command line handler */
+	poll_register_fd(0, POLLIN, stdin_handler);
+
+	poll_dispatch_loop();
+
+	return 0;
+}
diff --git a/android/hal-client/pollhandler.c b/android/hal-client/pollhandler.c
new file mode 100644
index 0000000..4e982b8
--- /dev/null
+++ b/android/hal-client/pollhandler.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <poll.h>
+
+#include "pollhandler.h"
+
+/*
+ * Code that allows to poll multiply file descriptors for events
+ * File descriptors can be added and removed at runtime
+ *
+ * Call poll_register_fd function first to add file descriptors to monitor
+ * Then call poll_dispatch_loop that will poll all registered file descriptors
+ * as long as they are not unregistered.
+ *
+ * When event happen on given fd appropriate user supplied handler is called
+ */
+
+/* Maximum number of files to monitor */
+#define MAX_OPEN_FD 10
+
+/* Storage for pollfd structures for monitored file descriptors */
+static struct pollfd fds[MAX_OPEN_FD];
+static poll_handler fds_handler[MAX_OPEN_FD];
+/* Number of registered file descriptors */
+static int fds_count = 0;
+
+/*
+ * Function polls file descriptor in loop and calls appropriate handler
+ * on event. Function returns when there is no more file descriptor to
+ * monitor
+ */
+void poll_dispatch_loop(void)
+{
+	while (fds_count > 0) {
+		int i;
+		int cur_fds_count = fds_count;
+		int ready = poll(fds, fds_count, 1000);
+
+		for (i = 0; i < fds_count && ready > 0; ++i) {
+			if (fds[i].revents == 0)
+				continue;
+
+			fds_handler[i](fds + i);
+			ready--;
+			/*
+			 * If handler was remove from table
+			 * just skip the rest and poll again
+			 * This is due to reordering of tables in
+			 * register/unregister functions
+			 */
+			if (cur_fds_count != fds_count)
+				break;
+		}
+		/*
+		 * This seems to be needed for correct output handling
+		 * when all waiting is performed in poll
+		 */
+		fflush(stdout);
+	}
+}
+
+/*
+ * Registers file descriptor to be monitored for events (see man poll(2))
+ * for events.
+ *
+ * return non negative value on success
+ * -EMFILE when there are to much descriptors
+ */
+int poll_register_fd(int fd, short events, poll_handler ph)
+{
+	if (fds_count >= MAX_OPEN_FD)
+		return -EMFILE;
+
+	fds_handler[fds_count] = ph;
+	fds[fds_count].fd = fd;
+	fds[fds_count].events = events;
+	fds_count++;
+
+	return fds_count;
+}
+
+/*
+ * Unregisters file descriptor
+ * Both fd and ph must match previously registered data
+ *
+ * return 0 if unregister succeeded
+ * -EBADF if arguments do not match any register handler
+ */
+int poll_unregister_fd(int fd, poll_handler ph)
+{
+	int i;
+
+	for (i = 0; i < fds_count; ++i) {
+		if (fds_handler[i] == ph && fds[i].fd == fd) {
+			fds_count--;
+			if (i < fds_count) {
+				fds[i].fd = fds[fds_count].fd;
+				fds[i].events = fds[fds_count].events;
+				fds_handler[i] = fds_handler[fds_count];
+			}
+			return 0;
+		}
+	}
+	return -EBADF;
+}
+
diff --git a/android/hal-client/pollhandler.h b/android/hal-client/pollhandler.h
new file mode 100644
index 0000000..e2f22df
--- /dev/null
+++ b/android/hal-client/pollhandler.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2013 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <poll.h>
+
+/* Function to be called when there are event for some descriptor */
+typedef void (*poll_handler)(struct pollfd *pollfd);
+
+int poll_register_fd(int fd, short events, poll_handler ph);
+int poll_unregister_fd(int fd, poll_handler ph);
+
+void poll_dispatch_loop(void);
-- 
1.7.9.5

