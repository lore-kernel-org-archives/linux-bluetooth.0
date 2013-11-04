Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android: Add the missing HAVE_CONFIG_H check daemon files
Date: Mon,  4 Nov 2013 11:34:58 +0200
Message-Id: <1383557698-4475-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383557698-4475-1-git-send-email-luiz.dentz@gmail.com>
References: <1383557698-4475-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c    | 4 ++++
 android/ipc.c    | 4 ++++
 android/socket.c | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 59fc90b..1ee8ed4 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -21,6 +21,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/android/ipc.c b/android/ipc.c
index 1f52753..e672bf8 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -21,6 +21,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <stddef.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/android/socket.c b/android/socket.c
index b6eed6e..e32be46 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -21,6 +21,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <glib.h>
 #include <stdbool.h>
 
-- 
1.8.3.1

