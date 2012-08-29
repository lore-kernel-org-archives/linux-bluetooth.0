Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 4/6] hog: Create a FIFO for dummy suspend
Date: Wed, 29 Aug 2012 17:53:08 -0300
Message-Id: <1346273590-16693-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates a FIFO on "/tmp/hogsuspend" to allow the users to
test the HoG suspend(HID Control Point) when the dummy back-end is
enabled.
---
 profiles/input/suspend-dummy.c | 102 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 282d3fb..f2941fe 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -26,21 +26,121 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
 
+#include <glib.h>
+
+#include "log.h"
 #include "suspend.h"
 
+#define HOG_SUSPEND_FIFO	"/tmp/hogsuspend"
+
 static suspend_event suspend_cb = NULL;
 static resume_event resume_cb = NULL;
+static GIOChannel *fifoio = NULL;
+
+static int fifo_open(void);
+
+static gboolean read_fifo(GIOChannel *io, GIOCondition cond, gpointer user_data)
+{
+	gchar buffer[12];
+	gsize offset, left, bread;
+	GIOStatus iostatus;
+
+	if (cond & (G_IO_ERR | G_IO_HUP))
+		goto failed;
+
+	offset = 0;
+	left = sizeof(buffer) - 1;
+	memset(buffer, 0, sizeof(buffer));
+
+	do {
+		iostatus = g_io_channel_read_chars(io, &buffer[offset], left,
+								&bread, NULL);
+
+		offset += bread;
+		left -= bread;
+		if (left == 0)
+			break;
+	} while (iostatus == G_IO_STATUS_NORMAL);
+
+	if (g_ascii_strncasecmp("suspend", buffer, 7) == 0)
+		suspend_cb();
+	else if (g_ascii_strncasecmp("resume", buffer, 6) == 0)
+		resume_cb();
+
+	return TRUE;
+
+failed:
+	/*
+	 * Both ends needs to be open simultaneously before proceeding any input
+	 * or output operation. When the remote closes the channel, hup signal is
+	 * received on this end.
+	 */
+
+	g_io_channel_unref(fifoio);
+	fifoio = NULL;
+
+	fifo_open();
+
+	return FALSE;
+}
+
+static int fifo_open(void)
+{
+	GIOCondition condition = G_IO_IN | G_IO_ERR | G_IO_HUP;
+	int fd;
+
+	fd = open(HOG_SUSPEND_FIFO, O_RDONLY | O_NONBLOCK);
+	if (fd < 0) {
+		int err = -errno;
+		error("Can't open FIFO (%s): %s(%d)", HOG_SUSPEND_FIFO,
+							strerror(-err), -err);
+		return err;
+	}
+
+	fifoio = g_io_channel_unix_new(fd);
+	g_io_channel_set_close_on_unref(fifoio, TRUE);
+
+	g_io_add_watch(fifoio, condition, read_fifo, NULL);
+
+	return 0;
+}
 
 int suspend_init(suspend_event suspend, resume_event resume)
 {
+	int ret;
+
 	suspend_cb = suspend;
 	resume_cb = resume;
 
-	return 0;
+	if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
+		int err = -errno;
+		error("Can't create FIFO (%s) : %s(%d)", HOG_SUSPEND_FIFO,
+							strerror(-err), -err);
+		return err;
+	}
+
+	ret = fifo_open();
+	if (ret < 0)
+		remove(HOG_SUSPEND_FIFO);
+
+	return ret;
 }
 
 void suspend_exit(void)
 {
+	if (fifoio) {
+		g_io_channel_shutdown(fifoio, FALSE, NULL);
+		g_io_channel_unref(fifoio);
+	}
+
+	remove(HOG_SUSPEND_FIFO);
 }
-- 
1.7.12

