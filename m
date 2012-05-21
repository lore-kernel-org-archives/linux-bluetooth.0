Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] gdbus: add macro for methods marked as NOREPLY
Date: Mon, 21 May 2012 11:54:35 -0300
Message-Id: <1337612075-2697-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

This one is not used in BlueZ, but it was necessary for other projects using
gdbus. It's better to keep them in sync.

 gdbus/gdbus.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e2e160d..0a8a27c 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -144,6 +144,13 @@ typedef struct {
 	.function = _function, \
 	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
 
+#define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_NOREPLY
+
 #define GDBUS_SIGNAL(_name, _args) \
 	.name = _name, \
 	.args = _args
-- 
1.7.10.2

