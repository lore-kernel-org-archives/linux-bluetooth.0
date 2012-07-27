Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH BlueZ] gdbus: Fix compilation error if macro "error" is defined
Date: Fri, 27 Jul 2012 13:14:13 +0530
Message-id: <1343375053-19193-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1343375053-19193-1-git-send-email-jaganath.k@samsung.com>
References: <1343375053-19193-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable "signature" used in error is not defined.
---
 gdbus/object.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 900e7ab..0f05234 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -645,8 +645,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
 		goto fail;
 
 	if (g_dbus_args_have_signature(args, signal) == FALSE) {
-		error("%s.%s: expected signature'%s' but got '%s'",
-				interface, name, args, signature);
+		error("signature does not match");
 		ret = FALSE;
 		goto fail;
 	}
-- 
1.7.1

