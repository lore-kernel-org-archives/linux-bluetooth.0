Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] gdbus: Fix crash in g_dbus_create_error_valist
Date: Tue,  7 Apr 2015 22:10:49 +0200
Message-Id: <1428437449-11210-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1428437449-11210-1-git-send-email-szymon.janc@tieto.com>
References: <1428437449-11210-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Passing NULL format parameter to vsnprintf results in invalid argument
error on glibc. But with some other libc libraries (musl and uClibc)
this results in dereferencing NULL pointer and crash due to
segmentation fault.
---
 gdbus/object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index c3c137b..74e975b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1412,7 +1412,10 @@ DBusMessage *g_dbus_create_error_valist(DBusMessage *message, const char *name,
 {
 	char str[1024];
 
-	vsnprintf(str, sizeof(str), format, args);
+	if (format)
+		vsnprintf(str, sizeof(str), format, args);
+	else
+		str[0] = '\0';
 
 	return dbus_message_new_error(message, name, str);
 }
-- 
1.9.3

