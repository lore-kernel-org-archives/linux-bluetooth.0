Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal-health: Clear NONBLOCK flag from fd
Date: Thu,  3 Jul 2014 13:31:33 +0300
Message-Id: <1404383493-8174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Java expects file descriptor passed with channel_state_cb() to be
blocking.
---
 android/hal-health.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 858d499..2ff19ab 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -19,6 +19,8 @@
 #include <stddef.h>
 #include <string.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -44,6 +46,13 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
 static void handle_channel_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_health_channel_state *ev = buf;
+	int flags;
+
+	if ((flags = fcntl(fd, F_GETFL, 0)) < 0)
+		flags = 0;
+
+	fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
+
 
 	if (cbacks->channel_state_cb)
 		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
-- 
1.9.1

