Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android/hal-health: Clear NONBLOCK flag from fd
Date: Thu,  3 Jul 2014 13:58:06 +0300
Message-Id: <1404385086-27763-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Java expects file descriptor passed with channel_state_cb() to be
blocking.
---
 android/hal-health.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 20ba459..bfc4f74 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -19,6 +19,9 @@
 #include <stddef.h>
 #include <string.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -44,6 +47,18 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
 static void handle_channel_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_health_channel_state *ev = buf;
+	int flags;
+
+	flags = fcntl(fd, F_GETFL, 0);
+	if (flags < 0) {
+		error("health: fcntl GETFL error: %s", strerror(errno));
+		return;
+	}
+
+	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		error("health: fcntl SETFL error: %s", strerror(errno));
+		return;
+	}
 
 	if (cbacks->channel_state_cb)
 		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
-- 
1.9.1

