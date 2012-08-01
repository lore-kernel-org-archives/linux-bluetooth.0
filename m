Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" is
 defined
Date: Wed, 01 Aug 2012 15:56:43 +0530
Message-id: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable "signature" used in error is not defined.
---
v0 -> Made error message as per Lucas's suggestion

 gdbus/object.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 900e7ab..9689006 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -645,8 +645,8 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
 		goto fail;
 
 	if (g_dbus_args_have_signature(args, signal) == FALSE) {
-		error("%s.%s: expected signature'%s' but got '%s'",
-				interface, name, args, signature);
+		error("%s.%s: got unexpected signature '%s'", interface, name,
+					dbus_message_get_signature(signal));
 		ret = FALSE;
 		goto fail;
 	}
-- 
1.7.1

